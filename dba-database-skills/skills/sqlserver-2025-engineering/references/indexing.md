# Índices por carga real

Fuentes: [indexes](source-registry.md#indexes), [maintenance](source-registry.md#maintenance), [resumable](source-registry.md#resumable), [editions](source-registry.md#editions).

Registra consultas, parámetros, selectividad, volumen, writes y planes antes de proponer índice. Diseña claves por igualdad/rango, joins, orden y reutilización; «más selectiva primero» no es una ley. INCLUDE añade cobertura y costo; no sirve como prefijo de búsqueda. Una PK puede ser nonclustered; un heap necesita justificación, no conversión automática.

Compara consolidación y extensión con índices existentes; distingue unicidad, filtro, dirección y columnas incluidas. Constraints no se retiran por falta de seeks. Filtered indexes requieren que el optimizador pruebe compatibilidad del predicado, incluida parametrización. Columnstore favorece ciertas cargas analíticas, pero necesita revisar calidad de rowgroups, ingestión y escrituras. Particionar no acelera cualquier consulta ni permite unicidad arbitraria entre particiones.

ONLINE y RESUMABLE dependen de edición y operación; pueden requerir locks y espacio simultáneo. ADD CONSTRAINT reanudable en 17.x aplica a PK/UNIQUE, no FK. Planifica pausa, MAX_DURATION, reanudación/aborto y sys.index_resumable_operations. Conserva DDL y mide regresiones antes de retirar índices.

Las missing-index DMVs son candidatos estimados, no instrucciones de creación ni análisis completo de costo. Consulta restricciones de índices JSON/vector por build y estado preview antes de emplearlos.
