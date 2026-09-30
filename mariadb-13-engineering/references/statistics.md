# Estadísticas y estimaciones

Fuentes: [statistics](source-registry.md#statistics), [analyze](source-registry.md#analyze), [indexes](source-registry.md#indexes).

Compara filas estimadas y observadas antes de atribuir lentitud a falta de índices. Distingue estadísticas InnoDB de estadísticas independientes del engine y sus histogramas. Comprueba configuración, permisos y sintaxis de ANALYZE TABLE ... PERSISTENT FOR según versión y necesidad.

Una muestra puede perder sesgo, correlación o valores raros. Reúne parámetros representativos, tamaño y cambios de distribución. Actualizar estadísticas puede cambiar planes de otras consultas; registra antes/después y supervisa regresiones.

No programes ANALYZE total indiscriminado tras cada carga pequeña. Evalúa consumo, bloqueos y tablas afectadas. Las tablas de estadísticas y variables MariaDB no son equivalentes a las de MySQL; evita copiar instrucciones de histogramas de ese producto.

No dependas todavía de la exposición nueva de estadísticas en optimizer trace sin resolver el conflicto documental 13.0.2 descrito en version-matrix. Los planes y medidas disponibles siguen siendo evidencia útil sin esa función.
