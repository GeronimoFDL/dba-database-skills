# Índices y ALTER TABLE

Fuentes: [indexes](source-registry.md#indexes), [ddl](source-registry.md#ddl), [foreign-keys](source-registry.md#foreign-keys).

Diseña índices a partir de predicados, orden y volumen, considerando el costo de escritura. El ancho de la PK InnoDB afecta a secundarios. Un índice compuesto no es intercambiable con varios índices simples. No copies INCLUDE, índices filtrados T-SQL o índices invisibles MySQL sin verificar capacidades MariaDB.

Antes de retirar un índice, revisa constraints, cargas infrecuentes y el intervalo de observación. Un scan puede ser óptimo; no prometas seek por usar <=>. Expresiones/columnas generadas, prefijos y longitudes dependen del tipo, collation y versión.

Consulta la matriz de la operación para ALGORITHM=INSTANT, INPLACE, NOCOPY o COPY y LOCK. Soporte y efectos dependen del engine, cambio y estructura; INPLACE no significa necesariamente ausencia de reconstrucción. Especifica requisitos cuando quieras que una alternativa más bloqueante falle, en vez de aceptarse silenciosamente.

Incluso DDL online necesita metadata locks y puede esperar transacciones largas. Estima tablas temporales, disco, redo/binlog, duración y réplica. No prometas cero bloqueo ni reanudación genérica. WITH (ONLINE = ON, RESUMABLE = ON) es sintaxis de SQL Server, no MariaDB.

Para construir constraints, valida previamente duplicados/huérfanos sin tomar la comprobación como protección contra escrituras concurrentes. Diseña cierre de esa carrera durante el cambio.
