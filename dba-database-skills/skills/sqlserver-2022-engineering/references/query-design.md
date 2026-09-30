# Diseño de consultas y SARGability

Fuentes: [S03, S23, S54–S56, S63, S69–S70, S73, S80, S84, S89](source-registry.md).

## Preservar resultados antes de medir

- Prefiere operaciones por conjuntos para trabajo relacional. Cursores, loops y lotes pueden ser apropiados para tareas operacionales o límites de recursos; exige una razón y mide.
- Usa `EXISTS` para existencia sin multiplicar filas; `NOT EXISTS` para antijoin cuando se busque ausencia. `NOT IN` con NULL puede cambiar resultados. Valida duplicados antes de sustituir joins por EXISTS o viceversa.
- En agregaciones, define el grano, trata NULL explícitamente y evita dobles conteos por joins 1:N. Valida tamaño de resultados intermedios y overflow del agregado.
- Paginación necesita orden único estable. `OFFSET/FETCH` es simple pero puede leer mucho con offsets grandes; keyset pagination sirve para avanzar/retroceder por una clave estable, con índice y token adecuados. No promete saltos arbitrarios ni consistencia entre páginas si los datos cambian.
- `#temp` tiene estadísticas y posibilidades de indexación; úsala si división en fases o distribución lo justifica. Una table variable no es «solo memoria» y deferred compilation no le añade histogramas de columnas. Compara volúmenes pequeños/grandes y varias primeras ejecuciones.

## Predicados

`IS NOT DISTINCT FROM` expresa igualdad segura frente a NULL en 2022 [S112](source-registry.md#s112); mide el plan. Para `WHERE ISNULL(Estado, 0) = 1`, si Estado es int, `WHERE Estado = 1` selecciona las mismas filas sin exigir la nueva sintaxis. No generalices la sustitución a otros valores: `ISNULL(Estado, 0) = 0` también acepta NULL.

Evita aplicar transformaciones innecesarias a la columna de búsqueda; procura transformar el parámetro manteniendo semántica y tipos. Hay excepciones optimizables y computed columns indexadas: inspecciona el plan, no impongas una prohibición de sintaxis.

```sql
-- BAD para buscar por día en una columna datetime2 indexada:
WHERE CONVERT(date, o.CreatedAtUtc) = @Day

-- GOOD como candidato, con límites datetime2 del mismo contrato UTC:
WHERE o.CreatedAtUtc >= @StartUtc
  AND o.CreatedAtUtc < @EndUtc
```

La conversión a date puede recibir tratamientos especiales del optimizador; el ejemplo favorece un rango explícito, no afirma que todo CAST impida un seek. Deriva los límites fuera del predicado, prueba cambio de día, precisión, zona y extremos del tipo. Evita `BETWEEN` con un final de día artificial.

- Funciones, aritmética y conversiones sobre columnas pueden impedir un acceso eficiente. Una expresión indexada puede ser otra solución si el workload la justifica.
- `LIKE '%texto%'` normalmente no permite un seek convencional por prefijo. Full-text search tiene otra semántica; no lo sustituyas sin validar la búsqueda esperada.
- Un predicado SARGable permite opciones de acceso, pero no obliga a elegir seek. Un scan puede ser óptimo al devolver muchas filas.

## SQL dinámico y escrituras

```sql
DECLARE @Statement nvarchar(max) = N'
SELECT o.OrderId, o.CreatedAtUtc
FROM sales.OrderHeader AS o
WHERE o.CustomerId = @CustomerId;';
EXEC sys.sp_executesql
    @Statement,
    N'@CustomerId int',
    @CustomerId = @RequestedCustomerId;
```

El esquema y tipo deben coincidir con el proyecto. Parametriza valores; para nombres u orden dinámico, mapea opciones permitidas a identificadores revisados. No aceptes fragmentos SQL del usuario ni supongas que `QUOTENAME` valida autorización.

UPSERT necesita unicidad en el motor y protección contra carreras. `IF NOT EXISTS` seguido de INSERT no es suficiente. Evalúa una transacción corta con bloqueo de actualización y protección de rango (`UPDLOCK`, `HOLDLOCK`) sobre una búsqueda indexada por clave única, o inserción optimista con tratamiento específico de conflicto y reintento de la unidad completa. Prueba dos sesiones; no atrapes cualquier error como duplicado.

`MERGE` no está prohibido, pero requiere fuente sin duplicados por clave, condiciones ON correctas, semántica de triggers, pruebas de concurrencia y revisión de incidencias para el CU real. Separar DML puede facilitar el control; tampoco elimina carreras sin un diseño transaccional.

Para DML masivo, usa lotes ordenados por clave, checkpoints y predicados reanudables; decide si la atomicidad total es necesaria. Registra conteos y valida el estado final; `OUTPUT` por sí solo no confirma éxito.
