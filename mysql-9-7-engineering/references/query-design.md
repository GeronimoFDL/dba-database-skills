# Consultas, UPSERT y lotes

Fuentes: [insert](source-registry.md#insert), [explain](source-registry.md#explain), [indexes](source-registry.md#indexes), [transactions](source-registry.md#transactions).

Preserva grano, NULL, multiplicidad y orden antes de optimizar. EXISTS suele evitar duplicar filas cuando solo se busca existencia. NOT IN con NULL no equivale a antijoin directo. Revisa sargabilidad, conversiones charset/tipo y rangos semiabiertos para fechas con parámetros tipados.

INSERT ... ON DUPLICATE KEY UPDATE responde a conflictos de claves únicas; con varias restricciones el conflicto puede no coincidir con la identidad de negocio pretendida. Prueba la semántica y evita depender de VALUES() deprecado cuando la sintaxis de aliases soportada sea apropiada. REPLACE puede borrar e insertar, disparar efectos y cambiar IDs; no lo trates como UPDATE inocuo.

INSERT IGNORE puede convertir errores en warnings; no lo uses como validación de datos. Examina warnings, filas afectadas y modo estricto. Una comprobación previa de existencia no resuelve carreras; protege invariantes con índices únicos y contrato transaccional.

FOR UPDATE y SKIP LOCKED tienen uso específico de concurrencia/colas; no aseguran vistas completas de reportes. Pagina por clave estable para lotes grandes, registra progreso y define atomicidad total o parcial. En cargas masivas, LOCAL INFILE implica capacidades de cliente/servidor y acceso a archivos: no habilitar por defecto.
