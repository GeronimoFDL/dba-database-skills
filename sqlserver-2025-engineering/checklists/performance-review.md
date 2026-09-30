# Revisión de rendimiento

- [ ] Síntoma, SLA, intervalo y carga real delimitados; evidencia anonimizada.
- [ ] Plan estimado/ejecutado identificado correctamente; parámetros, filas, lecturas y tiempos trazables.
- [ ] Causa separada: estimaciones, volumen, I/O, CPU, locks, latches, memoria, red o cliente.
- [ ] Estadísticas, distribución y configuración observadas, sin suponer valores de fábrica.
- [ ] Índices existentes y costo de escritura/espacio incluidos; scan no tratado como defecto por sí solo.
- [ ] Antes/después comparables, variabilidad y concurrencia incluidas.
- [ ] Efectos sobre otras consultas, mantenimiento y plan de retirada evaluados.

Consulta [performance-troubleshooting](../references/performance-troubleshooting.md), [indexing](../references/indexing.md) y [statistics](../references/statistics.md).
