# SQL, funciones y procedimientos

Fuentes: [functions](source-registry.md#functions), [insert](source-registry.md#insert), [merge](source-registry.md#merge), [schemas](source-registry.md#schemas).

Usa parámetros del driver; en SQL preparado del servidor suelen representarse como $1, $2. Para PL/pgSQL dinámico usa EXECUTE ... USING para valores y format con %I para identificadores previamente validados. No concatenes valores ni confundas %L con autorización.

Califica objetos cuando search_path no esté controlado, usa columnas explícitas y terminadores. LIMIT/OFFSET necesita ORDER BY estable cuando importa qué filas se obtienen; keyset puede evitar offsets profundos. generate_series y funciones de ventana tienen semántica propia de PostgreSQL, no límites de compatibilidad SQL Server.

Funciones y procedimientos difieren en control de transacciones y contextos de llamada; no copies BEGIN TRY/XACT_ABORT/NOCOUNT. Un bloque BEGIN de PL/pgSQL no equivale por sí mismo a iniciar transacción. EXCEPTION crea comportamiento de subtransacción y tiene costo; no atrapes WHEN OTHERS para ocultar fallos.

Marca volatilidad y paralelismo de funciones según su comportamiento real; declararlas IMMUTABLE por rendimiento puede producir resultados incorrectos. SECURITY DEFINER requiere search_path seguro, permisos de EXECUTE revisados y nombres calificados. RETURNING devuelve datos del comando, pero no demuestra COMMIT. MERGE y ON CONFLICT son alternativas con contratos distintos; prueba concurrencia.
