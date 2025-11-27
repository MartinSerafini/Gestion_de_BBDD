## Gestión de Seguridad y Permisos en MySQL

Este script SQL (`gestion_permisos_usuarios.sql`) sirve como una plantilla de **buenas prácticas** para la administración de la seguridad en bases de datos MySQL, centrándose en el **Principio del Mínimo Privilegio**.

El objetivo principal es demostrar la creación de diferentes perfiles de usuario y la asignación **granular** de permisos, asegurando que cada usuario solo tenga el acceso **estrictamente necesario** para cumplir con su rol.

---

### Perfiles de Acceso Implementados

El código define roles claros mediante la concesión de privilegios específicos (`GRANT`) a usuarios recién creados (`CREATE USER`):

* **Usuario Base (Sin Privilegios):** Se crea un usuario sin permisos explícitos. Este perfil ilustra el estado por defecto y es la base para cualquier concesión posterior.
* **Usuarios de Lectura (\`SELECT\`):** Perfiles limitados a **consultar** datos. Ideales para aplicaciones de *reporting* o usuarios que solo necesitan visualizar información sin modificarla.
* **Usuarios de Escritura (\`INSERT\`, \`UPDATE\`, \`DELETE\`):** Perfiles que pueden **modificar** los datos (añadir, cambiar o eliminar registros), pero no pueden alterar la estructura de la base de datos (DDL).
* **Usuarios Full (Administrativos):** Perfiles con **todos los privilegios** (\`ALL PRIVILEGES\`). Estos usuarios tienen control total sobre los datos y la estructura, y deben usarse con extrema precaución.
* **Permisos Granulares:** Se demuestra cómo restringir el acceso incluso dentro de una base de datos, otorgando permisos (\`SELECT\`) sobre una **tabla específica** en lugar de sobre toda la base.

---

### Gestión del Ciclo de Vida del Usuario

El script también muestra procedimientos esenciales para el mantenimiento de la seguridad:

* **Verificación de Permisos:** Se utiliza \`SHOW GRANTS FOR\` para auditar y confirmar exactamente qué privilegios tiene un usuario.
* **Eliminación de Usuarios:** Se utiliza \`DROP USER\` para **remover** cuentas. Este comando elimina la cuenta y, crucialmente, revoca **automáticamente** todos los permisos que le habían sido asignados, manteniendo la limpieza y seguridad del sistema.

Este código es fundamental para mantener un ambiente de base de datos seguro y ordenado.
