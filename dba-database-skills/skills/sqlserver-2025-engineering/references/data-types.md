# Tipos y contrato de datos

Fuentes: [types](source-registry.md#types), [json](source-registry.md#json), [vector](source-registry.md#vector).

Elige tipo, nulabilidad, longitud, precisión, escala y collation por dominio. decimal/numeric para importes exactos; float/real para aproximaciones justificadas. Examina redondeo y overflow en cálculos y conversiones. Usa datetime2 para precisión de fecha/hora y datetimeoffset cuando el contrato requiera offset; ninguno conserva por sí solo todas las reglas de una zona geográfica.

nvarchar soporta texto Unicode; varchar depende de collation/codificación, incluida UTF-8 donde esté configurada. Longitud de almacenamiento no equivale siempre a caracteres visibles. Antes de migrar ntext/text/image o cambiar collation, prueba pérdida de datos, tamaño, índices y cliente. Evita MAX indiscriminado, pero no trunques contenido legítimo por una preferencia de estilo.

rowversion es un token binario de concurrencia, no fecha ni clave de negocio. IDENTITY y sequences no garantizan ausencia de huecos; su unicidad requiere constraint. uniqueidentifier tiene costos físicos dependientes del patrón de inserción.

json nativo cambia almacenamiento/contrato de drivers; valida conversiones, nulos SQL frente a JSON null y operaciones soportadas. Para vector registra dimensión, precisión, modelo de embeddings y métrica; compara calidad/recall además de latencia. Suponer equivalencia semántica entre búsquedas exactas y aproximadas es incorrecto.
