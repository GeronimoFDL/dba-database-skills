# Replicación, HA y DR

Fuentes: [ha](source-registry.md#ha), [logical](source-registry.md#logical), [pitr](source-registry.md#pitr).

Streaming replication física reproduce WAL para un cluster compatible; replicación lógica publica cambios seleccionados y tiene restricciones distintas. Verifica replica identity, tablas, secuencias, DDL y extensiones: una suscripción no replica automáticamente todo objeto/estado del origen.

Define slots, retención, timeline, failover, fencing y monitorización. La replicación física por sí sola no implementa todo el orquestador de failover. Herramientas externas necesitan versión, quorum y permisos explícitos; no las declares componentes del núcleo.

Asíncrona puede perder transacciones; síncrona depende de acknowledgements y política. synchronous_commit=remote_apply añade semántica/costo frente a otros niveles; acuerda disponibilidad si no hay standby. Un primario antiguo debe quedar impedido de aceptar escrituras antes de promover otro.

Prueba clientes/pooling, DNS/endpoints, promotion/failback, slots y presión WAL. Lecturas en standby pueden tener lag o ser canceladas por conflictos de recuperación; hot_standby_feedback puede retener bloat en primario. La réplica no sustituye PITR ni datos históricos. Mide RTO y pérdida potencial en simulacros autorizados.
