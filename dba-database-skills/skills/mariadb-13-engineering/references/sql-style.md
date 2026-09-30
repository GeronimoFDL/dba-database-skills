# SQL y rutinas MariaDB

Fuentes: [releases](source-registry.md#releases), [constraints](source-registry.md#constraints), [transactions](source-registry.md#transactions), [sequence](source-registry.md#sequence).

Parametriza valores con el conector; valida y delimita identificadores por separado. Usa database.table cuando aclare resolución. ANSI_QUOTES y otros sql_mode cambian interpretación; registra modo de creación y de ejecución de rutinas. DELIMITER pertenece al cliente y no debe enviarse como SQL a cualquier driver.

Usa handlers, SIGNAL y RESIGNAL según el contexto. Establece dueño de transacción y contrato de errores; una rutina no debe confirmar silenciosamente trabajo ajeno. NOCOUNT, XACT_ABORT y TRY/CATCH de T-SQL no son instrucciones MariaDB. Las funciones, triggers y procedimientos tienen restricciones diferentes.

La igualdad null-safe <=> puede expresar la regla buscada; no promete un index seek. LIMIT necesita ORDER BY estable para resultados deterministas. Comprueba sintaxis de ventanas, CTE recursivas y funciones en MariaDB, sin extrapolar la documentación de MySQL.

En 13.0.2, REF CURSOR/RECORD como parámetros o retornos se documentan para rutinas de paquetes; no generes firmas globales suponiendo igual soporte. Confirma SQL mode y sintaxis del paquete. Las secuencias requieren gestionar caché, concurrencia y privilegios; no sirven como numeración fiscal sin huecos.

Devuelve columnas explícitas y contratos de tipos estables. No fuerces una plantilla transaccional en rutinas de solo lectura o en contextos que no admitan control transaccional.
