/*
   Ejemplo completo de migracion aditiva, no un deploy del dominio del usuario.
   Contrato minimo: dbo.ExampleEntity.ExternalReference nvarchar(100) NULL.
   Comprueba tipo nativo, longitud, nulabilidad y columna no calculada.
   No compara todo el schema: agregar al contrato collation, cifrado,
   masking u otras propiedades cuando sean requisitos del cambio real.
   Adaptar objeto, contrato y validaciones al proyecto antes de habilitar.
   SQL Server 2022, compatibilidad 160. Una sola sesion/runner de migracion.
   No requiere GO ni modo SQLCMD. Usar conexion dedicada sin transaccion
   exterior; posee su propia transaccion y deja XACT_ABORT ON en la sesion.

   Pre-check externo: alcance/autorizacion, schema esperado, permisos,
   espacio/log, bloqueos, consumidores y recuperacion ensayada.
   Validacion de aplicacion: lecturas/escrituras y consumidores anteriores.
   Roll-forward preferido para este ejemplo: mantener columna nullable y
   corregir consumidor. Quitarla despues puede perder escrituras nuevas;
   no se incluye DROP automatico como rollback.
   Fuentes: references/source-registry.md S20-S22, S71-S72, S93.
*/
DECLARE @Execute bit = 0;
DECLARE @ExpectedServer sysname = NULL;
DECLARE @ExpectedDatabase sysname = NULL;

IF @Execute = 0
BEGIN
    SELECT
        N'Preview: no se ha aplicado ningun cambio.' AS Status,
        CONVERT(nvarchar(128), SERVERPROPERTY('ServerName')) AS CurrentServer,
        DB_NAME() AS CurrentDatabase,
        N'Agregar dbo.ExampleEntity.ExternalReference nvarchar(100) NULL'
            AS ProposedChange;
    RETURN;
END;

IF @ExpectedServer IS NULL OR @ExpectedDatabase IS NULL
    THROW 51000, N'Defina servidor y base esperados antes de ejecutar.', 1;

IF @ExpectedServer <> CONVERT(nvarchar(128), SERVERPROPERTY('ServerName'))
   OR @ExpectedDatabase <> DB_NAME()
    THROW 51001, N'El destino conectado no coincide con el destino esperado.', 1;

IF DB_ID() <= 4
    THROW 51002, N'Este ejemplo no admite bases de sistema.', 1;

IF CONVERT(int, SERVERPROPERTY('ProductMajorVersion')) <> 16
    THROW 51003, N'Esta plantilla requiere SQL Server 2022 (16.x).', 1;

IF NOT EXISTS
(
    SELECT 1 FROM sys.databases
    WHERE database_id = DB_ID() AND compatibility_level = 160
)
    THROW 51004, N'Esta plantilla requiere compatibilidad 160; no la cambia.', 1;

IF @@TRANCOUNT <> 0
    THROW 51005, N'Ejecutar sin transaccion exterior; revisar contrato del runner.', 1;

SET XACT_ABORT ON;

BEGIN TRY
    BEGIN TRANSACTION;

    DECLARE @ObjectId int = OBJECT_ID(N'dbo.ExampleEntity', N'U');
    IF @ObjectId IS NULL
        THROW 51006, N'No existe la tabla esperada o no es visible para esta identidad.', 1;

    IF EXISTS
    (
        SELECT 1 FROM sys.columns
        WHERE object_id = @ObjectId AND name = N'ExternalReference'
    )
    BEGIN
        IF NOT EXISTS
        (
            SELECT 1 FROM sys.columns
            WHERE object_id = @ObjectId AND name = N'ExternalReference'
              AND system_type_id = 231 AND user_type_id = 231
              AND max_length = 200 AND is_nullable = 1 AND is_computed = 0
        )
            THROW 51007, N'La columna existe con un contrato diferente; revisar drift.', 1;
    END
    ELSE
    BEGIN
        -- Lote diferido fijo: se compila despues de las comprobaciones.
        EXEC sys.sp_executesql
            N'ALTER TABLE dbo.ExampleEntity ADD ExternalReference nvarchar(100) NULL;';
    END;

    IF NOT EXISTS
    (
        SELECT 1 FROM sys.columns
        WHERE object_id = @ObjectId AND name = N'ExternalReference'
          AND system_type_id = 231 AND user_type_id = 231
          AND max_length = 200 AND is_nullable = 1 AND is_computed = 0
    )
        THROW 51008, N'La validacion posterior del contrato ha fallado.', 1;

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF XACT_STATE() <> 0
        ROLLBACK TRANSACTION;
    THROW;
END CATCH;

SELECT N'Contrato de columna verificado; validar ahora la aplicacion.' AS Status;
