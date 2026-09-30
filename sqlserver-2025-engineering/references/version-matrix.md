# Matriz de capacidades 17.x

Fuentes: [version](source-registry.md#version), [releases](source-registry.md#releases), [editions](source-registry.md#editions), [breaking](source-registry.md#breaking), [oppo](source-registry.md#oppo), [psp](source-registry.md#psp), [locking](source-registry.md#locking), [ce](source-registry.md#ce), [json](source-registry.md#json), [vector](source-registry.md#vector).

Obtén ProductVersion, Edition, compatibilidad, CU, opciones de base y estado real de Query Store. Conserva el build en el diagnóstico. Developer ya no significa necesariamente Enterprise: Standard Developer reproduce las capacidades de Standard. Su licencia sigue siendo de desarrollo/pruebas.

| Capacidad | Requisitos y decisión |
|---|---|
| OPPO | Compatibilidad 170 y OPTIONAL_PARAMETER_OPTIMIZATION habilitado; atiende patrones elegibles de parámetros opcionales. No corrige toda consulta dinámica. |
| PSP | Verificar compatibilidad/elegibilidad; 2025 amplía escenarios, incluidos DML y tempdb. No atribuir dispatcher o variantes sin observar evidencia. |
| CE feedback / feedback de expresiones | Distinguir CE_FEEDBACK y CE_FEEDBACK_FOR_EXPRESSIONS. Confirmar Enterprise/equivalente, requisitos y persistencia en Query Store; no habilitar por extrapolación de otras ediciones. |
| Feedback DOP/memory grants | La matriz 2025 los restringe a Enterprise/equivalente. Inspeccionar configuración real, compatibilidad e historia; no suponer beneficio o activación. |
| Optimized locking | Enterprise/Standard; OFF de fábrica en SQL Server. ADR es prerrequisito; LAQ requiere además RCSI. Evaluar semántica y versiones antes de activar. |
| Native json | Disponible en 17.x; no confundir soporte del tipo con disponibilidad/estado de cada función o índice JSON. Verificar cliente y herramientas. |
| Vector | Distinguir tipo float32 de búsqueda aproximada e índices vectoriales preview. float16 es preview en SQL Server según documentación consultada; no copiar su estado GA de Azure. |
| Nuevas ediciones/límites | Web se retira; consultar matriz 2025 antes de dimensionar. Express, Standard y Developer cambiaron frente a 2022. |

La lista de novedades incluye capacidades preview: no activar PREVIEW_FEATURES como baseline. Documenta aceptación expresa y entorno de evaluación cuando una necesidad dependa de ellas. Verifica también cambios de cifrado de linked servers, replicación y herramientas con OLE DB 19; una página general o un selector ver17 no elimina contenido de otros productos.
