# Tipos y dominios

Fuentes: [types](source-registry.md#types), [generated](source-registry.md#generated), [version](source-registry.md#version).

Usa numeric para aritmética exacta, enteros adecuados al rango y boolean para lógica; no copies bit/IDENTITY de T-SQL. text no es intrínsecamente peor que varchar; impón límites por dominio, no por un supuesto rendimiento universal. Collation y encoding condicionan comparación, unicidad e índices; registra proveedor y versión para upgrades del sistema.

timestamptz representa un instante y se presenta según TimeZone; no conserva el nombre original de la zona. timestamp without time zone tiene otra semántica. Define UTC/zonas, cambios de horario y precisión; no conviertas silenciosamente. Usa date, interval, uuid, bytea, arrays o rangos cuando expresen el dominio.

json conserva texto, jsonb representa contenido estructurado con diferencias en orden/duplicación de claves; valida contratos antes de convertir. JSONB no sustituye constraints relacionales ni garantiza acceso indexado para todo predicado. Índices GIN/expresión dependen de operadores.

GENERATED AS IDENTITY usa secuencias y puede dejar huecos; PK/UNIQUE establece unicidad. Las columnas generadas virtuales de 18 requieren revisar funciones/tipos admitidos; especifica VIRTUAL/STORED cuando importe. Cambios de ENUM o DOMAIN afectan despliegue y consumidores. Verifica round-trip del driver para numeric, interval y tipos temporales.
