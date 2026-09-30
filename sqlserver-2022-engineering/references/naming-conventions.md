# Convenciones de nombres

Fuentes técnicas: [S59](source-registry.md). El resto de la tabla es una convención local sugerida, no una norma de Microsoft.

Conserva una convención coherente existente. En proyectos nuevos, usa nombres que expresen dominio y propósito, schema qualification para objetos persistentes y nombres explícitos de constraints para facilitar cambios y diagnóstico. Evita renombrar objetos solo por estética; pueden existir consumidores externos y SQL dinámico.

| Objeto | Ejemplo o criterio |
|---|---|
| Schema | `sales`, `billing`; dominio o límite de permisos |
| Tabla | `sales.OrderHeader`, `sales.OrderLine`; singular/plural según el repositorio |
| Columna | `OrderId`, `CreatedAtUtc`, `TotalAmount`; unidad o zona cuando sean parte del contrato |
| PK | `PK_OrderHeader` |
| FK | `FK_OrderLine_OrderHeader_OrderId` |
| UNIQUE | `UQ_OrderHeader_OrderNumber` |
| CHECK | `CK_OrderLine_Quantity_Positive` |
| DEFAULT | `DF_OrderHeader_CreatedAtUtc` |
| Índice | `IX_OrderHeader_CustomerId_CreatedAtUtc`; `UX_` para índice único fuera de constraint si el proyecto lo usa |
| View | `sales.OpenOrders` o `sales.vw_OpenOrders` según convención |
| Procedimiento | `sales.GetOrder`, `sales.CreateOrder`; evita `sp_` en procedimientos de usuario |
| Función | `sales.CalculateTax`, o nombre del conjunto para una TVF |
| Trigger | `TR_OrderHeader_Audit`; propósito y evento documentados |
| Sequence | `sales.OrderNumberSequence` |

Evita nombres reservados, abreviaturas ambiguas, información sensible e identificadores que requieran quoting innecesario. Respeta el límite de identificadores del motor y comprueba colisiones al construir nombres largos. No codifiques detalles volátiles como todas las columnas INCLUDE en el nombre del índice. Un nombre no garantiza la forma del objeto: inspecciona su definición antes de una migración.
