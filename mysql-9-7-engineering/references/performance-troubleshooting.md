# Diagnóstico y observabilidad

Fuentes: [explain](source-registry.md#explain), [monitoring](source-registry.md#monitoring), [sys](source-registry.md#sys), [transactions](source-registry.md#transactions).

Empieza por síntoma, intervalo, parámetros, digest y cambios. Performance Schema y sys schema permiten correlacionar sentencias, waits, locks y memoria según instrumentos/consumers habilitados. Verifica configuración, permisos y costo antes de activarlos masivamente. Los digests agregan consultas; no son historial completo de planes ni valores de parámetros.

Distingue EXPLAIN estimado de EXPLAIN ANALYZE, que ejecuta lo soportado. Revisa filas/loops, costo, tiempo, acceso, temporales, sorts y joins, sin confundir estimaciones con medidas. Slow query log puede exponer valores y generar I/O; filtros, rotación y retención deben estar definidos.

Para blocking usa data_locks/data_lock_waits y metadata locks cuando estén disponibles/configurados; muestra raíz y transacción, no solo espera final. Para InnoDB examina buffer pool, redo, undo/purge y latencia física. No aumentar buffer pool para solucionar un plan que devuelve millones de filas innecesarias.

Compara cargas y distribución equivalentes; documenta reinicios de contadores. Hints, optimizer_switch y cambios persistidos requieren motivo y retirada. MySQL no tiene Query Store/PSP/OPPO de SQL Server: no inventes equivalencias funcionales completas.
