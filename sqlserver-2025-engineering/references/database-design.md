# Diseño, contratos y nombres

Fuentes: [constraints](source-registry.md#constraints), [types](source-registry.md#types).

Define entidades, grano, autoridad, histórico, cardinalidades y reglas antes del DDL. Normaliza con todas las claves candidatas; una identidad artificial no elimina unicidad de negocio. Elige PK estable, expresa claves alternativas mediante UNIQUE y decide clustered por separado.

Una FK no crea automáticamente índice en el hijo. NOT NULL exige padre para cada hijo, pero una FK no exige hijos para todo padre. En 1:0..1 añade unicidad; una tabla puente necesita unicidad de la pareja si ese es su grano. No impongas cascadas por llamar «detalle» a una entidad. Revisa ciclos, fan-out y retención histórica.

CHECK rechaza FALSE, pero UNKNOWN puede pasar; combínalo con NOT NULL. DEFAULT no sustituye un NULL explícito. UNIQUE nullable de una columna admite un NULL; unicidad solo para valores conocidos puede requerir índice único filtrado. Valida constraints sobre datos existentes y su estado trusted; no ocultes errores mediante NOCHECK.

Usa schemas para propiedad/permisos y nombres estables, sin imponer prefijos arbitrarios. Califica objetos persistentes. Documenta diccionario, claves compuestas y mínimos/máximos en ambos sentidos; el diagrama debe reflejar el DDL y señalar invariantes adicionales que requieren otro mecanismo. Las convenciones son acuerdos del proyecto, no requisitos del motor.
