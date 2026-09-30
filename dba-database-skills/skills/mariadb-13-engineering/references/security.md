# Seguridad efectiva

Fuentes: [security](source-registry.md#security), [roles](source-registry.md#roles).

Separa cuentas de aplicación, despliegue, backup, réplica y administración. Evalúa usuario@host, roles activos/default y privilegios efectivos. No extrapoles roles o plugins de autenticación MySQL. Evita cuentas administrativas en aplicaciones y grants globales para resolver un error local.

Verifica TLS y certificado del servidor con el conector real. Protege secretos, llaves, dumps y logs; no recomiendes desactivar verificación para resolver certificados. Cifrado en tránsito, en reposo y auditoría son controles diferentes, con plugins y requisitos de distribución que deben comprobarse.

Audita DEFINER y SQL SECURITY de rutinas/vistas, resolución de nombres y objetos usados por cuentas privilegiadas. Parametriza SQL dinámico; los nombres requieren lista permitida. Prueba permisos negativos con la identidad efectiva, incluida separación entre tenants.

No traduzcas automáticamente políticas RLS de PostgreSQL o Ledger de SQL Server a comandos MariaDB. Si una regla exige aislamiento por filas, diseña y prueba un mecanismo soportado y su resistencia a acceso directo, bypass y errores de aplicación.

Limita acceso a archivos, plugins y capacidades de importación. La recuperación debe incluir claves/certificados y sus permisos; un backup cifrado sin llaves recuperables no acredita recuperación.
