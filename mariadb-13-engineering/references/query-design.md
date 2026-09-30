# Consultas y escrituras

Fuentes: [releases](source-registry.md#releases), [analyze](source-registry.md#analyze), [indexes](source-registry.md#indexes), [transactions](source-registry.md#transactions).

Conserva grano, NULL, multiplicidades y orden antes de optimizar. Diferencia NOT IN con NULL de un antijoin; usa EXISTS cuando solo importe existencia. Revisa conversiones de tipo/collation y predicados sobre columnas indexadas. Una función aplicada a la columna puede limitar acceso eficiente; mide el plan real.

INSERT ... ON DUPLICATE KEY UPDATE exige identificar qué UNIQUE representa el conflicto esperado. Con varias claves únicas, prueba la semántica concreta. REPLACE puede eliminar e insertar con consecuencias en IDs, triggers y relaciones; no sustituye inocuamente UPDATE. IGNORE puede ocultar errores como warnings; inspecciónalos.

En 13.0.2, verifica UPDATE ... RETURNING para una sola tabla y el uso documentado de OLD_VALUE(). No copies una sintaxis de OUTPUT de SQL Server ni extiendas el alcance a UPDATE multitabla. Prueba qué filas/valores recibe el cliente y su manejo de múltiples resultados.

Divide cargas grandes por clave estable y registra progreso, con límites de log y réplica. Define atomicidad total o parcial y reanudación. Una consulta previa de existencia no previene carreras: impón restricciones y usa un contrato transaccional adecuado.

Valida FOR UPDATE, SKIP LOCKED y aislamiento para colas antes de recomendarlos; una lectura que omite filas bloqueadas no produce un reporte completo. No añadas hints, QB_NAME o cambios de optimizer_switch sin un caso reproducible y un criterio de retirada.
