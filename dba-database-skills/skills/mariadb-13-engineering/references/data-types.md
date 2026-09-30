# Tipos y representación

Fuentes: [types](source-registry.md#types), [json](source-registry.md#json), [temporal](source-registry.md#temporal).

Usa DECIMAL para cantidades exactas, con escala y redondeo de negocio. Verifica extremos al cruzar UNSIGNED y tipos del cliente. BOOLEAN es una representación numérica, no garantía suficiente de dominio de dos valores. Define nulabilidad y CHECK cuando corresponda.

Especifica utf8mb4 y una collation adecuada para igualdad, orden y unicidad. No supongas que nombres de collations MySQL existen o significan exactamente lo mismo en MariaDB. El número de caracteres no es el tamaño en bytes del índice. Prueba emojis, acentos, espacios y cambios de collation antes de reconstruir claves únicas.

TIMESTAMP y DATETIME tienen contratos diferentes sobre zona y rango; fija zona de conexión, precisión y manejo de fechas inválidas según sql_mode. Un texto de fecha o DATETIME sin zona no determina un instante por sí solo. Separa vigencia de negocio, auditoría y tiempo de transacción.

JSON en MariaDB es un alias de LONGTEXT con características de collation y validación documentadas; no es el almacenamiento binario de MySQL. Comprueba la definición efectiva, JSON_VALID, claves duplicadas, extracción, SQL NULL y JSON null. Para indexar propiedades evalúa columnas generadas e índices compatibles; no copies índices multivalor de MySQL por similitud de nombres.

Usa tipos especializados y secuencias solo tras verificar soporte del servidor, conector y herramientas de dump. Para UUID, define representación, comparación y orden antes de convertir datos. No uses campos JSON o listas delimitadas para ocultar relaciones que requieren integridad referencial.
