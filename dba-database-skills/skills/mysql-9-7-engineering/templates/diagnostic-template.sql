-- MySQL 9.7: inventario acotado; sin mutaciones ni EXPLAIN ANALYZE.
-- Confirmar conexión autorizada; no compartir identidades sin anonimizar.
SELECT VERSION() AS server_version, @@version_comment AS distribution,
       DATABASE() AS database_name, CURRENT_USER() AS effective_account;
SELECT @@SESSION.sql_mode AS sql_mode,
       @@SESSION.transaction_isolation AS transaction_isolation,
       @@SESSION.autocommit AS autocommit,
       @@character_set_server AS character_set_server,
       @@collation_server AS collation_server;
SELECT ENGINE, COUNT(*) AS table_count
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_TYPE = 'BASE TABLE'
GROUP BY ENGINE;
