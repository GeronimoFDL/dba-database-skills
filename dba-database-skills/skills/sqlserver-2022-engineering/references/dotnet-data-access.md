# SQL Server desde .NET

Fuentes: [S53–S56, S69, S84–S88, S93](source-registry.md).

Esta referencia evalúa efectos sobre la base, no prescribe una arquitectura C#. Inspecciona versión real de EF Core, Dapper y Microsoft.Data.SqlClient; no infieras su comportamiento a partir de «.NET moderno».

| Síntoma/decisión | Comprobación |
|---|---|
| Muchas consultas pequeñas | Cuenta viajes y detecta N+1/lazy loading; compara proyección, carga anticipada o consultas separadas conscientes. Evita reemplazarlo por un join que multiplique desmesuradamente filas. |
| Demasiadas columnas/filas | Proyecta lo necesario, pagina con orden estable y filtra en servidor; revisar materialización y tracking. |
| Lentitud que no aparece en SQL | Separa tiempo de espera del pool, apertura, ejecución, red y materialización; correlaciona trazas de aplicación con Query Store. |
| Conversión implícita | Verifica tipo, longitud, Unicode, precisión y escala del parámetro enviado. En Dapper, `DbString`/parámetros explícitos pueden alinear varchar y longitud con la columna. |
| Agotamiento del pool | Dispose/cierre oportuno, transacciones abiertas, connection strings variables, múltiples identidades y concurrencia. No aumentar Max Pool Size sin causa y capacidad del servidor. |
| Acceso async | Mejora uso de hilos de la aplicación, no reduce por sí mismo CPU ni lecturas SQL. Evita bloqueos sync-over-async; mide casos específicos del driver. |
| Command timeout | Límite de espera de un comando, distinto de conexión y lock timeout. Basarlo en SLA y diagnóstico; aumentarlo puede ocultar blocking. Cancelación no prueba que no hubiera commit. |
| Batching | Reduce viajes si la unidad de trabajo lo permite; vigila tamaño de parámetros, log, bloqueo y reanudación. |

`DbContext` ya participa en seguimiento y unidad de trabajo; no impongas Repository/Unit of Work adicionales sin necesidad del diseño. Clean Architecture, DDD y SOLID orientan límites y dependencias, no sustituyen constraints ni métricas. Alinea transacciones con invariantes del módulo y evita transacciones distribuidas implícitas por abrir múltiples conexiones.

Para EF Core, inspecciona SQL y parámetros reales en una captura protegida. Usa `rowversion` como concurrency token cuando se requiera detectar modificaciones; define manejo de `DbUpdateConcurrencyException`. Revisa estrategia de reintentos con transacciones explícitas: debe reintentar la unidad completa y ser idempotente. MARS impide los savepoints automáticos de EF; documenta el contrato de error.

Para Dapper, conserva transacción, timeout y cancelación explícitos según API instalada. Parámetros no protegen nombres/tablas concatenados. No intercambies conexiones/transactions entre componentes sin definir su dueño y ciclo de vida.

Una regresión puede requerir cambiar acceso a datos, no índices. Valida con carga concurrente desde el cliente real, incluida serialización, SQL emitido, errores y recuperación de conexiones.
