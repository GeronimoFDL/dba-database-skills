# Revisión de seguridad

Referencia: [security](../references/security.md). Ajusta alcance a la solicitud; no afirmar certificación CIS.

- [ ] Identidades de aplicación, deploy, operación y auditoría separadas según responsabilidades.
- [ ] Permisos efectivos mínimos comprobados, incluidas pruebas negativas y herencia/DENY.
- [ ] SQL parametrizado; identificadores dinámicos de lista permitida; ninguna credencial embebida.
- [ ] TLS y validación de certificados comprobados con drivers usados.
- [ ] TDE/Always Encrypted/backup cifrado elegidos según amenaza y edición; claves recuperables.
- [ ] Audit con destino protegido, retención y tratamiento de fallos.
- [ ] Si se requiere [Ledger](../references/ledger.md): modelo elegido, limitaciones, crecimiento, digests externos protegidos y verificación/recuperación definidos; sin promesas de invulnerabilidad o cumplimiento automático.
- [ ] DDM no usado como barrera de confidencialidad; RLS probado entre tenants y roles.
- [ ] xp_cmdshell/CLR/linked servers/TRUSTWORTHY/cross-database access limitados a necesidad comprobada.
- [ ] Diagnósticos y planes anonimizados antes de compartir; secretos y datos de producción protegidos.
- [ ] Excepciones con motivo, alcance y responsable; estado de evaluación CIS y versión del benchmark explícitos.
