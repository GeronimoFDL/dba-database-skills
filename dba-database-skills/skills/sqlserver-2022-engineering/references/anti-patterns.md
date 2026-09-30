# Anti-patrones que requieren revisión

Fuentes y reglas detalladas: [query-design](query-design.md), [indexing](indexing.md), [statistics](statistics.md), [query-optimizer](query-optimizer.md), [transactions-concurrency](transactions-concurrency.md), [security](security.md), [maintenance](maintenance.md). Esta tabla es un detector, no autorización de reescritura automática.

| Señal | Respuesta de ingeniería |
|---|---|
| `SELECT *` productivo con columnas conocidas | Proyectar contrato necesario; `EXISTS (SELECT 1...)`/existencia tiene otra finalidad y no requiere cargar columnas. |
| RBAR, cursor o loop innecesario | Comparar alternativa por conjuntos; conservar lotes/recorridos justificados por operación. |
| SQL concatenado con entradas | Parametrizar valores; lista permitida para identificadores y estructura. |
| `NOLOCK` indiscriminado | Demostrar semántica aceptada; diagnosticar blocking y evaluar aislamiento. |
| `MERGE` sin análisis | Revisar fuente única, concurrencia, triggers y CU; no afirmar que es siempre incorrecto. |
| Scalar UDF costosa | Confirmar frecuencia, inlining real y plan; considerar expresión/TVF adecuada. |
| Implicit conversion | Alinear cliente/columna y verificar acceso; no cast automático de la columna filtrada. |
| Predicado no SARGable | Reescribir preservando NULL, tipos, zona y límites; medir plan y resultado. |
| `text`, `ntext`, `image`, `timestamp` nuevo | Migrar al equivalente semántico moderno; conservar Unicode. |
| `varchar`/`nvarchar` sin longitud | Definir tamaño coherente con contrato y datos reales. |
| Índices excesivos, duplicados o solapados | Revisar constraints, ventanas completas y costo de escritura antes de consolidar. |
| INCLUDE gigantesco para eliminar todos los lookups | Comparar beneficio total frente a ancho, log, memoria y mantenimiento. |
| Transacciones largas | Reducir duración sin romper atomicidad; retirar esperas externas. |
| CATCH que silencia errores | Rollback acorde al dueño y XACT_STATE, después THROW; propagar fallo real. |
| SHRINK recurrente | Resolver capacidad/retención de log; operación excepcional justificada con crecimiento posterior evaluado. |
| Todas las estadísticas constantemente | Elegir objetos por distribución, muestra, modificaciones y errores de estimación. |
| Rebuild de todos los índices o umbrales 5/30 automáticos | Correlacionar densidad/fragmentación, tamaño y degradación; incluir costo operacional. |
| Hints como primera solución | Obtener evidencia y corregir causa antes de mitigación específica. |
| `OPTION (RECOMPILE)` generalizado | Medir variabilidad frente a CPU de compilación y pérdida de reutilización. |
| Vaciar plan cache para «arreglar» | Conservar evidencia y resolver causa; no causar tormenta de compilaciones compartida. |
| `db_owner`/sysadmin para aplicación | Diseñar y comprobar permisos mínimos efectivos. |
| Secretos en código o capturas | Retirar de artefactos, proteger y rotar según exposición real. |
| Deshabilitar seguridad/constraints/triggers por un error | Diagnosticar contrato y dependencia; cualquier excepción requiere alcance, impacto y validación. |
| «READ-ONLY significa sin riesgo» | Acotar costo, permisos y datos; plan real ejecuta y CHECKDB/DMFs físicas consumen recursos. |
| «Compatibilidad 160 activa todo IQP» | Verificar edición, configuraciones, Query Store y elegibilidad. |
| «VERIFYONLY correcto significa backup confiable» | Ensayar restore, integridad y aplicación dentro de RPO/RTO. |

Prioriza hallazgos por pérdida de datos, seguridad, corrección, disponibilidad y costo demostrado. No conviertas convenciones cosméticas o posibilidades no observadas en defectos de severidad alta.
