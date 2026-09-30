# T-SQL de SQL Server 2022

Fuentes: [S59–S70, S80, S94–S97, S104](source-registry.md). Estilo: keywords en MAYÚSCULAS, cuatro espacios salvo convención existente, alias legibles, columnas explícitas, parámetros tipados y `;` al terminar sentencias. `GO` es separador del cliente, no T-SQL: no enviarlo dentro de un único `DbCommand`.

## Sintaxis disponible, no obligación de uso

Para las incorporaciones siguientes: [S112–S116, S126](source-registry.md). No sustituyas una consulta correcta solo por usar sintaxis más reciente; compara semántica y costo.

| Construcción | Uso y límite |
|---|---|
| `CREATE OR ALTER` | Procedimientos, funciones, vistas y triggers compatibles. No sirve para tablas ni sustituye un plan de migración. Respeta las reglas de batch del objeto. |
| CTE | Expresa una consulta; no garantiza materialización ni caché. Para reutilización costosa evalúa `#temp` y su costo total. |
| Recursive CTE | Define ancla, avance y terminación; prueba ciclos y profundidad. `MAXRECURSION 0` elimina el límite, no corrige ciclos. |
| `APPLY` | Relación lateral; `CROSS APPLY` elimina filas sin resultado, `OUTER APPLY` las conserva. Mide ejecuciones repetidas de la rama interior. |
| Window functions | Ranking/agregación sin perder detalle; orden determinista y frame explícito cuando afecte el resultado. |
| `WINDOW` | Reutiliza ventanas nombradas; requiere compatibilidad 160. Mejora claridad, no implica mejora automática de rendimiento. |
| `GENERATE_SERIES(start, stop, step)` | En 2022 requiere compatibilidad 160. `start` y `stop` deben tener el mismo tipo numérico admitido; `value` conserva ese tipo, no es siempre bigint. Explicita paso y límites, evita cero y comprueba el volumen; no reemplaza universalmente una tabla de números. |
| `DATE_BUCKET` | Agrupa por intervalos con ancho positivo y origen definido. Sin origen usa 1900-01-01; `date` y `origin` deben tener el mismo tipo temporal. Valida límites y calendario del negocio; no garantiza un seek. |
| `IS [NOT] DISTINCT FROM` | Comparación con resultado verdadero/falso incluso con NULL. Úsala si esa es la semántica requerida; no garantiza SARGability ni elimina todos los scans. |
| `IGNORE NULLS` / `RESPECT NULLS` | Disponibles en 2022 para FIRST_VALUE/LAST_VALUE y LAG/LEAD; RESPECT NULLS es el valor predeterminado. Define orden y frame; LAST_VALUE puede devolver el valor del frame actual, no el último de la partición. Revisa la corrección de IGNORE NULLS de LAG/LEAD en CU4 y el build efectivo. |
| `STRING_SPLIT(text, separator, 1)` | Ordinal disponible en 2022, función con compatibilidad mínima 130. El tercer argumento es constante 0/1; para orden original usa `ORDER BY ordinal`. |
| `STRING_AGG` | Usa `WITHIN GROUP` si importa el orden; controla NULL y longitud resultante. Castea a `nvarchar(max)` antes de agregar solo si la salida puede superar el límite del tipo acotado. |
| `GREATEST`, `LEAST` | Disponibles en 2022. Ignoran NULL si hay otro argumento no nulo; todos NULL devuelve NULL. Revisar precedencia de tipos y conversiones. |
| `DATETRUNC` | Disponible en 2022; expresa truncamiento temporal. `week` depende de `DATEFIRST`; `iso_week` no. No lo impongas sobre columnas filtradas. |
| JSON | `JSON_VALUE`, `JSON_QUERY`, `JSON_MODIFY`, `FOR JSON`; `OPENJSON` requiere 130. `JSON_OBJECT`, `JSON_ARRAY` e `ISJSON(..., OBJECT/ARRAY/VALUE/SCALAR)` están en 2022. No añadir `RETURNING json` ni agregados JSON de 2025. |
| `CASE` | Expresión, no control de flujo. No bases la seguridad de una división en asumir evaluación corta de todas sus ramas; usa tipos y `NULLIF` cuando su semántica sea válida. |
| `OUTPUT` | Devuelve valores afectados; no garantiza orden ni confirma COMMIT. Puede devolver filas aunque la sentencia falle o se revierta. |

En JSON, el valor SQL NULL y el JSON null requieren contrato explícito: `JSON_OBJECT` conserva NULL por defecto y `JSON_ARRAY` omite el elemento por defecto; usa la cláusula adecuada. `ISJSON` no verifica unicidad de claves ni un esquema de negocio.

Usa `schema.object` para objetos persistentes; no traduzcas literalmente `LIMIT`, `BOOLEAN`, `SERIAL` u `ON DELETE RESTRICT` desde otro dialecto. En SQL Server, revisa `TOP`, `OFFSET/FETCH`, `bit`, `IDENTITY`/sequences y `NO ACTION` según el contrato. `TOP (N)` con columnas explícitas y orden apropiado sigue siendo válido; no fuerces OFFSET/FETCH. El ordinal de STRING_SPLIT es opcional cuando el orden no importa, y no ordena el resultado sin ORDER BY.

En procedimientos, considera `SET NOCOUNT ON` para reducir mensajes de filas afectadas cuando el cliente no dependa de ellos. Usa `SET XACT_ABORT ON` con el contrato transaccional de [transactions-concurrency](transactions-concurrency.md), no como decoración universal. Triggers deben manejar múltiples filas de `inserted`/`deleted` y evitar trabajo externo prolongado.
