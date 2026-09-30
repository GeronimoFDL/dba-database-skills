# Cuentas, roles y protección

Fuentes: [security](source-registry.md#security), [roles](source-registry.md#roles), [tls](source-registry.md#tls), [auth](source-registry.md#auth).

La identidad incluye usuario y host; CURRENT_USER() puede diferir de USER(). Diseña cuentas separadas por función y origen, evitando root/SUPER o privilegios dinámicos amplios por comodidad. Roles concedidos no siempre están activos: valida roles por defecto y permisos efectivos con la cuenta real.

Autenticación depende de plugin y cliente; verifica caching_sha2_password y TLS. Cifrar sin validar identidad del servidor no basta: prueba CA, hostname, expiración y renovación. No habilites un plugin antiguo o desactives validaciones para sortear un conector obsoleto.

Rutinas/vistas SQL SECURITY DEFINER usan privilegios del definidor; revisa cuentas huérfanas, permisos y contenido dinámico. Database no es frontera suficiente de tenant si la cuenta puede consultar todo. No presentes RLS de PostgreSQL/SQL Server como capacidad nativa equivalente: evalúa diseño de acceso, vistas/rutinas y pruebas negativas.

Audit, cifrado at-rest, keyring y herramientas de backup dependen de edición/componentes/servicio. Declara requisitos de licencia y custodia de claves. Restringe FILE, LOCAL INFILE, plugins y conexiones externas. Protege backups, logs y planes; no atribuyas certificación de cumplimiento a una opción habilitada.
