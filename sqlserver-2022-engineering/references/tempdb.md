# tempdb

Fuentes: [S18, S38, S42](source-registry.md).

Dimensiona por picos de objetos temporales, sorts/hash spills, versionado y operaciones de mantenimiento; considera reinicios porque tempdb se recrea. Preasigna espacio razonable, deja margen y conserva autogrowth como respaldo, no como mecanismo de capacidad normal.

- Mantén data files del mismo tamaño y crecimiento configurado para distribución equilibrada. Usa incrementos absolutos adecuados al almacenamiento y monitoriza crecimiento, latencia y capacidad.
- Como punto inicial documentado, Microsoft propone tantos data files como procesadores lógicos hasta ocho; por encima de ocho, iniciar con ocho. Si se demuestra contención de asignación, evaluar incrementos de cuatro y medir o corregir workload. Es una guía inicial, no «un archivo por CPU» ni razón para reemplazar una configuración que funciona.
- Varios log files no paralelizan las escrituras del log. Dimensiona el log según uso y crecimiento real; no copies el número de data files.
- Distingue contención de asignación `PAGELATCH_*` de esperas de I/O `PAGEIOLATCH_*`, spills y version store. Más archivos no corrigen una consulta que genera trabajo temporal excesivo.
- Evalúa latencia/capacidad de almacenamiento, no solo letras de unidad; dos rutas pueden compartir el mismo recurso físico. Considera requisitos de disponibilidad del entorno.

Si RCSI/SNAPSHOT usa tempdb para versiones, mide tasa de generación y retención por transacciones largas. Con ADR habilitado, las versiones correspondientes se almacenan en PVS de la base de usuario; sigue midiendo otros usos de tempdb.

SQL Server 2022 mejora la concurrencia de actualización de GAM/SGAM; reduce contención de asignación, pero no elimina todas las esperas PAGELATCH. Las mejoras de PFS ya existían en 2019 [S38]. Identifica la página y el recurso antes de atribuir la espera: `sys.dm_db_page_info` ayuda a inspeccionar una página concreta; no es un monitor continuo de esperas. En 2022 requiere `VIEW DATABASE PERFORMANCE STATE` en la base [S122](source-registry.md#s122).

En 2022, autogrowth de log de hasta 64 MB puede beneficiarse de Instant File Initialization; no elijas automáticamente crecimientos pequeños en un log grande por esta característica. Dimensiona para reducir pausas y frecuencia de crecimiento. Cambios de ubicación o configuración requieren ventana, validación de permisos y comprobación tras reinicio cuando corresponda.
