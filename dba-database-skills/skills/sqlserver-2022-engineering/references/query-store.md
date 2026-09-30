# Query Store

Fuentes: [S02, S15–S17, S81](source-registry.md).

En SQL Server 2022 está activado por defecto para bases nuevas; una base restaurada o actualizada conserva ajustes anteriores. Verifica estado deseado y real: `actual_state_desc`, `desired_state_desc`, `readonly_reason`, espacio actual/máximo, captura, retención e intervalo. READ_WRITE es requisito de varios feedbacks; ON no basta si el estado real cambió.

## Configuración contextual

- Favorece `AUTO` como inicio de captura; `CUSTOM` permite adaptar umbrales a la carga. `ALL` puede añadir mucho ruido con consultas ad hoc; `NONE` detiene captura nueva, no equivale a borrar historia.
- Dimensiona `MAX_STORAGE_SIZE_MB` por cantidad de consultas/planes, retención y espacio disponible. Ajusta `STALE_QUERY_THRESHOLD_DAYS`, cleanup por tamaño e intervalos a ciclos operacionales y necesidades de investigación; no copies tamaños universales.
- Observa overhead, razón de READ_ONLY y limpieza antes de ampliar espacio. Exporta evidencia relevante antes de eliminar historia. No usar CLEAR como tarea rutinaria.
- Captura waits si son útiles al diagnóstico y revisa permisos y confidencialidad del texto almacenado. La retención debe cumplir la política del proyecto.

## Regresiones y mitigación

Compara ventanas equivalentes antes y después del deployment, volumen de ejecuciones, CPU, duración, reads y variabilidad. Query Store almacena estadísticas agregadas; no constituye un plan real con conteos por operador de cada ejecución. No promedies promedios sin ponderar el número de ejecuciones ni inventes percentiles a partir de medias.

Para plan forcing, identifica plan/query correctos, verifica índices y contexto y confirma que forzarlo tiene éxito. Conserva alternativa de `sys.sp_query_store_unforce_plan` y monitoriza fallos de forcing y otros parámetros.

Para Query Store hints, justifica primero por qué no basta corregir consulta, tipos, estadísticas o diseño. Registra el hint anterior y utiliza `sys.sp_query_store_set_hints`; comprueba `sys.query_store_query_hints`, fallos y rendimiento. La reversión usa `sys.sp_query_store_clear_hints` o restablece el hint anterior, no elimina toda la historia. Pueden sobreponerse a hints escritos en la consulta y afectar otros mecanismos IQP; revisa interacciones.

No ejecutar forcing/hints solo porque una consulta esté entre las más costosas: puede realizar trabajo útil y estar bien optimizada. Define responsable, período de observación y criterio para retirar mitigaciones. Para réplicas secundarias de 2022 consulta la restricción en [IQP](intelligent-query-processing.md).
