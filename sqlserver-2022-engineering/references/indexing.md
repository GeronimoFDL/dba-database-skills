# Índices basados en workload

Fuentes: [S01, S03–S05, S49, S51, S75–S76, S82–S83](source-registry.md).

## Expediente mínimo para recomendar un índice

Registra consultas y parámetros representativos, plan, frecuencia de lectura/escritura, índices existentes, distribución/selectividad, tamaño esperado y costo de mantenimiento. Si faltan métricas, presenta un candidato para probar, no una mejora demostrada.

1. Identifica el operador y las lecturas que se pretende reducir; comprueba si el problema real es estimación, bloqueo o volumen devuelto.
2. Inspecciona key columns, dirección, INCLUDE, filtros, unicidad, constraints y particiones de índices existentes. Evalúa extender/consolidar antes de sumar.
3. Diseña la clave según predicados de igualdad/rango, joins y orden de la carga real. «Más selectiva primero» no es una ley: el orden también afecta reutilización y ordenamiento. Las columnas INCLUDE no sirven como prefijo de búsqueda.
4. Estima bytes, espacio temporal/log, write amplification y bloqueo de creación. Confirma soporte de opciones ONLINE/RESUMABLE por edición y operación; ONLINE puede necesitar bloqueos breves.
5. Compara resultados y recursos antes/después con varias consultas, no solo la que motivó el índice. Documenta condiciones para retirarlo.

## Selección física

- Microsoft favorece clustered rowstore en muchas tablas persistentes. Elige una clave estrecha, estable y preferiblemente única; una PK no tiene que ser clustered. Heaps pueden servir para staging/cargas con vida corta. No conviertas todas las tablas sin inspeccionar uso, costo de conversión y forwarded records.
- Nonclustered cubre rutas de lectura específicas. Un `Key Lookup` barato para pocas filas puede ser razonable; incorpora columnas solo cuando la reducción total compense espacio y escrituras. No crees índices gigantes para que desaparezca un icono del plan.
- Índices unique expresan invariantes; no se eliminan por falta de seeks en una DMV. Filtered indexes pueden servir a subconjuntos selectivos, siempre que el optimizador pueda demostrar que el predicado de la consulta está contenido en el filtro; parametrización puede afectar esa demostración.
- Evalúa índices en FK por joins, validaciones y modificaciones de padres. SQL Server no los crea automáticamente ni los requiere para toda FK.
- Columnstore favorece exploración analítica y compresión; evalúa rowgroups, cargas, cambios y latencia. Un nonclustered columnstore en OLTP añade escritura; particionamiento e índices rowstore complementarios necesitan evidencia.
- Revisa ancho de clave clustered porque se propaga como localizador a índices nonclustered. Claves secuenciales pueden concentrar inserciones en la última página; investiga la contención antes de cambiar su patrón.

## Sugerencias y retiradas

### Creación de constraints reanudable

SQL Server 2022 permite `ALTER TABLE ... ADD CONSTRAINT` reanudable para PRIMARY KEY y UNIQUE, no para FOREIGN KEY. Requiere `ONLINE = ON`, soporte de edición/operación y planificación de espacio, log y bloqueos; no significa ausencia de interrupciones. Define `MAX_DURATION`, pausa/reanudación/aborto y seguimiento mediante `sys.index_resumable_operations`, no mediante `sys.dm_tran_resumable_operations`. Para estas constraints, consulta la sintaxis `ALTER INDEX ALL ... PAUSE/RESUME/ABORT` documentada antes de generar el script. Una operación pausada conserva recursos y estructuras que deben gestionarse [S119–S120](source-registry.md).

Missing-index DMVs se basan en estimaciones durante optimización; no prueban el índice, no cubren todos los tipos ni ponderan todo el costo de escritura. Agrupa sugerencias y diseña una alternativa contrastada.

Antes de declarar un índice unused, conserva ventana de observación suficiente para cierres mensuales, informes y failovers; registra reinicios/reset y restricciones. Dos índices que comparten prefijo no necesariamente son redundantes: comprueba orden, filtro, cobertura y unicidad. Retira uno por vez, conserva su DDL y monitoriza.
