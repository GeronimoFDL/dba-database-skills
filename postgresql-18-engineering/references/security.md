# Roles, autenticación y aislamiento

Fuentes: [security](source-registry.md#security), [rls](source-registry.md#rls), [schemas](source-registry.md#schemas), [functions](source-registry.md#functions), [ssl](source-registry.md#ssl), [releases](source-registry.md#releases).

Separa roles LOGIN de roles de privilegios; distingue ownership, membresía, herencia y posibilidad de SET ROLE. Evita superuser para aplicaciones/monitoreo. Revisa pg_hba.conf en orden, métodos y redes; no uses trust como arreglo permanente. SCRAM y TLS con verify-full requieren cliente, certificados y nombres compatibles; MD5 está deprecado en 18.

RLS necesita habilitación, políticas y pruebas con las identidades reales. Propietarios y roles BYPASSRLS/superuser pueden eludir políticas según configuración; FORCE ROW LEVEL SECURITY no transforma superuser en usuario restringido. Define quién fija contexto de tenant y cómo se limpia con pooling.

search_path que incluye schemas escribibles permite suplantar objetos. Funciones SECURITY DEFINER deben fijar contexto seguro y limitar EXECUTE, especialmente ante privilegios PUBLIC. Revisa extensiones, lenguajes no confiables y acceso a filesystem/red; no instales extensiones por comodidad sin necesidad.

En 18.6 verifica allowlist output_plugin_libraries al usar decodificadores externos y recomendaciones de seguridad de pgcrypto/psql. Distingue cifrado de disco del entorno, TLS y cifrado por columna: no inventes TDE o Ledger de SQL Server en el núcleo. Auditoría avanzada puede depender de extensiones/servicio, con versión y retención explícitas.
