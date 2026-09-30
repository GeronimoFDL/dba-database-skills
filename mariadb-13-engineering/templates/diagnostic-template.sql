-- MariaDB 13.0: inventario acotado de solo lectura.
-- Usar una conexión autorizada; anonimizar identidades al compartir resultados.
SELECT VERSION() AS server_version, @@version_comment AS distribution,
       DATABASE() AS database_name, CURRENT_USER() AS effective_account;
SELECT VARIABLE_NAME, SESSION_VALUE, GLOBAL_VALUE
FROM information_schema.SYSTEM_VARIABLES
WHERE VARIABLE_NAME IN ('SQL_MODE', 'AUTOCOMMIT', 'TX_ISOLATION',
                        'CHARACTER_SET_SERVER', 'COLLATION_SERVER',
                        'INNODB_LOG_ARCHIVE');
SELECT ENGINE, COUNT(*) AS table_count
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_TYPE = 'BASE TABLE'
GROUP BY ENGINE;
