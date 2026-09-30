# Índices y creación concurrente

Fuentes: [indexes](source-registry.md#indexes), [partial](source-registry.md#partial), [index-create](source-registry.md#index-create), [version](source-registry.md#version).

Elige B-tree para comparaciones/orden habituales; GIN para operadores de colecciones/documentos, GiST/SP-GiST para dominios compatibles y BRIN para correlación física en tablas grandes. Verifica operator class y tipos: el nombre del método no garantiza que soporte el predicado.

Diseña índices multicolumna por filtros, orden y carga. Skip scan de 18 amplía casos elegibles, no hace irrelevante la primera columna. INCLUDE puede permitir index-only scans, pero dependen además del visibility map y requieren mantenimiento; más cobertura aumenta escrituras/espacio. Expresiones indexadas requieren funciones apropiadas y coincidencia de semántica.

Un índice parcial necesita que el planner pueda demostrar implicación del predicado; consultas parametrizadas pueden impedirlo. Duplicados de prefijo no son necesariamente redundantes. No retires índices de constraints por métricas de lectura aisladas.

CREATE INDEX CONCURRENTLY reduce bloqueo de escrituras, pero no significa cero espera. No puede ejecutarse dentro de un bloque de transacción; realiza más fases y puede dejar índice inválido ante fallo. Revisa pg_index, transacciones antiguas, progreso y recuperación antes de reintentar. Comprueba límites de tablas particionadas; no copies ONLINE/RESUMABLE de SQL Server.
