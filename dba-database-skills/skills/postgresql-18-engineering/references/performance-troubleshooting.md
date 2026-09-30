# Diagnóstico y observabilidad

Fuentes: [monitoring](source-registry.md#monitoring), [explain](source-registry.md#explain), [statistics](source-registry.md#statistics).

Registra intervalo, consulta, parámetros, volumen, SLA y cambios recientes. Usa pg_stat_activity, waits, pg_locks, progreso de operaciones, pg_stat_io y estadísticas de tablas/índices para localizar causa. Distingue snapshots, contadores acumulados y reinicios/resets; no declares un índice inútil con ventana insuficiente.

pg_stat_statements es extensión, no Query Store nativo: comprueba instalación, preload, permisos y reinicio requerido antes de proponer habilitación. Identificadores de consultas y muestras no equivalen a historial completo de planes. Logs/auto_explain también consumen recursos y pueden exponer datos; configura filtros y retención.

EXPLAIN sin ANALYZE describe estimación; con ANALYZE ejecuta. Valida permiso para DML y efectos de funciones. Compara rows/loops, buffers, sort/hash spills, JIT, workers y variabilidad; no atribuyas toda lentitud a falta de índice. Si no hay servidor, entrega consultas propuestas y evidencias pendientes.

AIO y skip scan de 18 no reemplazan diagnóstico de I/O, CPU, locks, cache, cliente y cardinalidad. Cambia una hipótesis a la vez, conserva contexto y evalúa regresiones en otras consultas.
