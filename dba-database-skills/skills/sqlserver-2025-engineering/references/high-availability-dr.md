# HA, DR y distribución

Fuentes: [ha](source-registry.md#ha), [editions](source-registry.md#editions), [breaking](source-registry.md#breaking), [query-store](source-registry.md#query-store).

Define fallos cubiertos, RPO/RTO, quorum, latencia y capacidad del destino. AG, FCI, log shipping y replicación cumplen objetivos distintos. Sincronía añade latencia y exige condiciones para failover sin pérdida; asíncrono puede perder transacciones no endurecidas. Basic AG de Standard tiene límites diferentes de Enterprise.

Comprueba listener, resolución, certificados, routing, reconexión y pooling. Prueba pérdida de nodo/sitio, failover/failback, escrituras interrumpidas y lag de envío/redo. Sincroniza objetos de instancia y dependencias no transportadas. La réplica no sustituye backup ni protege de borrados lógicos.

En 17.x revisa soporte específico de Query Store en secundarios y edición; no heredes la exclusión preview de 2022 sin consultar notas de 2025. El soporte de lectura/backup secundario tampoco demuestra permisos o jobs configurados. Cambios de OLE DB/TLS afectan replicación y distribución remota.

Antes de adoptar enlaces a servicios cloud verifica CU, modo y estado preview. No prometas RTO sin simulacro ni cero pérdida por la mera existencia de una réplica. Separa runbook de configuración, operación y recuperación.
