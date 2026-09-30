# Transacciones InnoDB

Fuentes: [transactions](source-registry.md#transactions), [deadlocks](source-registry.md#deadlocks), [implicit-commit](source-registry.md#implicit-commit), [ddl](source-registry.md#ddl).

Verifica engine y autocommit. REPEATABLE READ es el aislamiento habitual de InnoDB, distinto del READ COMMITTED predeterminado de PostgreSQL. Las lecturas consistentes y las lecturas bloqueantes pueden observar estados distintos; no mezcles ambas sin comprender el snapshot y los locks.

Next-key/gap locks protegen ciertos rangos y pueden bloquear inserciones. READ COMMITTED modifica ese comportamiento y la fotografía; no lo impongas para «resolver» toda contención. Diseña índices para limitar filas examinadas y adquiere recursos en orden consistente.

Deadlock puede revertir la transacción víctima completa; lock wait timeout puede revertir solo la sentencia según configuración. Después de un error, define si debes ROLLBACK de toda unidad antes de reintentar; no asumas semántica de PostgreSQL o SQL Server. Reintentos acotados, idempotentes y con backoff.

DDL y otros comandos pueden producir implicit commit. Atomic DDL no permite envolver varias operaciones DDL/DML en una transacción reversible del usuario. SAVEPOINT no vuelve transaccional una operación con implicit commit. Revisa conexiones reutilizadas, transacciones abiertas, long snapshots y purge/undo. Nunca uses KILL indiscriminado ni reduzcas durabilidad por conveniencia.
