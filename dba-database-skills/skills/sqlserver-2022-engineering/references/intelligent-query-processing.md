# IQP: matriz para SQL Server 2022 (16.x)

Fuentes: [S01–S02, S09–S14, S17](source-registry.md). Comprobada el 2026-09-29. «Enterprise» incluye capacidades equivalentes de Developer/Evaluation en sus usos permitidos; no presupongas esa edición porque DEV la tenga. «Todas» se refiere a las ediciones 2022 de la matriz Microsoft. Los requisitos son necesarios, no garantía de elegibilidad ni beneficio.

| Capacidad | Compatibilidad mínima | Query Store | Edición 2022 | Configuración y decisión |
|---|---:|---|---|---|
| Parameter Sensitive Plan Optimization | 160 | Recomendado para observar; no obligatorio | Todas | `PARAMETER_SENSITIVE_PLAN_OPTIMIZATION = ON` por defecto en 160; parameter sniffing habilitado. Para SELECT elegible y predicados de igualdad con sesgo. No extender a DML o parámetros opcionales de 2025. |
| Cardinality Estimation Feedback | 160 | Habilitado y READ_WRITE | Enterprise | `CE_FEEDBACK = ON` por defecto. Corrige ciertas hipótesis de CE en consultas repetidas; no todo error de estimación. Plan forzado o hints del usuario pueden impedirlo. |
| Degree of Parallelism Feedback | 160 | Habilitado y READ_WRITE | Enterprise | `DOP_FEEDBACK = OFF` por defecto en 2022. Evaluar activación; ajusta paralelismo ineficiente dentro del límite MAXDOP. No vuelve paralela una consulta serial. |
| Batch mode Memory Grant Feedback | 140 | No para funcionamiento básico | Enterprise | `BATCH_MODE_MEMORY_GRANT_FEEDBACK = ON` por defecto. Ajusta futuras ejecuciones elegibles en batch mode. |
| Row mode Memory Grant Feedback | 150 | No para funcionamiento básico | Enterprise | `ROW_MODE_MEMORY_GRANT_FEEDBACK = ON` por defecto. Evalúa grants excesivos o insuficientes en ejecuciones repetidas. |
| Memory Grant Feedback persistence | 140; row mode requiere 150 | READ_WRITE | Enterprise | `MEMORY_GRANT_FEEDBACK_PERSISTENCE = ON` por defecto. Conserva feedback en Query Store; no exigir 160 por haber sido introducido en 2022. |
| Percentile Memory Grant Feedback | 140; row mode requiere 150 | READ_WRITE | Enterprise | `MEMORY_GRANT_FEEDBACK_PERCENTILE_GRANT = ON` por defecto. Usa historial de grants; sin Query Store operativo no surte efecto. |
| Scalar UDF Inlining | 150 | No | Todas | `TSQL_SCALAR_UDF_INLINING = ON` por defecto; restricciones de elegibilidad y correcciones por CU. `is_inlineable = 1` no confirma inlining real. |
| Table Variable Deferred Compilation | 150 | No | Todas | `DEFERRED_COMPILATION_TV = ON` por defecto. Usa filas de la primera ejecución al compilar; no crea estadísticas de columnas ni elimina sensibilidad a cardinalidades posteriores. |
| Batch Mode on Rowstore | 150 | No | Enterprise | `BATCH_MODE_ON_ROWSTORE = ON` por defecto; el optimizador decide elegibilidad. No confundirlo con batch mode sobre columnstore disponible con otras restricciones de edición. |

## Comprobación operacional

Optimized plan forcing está disponible en las ediciones enumeradas de 2022 [S01, S117](source-registry.md). `OPTIMIZED_PLAN_FORCING` está ON por defecto, pero requiere Query Store READ_WRITE y un plan elegible: reutiliza pasos de optimización para reducir compilación de consultas forzadas. No fuerza planes por sí solo ni garantiza menor tiempo de ejecución. Verifica `has_compile_replay_script` e `is_optimized_plan_forcing_disabled` en `sys.query_store_plan`; RECOMPILE y consultas distribuidas no son elegibles. No atribuyas este comportamiento a todas las consultas por tener compatibilidad 160.

Para `sys.query_store_plan_feedback`, usa `feature_id`, `feature_desc`, `state` y `state_desc`; `feature_type` no es la columna documentada. En 16.x distingue CE (1), memory grant (2) y DOP (3); no traslades LAQ de versiones posteriores. La vista requiere `VIEW DATABASE PERFORMANCE STATE` en 2022. Sus estados aportan evidencia del proceso, no una medición autónoma de mejora ni telemetría instantánea garantizada [S118](source-registry.md#s118).

1. Lee `SERVERPROPERTY('ProductVersion')`, `SERVERPROPERTY('Edition')`, `sys.databases.compatibility_level`, `sys.database_scoped_configurations` y `sys.database_query_store_options`.
2. Comprueba CU e incidencias conocidas. Mantén el análisis en 16.x; una página con selector ver16 todavía puede mostrar párrafos de 17.x.
3. Para PSP busca dispatcher y query variants en planes/Query Store. Para memory grants compara memoria concedida/usada, spills y atributos de feedback. Para CE/DOP consulta `sys.query_store_plan_feedback`, hints y Extended Events aplicables; no infieras activación por el nombre de la función.
4. Compara varias ejecuciones y parámetros antes/después; los mecanismos adaptativos necesitan historia y pueden quedar deshabilitados o no aplicar.

Caso conocido que ilustra la importancia del CU: S10 documenta una incidencia de CE feedback desde CU8, corregida en CU12, que podía aumentar memoria de plan cache y CPU en ciertas cargas. Si el build/síntoma coincide, investiga esa corrección antes de ajustar memoria o vaciar caché. No convierte CU12 en recomendación de parche actual: revisa el mantenimiento soportado y notas vigentes de 16.x.

No recomendar en 2022: Optional Parameter Plan Optimization (OPPO), PSP para DML, tipo nativo `json`, `CREATE JSON INDEX`, `JSON_CONTAINS`, `JSON_OBJECTAGG`/`JSON_ARRAYAGG`, optimized locking o automatic index compaction como capacidades generales de 16.x. Son capacidades de versiones/productos diferentes.

En particular, `CE_FEEDBACK_FOR_EXPRESSIONS` y su aprendizaje mediante firmas de expresiones corresponden a 2025; en 2022 usa el alcance documentado de `CE_FEEDBACK` [S10, S123](source-registry.md). DOP Feedback está OFF de fábrica en 2022, pero no lo actives por esa sola razón: confirma edición, requisitos y beneficio medido.

Query Store para réplicas secundarias legibles se documenta como **preview no soportada en producción en SQL Server 2022** [S02], aunque la tabla de ediciones la enumere. Para este conflicto prevalece la nota específica de soporte. No habilitarla como parte de un baseline de producción ni trasladar comportamiento de 2025.
