# Revisión de esquema

Referencias: [database-design](../references/database-design.md), [data-types](../references/data-types.md), [indexing](../references/indexing.md).

- [ ] Entidades, grano, cardinalidades y autoridad de datos explícitos.
- [ ] Diccionario y relaciones expresan mínimos/máximos en ambos sentidos; el diagrama concuerda con PK/UNIQUE/FK/NULL y distingue reglas que requieren cumplimiento adicional.
- [ ] [Normalización](../references/normalization.md): reglas y dependencias confirmadas separadas de hipótesis; preguntas pendientes explícitas, sin inferir reglas solo de muestras.
- [ ] Todas las claves candidatas consideradas; cierres, atributos primos y evaluación de 1FN, 2FN y 3FN justificados, o límites del análisis declarados.
- [ ] Redundancias y anomalías de inserción, actualización y eliminación identificadas, distinguiendo hechos históricos independientes.
- [ ] Descomposición con cobertura de atributos, reconstrucción sin pérdida y preservación de dependencias demostradas por separado.
- [ ] Modelo resultante validado, incluidos NULL, duplicados, collation, cardinalidades y consumidores; desnormalización justificada con autoridad y consistencia definidas.
- [ ] PK estable; unicidad de negocio y FKs correctas, sin confundir PK con clustered.
- [ ] NULL/NOT NULL, DEFAULT y CHECK expresan las reglas, incluido UNKNOWN.
- [ ] Tipos, longitudes, precisión, escala, collation y Unicode preservan datos actuales y crecimiento previsto.
- [ ] Cascadas, tablas puente y relaciones 1:1 protegidas mediante constraints.
- [ ] Constraints nuevos validados sobre datos existentes y confiables para el optimizador.
- [ ] Computed/PERSISTED, temporal, rowversion y particiones usados con una razón y requisitos verificados.
- [ ] Índices justificados por lectura/escritura y constraints, sin duplicación inadvertida.
- [ ] Compatibilidad con consumidores y ventana de migración verificadas.
- [ ] Riesgo de bloqueo, log, espacio, rollback/roll-forward y validación posterior documentado.
