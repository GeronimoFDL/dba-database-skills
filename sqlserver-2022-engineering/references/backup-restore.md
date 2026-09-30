# Backup, restore y recuperación

Fuentes: [S33–S37, S77–S78](source-registry.md).

Recoge RPO (pérdida de datos tolerable), RTO (tiempo de recuperación), criticidad, tamaño, tasa de log, ancho de banda, retención, destinos y responsables. Elige recovery model y cadena de backups que puedan cumplir ambos objetivos; mide tiempos reales incluyendo transferencia, restauración, validación y reconexión.

| Opción | Implicación |
|---|---|
| SIMPLE | No admite backups del log; recuperación hasta backups de datos disponibles. No significa ausencia de logging ni de crecimiento del log. |
| FULL recovery model | Permite cadena de log y recuperación a punto en el tiempo cuando están disponibles los backups necesarios. Configúralos y comprueba cadena inicializada; cambiar la opción no crea una estrategia. |
| BULK_LOGGED | Para operaciones masivas seleccionadas con logging mínimo; un backup del log que incluye esas operaciones limita recuperación a puntos interiores. Evalúa pérdida y acceso a archivos ante un desastre. |
| FULL backup | Base completa; no trunca el log por sí mismo. Un full normal establece base diferencial. |
| DIFFERENTIAL | Cambios desde la base diferencial correspondiente, no desde el diferencial anterior. Conserva y verifica esa base. |
| LOG backup | Parte ordenada de la cadena para recuperar transacciones; relaciona frecuencia con RPO. |
| COPY_ONLY full | Copia ad hoc sin alterar base diferencial; no la confundas con un full normal para nuevos diferenciales. |
| Tail-log | Intenta capturar la cola antes de restaurar cuando el estado lo permite. `NORECOVERY` cambia disponibilidad; requiere plan, no es diagnóstico. |

Cambiar de FULL a SIMPLE interrumpe la cadena de log; antes de hacerlo analiza HA, RPO y recuperación posterior. Al volver a FULL planifica backup de datos que inicie la cadena y reanuda backups de log. No cambies modelos para reducir espacio sin resolver la causa.

## Comprobar recuperabilidad

- Usa `BACKUP ... WITH CHECKSUM` como control de detección, evaluando costo; custodia copia separada, acceso y cifrado según criticidad. Conserva claves, certificados y credenciales necesarias fuera del dominio de fallo del servidor.
- `RESTORE VERIFYONLY` comprueba legibilidad/completitud y verificaciones disponibles; no restaura ni valida toda la estructura lógica. No equivale a CHECKDB ni demuestra RTO.
- Ensaya restauración en destino aislado: full correcto, diferencial compatible y logs en orden/LSN; aplica `NORECOVERY` durante la secuencia y `RECOVERY` al finalizar. Prueba un punto temporal requerido, no solo el último backup.
- Después ejecuta `DBCC CHECKDB`, valida datos críticos y pruebas de aplicación, usuarios/logins, jobs y dependencias. Incluye backups de bases del sistema y material de recuperación de instancia según su uso.
- Registra fecha, archivos, destino, integridad, RPO/RTO alcanzados y responsable. Alerta por antigüedad, huecos, fallo de copia y fallos de restauración.

**Un backup no debe considerarse operacionalmente confiable hasta que exista un proceso probado de restauración.** El éxito del job o VERIFYONLY no cumple por sí solo ese criterio.

Antes de cualquier restore, verifica destino físico, nombres de archivos, capacidad y sesiones. No uses `WITH REPLACE` por defecto. Un restore de base completa como rollback puede perder transacciones posteriores: declara ese costo y considera roll-forward.
