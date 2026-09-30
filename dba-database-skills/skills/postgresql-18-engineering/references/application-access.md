# Clientes y pooling

Fuentes: [types](source-registry.md#types), [transactions](source-registry.md#transactions), [ssl](source-registry.md#ssl), [functions](source-registry.md#functions).

Verifica driver y proveedor ORM para PostgreSQL 18, incluyendo tipos temporales, numeric, uuid, jsonb y rangos. Parametriza valores con tipos explícitos; un literal de texto y un parámetro tipado pueden producir planes diferentes. Inspecciona SQL real, N+1, buffering y transacciones del ORM.

Pooling por sesión y por transacción tienen contratos distintos: prepared statements, tablas temporales, LISTEN, advisory locks de sesión y SET pueden no sobrevivir como espera la aplicación. No asumir soporte de un pooler por nombre; comprueba versión y modo.

Define timeout, cancelación y recuperación de conexión en estado aborted. SQLSTATE 40001/40P01 pueden exigir reintentar la unidad completa, con límite e idempotencia. Un timeout cerca del COMMIT no confirma que no se escribió.

Para funciones privilegiadas o multi-tenant, prueba search_path y roles efectivos del cliente. COPY/bulk y batches reducen overhead pero requieren límites, errores y estrategia de reejecución. No trates UTC, offset y zona como equivalentes en la serialización; valida round-trip y cambio de horario.
