# Diagnóstico, Query Store e IQP

Fuentes: [query-store](source-registry.md#query-store), [iqp](source-registry.md#iqp), [oppo](source-registry.md#oppo), [psp](source-registry.md#psp), [ce](source-registry.md#ce), [editions](source-registry.md#editions).

Define síntoma, intervalo, SLA, consulta y parámetros. Clasifica CPU, I/O, memoria, spills, waits, locks, compilación, cliente o red. Captura primero evidencia acotada: Query Store, DMVs, planes existentes y Extended Events específicos. Verifica permisos de performance state de 17.x; no uses sysadmin como solución de monitoreo.

Query Store está ON para bases nuevas, no prueba el estado de restauradas. Comprueba actual_state_desc, readonly_reason, captura, retención y espacio. Sus métricas agregadas no son un plan real por ejecución: pondera promedios por cantidad y no inventes percentiles. Evita ALL/CLEAR como recetas.

Para PSP/OPPO busca dispatcher y variantes; para grants compara memoria concedida/usada y spills en varias ejecuciones. CE/DOP y feedback de expresiones tienen requisitos distintos. sys.query_store_plan_feedback usa feature_id/feature_desc y state_desc; observa evidencia, no una mejora automática por un estado.

Plan forcing e hints son mitigaciones específicas: comprueba éxito, parámetros adversos y retirada. Optimized plan forcing reduce compilación de planes forzados elegibles; no fuerza consultas por sí solo. No vacíes cachés ni actives todos los feedbacks para «probar». Registra cambios, resultados y reversión; distingue opciones GA/preview y edición antes de recomendar.
