# Consultas y escrituras

Fuentes: [explain](source-registry.md#explain), [insert](source-registry.md#insert), [merge](source-registry.md#merge), [indexes](source-registry.md#indexes).

Identifica grano y multiplicidad antes de reescribir joins/agregaciones. EXISTS/NOT EXISTS y NULL necesitan validación; evita dividir agregados tras un join que duplicó filas. CTE puede inlinearse o materializarse según caso y cláusulas; no impongas MATERIALIZED como caché gratuita.

Transforma parámetros cuando preserve semántica, alinea tipos y revisa operadores/indexes de expresión. IS NOT DISTINCT FROM no garantiza un index scan. Una sequential scan puede ser correcta. Para búsquedas de texto evalúa capacidades de núcleo/extensiones y su semántica, sin sustituir LIKE por una búsqueda lingüística diferente.

INSERT ... ON CONFLICT requiere árbitro único/exclusión según acción; su manejo de conflicto no elimina otros invariantes concurrentes. MERGE no es reemplazo universal con idénticas garantías. Evita SELECT de existencia seguido de INSERT sin protección. Prueba conflictos simultáneos y reintentos idempotentes.

FOR UPDATE SKIP LOCKED puede servir a colas, pero ofrece vista inconsistente para reportes generales. Lotes con límites y orden estable reducen retención de locks/WAL; registra progreso y fallos parciales. COPY exige permisos y origen/destino revisados; COPY del servidor y comandos del cliente operan en máquinas distintas.
