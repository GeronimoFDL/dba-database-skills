# Cambio en producción

- [ ] Destino, entorno y operación coinciden con autorización explícita ya existente; no volver a pedirla si es suficiente.
- [ ] Cambio concreto revisado, prerrequisitos y diferencias del esquema identificados; preparar antes de solicitar autorización faltante.
- [ ] Clasificar efectos de cada sentencia, incluidas llamadas externas, planes con ejecución y DDL con implicit commit.
- [ ] Backup restaurable o recuperación alternativa comprobada; RPO/RTO y claves disponibles.
- [ ] Estimar locks, log/WAL/binlog, disco, memoria, réplica y duración.
- [ ] Fijar límites observables de aborto/pausa, responsable y comunicación requerida.
- [ ] Ensayar éxito, fallo parcial, reejecución, concurrencia y reconexión en entorno autorizado.
- [ ] Confirmar restricciones de transacción, ONLINE/CONCURRENTLY/ALGORITHM, edición y operación.
- [ ] Definir validación funcional y técnica, reversión o roll-forward y conservación de evidencia.
- [ ] No confundir copiar/generar SQL con permiso para ejecutarlo en producción.

Consulta [deployment](../references/deployment.md), [backup-restore](../references/backup-restore.md) y [high-availability-dr](../references/high-availability-dr.md).
