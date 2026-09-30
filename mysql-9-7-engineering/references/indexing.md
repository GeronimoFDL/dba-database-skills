# Índices InnoDB y DDL online

Fuentes: [indexes](source-registry.md#indexes), [online-ddl](source-registry.md#online-ddl), [foreign-keys](source-registry.md#foreign-keys).

La PK clustered se incorpora a índices secundarios; claves anchas aumentan almacenamiento y escritura. Diseña compuestos por igualdad/rango/orden y carga; no hay INCLUDE de T-SQL equivalente que copiar literalmente. Índices covering pueden ayudar, pero evalúa tamaño, buffer pool y frecuencia de cambios.

Índices de prefijo no siempre preservan unicidad completa ni cubren el valor original. Funcionales, generated columns, FULLTEXT y espaciales necesitan tipos, expresiones y operadores compatibles. MySQL no ofrece índices parciales con WHERE al estilo PostgreSQL: una generated column nullable puede modelar ciertas reglas, pero exige demostrar semántica de NULL y unicidad.

Invisible indexes ayudan a evaluar acceso, pero siguen consumiendo mantenimiento y no dejan de imponer unicidad. Revisa constraints y usos periódicos antes de eliminar. Optimización no consiste en evitar toda lectura de tabla.

Para ALTER elige ALGORITHM=INSTANT/INPLACE/COPY y LOCK según operación soportada, edición/engine y costo; INPLACE puede reconstruir, INSTANT no cubre todo. Usa requisitos explícitos para evitar fallback no deseado. Metadata locks pueden bloquear incluso operaciones online. No copies WITH(ONLINE=ON,RESUMABLE=ON) ni prometas pausa/reanudación genérica.
