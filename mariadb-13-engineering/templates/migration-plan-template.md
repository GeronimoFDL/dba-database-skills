# Plan de migración MariaDB 13.0

Registra versión/build, engine, topología, destino autorizado y ruta de recuperación ensayada.

1. Separar DDL con implicit commit del DML de negocio; definir fases y reejecución.
2. Resolver requisitos de ALGORITHM/LOCK y metadata locks; no prometer reanudación universal.
3. Validar claves, datos existentes, histórico temporal, clientes y escrituras concurrentes.
4. Revisar procedimiento Galera/replicación y límites de disco, redo/binlog y lag.
5. Confirmar compatibilidad de backup; no combinar innodb_log_archive con mariadb-backup incompatible.
6. Resolver la discrepancia sobre atomic CREATE OR REPLACE TABLE antes de depender de esa novedad.
7. Documentar éxito, fallo parcial, recuperación, reconciliación y evidencia.

No contiene DDL ejecutable sin un cambio concreto y verificado.
