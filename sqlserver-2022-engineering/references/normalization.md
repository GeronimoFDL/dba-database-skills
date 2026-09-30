# Normalización relacional hasta 3FN

Usa esta guía al diseñar o revisar un modelo relacional. El objetivo habitual es alcanzar al menos 3FN; justifica las excepciones según el uso y la semántica. Es una evaluación lógica, independiente de la elección de índices. No implica autorización para migrar datos.

Fuentes: [S106](source-registry.md#s106) para dependencias, 3FN y síntesis; [S107](source-registry.md#s107) para descomposición sin pérdida. Son teoría relacional independiente del motor. Para materializar el modelo en SQL Server 2022, consulta [database-design](database-design.md) y las fuentes S49–S50. El procedimiento de investigación y entrega siguiente es una pauta de ingeniería.

## 1. Establecer las reglas antes de transformar

Identifica entidades, significado de cada atributo, grano de cada fila, cardinalidades y ámbito: organización/tenant, período, versión o estado. Pregunta por identificadores reutilizables, cambios históricos y excepciones. Distingue el valor actual de una entidad del valor registrado en una transacción: el precio vendido o la dirección histórica pueden ser hechos independientes.

Mantén un registro como este:

| Regla y ámbito | Dependencia propuesta | Estado | Evidencia o confirmación necesaria |
|---|---|---|---|
| Descripción precisa del negocio | X → Y | Confirmada / hipótesis / contradicha | Requisito, responsable, constraint vigente o pregunta concreta |

Una dependencia funcional X → Y exige que dos filas válidas con el mismo X tengan el mismo Y, en todo estado permitido por el negocio. Los nombres, una muestra sin duplicados o las correlaciones observadas no demuestran esa regla. Los datos pueden aportar contraejemplos; confirma si reflejan una excepción válida o un defecto de calidad. Las constraints revelan parte del contrato implementado, no todas las reglas ni necesariamente el contrato deseado.

No inventes dependencias. Si falta una regla esencial, formula la pregunta exacta, explica qué decisión depende de ella y ofrece alternativas condicionadas. Continúa el análisis que no dependa de esa respuesta. No declares normalización completa a partir de hipótesis ni interpretes el silencio como confirmación.

## 2. Claves y evaluación de las formas normales

Declara el conjunto de atributos R y las dependencias confirmadas F. Calcula cierres X+ bajo F: una superclave determina R; una clave candidata es una superclave mínima. Un atributo primo pertenece a alguna clave candidata. Considera **todas las claves candidatas**, incluidas las alternativas a la PK. Si la enumeración no es viable, justifica una caracterización completa; si no puedes completarla, declara la evaluación parcial.

| Forma | Criterio lógico |
|---|---|
| 1FN | Valores individuales del dominio definido, sin grupos repetitivos ni listas de hechos que deban relacionarse por separado. Explicita el dominio y el grano. |
| 2FN | 1FN y ningún atributo no primo depende de un subconjunto propio de una clave candidata. |
| 3FN | 1FN y, para toda dependencia no trivial X → A de F+, X es superclave o A es primo. |

No uses únicamente la regla abreviada «sin dependencias transitivas entre columnas no clave»: puede clasificar mal claves que se solapan. Una PK artificial no elimina las dependencias del negocio. No declares 2FN solo porque la PK sea simple. No confundas BCNF con 3FN ni con 4FN: BCNF exige superclave para todo determinante no trivial y puede impedir conservar todas las dependencias en una descomposición. Alcanzar 3FN no elimina toda redundancia posible.

Para 1FN, distingue columnas repetidas del mismo hecho, como Phone1/Phone2, de atributos con roles distintos. No declares automáticamente que una dirección textual o un documento JSON opaco viola 1FN; decide según su dominio y uso. Si sus componentes representan entidades consultables independientemente, evalúa su separación.

## 3. Redundancias y anomalías

Por cada dependencia problemática, señala el hecho repetido y construye un ejemplo claramente hipotético de sus efectos:

- Inserción: un hecho no puede registrarse sin inventar otro hecho o introducir valores impropios.
- Actualización: el mismo hecho requiere múltiples cambios y puede quedar contradictorio.
- Eliminación: borrar la última fila de un hecho elimina accidentalmente otro hecho independiente.

Separa anomalías de diseño, errores de calidad y duplicación intencional. No deduzcas que dos valores iguales representan el mismo hecho. Documenta claves, filas o reglas afectadas sin exponer datos sensibles.

## 4. Proponer y demostrar la descomposición

Conserva todos los atributos y su significado. Expresa las relaciones nuevas, sus claves y las dependencias proyectadas desde F+, no solo las dependencias escritas originalmente. Prueba por separado:

- **Sin pérdida:** las proyecciones se reúnen para reconstruir exactamente cualquier relación válida, sin filas espurias. En una división binaria R1/R2 basta que su intersección determine R1 o R2 bajo F+. Para varias relaciones usa divisiones binarias justificadas, chase o una síntesis con garantía; revisar pares arbitrarios no basta.
- **Preservación:** la unión de las dependencias proyectadas implica F; comprueba el cierre de cada determinante de una cobertura de F. No confundas una FK con esta demostración.

Cuando convenga sintetizar 3FN, obtiene una cobertura mínima con consecuentes simples, sin atributos extraños ni dependencias redundantes; agrupa por determinante X y crea relaciones X ∪ Y. Elimina relaciones contenidas redundantes. Si ninguna contiene una clave candidata de R, añade una relación con una clave candidata. Comprueba cobertura de atributos y resultados. Estas garantías dependen de que F represente correctamente las reglas confirmadas.

No prometas simultáneamente BCNF y preservación si no son compatibles. Para la solicitud de 3FN, explica por qué la propuesta conserva ambas propiedades y cualquier restricción adicional que no sea una dependencia funcional.

### Ejemplo hipotético: PK simple y clave alternativa compuesta

Supón R(Id, A, B, C) y reglas **confirmadas para este ejemplo**: Id → ABC, AB → Id y A → C. Las claves candidatas son Id y AB. C es no primo y depende de A, subconjunto propio de AB: viola 2FN aunque Id sea una PK simple.

La propuesta R1(A, C), R2(Id, A, B) está en 3FN. La intersección A determina R1, por lo que la unión es sin pérdida. Se conservan A → C, AB → Id e Id → AB; juntas implican Id → ABC. En SQL, conserva la unicidad alternativa de (A, B) y define la relación por A. No apliques estas dependencias a una base real solo por semejanza de nombres.

## 5. Validación e implementación

Recalcula claves, atributos primos y forma normal de cada relación resultante respecto de las dependencias proyectadas. Entrega la demostración de ausencia de pérdida y preservación por separado, con sus supuestos. Verifica también cardinalidades, obligatoriedad e invariantes que no estén cubiertos por dependencias funcionales.

Al traducir a SQL Server, define PK, UNIQUE, NOT NULL, FKs y CHECK según su semántica real. Un UNIQUE nullable o filtrado no equivale sin más a una clave candidata del modelo clásico. Declara cómo se manejan NULL, collation, comparación de texto y duplicados; la teoría de conjuntos no reproduce automáticamente la semántica de las tablas SQL.

Antes de migrar, verifica mapeo de identificadores, nulos, huérfanos, conflictos de unicidad, conteos, multiplicidades y reconstrucción de valores. Comparar muestras o usar EXCEPT puede ayudar a detectar fallos, pero no prueba las dependencias del negocio; EXCEPT tampoco conserva multiplicidades. Evalúa consumidores, concurrencia, histórico, volumen y reversión con [deployment](deployment.md) y [schema-review](../checklists/schema-review.md). No generes valores sustitutos para encubrir conflictos.

Si propones desnormalizar, documenta la dependencia afectada, necesidad concreta o medición, alternativa normalizada, fuente autoritativa, responsables de escritura, mecanismo de consistencia, retraso admisible, conciliación y costo. Distingue el modelo lógico normalizado de sus proyecciones o cachés físicas; no etiquetes como 3FN una tabla que incumpla el criterio.

## Entrega del análisis

### Cuándo ampliar a BCNF, 4FN y 5FN

No impongas esta secuencia a todo modelo. BCNF puede perder preservación de dependencias; conserva la decisión explícita frente a 3FN [S106]. Para 4FN identifica dependencias multivaluadas independientes confirmadas: en toda dependencia multivaluada no trivial X ↠ Y, X debe ser superclave. Para 5FN examina dependencias de reunión no triviales y si están implicadas por las claves candidatas [S125](source-registry.md#s125). No infieras independencia porque existan varias FKs. No sustituyas una relación ternaria por relaciones binarias sin demostrar reconstrucción sin pérdida para todos los estados válidos. Registra las reglas pendientes y no certifiques una forma superior si no dispones de ellas.

La desnormalización tampoco exige exclusivamente vistas indexadas ni actualización síncrona: acuerda consistencia y latencia según el caso, documentando fallos y conciliación. La elección OLTP/analítica debe respetar la semántica, no un orden de formas normales automático.

### Resultado

Incluye: reglas confirmadas y preguntas pendientes; claves candidatas y dependencias; evaluación 1FN/2FN/3FN por relación; anomalías; modelo propuesto; demostraciones; validación y excepciones justificadas. Marca cada conclusión como demostrada respecto de F, condicionada o insuficiente por falta de información. No atribuyas una garantía sobre el negocio a una demostración basada en un conjunto incompleto de reglas.
