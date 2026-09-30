# Configuración y capacidad

Fuentes: [releases](source-registry.md#releases), [monitoring](source-registry.md#monitoring), [transactions](source-registry.md#transactions).

Inventaría configuración efectiva, archivos y fuentes de override, memoria del host/contenedor, CPU y almacenamiento. Preserva valores previos y cambia una hipótesis medible por vez. No copies porcentajes universales de buffer pool o límites de conexiones.

Presupuesta buffer pool más conexiones, buffers por operación, temporales, instrumentación y sistema operativo. Aumentar max_connections puede empeorar saturación; evalúa pooling y backpressure. Mide I/O y checkpoints antes de modificar redo o políticas de durabilidad.

Ajustes de flush/binlog pueden afectar pérdida de datos y recuperación; documenta ese trade-off frente a RPO. Los nombres parecidos a MySQL no garantizan mismo rango, default o significado. Usa metadata de SYSTEM_VARIABLES, incluidas deprecaciones disponibles en 13.0.2, y distingue variables dinámicas de las que requieren reinicio.

No habilites innodb_log_archive mientras el flujo dependa de mariadb-backup incompatible. Antes de persistir cambios, prueba arranque, réplica y backup. Estima crecimiento de datos/índices, binlog, relay log y espacio transitorio de ALTER/restore.
