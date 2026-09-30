/*
   Inventario acotado para SQL Server 2022 (16.x).
   Ejecutar en la base seleccionada y dentro del alcance autorizado.
   Solo lectura; aun asi requiere revisar costo y confidencialidad.
   La seccion DMV es optativa: requiere VIEW SERVER PERFORMANCE STATE.
   No captura planes reales ni ejecuta consultas de negocio.
   Fuentes: references/source-registry.md S17, S48, S81.
*/
DECLARE @CollectPlanCache bit = 0;

SELECT
    CONVERT(nvarchar(128), SERVERPROPERTY('ServerName')) AS ServerName,
    CONVERT(nvarchar(128), SERVERPROPERTY('Edition')) AS Edition,
    CONVERT(nvarchar(128), SERVERPROPERTY('ProductVersion')) AS ProductVersion,
    DB_NAME() AS DatabaseName,
    SYSDATETIMEOFFSET() AS CapturedAt;

SELECT
    d.name,
    d.compatibility_level,
    d.recovery_model_desc,
    d.is_read_committed_snapshot_on,
    d.snapshot_isolation_state_desc,
    d.page_verify_option_desc
FROM sys.databases AS d
WHERE d.database_id = DB_ID();

SELECT
    c.name,
    c.value,
    c.value_for_secondary
FROM sys.database_scoped_configurations AS c
WHERE c.name IN
(
    N'PARAMETER_SENSITIVE_PLAN_OPTIMIZATION', N'PARAMETER_SNIFFING',
    N'CE_FEEDBACK', N'DOP_FEEDBACK', N'MAXDOP',
    N'BATCH_MODE_MEMORY_GRANT_FEEDBACK', N'ROW_MODE_MEMORY_GRANT_FEEDBACK',
    N'MEMORY_GRANT_FEEDBACK_PERSISTENCE',
    N'MEMORY_GRANT_FEEDBACK_PERCENTILE_GRANT',
    N'TSQL_SCALAR_UDF_INLINING', N'DEFERRED_COMPILATION_TV',
    N'BATCH_MODE_ON_ROWSTORE'
)
ORDER BY c.name;

SELECT
    q.actual_state_desc,
    q.desired_state_desc,
    q.readonly_reason,
    q.current_storage_size_mb,
    q.max_storage_size_mb,
    q.query_capture_mode_desc,
    q.stale_query_threshold_days,
    q.size_based_cleanup_mode_desc,
    q.interval_length_minutes
FROM sys.database_query_store_options AS q;

IF @CollectPlanCache = 1
BEGIN
    -- TOP limita salida, no el costo de recorrer/ordenar la cache.
    -- Sin SQL text ni XML para evitar exponer literales en esta plantilla.
    -- Acumulados desde compilacion: no comparar como intervalos iguales.
    SELECT TOP (20)
        qs.query_hash,
        qs.query_plan_hash,
        qs.creation_time,
        qs.last_execution_time,
        qs.execution_count,
        qs.total_logical_reads,
        qs.total_physical_reads,
        CAST(qs.total_worker_time / 1000.0 AS decimal(28, 3)) AS TotalCpuMs,
        CAST(qs.total_elapsed_time / 1000.0 AS decimal(28, 3)) AS TotalElapsedMs,
        CAST(qs.total_logical_reads * 1.0 / NULLIF(qs.execution_count, 0)
             AS decimal(28, 3)) AS AvgLogicalReads
    FROM sys.dm_exec_query_stats AS qs
    CROSS APPLY sys.dm_exec_plan_attributes(qs.plan_handle) AS pa
    WHERE pa.attribute = N'dbid'
      AND CONVERT(int, pa.value) = DB_ID()
    ORDER BY qs.total_worker_time DESC, qs.query_hash;
END;
