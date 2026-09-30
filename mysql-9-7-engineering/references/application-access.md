# Conectores y aplicación

Fuentes: [types](source-registry.md#types), [transactions](source-registry.md#transactions), [insert](source-registry.md#insert), [tls](source-registry.md#tls), [auth](source-registry.md#auth).

Verifica soporte 9.7, autenticación y TLS del conector/ORM; MariaDB Connector no debe asumirse equivalente sin matriz de compatibilidad. Parámetros, charset de conexión, collation, timezone y sql_mode forman parte del contrato. Inspecciona SQL real, N+1 y transporte de DECIMAL/JSON/UNSIGNED.

Pooling requiere limpiar autocommit, transacción, variables de sesión, roles y temporales. No reutilices conexiones después de errores sin conocer estado. Timeouts y failover pueden dejar COMMIT con resultado desconocido; usa idempotency keys y reintentos de unidad completa para fallos reconocidos.

La cantidad de filas afectadas por UPSERT/UPDATE puede depender de operación y flags del cliente, como found rows; no inferir éxito de negocio solo por un conteo esperado. AUTO_INCREMENT recuperado debe asociarse a la misma conexión/operación.

Prepared statements y batches no garantizan plan óptimo ni atomicidad total. Define límites, cancelación y backpressure; evita cargar resultados masivos sin streaming cuando el cliente lo permita. Prueba round-trip de fechas, emojis, extremos numéricos y nulos con el driver real.
