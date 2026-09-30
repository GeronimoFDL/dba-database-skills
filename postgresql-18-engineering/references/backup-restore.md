# Copias, WAL y recuperación

Fuentes: [backup](source-registry.md#backup), [pitr](source-registry.md#pitr), [basebackup](source-registry.md#basebackup), [verifybackup](source-registry.md#verifybackup), [pgdump](source-registry.md#pgdump).

Distingue backup lógico (pg_dump/pg_dumpall) de copia física con WAL. pg_dump toma una base; roles/tablespaces y objetos globales requieren tratamiento separado. Un dump no es backup físico ni ofrece por sí mismo PITR. El formato custom facilita restore selectivo; revisa propietarios, extensiones, permisos y versiones de herramientas.

PITR requiere base backup y cadena íntegra de WAL archivado, destinos durables y configuración de recuperación. Registra timelines, slots, retención y claves; copiar PGDATA en caliente sin protocolo correcto no es un backup consistente. Comprueba fallos de archive_command o mecanismo equivalente y capacidad antes de purgar.

pg_verifybackup comprueba manifest/integridad de copia en su alcance, pero no sustituye arrancar una restauración y probar consultas/aplicación. Ensaya recuperación temporal, promoción y recuperación de roles/configuraciones externas. Copias incrementales físicas requieren herramientas y combinación compatibles; no asumir que son restores autónomos.

Prueba restores aislados con WAL completo y tiempos RPO/RTO. Una réplica puede propagar borrados. Protege dumps porque pueden contener datos y código ejecutable; restaura material no confiable en un contexto aislado. Documenta backup previo a upgrades y estrategia frente a nuevo WAL tras promoción.
