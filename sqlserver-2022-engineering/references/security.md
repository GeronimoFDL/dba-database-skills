# Seguridad de base de datos y aplicaciones

Fuentes: [S01, S24–S32, S69, S78, S89–S90, S99–S102](source-registry.md). CIS se usa como marco de evaluación: se verificó su catálogo SQL Server 2022 v1.3.0, no se obtuvo ni auditó el PDF completo. No atribuyas números de controles ni certificación CIS a esta guía.

## Identidad, permisos y superficie

- Prefiere Windows/AD authentication cuando la plataforma y operación lo permitan. SQL authentication puede ser necesaria; protege y rota secretos, limita origen de red y evita cuentas compartidas de administración. No cambies autenticación sin verificar compatibilidad y recuperación de acceso.
- Distingue logins de servidor, users de base y roles de ambos ámbitos. Concede a roles el mínimo necesario; separa identidad de aplicación, despliegue, backup, monitoreo y administración. No uses `sysadmin`/`db_owner` como remedio rutinario.
- `GRANT` concede; `REVOKE` retira una concesión/denegación explícita y puede dejar permisos heredados; `DENY` deniega con excepciones del modelo, incluida la interacción histórica de permisos de columna. Verifica permisos efectivos con la identidad real, no solo el DDL de roles.
- Schemas y ownership chaining cambian cómo se comprueban permisos. SQL dinámico puede requerir un diseño distinto; evalúa módulos firmados y permisos específicos para acceso entre bases. No actives cross-database ownership chaining o `TRUSTWORTHY` globalmente por comodidad.
- Mantén `TRUSTWORTHY OFF` para bases de usuario salvo necesidad justificada; no apliques ciegamente esta regla a `msdb`, cuyo comportamiento de producto debe respetarse.
- Cuentas de servicio separadas y con privilegios mínimos; en Windows evalúa cuentas administradas y realiza cambios con las herramientas de configuración soportadas. No incrustes credenciales en SQL, repositorios, logs ni planes compartidos.
- Reduce superficie: no habilites `xp_cmdshell`, CLR, linked servers, RPC o acceso externo sin necesidad, permisos y responsable. Para CLR conserva sus controles de confianza; para linked servers revisa mapeo de identidad, delegación y destinos, no credenciales amplias reutilizadas.

## Protecciones complementarias

| Control | Qué protege y qué debe probarse |
|---|---|
| TLS | Tránsito y validación de identidad con certificado confiable, nombre correcto y clientes compatibles. No resolver errores dejando permanentemente `TrustServerCertificate=True` o cifrado deshabilitado. |
| TDE | Archivos de datos/log en reposo; no oculta datos a usuarios autorizados ni sustituye TLS. Custodia certificado y clave privada; prueba restauración fuera del servidor original. |
| Always Encrypted | Separa acceso a claves del motor mediante cliente compatible. Revisa consultas admitidas, enclave si aplica, claves y costo; no prometer transparencia funcional completa. |
| Backup cifrado | Protege copias; exportación y custodia independiente de claves/certificados son parte de la recuperación. Verifica soporte de edición. |
| SQL Server Audit | Evidencia de acciones: configura selección, destino protegido, retención, monitoreo de fallos y acceso restringido. Definir tratamiento de fallos según requisitos. |
| Dynamic Data Masking | Reduce exposición accidental; no cifra ni impide inferencia por usuarios que pueden consultar libremente. |
| Row-Level Security | Filtros de lectura y bloqueos de escritura según política. Prueba todos los roles y contexto de tenant; protege quién establece ese contexto, especialmente con pooling. |

No inventes cumplimiento regulatorio: convierte requisitos aprobados en verificaciones específicas y evidencia.

Para evidencia criptográfica de alteraciones, consulta [ledger](ledger.md). Su verificación depende de digests confiables protegidos externamente; no sustituye los controles de acceso ni certifica cumplimiento por sí sola.

## Inyección y validación

Parametriza todas las entradas de valores; procedimientos almacenados y ORMs también son vulnerables si concatenan SQL. `sp_executesql` es seguro solo con un texto fijo/revisado y parámetros separados. Para identificadores/orden dinámico que no aceptan parámetros, mapea opciones de una lista permitida y delimita nombres con `QUOTENAME`; valida longitud y resultado. No uses escape de comillas como defensa principal.

Prueba permisos negativos, SQL malicioso como datos, filtración entre tenants, renovación de certificados y recuperación de secretos. Usa [security-review](../checklists/security-review.md).
