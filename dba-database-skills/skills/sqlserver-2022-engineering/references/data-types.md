# Tipos de datos

Fuentes: [S53–S58, S63–S64, S68, S88, S105](source-registry.md).

Selecciona el tipo por dominio, rango futuro y contrato con el cliente. Reducir almacenamiento es útil, pero elegir un rango insuficiente para ahorrar bytes puede provocar migraciones costosas. No asignes `max` o `bigint` a todo por comodidad.

| Familia | Criterio para 16.x |
|---|---|
| `tinyint`, `smallint`, `int`, `bigint` | Rango positivo 0–255 para tinyint; los otros son enteros con signo de 16/32/64 bits. Estima crecimiento y compatibilidad de PK/FK; documenta el margen. |
| `decimal(p,s)` | Cantidades exactas: deriva precisión y escala del dominio y de resultados intermedios. Prueba redondeo, multiplicación, división y overflow. |
| `money`, `smallmoney` | No están deprecated, pero su escala fija y truncamiento requieren cautela; favorece decimal diseñado para cálculos monetarios. La moneda debe modelarse aparte. |
| `bit` | Booleano, nullable solo si existe un tercer estado válido. |
| `date`, `time(p)` | Fecha o hora sin información que el dominio no necesita; una hora no representa por sí sola una duración ilimitada. |
| `datetime2(p)` | Instantes/fechas con precisión explícita; para UTC establece el contrato en escritura y lectura. No almacena zona horaria. |
| `datetimeoffset(p)` | Conserva el offset; no guarda reglas ni identificador de zona. Añade zona separada si el negocio la requiere. |
| `uniqueidentifier` | Identidad distribuida cuando sea necesaria; compara anchura y patrón de inserción. Un GUID aleatorio como clustered key puede aumentar splits; secuencial no elimina todos los costos ni sustituye seguridad. |
| `char(n)`, `nchar(n)` | Longitud fija real, no longitud máxima conocida de datos variables. |
| `varchar(n)`, `nvarchar(n)` | Longitud variable limitada por contrato; declara n en columnas, parámetros, variables y casts. |
| `varbinary(n/max)` | Binarios; `max` solo para tamaños que lo requieren. No representa texto sin acordar codificación. |
| `xml` | Datos que necesitan semántica XML, esquema o consultas XML. Evalúa costo de índices. |
| JSON | En 2022, texto `nvarchar` o `varchar` con codificación definida, validación y funciones JSON; no tipo nativo `json`. Usa `ISJSON` cuando el contrato exija JSON válido. |

## Unicode y conversiones

- Con una collation no UTF-8, `varchar` usa su página de códigos y puede perder caracteres ajenos. Para texto multilingüe, `nvarchar` con collation adecuada suele ser una opción directa. `varchar` con collation `_UTF8` también almacena Unicode en 2022; valida clientes, tamaño real y comparaciones antes de elegir.
- En `varchar(n)`, n es bytes; en `nvarchar(n)`, unidades de dos bytes. No equivale necesariamente a cantidad de caracteres: prueba caracteres suplementarios y límites. Para literales Unicode en nvarchar, usa `N'...'`.
- Empareja tipo, longitud y collation de joins/filtros y parámetros de EF/Dapper/SqlClient. Una conversión implícita puede afectar el acceso y la estimación; confirma el lado convertido en el plan antes de atribuirle una regresión.
- Declara `decimal` con p/s explícitos y parámetros de fecha tipados; evita parseo dependiente de idioma. Conserva la semántica de zona al reescribir rangos.
- Reemplaza `text` → `varchar(max)`, `ntext` → `nvarchar(max)`, `image` → `varbinary(max)` sin perder codificación. Si el dominio tiene un límite menor, valídalo antes de usar un tipo acotado. Para código nuevo, usa `rowversion` en lugar del sinónimo deprecated `timestamp`; no confundirlo con una fecha.

Comprueba impacto en índices, memoria, network payload y estimaciones. Un tipo correcto no garantiza un seek; selectividad y costo siguen importando.

## Migrar texto existente

Antes de convertir `ntext` multilingüe a `nvarchar(max)`, inventaría collation y soporte SC, contenido real, tamaños con `DATALENGTH`, NULL, dependencias y versiones de lectores/escritores. Conserva codificación y semántica de comparación; cambiar collation es otra decisión, no un efecto incidental de modernizar el tipo.

Una tabla pequeña puede admitir `ALTER COLUMN` en una ventana probada. Para volumen o disponibilidad que lo impidan, aplica [expand/contract](deployment.md): columna nueva, consumidores compatibles, copia por lotes reanudables y conciliación de escrituras concurrentes antes del cambio de lectura. No elimines la columna anterior hasta validar equivalencia, conteos, NULL, longitud y caracteres fuera del alfabeto latino, incluidos suplementarios si existen. Compara contenido de forma que la collation no oculte diferencias relevantes. Estima bloqueo, crecimiento de log/espacio y posibilidad de recuperación para ambos caminos; no generes ALTER directo a producción solo por haber elegido el tipo destino.
