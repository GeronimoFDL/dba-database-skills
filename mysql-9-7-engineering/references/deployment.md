# DDL y upgrades 9.7

Fuentes: [upgrade](source-registry.md#upgrade), [ddl](source-registry.md#ddl), [implicit-commit](source-registry.md#implicit-commit), [online-ddl](source-registry.md#online-ddl), [changes](source-registry.md#changes).

Ensaya ruta de upgrade soportada desde la versión real; no saltar majors arbitrariamente ni usar herramientas de 8.x como validación completa de 9.7. Revisa variables retiradas, auth, collation, clientes y replicación. Identifica parches específicos de Docker frente a binarios de plataforma.

Atomic DDL no es transactional DDL para el usuario. ALTER/CREATE/DROP pueden hacer implicit commit incluso al fallar en contextos documentados; no mezcles DML de negocio pendiente con DDL esperando rollback conjunto. Migra en fases con precondiciones, recuperación y registro de lo completado.

Para tablas grandes evalúa ALGORITHM/LOCK admitidos, metadata locks, espacio y logs; evita fallback a COPY inesperado. Herramientas de online schema change dependen de triggers, FKs, binlog y distribución: verificar compatibilidad 9.7 antes de recomendarlas.

Usa expand/contract para cambios de contrato, backfill por clave estable, validación de conteos/valores y corte de consumidores. Desactivar checks no sustituye validación posterior. Downgrade no se supone soportado: preserva backup, binarios, punto de corte y plan para reconciliar nuevas escrituras.
