# Revisión de T-SQL

Usar junto con [t-sql-style](../references/t-sql-style.md), [query-design](../references/query-design.md) y, si hay escrituras, [transactions-concurrency](../references/transactions-concurrency.md). Marca no aplicable con motivo; no alargues una corrección pequeña.

- [ ] Semántica comprobada para NULL, duplicados, límites, tipos y cardinalidades de joins/agregados.
- [ ] Columnas/schema explícitos; parámetros del cliente y servidor compatibles.
- [ ] Sintaxis admitida en 16.x/compatibilidad real; restricciones de batch y GO tratadas por el ejecutor.
- [ ] Orden determinista si el contrato exige orden/paginación; ordinal de STRING_SPLIT no confundido con orden de salida.
- [ ] Entradas parametrizadas; estructura dinámica limitada a opciones permitidas.
- [ ] Invariantes protegidos ante dos sesiones concurrentes; UPSERT probado.
- [ ] Transacción con dueño claro; errores propagados y rollback posible según estado.
- [ ] Sin hints, índices ni RECOMPILE preventivos; rendimiento respaldado cuando se afirma mejora.
- [ ] OUTPUT no tratado como confirmación de commit; efectos externos y reintentos controlados.
- [ ] Pruebas realizadas y pendientes diferenciadas; hallazgos con evidencia y solución mínima.
