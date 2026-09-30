# Integridad y corrupción

Fuentes: [S35, S37, S98](source-registry.md).

Verifica `PAGE_VERIFY CHECKSUM`; detecta ciertos daños al escribir/leer páginas, no demuestra ausencia de corrupción ni reescribe inmediatamente todas las páginas existentes. Revisa alertas y errores de I/O junto con resultados de CHECKDB.

Programa `DBCC CHECKDB` según criticidad, ventana, tamaño, cambios y capacidad de restaurar dentro del RTO. Guarda resultado completo, fecha de última ejecución satisfactoria y alertas accionables. «El job terminó» no basta sin revisar su salida y código de error.

Para bases grandes, estima CPU, I/O, snapshot interno y espacio de tempdb. Evalúa ejecutar CHECKDB sobre una restauración reciente en infraestructura separada y verificaciones físicas más frecuentes en el origen. `PHYSICAL_ONLY` es una comprobación parcial: define explícitamente cuándo se ejecuta la completa. El éxito en una copia no certifica el almacenamiento actual del origen.

Ante corrupción, conserva logs y evidencia, detén cambios que puedan agravarla y determina alcance y causa (almacenamiento, memoria, firmware, software). Identifica backups conocidos íntegros y prueba la recuperación. No sobrescribas las únicas copias útiles con nuevos backups corruptos.

La recuperación preferida es restaurar desde una copia válida, según tipo/alcance del daño y recovery model. `REPAIR_ALLOW_DATA_LOSS` es último recurso de emergencia cuando no es viable restaurar; puede desasignar datos y romper relaciones. Nunca es mantenimiento rutinario ni se ejecuta automáticamente. Antes de cualquier reparación, prepara copia preservada, impacto de pérdida, autorización específica y validación posterior de integridad y negocio. Un CHECKDB limpio después de reparar no demuestra que no se hayan perdido datos.
