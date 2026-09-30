# Transacciones, versionado y concurrencia

Fuentes: [transactions](source-registry.md#transactions), [xact](source-registry.md#xact), [locking](source-registry.md#locking).

Declara dueño, unidad de trabajo, aislamiento e invariantes. SQL Server no ofrece transacciones anidadas independientes: ROLLBACK sin savepoint afecta la exterior. Un script que exige transacción propia debe rechazar @@TRANCOUNT distinto de cero, usar TRY/CATCH y XACT_ABORT según contrato, confirmar al terminar y revertir si XACT_STATE() es distinto de cero ante fallo.

En procedimientos que participan en transacción ajena, conserva el estado inicial y acuerda savepoints; XACT_STATE=-1 impide volver a un savepoint y requiere rollback completo por el dueño. No todos los errores/compilaciones/cancelaciones son capturados. Propaga con THROW y no confirma trabajo ajeno.

READ COMMITTED con RCSI usa fotografía por sentencia; SNAPSHOT usa fotografía de transacción y puede producir conflictos de actualización. SERIALIZABLE protege rangos con mayor contención. NOLOCK permite inconsistencias y sigue adquiriendo locks de esquema. Distingue bloqueo, deadlock y latch; reintenta toda unidad idempotente solo en errores reconocidos, con límite.

Optimized locking requiere ADR y soporte de edición; LAQ requiere RCSI. No lo conviertas en cambio preventivo: prueba colas, leer-modificar-escribir, triggers, transacciones largas y retención de versiones. Con ADR, dimensiona PVS; distingue sus usos de tempdb. rowversion con comparación del valor original permite detectar conflictos, no resolverlos automáticamente.
