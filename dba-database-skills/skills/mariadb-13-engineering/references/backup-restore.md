# Backup y recuperación

Fuentes: [backup](source-registry.md#backup), [pitr](source-registry.md#pitr), [releases](source-registry.md#releases), [temporal](source-registry.md#temporal).

Define RPO/RTO, retención y escenarios: borrado, corrupción, pérdida de nodo y sitio. Elige copia física o lógica compatible con versión, engine, tamaño y distribución. Usa versiones de mariadb-backup explícitamente compatibles; no intercambies MySQL Enterprise Backup o XtraBackup por semejanza.

Para copias físicas, completa la fase prepare que corresponda antes del restore. Restaura en un entorno aislado, confirma propietarios/permisos, configuración y claves, y valida integridad y aplicación. Conserva evidencia de duración y punto recuperado; una ejecución de backup exitosa no basta.

ADVERTENCIA ESPECÍFICA 13.0.2: las notas indican que mariadb-backup todavía no soporta el nuevo formato asociado a innodb_log_archive y falla con esa combinación. No habilites innodb_log_archive en la configuración recomendada ni lo presentes como sustituto listo de PITR. Cualquier uso requiere documentación actualizada para el build, herramientas compatibles y ensayo separado; no improvises recuperación manual.

PITR convencional requiere backup base coherente, binlogs íntegros y coordenadas/GTID adecuados. Ensaya recuperación hasta el evento deseado sin repetir el incidente. Retención/purga debe contemplar réplicas y ventanas de recuperación; HA no reemplaza histórico.

Para dumps, registra consistencia por engine, actividad DDL, rutinas, triggers, eventos, usuarios/grants y configuración. Comprueba que las tablas system-versioned incluyan las versiones históricas requeridas; no supongas que un dump predeterminado satisface auditoría histórica. Prueba restore con el cliente y servidor destinatarios.
