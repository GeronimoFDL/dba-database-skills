# Plan de migración PostgreSQL 18.6

Completa destino, versión, roles, autorización, precondiciones, datos, consumidores y backup restaurable.

1. Distinguir parche/major/DDL; revisar extensiones y notas 18.6.
2. Clasificar locks y si cada comando admite transacción. CREATE INDEX CONCURRENTLY se ejecuta fuera del bloque, con recuperación de índices inválidos.
3. Definir timeouts, fases expand/contract y validación de constraints cuando aplique.
4. Ensayar fallo, reejecución y concurrencia; validar WAL/disco/réplica.
5. Definir reversión/roll-forward, punto de corte y pruebas posteriores.

Sin objetos concretos no se proporciona DDL ejecutable. No ejecutar EXPLAIN ANALYZE sobre escrituras en PROD bajo la etiqueta de solo lectura.
