# Backup, restore y recuperación

Fuentes: [backup](source-registry.md#backup), [ha](source-registry.md#ha), [integrity](source-registry.md#integrity).

Define RPO/RTO, retención, destino aislado/inmutable y acceso a claves. Selecciona recovery model según recuperación requerida: FULL necesita cadena de logs y gestión de capacidad; un full no sustituye log backups. Registra base diferencial, LSN, dependencias y copy-only; no rompas cadena cambiando recovery model para reducir log.

CHECKSUM y VERIFYONLY detectan ciertas fallas, pero no prueban recuperación funcional. Restaura en una instancia aislada, valida integridad y aplicación y mide tiempos. Ensaya point-in-time, secuencia full/differential/log, tail-log cuando corresponda y recuperación de certificados. No sobrescribas una base para «validar» sin autorización.

En 2025 se amplían backups full/differential en secundarios AG; comprueba rol, condiciones y topología soportados, no copies restricciones de 2022 ni asumas que la preferencia de backup programa jobs. Mantén conectividad y credenciales por réplica.

Restaurar un backup de versión superior en inferior no es un rollback soportado. Antes de upgrade conserva recuperación con servidor/binarios adecuados y plan de reconciliación. HA replica también errores: combina copias históricas y simulacros. Incluye objetos de instancia, logins, jobs, secretos y dependencias no contenidos en la base.
