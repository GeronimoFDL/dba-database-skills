# Tipos y charset

Fuentes: [types](source-registry.md#types), [json](source-registry.md#json).

Usa DECIMAL para importes exactos y prueba precisión/overflow. UNSIGNED cambia rangos y compatibilidad de FKs/parámetros; no convertirlo a entero firmado sin verificar extremos. BOOLEAN es sinónimo de TINYINT(1), no un dominio que limite por sí solo a dos valores; usa restricciones cuando el contrato lo requiera.

Elige utf8mb4 y collation de forma explícita según idioma, sensibilidad y unicidad. utf8 histórico no debe asumirse Unicode completo. Longitud indexable depende de bytes, engine y estructura; no reduzcas columnas silenciosamente para hacer pasar un índice. CHAR, VARCHAR, TEXT y BLOB tienen semántica/costos distintos.

TIMESTAMP realiza conversiones según time_zone y tiene límites distintos de DATETIME; DATETIME no identifica por sí solo un instante UTC. Define precisión, zona, fechas inválidas y comportamiento bajo sql_mode. No uses fechas cero como ausencia sin contrato.

JSON de MySQL tiene representación y funciones propias; no lo equipares al alias textual JSON de MariaDB. Distingue SQL NULL de JSON null, collation y extracción tipada. Para indexar, verifica expresiones/generated columns o índices multivalor compatibles. ENUM/SET requieren evolución de dominio controlada; UUID requiere decisión de representación y orden, no una equivalencia automática con uniqueidentifier.
