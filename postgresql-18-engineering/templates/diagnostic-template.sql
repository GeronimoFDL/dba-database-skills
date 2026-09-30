-- PostgreSQL 18: inventario acotado, sin mutaciones.
-- Confirmar conexión autorizada y permisos; no incluye EXPLAIN ANALYZE.
SELECT current_database() AS database_name, current_user AS role_name,
       current_setting('server_version') AS server_version,
       current_setting('server_version_num') AS server_version_num;
SELECT name, setting, unit, context, pending_restart
FROM pg_catalog.pg_settings
WHERE name IN ('transaction_isolation','server_encoding','TimeZone',
               'shared_buffers','work_mem','max_connections','io_method',
               'data_checksums','output_plugin_libraries');
