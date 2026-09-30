# Query Optimizer y planes

Fuentes: [S06, S09–S17, S43, S48, S73, S81](source-registry.md).

Un plan es una elección basada en estimaciones, índices, constraints, parámetros y opciones de sesión. Un operador de alto porcentaje en un plan estimado no demuestra el cuello de botella real. Compara filas reales/estimadas, ejecuciones por operador, reads, spills, grants y waits con el costo observado.

El plan estimado compila sin ejecutar; no aporta runtime. El plan real ejecuta y puede modificar datos o ser costoso. Prefiere evidencia ya capturada o reproducción autorizada. Query Store conserva historia que la caché no proporciona; la caché puede perder planes por reinicios, presión, DDL o recompilación.

## Sensibilidad a parámetros

Parameter sniffing es un mecanismo normal para compilar usando parámetros. Hay problema cuando un único plan produce resultados de rendimiento inaceptables para distribuciones diferentes.

1. Reproduce parámetros de cardinalidad baja, media y alta, distintas primeras ejecuciones y opciones SET del cliente.
2. Comprueba errores de tipos, estadísticas, estimaciones, índices, SQL generado y cambios recientes.
3. Verifica elegibilidad y uso de PSP para 2022 en [la matriz IQP](intelligent-query-processing.md), incluyendo edición y configuraciones.
4. Si persiste, compara reescritura, separación de casos o SQL dinámico parametrizado. Solo después evalúa una mitigación más específica.

| Mitigación | Beneficio que se debe probar y costo |
|---|---|
| `OPTION (RECOMPILE)` en una sentencia | Plan adaptado a la ejecución; consume compilación y reduce reutilización. No añadir a todos los procedimientos. |
| `OPTIMIZE FOR (@p = ...)` | Plan para valor elegido; justificar representatividad y obsolescencia cuando cambie la distribución. |
| `OPTIMIZE FOR UNKNOWN` | Usa estimaciones generales; puede empeorar extremos y no equivale a resolver el sesgo. |
| Plan forcing | Contención de una regresión usando un plan conocido; puede fallar o quedar inadecuado. Monitoriza y define retirada. |
| Query Store hint | Cambio por query_id sin editar código; persistente, requiere inventario, comprobación de aplicación y reversión. |

No limpies toda la plan cache como solución: elimina evidencia y aumenta compilaciones. No cambies compatibilidad, CE global o parameterization de toda la base por un caso aislado sin evaluación del workload. Forced parameterization puede mejorar reutilización y también producir planes sensibles; mide ambas consecuencias.

Registra query_id/plan_id o hashes, parámetros anonimizados, evidencia, alcance, propietario y fecha de revisión para toda mitigación. Distingue «sintaxis aceptada», «hint aplicado» y «resultado mejorado».
