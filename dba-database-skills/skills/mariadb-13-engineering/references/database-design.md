# Diseño relacional e integridad

Fuentes: [constraints](source-registry.md#constraints), [foreign-keys](source-registry.md#foreign-keys), [temporal](source-registry.md#temporal), [sequence](source-registry.md#sequence).

Define grano, identidad, claves candidatas y dependencias confirmadas. Traduce la normalización a PK, UNIQUE, FK, CHECK y nulabilidad compatibles con el engine. AUTO_INCREMENT y secuencias no eliminan la necesidad de claves de negocio ni prometen ausencia de huecos.

InnoDB organiza datos por clave clustered y añade esa clave a índices secundarios. Evalúa ancho y estabilidad de la PK. UNIQUE con NULL no representa automáticamente una clave candidata total; define la regla de ausencia. CHECK y FK requieren revisar estado, variables que deshabilitan validación y datos ya presentes. Una comprobación de la aplicación no elimina carreras concurrentes.

Comprueba tipos, signedness, collation, índices y restricciones de particionamiento antes de emitir FKs. Reactivar foreign_key_checks no demuestra que una carga previa carezca de huérfanos. No copies restricciones o extensiones históricas de claves referenciadas de MySQL sin comprobar MariaDB.

Database y schema se usan como sinónimos; documenta sensibilidad de nombres según plataforma y configuración. Una FK no impone que todo padre tenga hijos. Cardinalidad 1:0..1 requiere unicidad adicional. Alinea Mermaid con restricciones reales y marca reglas pendientes.

Las tablas system-versioned conservan historia según su configuración, pero no son Ledger criptográfico. Define historia de negocio frente a tiempo del sistema, retención, acceso histórico y efectos de cambios de esquema. Revisa expresamente cómo respaldar y restaurar todas las versiones con las herramientas del destino.
