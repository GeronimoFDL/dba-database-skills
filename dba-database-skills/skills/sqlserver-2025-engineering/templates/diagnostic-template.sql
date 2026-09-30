-- SQL Server 2025: inventario acotado, sin mutaciones.
-- Ejecutar solo en la conexión autorizada; confirmar permisos y anonimizar salidas.
SELECT SERVERPROPERTY('ProductVersion') AS ProductVersion,
       SERVERPROPERTY('Edition') AS Edition, DB_NAME() AS DatabaseName;
SELECT name, compatibility_level, state_desc, recovery_model_desc,
       is_read_committed_snapshot_on, snapshot_isolation_state_desc
FROM sys.databases WHERE database_id = DB_ID();
SELECT actual_state_desc, desired_state_desc, readonly_reason
FROM sys.database_query_store_options;
-- La ausencia de filas/permisos no demuestra ausencia de la capacidad.
