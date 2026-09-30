# T-SQL y módulos

Fuentes: [types](source-registry.md#types), [version](source-registry.md#version), [xact](source-registry.md#xact).

Usa sentencias terminadas en punto y coma, columnas explícitas y schema.object. GO pertenece al cliente y no debe enviarse como T-SQL dentro de un comando del driver. CREATE OR ALTER aplica a módulos soportados, no a cualquier tabla. Identifica reglas de batch al generar procedimientos/vistas/funciones.

NOCOUNT reduce mensajes cuando el cliente no depende de ellos. XACT_ABORT debe integrarse con el dueño y contrato transaccional; no garantiza recuperación ante todo error. TRY/CATCH y THROW preservan fallos; no conviertas errores en éxito silencioso. Triggers deben tratar inserted/deleted como conjuntos y no hacer llamadas externas prolongadas dentro de la transacción.

TOP y OFFSET/FETCH son alternativas válidas; orden único cuando la selección/paginación lo requiera. STRING_SPLIT con ordinal necesita ORDER BY ordinal para presentación ordenada. GENERATE_SERIES devuelve el tipo de sus extremos, no siempre bigint. WINDOW requiere compatibilidad adecuada. IS NOT DISTINCT FROM expresa igualdad con NULL, no garantiza seek.

Las funciones de regex, JSON y vector de 17.x necesitan revisión de versión, compatibilidad, límites y cliente. No reemplaces código correcto solo por novedad. CASE es una expresión; evita depender de cortocircuito para prevenir errores de división o conversión.
