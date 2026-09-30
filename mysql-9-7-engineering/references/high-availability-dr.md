# Replicación, GTID y Group Replication

Fuentes: [ha](source-registry.md#ha), [gtid](source-registry.md#gtid), [backup](source-registry.md#backup).

Replica asíncrona no garantiza cero pérdida; semisíncrona y Group Replication tienen requisitos y semánticas distintas. Define disponibilidad, quorum, fencing, selección de escritor, failover y clientes. MySQL Router/InnoDB Cluster son componentes de una arquitectura, no activados por crear una réplica.

GTID identifica transacciones y facilita posicionamiento; no corrige drift ni convierte MariaDB GTID en formato compatible. Registra conjuntos ejecutados/purgados y evita saltar errores o inyectar transacciones vacías sin evaluar integridad. Revisa binlog format, claves, row image y compatibilidad origen/destino.

Group Replication necesita mayoría, requisitos de tablas y red; certificación puede rechazar transacciones y requiere reintentos. Modo single-primary/multi-primary cambia conflictos, no elimina la necesidad de invariantes. Un nodo atrasado no debe aceptar tráfico incompatible con el SLA.

Mide apply lag y fallos, no solo un contador de segundos. Prueba pérdida de nodo/sitio, incorporación, recuperación distribuida, routing y failback. Protege credenciales de replicación y TLS. Copias históricas siguen siendo necesarias frente a borrados/corrupción replicados.
