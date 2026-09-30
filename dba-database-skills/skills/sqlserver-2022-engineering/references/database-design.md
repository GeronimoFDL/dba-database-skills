# Diseño relacional

Fuentes: [S49–S53, S74–S75, S79](source-registry.md). Las preferencias de modelado son criterios de ingeniería, no requisitos del motor.

## Contrato e integridad

Para documentar el diseño, usa la [plantilla de modelo relacional](../templates/relational-model-template.md): diccionario, claves, relaciones y mínimos/máximos en ambos sentidos. Si un diagrama ayuda, representa esas mismas reglas mediante notación pata de gallo y comprueba su coherencia con el DDL; no presupongas una herramienta externa.

Para diagramas pequeños en Markdown, prefiere Mermaid `erDiagram` con el ejemplo de la plantilla; respeta el formato solicitado y la capacidad del visor. Entrega primero el resumen del modelo y después su implementación cuando ambos formen parte de la solicitud. Un diagnóstico o cambio menor no exige siempre diagrama ni DDL.

Una FK NOT NULL exige padre para cada hijo, pero no exige hijos para todo padre. Una relación 1:0..1 requiere además unicidad adecuada en la FK; documenta por separado reglas de participación mínima. No prescribas CASCADE por llamar «detalle» a una entidad. En SQL Server la acción restrictiva se expresa con `NO ACTION`, no `RESTRICT`; SET NULL requiere columnas que admitan NULL [S49, S121](source-registry.md).

- Modela entidades, cardinalidades e invariantes antes de elegir acceso físico. Aplica [normalization](normalization.md) para evaluar hasta 3FN con todas las claves candidatas y reglas confirmadas; no deduzcas dependencias solo de datos existentes. Justifica desnormalización, autoridad del dato y consistencia, preservando la semántica histórica.
- Usa schemas para dominios y permisos estables. En un monolito modular, explicita quién modifica cada conjunto de tablas; compartir servidor no obliga a compartir propiedad. No suprimas FKs solo para imitar límites de clases o repositorios.
- Elige PK estable y estrecha. Una clave natural es válida si es estable y manejable; una surrogate key no sustituye el `UNIQUE` de la clave de negocio. Decide por separado si la PK será clustered.
- `IDENTITY` y sequences generan valores; no garantizan ausencia de huecos ni unicidad sin constraint. Rollbacks y caché pueden dejar huecos. No uses esos mecanismos como numeración legal correlativa sin un diseño adicional. Sequence sirve para asignación independiente o compartida y sus valores se consumen fuera de la transacción de negocio.
- En 1:N, coloca la FK en el lado N; para 1:1, añade unicidad a la FK o comparte PK. En N:M, una tabla puente necesita unicidad de la pareja, incluso si tiene surrogate key. Una FK no crea automáticamente un índice en la tabla hija.
- Las tablas de catálogo requieren códigos únicos y ciclo de vida definido; no codifiques identificadores incidentales en aplicaciones. Las transaccionales necesitan reglas claras de inmutabilidad, retención y corrección.

## Semántica de restricciones

- Expresa `NULL`/`NOT NULL` explícitamente según el dominio. `DEFAULT` aporta un valor si se omite, pero no valida el dominio ni sustituye un `NULL` explícito.
- Un `CHECK` rechaza FALSE; UNKNOWN por `NULL` puede pasar. Combínalo con `NOT NULL` cuando corresponda. Valida límites, datos históricos y trusted constraints; no escondas problemas con `NOCHECK`.
- `UNIQUE` de una sola columna nullable permite un solo NULL. Si la regla es unicidad solo para valores conocidos, evalúa un índice único filtrado `WHERE ColumnName IS NOT NULL`. Para claves compuestas, razona sobre combinaciones completas.
- Revisa cascadas por fan-out, auditoría y bloqueos. Comprueba las reglas también ante escrituras concurrentes; validarlas solo en C# deja ventanas de carrera.

## Capacidades contextuales

| Capacidad | Decisión |
|---|---|
| Temporal tables | Historial de versiones y consultas temporales; define retención, acceso al historial y costo de escritura. No sustituye backup ni registra por sí sola el usuario responsable. |
| Computed columns | Centraliza una expresión estable; comprueba determinismo, precisión, tipo y opciones SET si se indexa. |
| `PERSISTED` | Almacena resultados y añade costo de escritura/espacio; no es requisito universal para indexar expresiones deterministas y precisas. |
| `rowversion` | Token binario de cambio para concurrencia optimista; no fecha, hora ni clave de negocio. |
| Particionamiento | Útil para retención, cargas y mantenimiento por segmentos. Verifica alineación de índices, claves únicas y eliminación de particiones en el plan; no promete acelerar cualquier consulta. |

Antes de aprobar, verifica datos existentes, restricciones entre tablas y el comportamiento de la aplicación con valores nulos, duplicados, eliminación y reintentos. Usa [schema-review](../checklists/schema-review.md).
