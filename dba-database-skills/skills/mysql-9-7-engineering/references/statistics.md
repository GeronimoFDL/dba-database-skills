# Estadísticas e histogramas

Fuentes: [statistics](source-registry.md#statistics), [explain](source-registry.md#explain).

InnoDB usa estadísticas persistentes/configurables: inspecciona cardinalidades, muestreo y auto-recalc. ANALYZE TABLE puede cambiar planes y consumir recursos; ejecutarlo indiscriminadamente no garantiza mejora. Revisa sesgo y correlaciones antes de tocar parámetros de muestreo globales.

Histogramas por columna ayudan a ciertas estimaciones; verifica su existencia, buckets, tipo de columna y actualización. No equivalen a estadísticas multicolumna de PostgreSQL ni al histograma de SQL Server. Las estadísticas persistentes no prueban vigencia tras cambios masivos.

Compara estimación con ejecución representativa, valores selectivos/no selectivos y joins. Costos no son milisegundos. Un índice recién creado y una distribución nueva pueden cambiar join order; conserva contexto para atribuir diferencias.

Lee tablas de estadísticas con permisos acotados y evita modificarlas manualmente como tuning rutinario. Evalúa impacto en plan y carga global, no solo una consulta artificial. Distingue caching del cliente, buffer pool y prepared statements antes de atribuir toda variación al optimizador.
