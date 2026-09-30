# Migraciones y despliegue

Fuentes: [upgrade](source-registry.md#upgrade), [breaking](source-registry.md#breaking), [resumable](source-registry.md#resumable), [releases](source-registry.md#releases).

Compara esquema esperado y real, dependencias, permisos y consumidores. Usa migraciones versionadas y checks de precondición; IF NOT EXISTS no valida que el objeto ya existente sea correcto. Para cambios incompatibles considera expand/contract, backfill por lotes y retirada tras cambiar lectores/escritores.

Revisa DDL, data movement, locks, log, espacio y recuperación. DACPAC/SqlPackage no prueban seguridad de la migración: inspecciona script y advertencias y conserva baseline. Confirma soporte 17.x en herramientas, parser, drivers y CI antes de usar nuevos tipos.

Separa upgrade de motor, compatibilidad 170 y cambios de opciones para atribuir regresiones. Captura Query Store y prueba parámetros representativos. Revisa rutas de upgrade soportadas, edición objetivo, linked servers/TLS y restauración; volver compatibilidad no revierte formato de archivos ni restaura un backup en versión anterior.

Cada ejecución requiere destino confirmado, plan de fallo parcial y criterios de pausa. Cuando el script posea su transacción, usa contrato explícito; no encapsules ciegamente operaciones que no admitan esa transacción. Entrega validación, reversión/roll-forward y riesgos; no ejecutes PROD por haber generado el artefacto.
