# Estadísticas y planner

Fuentes: [statistics](source-registry.md#statistics), [explain](source-registry.md#explain).

Compara filas estimadas/reales por nodo y parámetros. ANALYZE muestrea distribuciones; revisa pg_stats, frecuencia, histograma y n_distinct, teniendo en cuenta permisos y exposición de valores. Autovacuum también puede ejecutar autoanalyze, con disparadores distintos de vacuum.

Usa objetivos de estadísticas por columna y CREATE STATISTICS para dependencias, MCV o ndistinct cuando el tipo de estimación lo aproveche. Las estadísticas extendidas no resuelven todas las correlaciones entre tablas. Subir default_statistics_target globalmente puede añadir costo sin beneficio.

Revisa estadísticas tras cargas/cambios relevantes, particiones y upgrades. Las estadísticas conservadas por pg_upgrade 18 ayudan, pero no certifican planes adecuados. Prueba parámetros sesgados y planes genéricos frente a personalizados; cambios de plan_cache_mode requieren evidencia.

EXPLAIN ANALYZE ejecuta: usa entorno autorizado y controla duración. Compara además buffers, I/O, sorts, hashes y paralelismo. No conviertas costos estimados en milisegundos ni sumes ingenuamente tiempos inclusivos de nodos.
