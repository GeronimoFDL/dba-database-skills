# MariaDB 13.0: comprobar el build

Fuentes: [version](source-registry.md#version), [releases](source-registry.md#releases), [changes](source-registry.md#changes).

Obtén VERSION(), version_comment, engine de cada tabla, sql_mode y variables efectivas. La referencia estable consultada es 13.0.2, publicada el 15 de septiembre de 2026; la rama es rolling. No atribuyas soporte LTS ni funciones de 13.1/13.2 al destino. Las notas de preview sirven para investigar, no para acreditar disponibilidad GA.

| Particularidad de 13.0.2 | Consecuencia operativa |
|---|---|
| Parámetros/retornos REF CURSOR y RECORD | El alcance documentado es rutinas de paquetes/PACKAGE BODY; no extender a rutinas globales. |
| UPDATE RETURNING y OLD_VALUE() | Verificar sintaxis para UPDATE de una sola tabla; no generalizar a UPDATE multitabla. |
| SYSTEM_VARIABLES | Puede exponer IS_DEPRECATED y DEPRECATED_REPLACEMENT; usar metadata para revisar configuración heredada. |
| QB_NAME | Permite nombrar bloques para dirigir hints; no garantiza un plan mejor. |
| Digests XXH3_128 | No comparar hashes históricos como identificadores estables entre versiones; no usarlos como garantía criptográfica. |
| innodb_log_archive | mariadb-backup todavía no admite el nuevo formato descrito; no activar como ajuste preventivo. |

Existe una discrepancia entre fuentes oficiales consultadas: el anuncio estable indica que atomic CREATE OR REPLACE TABLE y estadísticas utilizadas en optimizer trace quedaron fuera; las notas detalladas de 13.0.2 las enumeran. Registra el conflicto, consulta notas corregidas y comprueba el build con una prueba aislada antes de depender de esas capacidades. Mientras no se resuelva, exclúyelas de la ruta predeterminada de migración. No conviertas esa incertidumbre en una afirmación de soporte ni de ausencia universal.

La atomicidad de una operación DDL frente a crash no equivale a poder deshacer una migración arbitraria mediante ROLLBACK. CREATE OR REPLACE TABLE también puede reemplazar datos y dependencias; comprobar su atomicidad no autoriza usarlo como migración conservadora.
