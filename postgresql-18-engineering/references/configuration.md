# Memoria, conexiones y almacenamiento

Fuentes: [config](source-registry.md#config), [monitoring](source-registry.md#monitoring), [vacuum](source-registry.md#vacuum).

Dimensiona por host/contenedor, concurrencia y carga. shared_buffers, effective_cache_size y work_mem tienen papeles distintos; effective_cache_size informa estimación, no reserva RAM. work_mem puede multiplicarse por operaciones, workers y sesiones; no fijarlo como porcentaje global libre. Revisa maintenance_work_mem y autovacuum por separado.

Controla max_connections y pooling antes de aumentar indiscriminadamente procesos. Registra límites del sistema, almacenamiento de WAL, checkpoints, temporales, tablespaces y crecimiento. fsync/full_page_writes y synchronous_commit afectan garantías distintas: no deshabilitarlos como tuning sin contrato explícito de pérdida/corrupción.

PostgreSQL 18 introduce AIO; confirma io_method y soporte real, mide I/O y latencia antes/después. Diferencia parámetros de sesión, reload y restart; consulta pg_settings y pending_restart, conserva valores previos y evita restart por inferencia.

Dimensiona autovacuum y retención WAL junto con replicación; un slot abandonado puede llenar disco. No borres archivos internos manualmente para liberar espacio. Servicios administrados limitan parámetros/rutas; entrega alternativa específica y no un archivo de configuración que no pueden aplicar.
