# Transacciones y concurrencia

Fuentes: [S18–S23, S46, S53, S85–S86, S103](source-registry.md).

Define primero la unidad de trabajo y sus invariantes ACID: atomicidad de cambios, consistencia mediante reglas válidas, aislamiento acordado y durabilidad con la configuración del motor. Mantén la transacción tan corta como permita el negocio: no incluir interacción humana, llamadas HTTP ni procesamiento innecesario. Usa orden de acceso consistente y búsquedas indexadas.

## Aislamiento en SQL Server

| Nivel/modelo | Semántica y costo |
|---|---|
| READ UNCOMMITTED / `NOLOCK` | Puede leer cambios no confirmados, omitir o duplicar filas. Sigue necesitando bloqueos de esquema; no elimina todos los bloqueos ni es solución general a blocking. |
| READ COMMITTED con RCSI OFF | Lectura de datos confirmados mediante locks; puede bloquearse con escritores. Lecturas sucesivas de una transacción pueden cambiar. Es el modelo habitual por defecto de SQL Server instalado. |
| READ COMMITTED con RCSI ON | Versiones consistentes al inicio de cada sentencia. Reduce conflictos lectura/escritura; no elimina conflictos entre escritores ni garantiza la misma fotografía para varias sentencias. |
| REPEATABLE READ | Retiene protección sobre datos leídos hasta fin de transacción; todavía pueden aparecer phantoms. |
| SNAPSHOT | Fotografía consistente de la transacción con versionado, previa habilitación. Puede fallar por conflicto de actualización; requiere estrategia de tratamiento/reintento. |
| SERIALIZABLE | Protege rangos contra phantoms; puede aumentar bloqueo/deadlocks. Útil para invariantes de concurrencia concretas, no como valor universal. |

Antes de habilitar RCSI/SNAPSHOT, prueba operaciones «leer y luego escribir», colas, reportes multisentencia, sesiones largas y comportamiento del ORM. Dimensiona y monitoriza versiones: normalmente tempdb sin ADR; con ADR habilitado, persistent version store en la base de usuario. Planea el cambio y su reversión con conexiones activas, capacidad y permisos. No uses terminación de sesiones indiscriminada para habilitarlo.

## Propiedad de la transacción y errores

`BEGIN TRANSACTION` debe tener dueño claro. Solo confirma la transacción el componente que la inicia. SQL Server no ofrece transacciones anidadas independientes: un rollback sin savepoint afecta toda la transacción exterior.

Para un script que **posee su propia transacción**, rechaza `@@TRANCOUNT <> 0` antes de comenzar; usa `SET XACT_ABORT ON`, `TRY/CATCH`, COMMIT al terminar y en CATCH `IF XACT_STATE() <> 0 ROLLBACK; THROW;`. La plantilla de migración usa este contrato.

Para un procedimiento reutilizable que participa en una transacción exterior, conserva `@@TRANCOUNT` inicial y acuerda el contrato con el llamador. Si es necesario, usa savepoint: con `XACT_STATE() = 1` puede revertirse al savepoint; con `-1` no puede hacerse, y el dueño debe revertir la transacción completa. Savepoints no están soportados en transacciones distribuidas. No pegues el patrón de script autónomo en un procedimiento llamado por EF.

`XACT_ABORT ON` ayuda ante muchos errores de ejecución; no cubre errores de compilación, desconexiones ni todos los escenarios de cancelación. `TRY/CATCH` tampoco captura todos los errores al mismo nivel. `THROW` preserva el error y respeta XACT_ABORT; evita CATCH que continúa como si hubiera éxito.

## Resolver conflictos

Blocking no es deadlock. Localiza raíz, transacción y recurso antes de terminar sesiones. Ante deadlocks, analiza grafo, orden de acceso e índices; reintenta la unidad completa solo para errores identificados, con límite, espera y operaciones idempotentes. Un timeout puede dejar resultado desconocido: no repetir efectos de negocio sin comprobarlo.

Para concurrencia optimista, compara clave y `rowversion` original en UPDATE/DELETE y verifica filas afectadas; cero filas indica conflicto o ausencia que debe resolver el contrato. `rowversion` no es un reloj. Controla lock escalation mediante lotes, índices y duración donde proceda; `ROWLOCK` no garantiza que no escale.
