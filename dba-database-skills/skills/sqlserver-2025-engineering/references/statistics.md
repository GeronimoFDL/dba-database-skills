# Estadísticas y cardinalidad

Fuentes: [statistics](source-registry.md#statistics), [maintenance](source-registry.md#maintenance).

Mantén creación/actualización automática salvo excepción comprobada. El histograma corresponde a la primera columna; estadísticas multicolumna no crean un histograma multidimensional perfecto. Analiza sesgo, parámetros, correlaciones y diferencias entre filas estimadas/reales antes de actualizar.

Consulta sys.stats, sys.stats_columns y sys.dm_db_stats_properties con permisos apropiados. Registra muestreo, última actualización, filas y modificaciones; valores NULL o recientes no prueban salud. Evalúa muestra mayor o FULLSCAN únicamente sobre estadísticas afectadas y con costo medido. Estadísticas filtradas/incrementales exigen predicados y particiones elegibles.

AUTO_UPDATE_STATISTICS_ASYNC permite compilar con información anterior. ASYNC_STATS_UPDATE_WAIT_AT_LOW_PRIORITY trata contención de actualización asíncrona; no es opción universal de UPDATE STATISTICS. Evalúa demoras y efecto sobre planes.

REORGANIZE no actualiza estadísticas. Rebuild actualiza las de su índice, no todas las de columna, y existen excepciones de muestreo. No dupliques mantenimiento indiscriminadamente ni provoques recompilaciones sin necesidad. La actualización puede empeorar un plan: compara la carga real y conserva vía de diagnóstico.
