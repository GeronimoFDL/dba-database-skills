# Autovacuum, integridad y wraparound

Fuentes: [vacuum](source-registry.md#vacuum), [amcheck](source-registry.md#amcheck), [releases](source-registry.md#releases), [index-create](source-registry.md#index-create).

Autovacuum es esencial para reutilizar espacio, visibility map y congelar XIDs; no deshabilitarlo globalmente para resolver un síntoma. Vigila dead tuples, edad de XID/multixact, tablas grandes, transacciones largas, prepared transactions y replication slots que impiden avanzar. Ajusta por tabla según churn y capacidad.

VACUUM normal no garantiza devolver espacio al SO. VACUUM FULL reescribe y toma locks fuertes; reserva para necesidad medida, capacidad y ventana. ANALYZE no reemplaza vacuum/freeze. Bloat no se deduce solo del tamaño: correlaciona evolución, uso y herramientas apropiadas.

Checksums, amcheck/pg_amcheck y restore testing cubren aspectos diferentes; confirma extensión, alcance, locks y permisos. Ante corrupción conserva copia/evidencia y busca causa de almacenamiento. No emplees zero_damaged_pages o pg_resetwal como receta de reparación.

18.6 documenta casos concretos de GIN/reltuples y de reindex con btree_gist/ltree; verifica índices/tipos afectados en la nota antes de actuar. REINDEX CONCURRENTLY también tiene restricciones y necesita gestionar fallos/objetos inválidos. Toda tarea lleva límites, progreso, alertas y evidencia.
