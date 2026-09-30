# Ledger y evidencia de alteraciones

Fuentes: [ledger](source-registry.md#ledger), [ledger-limits](source-registry.md#ledger-limits).

Evalúa Ledger para verificación criptográfica de integridad, no como requisito universal. Updatable ledger permite modificar datos conservando historial; append-only bloquea UPDATE/DELETE en la interfaz del motor. Ledger y temporal son capacidades distinguibles y combinables: no toda tabla Ledger equivale a SYSTEM_VERSIONING temporal.

No admite TRUNCATE ni tablas In-Memory; una tabla ordinaria no se convierte directamente a Ledger y una Ledger no vuelve ordinaria. Revisa retención, crecimiento e incompatibilidades del tipo concreto. Distingue limitaciones del historial y de la tabla actual.

Los digests deben custodiarse externamente en almacenamiento confiable, fuera del control de quien pueda alterar la base. Define generación, exportación, verificación periódica y respuesta a discrepancias. Guardar hashes no equivale a haber verificado los datos. La verificación puede consumir recursos; estima ventana y prueba continuidad de evidencia después de restauraciones.

Ledger detecta alteraciones frente a evidencia confiable; no demuestra que los datos ingresados fueran verdaderos ni impide toda manipulación de archivos por administradores del equipo. Mantén permisos, Audit, backups y controles de identidad; no prometas no repudio personal o cumplimiento automático.
