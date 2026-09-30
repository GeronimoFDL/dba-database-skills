# MySQL 9.7 LTS: versión efectiva

Fuentes: [version](source-registry.md#version), [releases](source-registry.md#releases), [changes](source-registry.md#changes), [ddl](source-registry.md#ddl), [auth](source-registry.md#auth).

Registra VERSION(), version_comment, engine por tabla, sql_mode, isolation, autocommit y configuración efectiva. LTS estabiliza la línea funcional, no elimina parches ni diferencias de empaquetado. La nota 9.7.3 consultada corresponde a un parche de seguridad de la imagen Docker; no la presentes como upgrade binario general para toda plataforma.

| Aspecto | Verificación |
|---|---|
| 9.7 frente a Innovation | 9.7 cierra la numeración secuencial previa; versiones posteriores pueden usar calendario. No tratar 26.7 como parche 9.7. |
| InnoDB | Confirmar engine real; transacciones, FKs y recuperación descritas aquí no se generalizan a MEMORY/MyISAM u otros. |
| Defaults 9.7 | innodb_log_writer_threads depende de binlog y CPU; medir estado real, no copiar baseline de 8.4. |
| Variables retiradas | Revisar configuración heredada; replica_parallel_type y group_replication_allow_local_lower_version_join aparecen retiradas en la nota 9.7. |
| Distribución | Enterprise Backup, Audit o servicios HeatWave pueden requerir productos/licencia distintos; no ofrecerlos como núcleo Community. |
| Autenticación | Verificar caching_sha2_password, cliente y TLS; no recomendar downgrade a mysql_native_password como solución rutinaria. |

Atomic DDL proporciona recuperación de ciertas operaciones soportadas ante fallo, no transacciones de usuario que agrupen arbitrariamente DDL. Mantén explícita esta distinción en toda migración. Las prestaciones MariaDB, secuencias o RETURNING de ese motor no se trasladan automáticamente a MySQL.
