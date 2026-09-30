# Transacciones y concurrencia

Fuentes: [transactions](source-registry.md#transactions), [implicit-commit](source-registry.md#implicit-commit), [ddl](source-registry.md#ddl).

Confirma engine, autocommit y aislamiento efectivos. InnoDB usa REPEATABLE READ por defecto, pero la configuración puede cambiarlo. MVCC no elimina locks de escritura ni metadata locks. Diferencia lecturas consistentes de lecturas bloqueantes, gap/next-key locks y efectos de índices/rangos.

Mantén transacciones cortas y orden de acceso consistente. Captura el deadlock antes de reintentar; reintenta la unidad completa con límite y espera acotada cuando el error lo permita. Lock timeout, deadlock y desconexión no implican el mismo estado transaccional; consulta configuración y driver.

Después de COMMIT con resultado desconocido no repitas a ciegas una operación no idempotente. Usa claves de idempotencia o consulta de estado duradera. SAVEPOINT no proporciona transacciones autónomas ni revierte implicit commit.

DDL puede confirmar implícitamente antes/después según sentencia. La atomicidad de DDL frente a crash no permite agrupar libremente DDL y DML bajo ROLLBACK. No generalices garantías InnoDB a Aria, MyISAM, MEMORY o acciones externas de rutinas.

En Galera, incorpora errores de certificación y reintentos de la transacción completa; una prueba con un solo nodo no valida conflictos multinodo.
