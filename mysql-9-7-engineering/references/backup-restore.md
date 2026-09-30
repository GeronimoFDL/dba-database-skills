# Copias y recuperación MySQL

Fuentes: [backup](source-registry.md#backup), [dump](source-registry.md#dump), [pitr](source-registry.md#pitr), [gtid](source-registry.md#gtid).

Define RPO/RTO, consistencia, retención y destino protegido. mysqldump con --single-transaction permite consistencia para tablas transaccionales, pero no protege automáticamente tablas no transaccionales ni DDL concurrente. Incluye routines, events, triggers, usuarios/permisos y configuración según su alcance; una lista de tablas no es copia completa del entorno.

Copias físicas deben usar herramientas compatibles con 9.7 y distribución; no supongas que una versión de XtraBackup o una herramienta MariaDB soporta MySQL 9.7. Enterprise Backup requiere producto/licencia verificados. Copiar archivos InnoDB en uso sin protocolo de backup no garantiza consistencia.

PITR combina base consistente y binlogs íntegros con posición/GTID y punto de parada correcto. Conserva timeline de promoción, claves y logs antes de purgar; probar aplicación de binlogs en copia aislada. Binlog y redo no cumplen la misma función. GTID_PURGED y GTID_EXECUTED requieren análisis del destino antes de restaurar.

Validar checksum o que el comando terminó no demuestra restore funcional. Restaura, verifica constraints/datos/aplicación y mide tiempo. Una réplica puede propagar DELETE accidental. Protege dumps porque contienen datos y definiciones ejecutables; nunca restaurar sobre producción para «probar» sin autorización.
