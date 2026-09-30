# Análisis de rendimiento

Completar con evidencia real; marcar «no disponible» cuando corresponda. Eliminar apartados no aplicables. No publicar valores sensibles de parámetros ni texto que contenga secretos.

## Objetivo y contexto

- Síntoma y resultado esperado, con SLA y ventana de observación:
- Servidor/base/entorno, edición, versión/build y configuración:
- Cambios recientes y patrón de workload, datos y concurrencia:
- SQL/objetos relevantes, query_id/plan_id o hashes:
- Alcance autorizado y categoría de riesgo:

## Evidencia y límites

| Evidencia | Origen/fecha/intervalo | Observación | Limitación |
|---|---|---|---|
| Plan real o estimado | | | Indicar si se ejecutó la consulta |
| Query Store | | | Captura, estado y agregación |
| DMVs/waits | | | Reinicios/reset y alcance |
| Índices/estadísticas | | | Definiciones, muestra, distribución |
| Aplicación/cliente | | | Pool, red, parámetros, materialización |

## Hipótesis y decisión

- Hechos que explican el síntoma:
- Hipótesis y observación que las confirmaría/refutaría:
- Alternativas consideradas y costo de no cambiar:
- Cambio mínimo elegido, alcance y requisitos de edición/configuración:
- Seguridad, integridad, bloqueo, log, espacio y costo de escritura:

## Comparación

| Métrica | Antes | Después | Condiciones comparables |
|---|---|---|---|
| Resultados/filas/invariantes | | | |
| Ejecuciones y parámetros representativos | | | |
| CPU y duración | | | |
| Logical/physical reads | | | |
| Grants/spills y estimaciones | | | |
| Throughput, blocking/deadlocks y errores | | | |
| Costo de escritura/mantenimiento | | | |

Registrar unidades, repeticiones y fuente. No inferir percentiles de promedios de Query Store. Si no hubo ejecución, dejar explícito que el beneficio aún no está demostrado.

## Aplicación y seguimiento

- Pre-check y artefacto exacto:
- Validación de resultados, concurrencia y seguridad:
- Criterios de éxito/aborto, rollback o roll-forward y limitaciones:
- Responsable y ventana para monitorizar regresiones:
- Para hints/forcing: inventario anterior, prueba de aplicación y criterio de retirada:
- Fuentes técnicas de [source-registry](../references/source-registry.md):
