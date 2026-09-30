# Plan de migración MySQL 9.7

Completa versión/distribución/engine, destino autorizado, precondiciones y respaldo restaurable.

1. Clasificar cada sentencia por implicit commit; separar DDL del DML pendiente.
2. Revisar ALGORITHM/LOCK y metadata locks. No existe garantía genérica de pausa/reanudación de todo ALTER.
3. Planificar expand/contract, backfill, claves/constraints y validación de datos.
4. Estimar disco, redo/binlog, réplica y ventana; definir aborto y limpieza tras fallo parcial.
5. Probar consumidores, permisos, reejecución y recuperación con herramientas compatibles.

Atomic DDL no autoriza a prometer ROLLBACK de una migración de varias sentencias. No incluye DDL ejecutable sin objetos/cambios concretos.
