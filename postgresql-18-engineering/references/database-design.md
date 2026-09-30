# Diseño e integridad relacional

Fuentes: [constraints](source-registry.md#constraints), [schemas](source-registry.md#schemas), [generated](source-registry.md#generated).

Define grano, entidades, claves candidatas y reglas confirmadas. Usa PK/UNIQUE, NOT NULL y CHECK para invariantes; PostgreSQL considera satisfecho un CHECK que no resulte FALSE, por lo que UNKNOWN requiere nulabilidad explícita. Evita CHECK que dependa de otras filas/tablas: no asegura integridad frente a cambios o restore.

UNIQUE permite varios NULL por defecto; NULLS NOT DISTINCT ofrece otra semántica cuando corresponda. Una FK no crea automáticamente índice en la tabla hija. Evalúa deferrabilidad y momento de comprobación; NO ACTION y RESTRICT no son idénticos en todos los contextos. No deshabilites triggers o integridad para ocultar huérfanos.

Define schemas y propietarios; search_path influye en resolución y seguridad. Usa nombres snake_case sin comillas como convención opcional; identificadores entre comillas conservan mayúsculas y exigen coherencia del cliente. Una base contiene schemas, no es sinónimo de schema.

Exclusion constraints, rangos y constraints temporales pueden expresar reglas de no solapamiento mejor que triggers, pero requieren operadores/indexes compatibles. Particionamiento afecta claves únicas y FKs: verifica cobertura de columnas de partición antes de generar DDL. Diferencia mínimo de hijos del negocio y lo que una FK realmente exige. Mantén diccionario y diagrama coherentes.
