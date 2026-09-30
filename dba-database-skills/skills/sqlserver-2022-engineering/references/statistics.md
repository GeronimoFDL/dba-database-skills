# Estadísticas

Fuentes: [S05–S08, S17](source-registry.md).

Mantén normalmente `AUTO_CREATE_STATISTICS` y `AUTO_UPDATE_STATISTICS` activados, salvo excepción comprobada. Auto-create crea estadísticas de una columna; no cubre automáticamente correlaciones multicolumna ni subconjuntos filtrados.

El histograma describe solo la primera columna y tiene un máximo de 200 pasos. Density aporta información sobre prefijos de columnas; ni FULLSCAN ni estadísticas multicolumna producen un histograma multidimensional perfecto. Antes de actualizar, compara filas reales/estimadas, valores de parámetros y distribución.

Consulta `sys.stats`, `sys.stats_columns` y `sys.dm_db_stats_properties` para `last_updated`, `rows`, `rows_sampled`, `steps` y `modification_counter`. Un valor NULL o una estadística reciente no prueba por sí solo un problema o su ausencia; documenta disponibilidad y contexto. El contador de modificaciones no describe todas las correlaciones posibles.

## Decisiones

| Situación | Acción evaluable |
|---|---|
| Carga grande o distribución significativamente distinta | Actualiza las estadísticas afectadas antes del workload crítico si la actualización automática no satisface el SLA. |
| Sesgo que el muestreo no representa | Compara un muestreo mayor o FULLSCAN sobre la estadística concreta; mide costo de I/O, CPU y cambios de plan. |
| Filtros relacionados | Evalúa estadísticas multicolumna y orden; comprueba mejora de estimaciones, no solo existencia del objeto. |
| Subconjunto estable muy distinto | Considera filtered statistics con predicado compatible con las consultas. |
| Tabla particionada grande | Evalúa incremental statistics para refrescar particiones afectadas; comprueba restricciones de soporte y que se necesite esa granularidad. |
| Compilaciones detenidas por actualización síncrona | Evalúa `AUTO_UPDATE_STATISTICS_ASYNC`: permite compilar con información anterior mientras actualiza en segundo plano. No garantiza estimaciones actuales. |
| Contención de metadatos con ASYNC | En 2022 puede evaluarse `ASYNC_STATS_UPDATE_WAIT_AT_LOW_PRIORITY`; no habilitar sin observar el problema. |

No programes `sp_updatestats` constante, FULLSCAN general ni desactivación de estadísticas automáticas como optimización preventiva. Tampoco apliques umbrales heredados de 20 % a todo: compatibilidad 160 ya incorpora umbrales dinámicos.

`ASYNC_STATS_UPDATE_WAIT_AT_LOW_PRIORITY` es una configuración de ámbito de base para la actualización automática asíncrona, junto con `AUTO_UPDATE_STATISTICS_ASYNC`; no es una opción universal de `UPDATE STATISTICS`. Reduce cierta contención al esperar el bloqueo de esquema, sin eliminar todo bloqueo ni garantizar estadísticas inmediatamente actuales [S06, S17](source-registry.md).

`REORGANIZE` no actualiza estadísticas. Un rebuild rowstore actualiza las estadísticas de su índice, no todas las de columnas; operaciones particionadas o resumibles tienen excepciones de muestreo. Evita volver a actualizarlas sin necesidad y destruir una muestra útil. Cada refresh puede provocar recompilaciones y planes distintos; registra el efecto y el costo.
