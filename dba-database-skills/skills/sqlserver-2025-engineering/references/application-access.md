# Clientes, EF Core y acceso a datos

Fuentes: [types](source-registry.md#types), [transactions](source-registry.md#transactions), [security](source-registry.md#security), [breaking](source-registry.md#breaking).

Verifica versión del driver/proveedor, soporte de SQL Server 17.x y de tipos nuevos. Parametriza valores con tipos/longitudes adecuados; AddWithValue o conversiones implícitas pueden alterar planes y resultados. Inspecciona SQL emitido por ORM, N+1, tracking, proyecciones y tamaño de resultados antes de culpar al motor.

Connection pooling no elimina autenticación ni estado de sesión: comprueba aislamiento, contexto de tenant y limpieza. Configura timeouts y cancelación con semántica de resultado desconocido. Reintenta solo fallos transitorios reconocidos y toda la unidad idempotente; evita duplicar cobros o mensajes tras timeout de COMMIT.

Comparar rowversion original y filas afectadas detecta concurrencia; no actualices silenciosamente el valor esperado. El dueño de transacción debe ser claro entre ORM, procedimiento y script. Prueba conexiones cifradas, certificados, failover y renovación de credenciales con el cliente real.

Bulk copy, TVPs y lotes necesitan contrato de orden, errores, tamaño y permisos. TVPs no reciben automáticamente estadísticas detalladas; evalúa cardinalidad y planes. Un cliente que serializa json/vector como texto puede perder precisión o rendimiento: comprueba round-trip y metadata antes de adoptar el tipo nativo.
