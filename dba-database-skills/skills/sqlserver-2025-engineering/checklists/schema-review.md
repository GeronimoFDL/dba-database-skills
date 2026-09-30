# Revisión de modelo

- [ ] Grano, cardinalidades, dominio, autoridad e histórico explícitos.
- [ ] Reglas confirmadas separadas de hipótesis; preguntas pendientes sin inventar respuestas.
- [ ] Todas las claves candidatas, dependencias, 1FN/2FN/3FN y anomalías evaluadas.
- [ ] Reconstrucción sin pérdida y preservación de dependencias justificadas por separado.
- [ ] PK/UNIQUE/FK/CHECK/NULL cumplen el contrato en este motor; el diagrama no promete reglas que el DDL no impone.
- [ ] Tipos, collation, precisión, zonas horarias y crecimiento preservados.
- [ ] Índices y particiones justificados; constraints no eliminadas por falta de lecturas.
- [ ] Desnormalización con motivo, autoridad, actualización y conciliación.
- [ ] Datos existentes, consumidores, concurrencia y reversión comprobados.

Consulta [normalization](../references/normalization.md), [database-design](../references/database-design.md) y [deployment](../references/deployment.md).
