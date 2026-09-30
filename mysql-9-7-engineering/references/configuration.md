# Configuración y capacidad

Fuentes: [config](source-registry.md#config), [changes](source-registry.md#changes), [transactions](source-registry.md#transactions).

Registra memoria disponible real, CPU, I/O, conexiones y servicios concurrentes. Buffer pool debe responder al working set y al margen del sistema; no fijarlo siempre a 80 %. Buffers por sesión/operación y temporales pueden multiplicar uso por concurrencia. Más max_connections no sustituye pooling/backpressure.

Dimensiona redo, undo, binlogs y temporales considerando checkpoints, escritura y recuperación. innodb_flush_log_at_trx_commit y sync_binlog afectan durabilidad; no relajarlos para ganar benchmark sin contrato de pérdida. Evalúa group commit y latencia del almacenamiento.

En 9.7 innodb_log_writer_threads cambia su default según binlog y CPU; consulta valor efectivo y mide antes de forzarlo. Variables pueden ser globales, de sesión, persistidas o de inicio; SET PERSIST no equivale a cambiar toda sesión ya abierta. Conserva valor anterior y procedimiento de reversión/reinicio.

lower_case_table_names, charset/collation y sql_mode deben formar parte del contrato de instalación y migración, no modificarse improvisadamente. No copies my.cnf de otra versión sin comprobar variables retiradas. En servicios administrados verifica parameter groups y opciones permitidas.
