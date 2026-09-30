# Integridad y mantenimiento InnoDB

Fuentes: [backup](source-registry.md#backup), [statistics](source-registry.md#statistics), [online-ddl](source-registry.md#online-ddl), [config](source-registry.md#config).

Inspecciona error log, fallos I/O, checksums y estado InnoDB antes de intentar reparar. CHECK TABLE tiene alcance y restricciones por engine; REPAIR TABLE no es remedio general para InnoDB. innodb_force_recovery es una vía extraordinaria de extracción/recuperación, no baseline ni cura que autorice escrituras normales.

Mantén copias consistentes y ensayos de restore como defensa principal. Ante corrupción preserva archivos/evidencia y evalúa restauración, hardware y versión antes de reconstruir índices o descartar páginas. Evita borrar redo/undo/ibdata manualmente.

OPTIMIZE TABLE puede reconstruir y consumir disco/locks; no programarlo universalmente como desfragmentación. Examina historial de crecimiento, espacio reutilizable, carga y estrategia de tablespaces. Un DELETE grande no devuelve necesariamente espacio al SO.

Vigila transacciones largas, history list y purge lag; retienen undo y afectan I/O. Dimensiona log/temporales y capacidad durante ALTER/rebuild. Eventos programados/jobs externos requieren privilegios, timezone, alerta y prueba de fallo; mantenimiento ejecutado no equivale a mejora medida.
