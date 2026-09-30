# Replicación, GTID y Galera

Fuentes: [gtid](source-registry.md#gtid), [ha](source-registry.md#ha), [backup](source-registry.md#backup).

Identifica topología, réplica asíncrona/semisíncrona o Galera, versión de proveedor, roles y objetivo de fallo. No confundas GTID MariaDB con el formato y procedimientos MySQL; dominios, servidores y secuencias afectan consistencia y failover.

Evalúa slave_pos/current_pos y escrituras locales antes de cambiar origen por GTID. Una posición mayor no prueba que el nodo contenga exactamente la historia correcta. No manipules posiciones para saltar errores sin identificar pérdida/divergencia. Protege credenciales y TLS.

Galera replica write sets con certificación; requiere quorum, manejo de conflictos, SST/IST y capacidad del nodo más lento. No promete escala ilimitada de escritura ni lectura causal automática en toda configuración. Verifica wsrep_sync_wait cuando el contrato requiera visibilidad causal y su costo.

Los cambios de esquema bajo TOI/RSU tienen efectos y riesgos distintos. Coordina nodos y consumidores con procedimientos compatibles; no ejecutes un ALTER por nodo suponiendo independencia. Bootstrap requiere identificar estado y nodo correctos; no automatices selección ciega que cause split-brain.

Ensaya failover, routing, reconexión, pérdida de COMMIT conocido, reintentos y failback. Mide lag y estado de apply, no solo disponibilidad TCP. Mantén backups históricos independientes ante corrupción o borrados replicados.
