# Migraciones y upgrades

Fuentes: [upgrade](source-registry.md#upgrade), [ddl](source-registry.md#ddl), [implicit-commit](source-registry.md#implicit-commit), [version](source-registry.md#version), [releases](source-registry.md#releases).

Verifica ruta de upgrade soportada desde el origen real y ciclo rolling de 13.0. No asumas compatibilidad directa con MySQL ni reversibilidad de archivos de datos. Ensaya configuración, plugins, autenticación, collations, rutinas, clientes, réplica y backup con el build exacto.

Clasifica sentencias con implicit commit antes de diseñar reversión. Divide DDL y DML en fases con precondiciones y registro de avance. CREATE OR REPLACE TABLE no es una forma conservadora de agregar columnas; además, la atomicidad nueva tiene discrepancia documental que debe resolverse antes de depender de ella.

Para tablas grandes verifica algoritmo/lock soportados, metadata locks, espacio y réplica. Una opción ONLINE no garantiza ausencia total de bloqueo ni pausa/reanudación. Define criterios de aborto y consecuencias de cancelación/fallo parcial.

Usa expand/contract para contratos en servicio, backfill por clave estable, validación de filas/valores y corte de consumidores. Controla escrituras concurrentes al introducir unicidad/FKs. Incluye objetos, grants, eventos y datos históricos requeridos.

Conserva backup restaurable, binarios y configuración anterior; para volver atrás tras nuevas escrituras define reconciliación o roll-forward. No prometas downgrade sin una ruta admitida. Mantén fuera de la migración novedades preview y archivado redo incompatible con backup.
