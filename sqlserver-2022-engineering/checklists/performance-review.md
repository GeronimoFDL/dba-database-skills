# Revisión de rendimiento

Referencias: [performance-troubleshooting](../references/performance-troubleshooting.md), [query-optimizer](../references/query-optimizer.md), [IQP](../references/intelligent-query-processing.md).

- [ ] Síntoma y objetivo cuantificados, con entorno/edición/CU/compatibilidad y workload.
- [ ] Plan y parámetros representativos disponibles, o carencia declarada sin conclusiones inventadas.
- [ ] Reads, CPU, duración, filas, frecuencia, concurrencia y variabilidad comparables.
- [ ] Estimaciones, conversiones, estadísticas, grants, spills y waits analizados en contexto.
- [ ] Blocking/deadlocks diferenciados de CPU/I/O/tempdb/log y de demoras del cliente.
- [ ] Contadores DMV con ventana y reinicios/reset documentados; Query Store con captura y estado real.
- [ ] Índices existentes, unicidad, filtros y costo de escritura incluidos en decisión.
- [ ] IQP validado por edición, compatibilidad, configuración, Query Store y plan.
- [ ] Cambio mínimo medido con varios parámetros y pruebas de corrección; mitigaciones tienen retirada.
- [ ] Comparación ponderada por ejecuciones, sin percentiles inventados a partir de promedios.
