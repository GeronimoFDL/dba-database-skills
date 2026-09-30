# Alta disponibilidad y recuperación ante desastres

Fuentes: [S01–S02, S33–S34, S44–S45](source-registry.md).

**High Availability ≠ Disaster Recovery ≠ Backup.** Define fallos que deben cubrirse, RPO/RTO, dominio de fallo, latencia, presupuesto y capacidades de edición/plataforma. Una réplica puede reproducir una eliminación errónea; no sustituye copias recuperables con retención.

| Alternativa | Aplicación y límites |
|---|---|
| Always On Availability Groups | Réplicas de bases y políticas de failover. Synchronous commit añade latencia y requiere estado/condiciones adecuadas para failover sin pérdida; asynchronous commit puede perder transacciones aún no enviadas/endurecidas. Configura quorum, conectividad, listener y aplicación. |
| Basic AG de Standard | Límites distintos de Enterprise; confirma número de réplicas/bases y restricciones de lectura/backup. No pruebes solo en Developer y asumas equivalencia. |
| Failover Cluster Instance | Disponibilidad a nivel de instancia; depende del almacenamiento compartido o solución soportada. No crea por sí sola una copia aislada para desastre. |
| Log shipping | Copia/restauración de logs con posible demora intencional; failover y recuperación requieren procedimientos y controles de la cadena. Puede ser adecuado para DR con RTO compatible. |
| Backup/restore | Recuperación histórica y portabilidad; integra copia separada, custodia de claves y ensayos. |
| Replicación | Distribución de datos para casos concretos; no asumir que copia toda la base, objetos de instancia o estado recuperable. |

Antes de aprobar, prueba failover y failback, reconexión/pooling, transacciones interrumpidas, lag de log/redo, pérdida de nodo/sitio, quorum y capacidad del destino. Sincroniza los logins, jobs, credenciales, certificados y dependencias que el diseño elegido no transporte automáticamente. Incluye restricciones de Windows/Linux y edición.

Para offload de backups en secundarios de AG de 2022, confirma tipos admitidos: full copy-only y log según condiciones; no traslades soporte ampliado de 2025. Query Store en secundarios legibles es preview no soportada en producción 2022 [S02]. Define monitoreo, operadores y runbooks; una arquitectura configurada sin simulacros no demuestra el RTO.
