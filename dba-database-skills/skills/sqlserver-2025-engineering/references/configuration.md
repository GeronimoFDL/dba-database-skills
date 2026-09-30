# Instancia, tempdb y capacidad

Fuentes: [tempdb](source-registry.md#tempdb), [editions](source-registry.md#editions), [locking](source-registry.md#locking).

Registra CPU/NUMA, memoria efectiva del host/contenedor, almacenamiento, latencia, concurrencia y servicios vecinos. Configura memoria dejando margen al sistema y otros consumidores; evita porcentajes universales. MAXDOP y cost threshold requieren topología y carga; Resource Governor en Standard 2025 no implica que deba habilitarse sin política.

Preasigna datos/log por crecimiento real y deja autogrowth como respaldo. Múltiples log files no paralelizan el log. Dimensiona tempdb por objetos temporales, spills, versionado y mantenimiento; archivos de datos equilibrados y crecimiento coherente. Más archivos no resuelven CPU o consultas excesivas.

Distingue PAGELATCH de PAGEIOLATCH, contención de asignación de última página y PVS de tempdb. 17.x introduce opciones adicionales de recuperación/recursos de tempdb: verifica soporte y estado real por build antes de activarlas. Los defaults de un servicio cloud no son baseline de SQL Server instalado.

Revisa Instant File Initialization, privilegios de servicio y límites de crecimiento sin asumir que todo crecimiento de log se beneficia igual. Cambios de rutas, inicio y límites requieren verificación tras reinicio, permisos de filesystem y capacidad de recuperación. No reinicies ni mates sesiones como diagnóstico por defecto.
