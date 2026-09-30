# Integridad y mantenimiento

Fuentes: [backup](source-registry.md#backup), [indexes](source-registry.md#indexes), [ddl](source-registry.md#ddl), [statistics](source-registry.md#statistics).

Investiga errores con logs, alcance, engine y backups disponibles antes de modificar archivos. No uses REPAIR TABLE como receta para InnoDB ni elimines redo/archivos para forzar arranque. Los modos de recuperación forzada son excepcionales para extracción controlada, no reparación rutinaria.

Valida integridad física mediante procedimientos soportados y lógica mediante constraints, huérfanos, duplicados y conciliación de negocio. Ninguna comprobación aislada garantiza toda integridad. Preserva evidencia y una copia antes de procedimientos invasivos.

OPTIMIZE TABLE puede reconstruir y consumir espacio/bloqueos; no lo programes por un porcentaje de fragmentación copiado de SQL Server. Analiza necesidad de recuperar espacio, engine y crecimiento. Ajusta estadísticas a cambios significativos, sin eliminar mecanismos de mantenimiento preventivo del motor.

Supervisa transacciones largas, history list/purge, disco y logs. Distingue log de error, redo, binlog y relay log; no borres archivos administrados por el servidor como limpieza. Purga según retención, réplica y recuperación comprobadas.
