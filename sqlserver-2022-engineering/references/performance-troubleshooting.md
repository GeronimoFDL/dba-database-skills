# Diagnóstico de rendimiento

Fuentes: [S04, S08, S15, S18, S38–S43, S46–S48, S81–S83](source-registry.md).

## Evidencia mínima adaptable

Define síntoma, inicio, alcance, SLA, entorno, CU, edición y cambios recientes. Mide en una ventana representativa: volumen/distribución, concurrencia, consultas/parametrización, CPU, duración, logical/physical reads, filas y errores. Latencia vista por la aplicación incluye espera del pool, red y materialización, no solo ejecución SQL.

| Evidencia | Pregunta que responde y límite |
|---|---|
| Query Store | ¿Qué consultas/planes cambiaron? Historia agregada dependiente de captura/retención. |
| Actual/Estimated Execution Plan | ¿Qué estima y hace el motor? Real requiere ejecución; estimado no prueba comportamiento real. |
| `sys.dm_exec_query_stats` | Consumo acumulado de planes cacheados; CPU/duración en microsegundos, granularidad efectiva limitada. Los planes desaparecidos no están representados. |
| `sys.dm_exec_sql_text`, `sys.dm_exec_query_plan` | Contexto/plan por handle; pueden devolver NULL. Texto y parámetros pueden contener datos sensibles. |
| `sys.dm_db_index_usage_stats` | Uso desde el período de vida de contadores; captura reinicios, adjuntos/desconexiones y operaciones que resetean evidencia. |
| `sys.dm_db_index_operational_stats` | Actividad/bloqueos/latches del índice; contadores viven en caché de metadatos, no un historial persistente. |
| `sys.dm_db_stats_properties` | Fecha, muestra y modificaciones; no demuestra por sí solo una estimación mala. |
| Waits, requests, locks y sessions | ¿En qué espera ahora y en el intervalo? Totales desde arranque mezclan cargas; usa deltas y contexto. |
| Extended Events | Episodios de bloqueo, deadlocks, errores o recompilación con filtros/retención. Capturar todo o todos los planes puede ser costoso. |

SQL Server 2022 requiere `VIEW SERVER PERFORMANCE STATE` para varias DMVs como query stats e index usage. Otras requieren permisos de base/objeto distintos; verifica cada DMV. No otorgues sysadmin para superar una consulta denegada; solicita evidencia mínima al responsable.

## Triangulación

- CPU alta: localiza consultas y frecuencia, estimaciones, trabajo redundante y compilaciones; no cambies MAXDOP por una sola lectura.
- Lecturas/spills/grants: compara filas estimadas/reales, ancho, sort/hash, concurrencia y memoria disponible. Un spill no basta para culpar a tempdb.
- Blocking: construye la cadena hasta el bloqueador raíz, su transacción y acceso. Deadlock: lee `xml_deadlock_report`, recursos y orden de acceso; `system_health` ya captura estos eventos.
- I/O: correlaciona waits con latencia de archivos, volumen y almacenamiento. `PAGEIOLATCH_*` no es equivalente a `PAGELATCH_*` (sin espera de disco).
- tempdb: distingue asignación, spills y version store. Log: crecimiento, espacio, `log_reuse_wait_desc`, backups, transacciones largas y colas de HA; no aplicar SHRINK como tratamiento de la causa.
- Memoria: identifica grants pendientes, clerks, presión del SO y límites. Paralelismo: interpreta CPU, duración, throughput y waits conjuntamente.

Usa `SET STATISTICS IO, TIME ON` solo en reproducción autorizada y restaura opciones de sesión. Conserva resultados comparables, sin limpiar caché en servidores compartidos. Cambia una causa por vez; comprueba resultados, parámetros extremos, picos de carga y posibles regresiones de escritura. Concluye «inconcluso» cuando los datos no sostengan una causa. Documenta con [la plantilla](../templates/performance-analysis-template.md).
