# Revisión de SQL

- [ ] Sintaxis y funciones pertenecen al motor/versiones observados; no traducción literal de otro dialecto.
- [ ] Valores parametrizados, identificadores de lista permitida y permisos mínimos.
- [ ] Tipos de parámetros coinciden; NULL, duplicados, límites y orden determinista probados.
- [ ] Agregaciones/joins preservan el grano; paginación y concurrencia tienen contrato.
- [ ] Escrituras tienen dueño de transacción, invariantes, manejo de errores y reintento acotado de la unidad completa.
- [ ] DDL no se presenta como reversible con ROLLBACK cuando este motor realiza implicit commit.
- [ ] La captura de un plan con ejecución está autorizada para los efectos de la sentencia.
- [ ] La optimización se sostiene en evidencia representativa, no en hints preventivos.

Consulta [sql-style](../references/sql-style.md), [query-design](../references/query-design.md) y [transactions-concurrency](../references/transactions-concurrency.md).
