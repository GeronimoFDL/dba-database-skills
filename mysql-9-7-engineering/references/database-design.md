# Diseño e integridad

Fuentes: [constraints](source-registry.md#constraints), [foreign-keys](source-registry.md#foreign-keys), [types](source-registry.md#types).

Identifica grano, claves candidatas y dependencias antes de crear tablas. En InnoDB la PK influye en el almacenamiento clustered y se incorpora en índices secundarios; elige tamaño/estabilidad sin sacrificar identidad de negocio. AUTO_INCREMENT no reemplaza UNIQUE de la clave natural ni genera numeración sin huecos.

UNIQUE permite múltiples NULL; una clave candidata del modelo lógico necesita tratamiento explícito de valores desconocidos. CHECK impone su expresión cuando está ENFORCED; verifica metadata y nulabilidad. Evita usar CHECK para reglas entre filas. DEFAULT no valida dominio ni reemplaza NULL explícito.

FKs requieren engines, tipos e índices compatibles; MySQL puede crear índice hijo requerido, pero revisa el diseño resultante. Prefiere clave referenciada única y completa, no extensiones históricas de claves no estándar. foreign_key_checks=0 no es una reparación: volver a activarlo no demuestra que los datos cargados sean válidos.

Database y schema son sinónimos en MySQL. Documenta mayúsculas/minúsculas, lower_case_table_names y plataforma, especialmente al migrar Windows/Linux. Cascadas, particiones, generated columns y FKs tienen restricciones combinadas: valida el DDL exacto. Una FK no impone mínimo de hijos; 1:0..1 necesita unicidad. Representa lo confirmado en diccionario y Mermaid.
