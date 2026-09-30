# Plan de migración SQL Server 2025

Completa destino/build/edición, autorización, precondiciones, diff de esquema, pruebas, volumen, recursos, backup restaurable y reversión antes de ejecutar.

1. Confirmar contratos y dependencias; separar upgrade, compatibilidad y DDL.
2. Clasificar qué operaciones permiten transacción, ONLINE o RESUMABLE.
3. Si el script posee una transacción, rechazar una transacción exterior y usar TRY/CATCH, XACT_STATE y THROW. Si participa en una exterior, definir contrato distinto.
4. Validar datos y consumidores; medir bloqueos/log/espacio/réplicas.
5. Definir límite de pausa/aborto, recuperación y comprobaciones posteriores.

No contiene DDL ejecutable porque objetos y cambios dependen del caso. Una reversión a motor anterior necesita copias y procedimiento compatibles, no solo ROLLBACK o bajar compatibilidad.
