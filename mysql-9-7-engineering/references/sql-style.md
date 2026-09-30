# SQL y rutinas MySQL

Fuentes: [types](source-registry.md#types), [insert](source-registry.md#insert), [implicit-commit](source-registry.md#implicit-commit), [constraints](source-registry.md#constraints).

Usa terminadores y nombres database.table cuando ayuden a fijar destino. Backticks delimitan identificadores; comillas dobles dependen de ANSI_QUOTES. sql_mode afecta validación y expresiones: registra el modo bajo el que se crean rutinas y prueba el efectivo. Conserva ONLY_FULL_GROUP_BY salvo razón documentada; no desactivarlo para ocultar agregaciones ambiguas.

Valores parametrizados mediante el conector; placeholders no sirven para nombres de columnas/tablas. PREPARE del servidor tiene contexto y límites distintos de los parámetros del cliente. DELIMITER es un comando del cliente, no SQL que enviar dentro de cualquier driver.

En rutinas, DECLARE HANDLER, SIGNAL y RESIGNAL no equivalen a TRY/CATCH/THROW de SQL Server. Define dueño de la transacción y no confirmes trabajo del llamador. No añadas NOCOUNT ni XACT_ABORT: no pertenecen a MySQL. Funciones/triggers tienen restricciones sobre transacciones y efectos; comprueba el contexto.

LIMIT requiere orden estable para selección/paginación determinista. La igualdad null-safe se expresa con <=> cuando esa semántica es necesaria, sin promesa de acceso por índice. CTE recursivas, ventanas y JSON_TABLE tienen límites propios; no generes GENERATE_SERIES o WINDOW de otro dialecto sin confirmar sintaxis MySQL.
