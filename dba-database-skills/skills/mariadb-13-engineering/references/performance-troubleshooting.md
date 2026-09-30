# Diagnóstico de rendimiento

Fuentes: [analyze](source-registry.md#analyze), [monitoring](source-registry.md#monitoring), [statistics](source-registry.md#statistics), [releases](source-registry.md#releases).

Define síntoma, SLA, intervalo, parámetros y concurrencia. Recoge plan, filas, I/O, CPU, locks y latencia de cliente; separa estimación incorrecta, exceso de trabajo, contención y saturación. Una métrica acumulada desde arranque no describe automáticamente el incidente.

EXPLAIN estima; ANALYZE y ANALYZE FORMAT=JSON ejecutan la consulta. Clasifica los efectos de la sentencia y posibles funciones antes de capturar medidas. La sintaxis y estructura de salida no son las de EXPLAIN ANALYZE MySQL; usa documentación MariaDB y registra versión.

Performance Schema, slow log y vistas auxiliares necesitan configuración y tienen costos. Evita habilitar toda instrumentación o publicar SQL/valores sensibles. Correlaciona servidor, pool, red y aplicación. Compara cargas iguales, variabilidad y otros consumidores.

Los digests de 13.0.2 usan XXH3_128 según notas; al comparar con otras versiones conserva texto normalizado/contexto en lugar de asumir hashes estables. Para hints y optimizer_switch registra estado previo, prueba controlada y retirada; QB_NAME permite dirigir un hint, no valida su conveniencia.

Si no existe acceso al motor, entrega hipótesis y consultas de diagnóstico acotadas, indicando que no se midió beneficio.
