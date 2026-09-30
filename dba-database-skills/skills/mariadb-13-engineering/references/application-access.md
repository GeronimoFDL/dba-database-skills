# Conectores y aplicaciones

Fuentes: [types](source-registry.md#types), [transactions](source-registry.md#transactions), [releases](source-registry.md#releases), [security](source-registry.md#security).

Confirma soporte MariaDB 13.0 del conector/ORM, autenticación y TLS. No asumas que un driver MySQL implementa todas las prestaciones MariaDB. Prueba parámetros, DECIMAL, UNSIGNED, JSON, zonas horarias y múltiples resultados, especialmente al adoptar UPDATE RETURNING.

En pooling, limpia transacciones, autocommit, aislamiento, roles, variables y temporales. Define cancelación, timeouts y recuperación de conexiones fallidas. Identifica cuándo el resultado de COMMIT es desconocido y usa idempotencia antes de reintentar.

Inspecciona SQL generado, N+1, paginación, transporte de grandes resultados y compatibilidad del dialecto. Prueba callbacks de errores y reintentos completos para deadlocks o certificación Galera; evita reintentar únicamente la última sentencia.

No infieras reglas de negocio solo de filas afectadas, IDs autogenerados o defaults del driver. Prueba round-trip de nulos, extremos numéricos, texto Unicode y tiempo con el cliente real. Documenta qué garantía exige el servidor y cuál depende de la aplicación.
