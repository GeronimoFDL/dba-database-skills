# MVCC, aislamiento y locks

Fuentes: [transactions](source-registry.md#transactions), [locks](source-registry.md#locks).

READ COMMITTED es el valor predeterminado: cada sentencia obtiene su snapshot. REPEATABLE READ conserva snapshot y puede fallar al actualizar filas cambiadas. SERIALIZABLE usa detección de anomalías y puede abortar transacciones; reintenta la unidad completa para errores de serialización identificados. READ UNCOMMITTED se comporta como READ COMMITTED.

Después de un error en una transacción explícita, se requiere ROLLBACK o recuperación a savepoint válido; no continúes como si la sesión estuviera sana. Define dueño, transacciones cortas y orden de locks. Secuencias no son gapless ni se revierten como datos normales. Un rollback no deshace necesariamente efectos externos de funciones.

MVCC no elimina locks: DDL puede adquirir ACCESS EXCLUSIVE y lectores/escritores mantienen recursos. Observa pg_locks, pg_stat_activity y pg_blocking_pids; identifica raíz y duración antes de cancelar. Evita idle in transaction, que retiene snapshots y dificulta vacuum.

Usa lock_timeout/statement_timeout con alcance deliberado; matar el proceso equivocado puede empeorar recuperación. Advisory locks requieren convención y limpieza acordadas. Para actualizar por concurrencia optimista usa versión explícita o contrato del ORM; no conviertas xmin en identificador durable sin evaluar wraparound y semántica.
