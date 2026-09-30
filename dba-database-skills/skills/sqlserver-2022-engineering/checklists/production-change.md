# Cambio de alto riesgo o mutación en producción

Referencias: [deployment](../references/deployment.md), [backup-restore](../references/backup-restore.md), [transactions-concurrency](../references/transactions-concurrency.md). Preparar el expediente antes de solicitar autorización que falte. Reutilizar la autorización existente para la misma operación/destino; no deducirla de una solicitud de generar SQL.

| Control | Evidencia exigible según riesgo |
|---|---|
| Identidad y alcance | Servidor, base, entorno, versión/edición, rol, cambio exacto, objetos/datos y autorización de sesión o proceso. |
| Riesgo/impacto | Pérdida potencial, bloqueo, log, espacio, dependencias, aplicaciones y tiempo fuera de servicio. |
| Pre-check | Estado esperado del esquema/datos, conteos, permisos, transacciones, espacio, backups y salud de HA. Fallar si diverge. |
| Respaldo | Definición/configuración previa y estrategia de recuperación acorde a RPO/RTO; comprobar restauración y material criptográfico. |
| Ejecución | Script revisado, precondiciones, runner y cuenta definidos, serialización, ventana, monitoreo y criterio de abortar. |
| Validación | Conteos/invariantes, integridad, permisos, aplicación, errores y rendimiento comparables con línea base. |
| Recuperación | Rollback/roll-forward viable, límites de tiempo/pérdida y efectos ya confirmados. Revertir código no revierte necesariamente datos. |

- [ ] No hay DROP/TRUNCATE/DML masivo/ALTER COLUMN ni cambio global oculto en un script «de diagnóstico».
- [ ] No se han desactivado constraints/triggers/seguridad para evitar errores sin una excepción explícita y verificación de restauración del control.
- [ ] No se capturará plan real de una escritura con la suposición de que es read-only.
- [ ] Se sabe quién posee la transacción; el operador conoce qué no se puede revertir transaccionalmente.
- [ ] Criterios de éxito, detención y escalamiento son observables; no hay reintento ciego de efectos no idempotentes.
- [ ] Antes de ejecutar, destino y autorización coinciden con este expediente. Si falta autorización, pedirla sobre el resultado concreto preparado.
- [ ] Tras ejecutar, registrar qué ocurrió, validación y acciones pendientes; si solo se generó el script, declararlo.
