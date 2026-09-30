# Migración y upgrade

Fuentes: [upgrade](source-registry.md#upgrade), [index-create](source-registry.md#index-create), [version](source-registry.md#version), [releases](source-registry.md#releases), [constraints](source-registry.md#constraints).

Clasifica cambio de parche, major version y esquema. PostgreSQL 18.6 no requiere dump/restore desde 18.x, pero revisa acciones de la nota. Para major upgrade elige pg_upgrade, dump/restore o replicación lógica con ensayo; validar extensiones, locales/collations, checksums, disco y clientes. pg_upgrade --check no ejecuta todas las pruebas de aplicación.

DDL es transaccional en muchos casos, pero CREATE INDEX CONCURRENTLY y otras operaciones no admiten bloque de transacción. Separarlas del wrapper del framework; no imitar el patrón de SQL Server para todo script. Estima lock_timeout, ACCESS EXCLUSIVE, scans/rewrite y WAL antes de ALTER.

Para constraints elegibles, evaluar NOT VALID seguido de VALIDATE CONSTRAINT puede distribuir costo; no todas las constraints soportan esa ruta. Para compatibilidad usa expand/contract y backfill acotado; no añade defaults o NOT NULL sin revisar versión y datos.

El rollback de upgrade no es simplemente arrancar binarios viejos sobre archivos nuevos. Preserva copias, punto de corte y estrategia para escrituras posteriores. Verifica sequence values, roles, estadísticas, collations y planes; no cambiar todas las opciones junto con el upgrade si se necesita atribuir regresiones.
