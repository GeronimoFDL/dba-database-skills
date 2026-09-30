# Desarrollo, migración y despliegue

Fuentes: [S01–S02, S15, S20–S22, S71–S72, S93](source-registry.md). Git, promoción por entornos y expand/contract son decisiones de ingeniería del proceso.

Versiona esquema, T-SQL, migraciones y configuración no secreta. Elige una autoridad de despliegue coherente (migraciones de aplicación, SQL Database Projects/DACPAC o scripts versionados); coordina cualquier combinación para evitar dos mecanismos modificando el mismo objeto sin conocimiento mutuo.

## Ciclo de cambio

1. Captura estado inicial y contrato de consumidores. Identifica tamaño, permisos, dependencias, bloqueos, log, capacidades de edición y tipo de operación.
2. Crea el cambio y validaciones. Idempotencia no es solo `IF NOT EXISTS`: si existe algo incompatible, falla con un diagnóstico. Evita ocultar schema drift.
3. Prueba DEV → TEST/UAT con datos y carga representativos; valida errores, concurrencia, reejecución e interrupción. Si DEV usa Developer y PROD Standard, verifica límites de edición.
4. Promueve el mismo artefacto revisado con identidad de despliegue separada, secretos administrados y trazabilidad de Git/Azure DevOps. Serializa migraciones sobre el mismo destino.
5. Antes de PROD, completa [production-change](../checklists/production-change.md) y confirma autorización existente, destino y recuperación. No ejecutar por el mero hecho de generar un pipeline.
6. Después, verifica esquema, datos, constraints, permisos, aplicación, jobs y regresiones en Query Store; conserva evidencia y límites de aceptación.

## SSDT / SQL Database Projects / DACPAC

Configura la plataforma de destino para SQL Server 2022 (`Sql160DatabaseSchemaProvider` cuando el proyecto usa ese proveedor). El build valida sintaxis/modelo, no demuestra tiempos de despliegue, ausencia de bloqueo ni compatibilidad de datos.

Genera e inspecciona script/reporte de publicación antes de aplicar. Mantén protecciones como `BlockOnPossibleDataLoss=True`; no garantizan seguridad completa y no deben desactivarse automáticamente para lograr un despliegue verde. Examina drops, reconstrucciones de tablas, conversiones, pre/post-deployment y drift. Publicar un DACPAC sincroniza modelo; no implica rollback de datos automático.

En EF, revisa migraciones/bundles o scripts idempotentes generados: un renombre mal detectado puede convertirse en drop/create. No aplicar migraciones concurrentes desde múltiples instancias de aplicación como mecanismo habitual de producción.

## Compatibilidad y recuperación

Usa expand/contract si conviven versiones: añade estructura compatible, despliega lectores/escritores compatibles, migra datos por lotes reanudables, verifica consistencia y retira lo antiguo cuando no haya consumidores. Agregar NOT NULL con default o cambiar tipo en una tabla grande requiere evaluación concreta, no asumir operación instantánea.

Planifica rollback de código y rollback/roll-forward de datos por separado. Un DOWN o DROP puede destruir escrituras nuevas; restaurar una base puede perder transacciones posteriores y exceder RTO. Explica esas limitaciones y ensaya el camino elegido. Algunas operaciones no caben en una transacción explícita; no envolver todo DDL administrativo con un patrón único.
