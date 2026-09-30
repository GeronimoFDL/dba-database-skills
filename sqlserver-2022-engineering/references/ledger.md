# Ledger en SQL Server 2022

Fuentes: [S108–S111, S121, S124](source-registry.md). Evalúa Ledger cuando se requiera evidencia criptográfica de alteraciones; no lo actives como requisito genérico de seguridad o de normalización.

## Elegir el modelo y sus límites

Ledger permite detectar manipulación mediante verificación contra digests confiables. No impide toda modificación externa de archivos por un administrador del equipo ni demuestra que el dato introducido sea verdadero. Tampoco certifica por sí solo cumplimiento normativo o no repudio de una persona. Conserva autenticación, permisos, Audit y backups según los requisitos [S108].

| Tipo | Comportamiento y decisión |
|---|---|
| Updatable ledger | Admite INSERT, UPDATE y DELETE; conserva versiones anteriores en historial y expone operaciones mediante una ledger view. El versionado Ledger y las consultas temporales son capacidades distinguibles: pueden combinarse, pero no asumas que toda tabla Ledger exige `SYSTEM_VERSIONING = ON` temporal [S124, S121]. |
| Append-only ledger | Solo permite inserciones; bloquea UPDATE/DELETE mediante la interfaz del motor y no necesita tabla de historial. Evalúa cómo registrar rectificaciones mediante nuevos hechos [S108]. |

Una base creada como ledger database tiene efectos sobre las nuevas tablas; no actives esa propiedad para resolver una necesidad aislada sin revisar el alcance. Una tabla ordinaria no se convierte directamente en Ledger y una tabla Ledger no se revierte a ordinaria. No admite TRUNCATE; revisa retención, crecimiento e incompatibilidades, incluidas In-Memory OLTP y replicación transaccional. Verifica las limitaciones específicas del historial y de la combinación temporal, sin trasladarlas indiscriminadamente a toda tabla Ledger [S109].

## Custodia y verificación

1. Define quién custodia los digests y evita que los administradores con capacidad de alterar la base puedan reemplazar también la evidencia externa. Generar un digest y dejarlo únicamente junto a los datos no establece esa separación.
2. Distingue generación manual con `sys.sp_generate_database_ledger_digest` y automatización soportada. En SQL Server, el almacenamiento automático usa Azure Storage; no traslades automáticamente opciones de Azure SQL. La generación manual permite conservar el JSON en un destino confiable, por ejemplo WORM. Protege credenciales y prueba exportación, disponibilidad y retención [S110].
3. Programa verificación con digests previamente protegidos: `sys.sp_verify_database_ledger` para gestión manual o `sys.sp_verify_database_ledger_from_digest_storage` para almacenamiento configurado. Comprueba que las ubicaciones sean las esperadas. La verificación puede recorrer tablas e historial: estima costo, ventana y tratamiento de fallos [S111].
4. Registra resultado, alcance temporal y digests utilizados; ensaya recuperación y continuidad de la evidencia tras restaurar. No declares integridad comprobada solo porque existan hashes o tablas de catálogo.

Entrega el diseño, costo de historial, restricciones, custodia externa y procedimiento de verificación antes de preparar una migración. Usa [security-review](../checklists/security-review.md) y [production-change](../checklists/production-change.md); las pruebas de manipulación deben hacerse en una copia de laboratorio autorizada.
