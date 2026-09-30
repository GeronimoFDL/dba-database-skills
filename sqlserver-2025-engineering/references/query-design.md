# Consultas y escrituras

Fuentes: [indexes](source-registry.md#indexes), [transactions](source-registry.md#transactions), [psp](source-registry.md#psp).

Preserva primero resultados: identifica multiplicidad de joins, grano de agregación y semántica de NULL. EXISTS evita multiplicar filas cuando se busca existencia; NOT IN con NULL no equivale automáticamente a NOT EXISTS. CTE no promete materialización; #temp puede ayudar cuando fases, estadísticas o reutilización lo justifican.

En predicados, alinea tipos y procura transformar parámetros, no columnas, sin cambiar semántica. Para días suele ser útil un rango semiabierto con límites tipados; algunas conversiones son optimizables, por lo que decide con plan. Scan y Key Lookup pueden ser óptimos. No añadas INCLUDE ni hints para eliminar iconos.

Parametriza valores en sp_executesql. Para identificadores y orden usa lista permitida y QUOTENAME; delimitar no concede autorización. Parámetros sniffed requieren distribución y planes representativos; evalúa PSP/OPPO antes de mitigaciones, sin prohibir RECOMPILE cuando exista evidencia.

UPSERT requiere unicidad y protección contra carreras. IF NOT EXISTS seguido de INSERT no basta. Evalúa transacción corta con protección de rango o intento optimista y manejo específico de conflicto. MERGE necesita fuente única por clave, semántica de triggers y prueba concurrente; no es garantía de atomicidad del negocio. DML por lotes requiere progreso estable e idempotencia; OUTPUT no confirma COMMIT.
