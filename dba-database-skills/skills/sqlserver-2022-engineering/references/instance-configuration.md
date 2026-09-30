# Configuración de instancia

Fuentes: [S01–S02, S17, S24, S38–S43, S78, S81](source-registry.md).

Inventaría CPU/NUMA/soft-NUMA, RAM, límites de VM/contenedor y edición, otras instancias, servicios, almacenamiento, carga y SLA. Conserva valor configurado/efectivo antes de cambiar; algunas opciones requieren reinicio o tienen alcance distinto. Cambia una variable por vez y observa un ciclo representativo.

| Parámetro | Cómo decidir |
|---|---|
| `max server memory` | Reserva para SO, drivers, agentes, otras instancias y asignaciones fuera de ese límite. No es un límite de toda la memoria del proceso. Mide presión y margen; no copiar un porcentaje sin contexto. |
| `min server memory` | No preasigna toda esa memoria al arrancar; afecta cuánto libera después de alcanzarla. Mantén un valor justificado, sobre todo con varias instancias o RAM variable. |
| `MAXDOP` | Parte de las recomendaciones Microsoft para procesadores por nodo NUMA/soft-NUMA y contrasta con throughput, duración y concurrencia. No imponer 1 u 8 universalmente; distingue servidor, base, operación y query hint. |
| Cost threshold for parallelism | El valor por defecto 5 no es recomendación universal ni milisegundos. Ajusta gradualmente con evidencia de consultas pequeñas paralelas, CPU, waits y ciclo completo. |
| IFI | En Windows, verifica el privilegio específico de mantenimiento de volumen para archivos de datos y sus implicaciones de seguridad. TDE impide IFI de datos; log autogrowth ≤64 MB puede beneficiarse en 2022 incluso con TDE. No concedas privilegios amplios innecesarios. |
| Autogrowth | Preasigna por capacidad, usa incrementos absolutos y alertas. Evalúa pausas, VLF del log y espacio; no desactives crecimiento sin contingencia. |
| Datos/log/backups | Separa por aislamiento de I/O, recuperación y dominio de fallo reales. Letras de unidad distintas no garantizan discos ni resiliencia independientes. |
| Backup compression | Compara reducción de I/O/espacio con CPU, ventana y restore. Verifica edición y algoritmo soportado en 2022; no asumir los de versiones posteriores. |
| Optimize for ad hoc workloads | Útil si planes de un solo uso consumen memoria relevante. Almacena stub inicial; tiene trade-off de recompilación/observabilidad. No corrige SQL mal parametrizado. |
| Query Store | Comprueba estado y dimensionamiento por base; consulta su referencia específica. |
| tempdb | Dimensionamiento, archivos y contención en su referencia; no extrapolar una configuración de otra instancia. |
| Cuentas de servicio | Privilegio mínimo y cambio por herramientas soportadas; documenta acceso a archivos, red, SPN/delegación si aplican. |

No actives trace flags históricos para problemas ya resueltos en 2022 sin evidencia y documentación para el CU instalado. Revisa soporte y notas del CU antes de parchear; un cambio de CU y de compatibilidad son cambios distintos que deben poder evaluarse por separado. No generes un baseline que modifique todas las instancias sin inventario.
