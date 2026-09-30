# PostgreSQL 18 y parche 18.6

Fuentes: [version](source-registry.md#version), [releases](source-registry.md#releases), [config](source-registry.md#config), [generated](source-registry.md#generated).

Confirma versión del servidor, distribución, extensiones, SO, encoding y collation provider. Un servicio administrado puede restringir superuser, filesystem, extensiones y parámetros; no prometas equivalencia operacional con una instalación propia.

| Capacidad 18 | Tratamiento |
|---|---|
| AIO | Verificar io_method, plataforma y métricas. Puede mejorar scans, bitmap heap scans y vacuum; no promete acelerar cualquier consulta ni sustituye dimensionamiento. |
| B-tree skip scan | Puede ampliar uso de índices multicolumna sin predicado en la primera columna; depende de distribución y costo. No elimina la importancia del orden de claves. |
| uuidv7() | UUID ordenado temporalmente disponible en núcleo; evaluar contrato de identificadores, privacidad temporal y patrón de escritura. |
| Generated columns | Las virtuales son el valor predeterminado en 18; elegir VIRTUAL/STORED explícitamente según costo y restricciones. |
| RETURNING OLD/NEW | Disponible en DML de 18; revisar aliases, triggers y resultado del comando concreto. No usar sintaxis T-SQL OUTPUT. |
| Constraints temporales | Evaluar WITHOUT OVERLAPS y PERIOD con rangos, claves y operadores elegibles; no son tablas temporales automáticas de SQL Server. |
| Checksums | initdb los habilita por defecto en 18; inspeccionar clusters existentes y compatibilidad con pg_upgrade, no deducirlo de la versión. |

18.6: revisar output_plugin_libraries para plugins de logical decoding permitidos, incidencias pgcrypto y scripts COPY de psql, además de recomendaciones de reindex específicas. El parche no exige dump/restore desde 18.x, pero sí puede requerir acciones según extensiones y uso. No ejecutar descifrado correctivo ni reindex general sin determinar afectación. pg_upgrade conserva estadísticas en 18, pero todavía requiere validación posterior. No presentar 18.6 como garantía perpetua de estar actualizado.
