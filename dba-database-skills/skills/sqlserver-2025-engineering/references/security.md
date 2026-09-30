# Seguridad e identidades

Fuentes: [security](source-registry.md#security), [breaking](source-registry.md#breaking), [editions](source-registry.md#editions).

Separa logins, users y roles; concede permisos a roles con propósito y prueba identidad efectiva. Schemas, ownership chaining, módulos firmados y EXECUTE AS cambian el contexto: no habilites TRUSTWORTHY o acceso entre bases para eludir un diseño. Restringe xp_cmdshell, CLR y linked servers a necesidades explícitas y destinos revisados.

Autenticación integrada/Entra/SQL depende de plataforma y arquitectura. Protege secretos y rotación. TLS debe validar certificado y nombre; OLE DB 19 introduce cambios relevantes de cifrado en linked servers/replicación. No restablezcas permanentemente TrustServerCertificate para ocultar una cadena inválida.

TDE protege archivos en reposo, no oculta datos a usuarios autorizados. Always Encrypted necesita cliente y custodia de claves; DDM no es cifrado ni barrera frente a inferencias; RLS requiere probar todos los roles y contexto de tenant, especialmente pooling. Audit necesita destino protegido, retención y alerta de fallo.

Custodia certificados y claves de backup/TDE fuera del servidor y prueba recuperación. Funciones REST/modelos externos pueden transmitir datos: destino, contenido, credenciales y autorización deben ser explícitos. No actives extensiones/preview ni egress por el solo hecho de estar disponibles. Cumplimiento requiere requisitos y evidencia, no una lista de funciones.
