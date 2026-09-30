# Mantenimiento proporcional a necesidad

Fuentes: [S05–S08, S15, S33, S37–S38, S46–S47](source-registry.md).

Diseña tareas por objetivo, evidencia, frecuencia, ventana y responsable. Evita trabajos simultáneos que compitan por CPU, I/O, tempdb o log. Vigila el impacto en envío/redo de AG y otras cargas.

## Índices y estadísticas

No utilices 5–30 % REORGANIZE y >30 % REBUILD como automatismo universal. Correlaciona tamaño, page density, fragmentación y patrón de lectura con degradación real; la densidad puede ser más relevante que la fragmentación. Una condición que dispara revisión no tiene que disparar reparación automática.

Compara no hacer nada, reorganizar, reconstruir y actualizar una estadística concreta. Evalúa recursos, log, bloqueos, espacio adicional, edición y ventana. `ONLINE` no significa cero bloqueo. Comprueba operaciones resumibles suspendidas y su costo mientras esperan.

`REORGANIZE` no actualiza estadísticas. Rebuild rowstore actualiza estadísticas del índice, con excepciones de muestreo para operaciones particionadas/resumibles; no refresca todas las estadísticas de columnas. Coordina ambos trabajos sin duplicación. Para columnstore examina calidad de rowgroups y filas eliminadas, no aplique métricas rowstore mecánicamente.

No recomendar automatic index compaction como feature de SQL Server 2022: la página compartida de mantenimiento enlaza capacidades de otros productos.

## Otras tareas

| Tarea | Resultado verificable |
|---|---|
| Backups y copias | Cumplimiento RPO, cadena completa, custodia y restauraciones ensayadas. |
| CHECKDB | Cobertura completa o parcial identificada, última validación íntegra y alertas. |
| Historial de backups/jobs | Retención acordada y eliminación soportada sin perder evidencia necesaria para recuperar o auditar. No DML manual sobre tablas internas. |
| Query Store | Espacio, captura, limpieza, estado real y revisión de mitigaciones persistentes. |
| Archivos y log | Espacio, crecimiento y causa de retención; no SHRINK rutinario. |
| SQL Agent jobs | Propietario, mínimos permisos, horario, exclusión de solapamientos, reintentos seguros, código de salida y notificación de fallos. Express requiere alternativa porque no incluye SQL Agent. |

Prueba tareas nuevas en un entorno representativo. Conserva métricas de costo y beneficio y reajusta por cambios de carga. No llames «mantenimiento exitoso» a una tarea que terminó pero incumplió disponibilidad o recuperación.
