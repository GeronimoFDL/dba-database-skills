# Integridad y mantenimiento

Fuentes: [integrity](source-registry.md#integrity), [maintenance](source-registry.md#maintenance).

Programa CHECKDB según tamaño, criticidad y recursos. Identifica restricciones de snapshots internos, espacio y opciones; PHYSICAL_ONLY es alcance reducido, no sustituto permanente de una revisión lógica completa. Registra build, errores, hardware/I/O y estado de backups. Ante corrupción, preserva evidencia y evalúa restauración conocida antes de repair.

REPAIR_ALLOW_DATA_LOSS no equivale a recuperación completa y requiere decisión explícita tras revisar pérdida potencial. Nunca presentes repair o restauración WITH REPLACE como rutina preventiva. Prueba integridad también después de restaurar y de cambios de almacenamiento.

Índices: decide por rendimiento, densidad, tamaño, uso y costo. No apliques umbrales 5/30 % universales, ni SHRINK recurrente, ni FULLSCAN global. Gestiona operaciones resumibles pausadas y mantenimiento de estadísticas específico.

Automatiza jobs con propietario, permisos, historial, alertas, ventanas y prueba de fallo. Una tarea configurada no demuestra ejecución exitosa ni recuperación. Retén evidencia suficiente para ciclos de negocio y revisa lo que se pierde tras reinicios de DMVs.
