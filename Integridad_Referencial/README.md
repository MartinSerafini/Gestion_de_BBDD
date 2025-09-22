### **Integridad Referencial**

Este trabajo práctico tiene como objetivo explorar y comprender los conceptos y la aplicación de la **integridad referencial** en una base de datos. Para ello, se ha diseñado una base de datos llamada "editoriales" que contiene tres tablas: `editoriales`, `empleados` y `libros`[cite: 19].

Estas tablas están interconectadas mediante claves primarias (`PRIMARY KEY`) y claves foráneas (`FOREIGN KEY`) para asegurar la coherencia de los datos.

---

### **Descripción de la Base de Datos**

#### **Tabla `editoriales`**
Almacena información sobre las editoriales.
* **id_editorial**: Identificador único de cada editorial.
* **nombre_editorial**: Nombre de la editorial.
* **Clave Primaria**: `id_editorial`.

#### **Tabla `empleados`**
Contiene los datos de los empleados de las editoriales.
* **id_empleado**: Identificador único del empleado.
* **nombre_empleado**: Nombre del empleado.
* **id_editorial**: Clave foránea que relaciona al empleado con la editorial a la que pertenece.
* **Regla de Integridad**: Se debe configurar la integridad referencial para que, si se elimina o actualiza una editorial, los empleados relacionados se vean afectados en cascada (`ON DELETE CASCADE ON UPDATE CASCADE`).

#### **Tabla `libros`**
Guarda información sobre los libros publicados.
* **id_libro**: Identificador único del libro.
* **titulo_libro**: Título del libro.
* **id_editorial**: Clave foránea que relaciona el libro con su editorial.
* **Regla de Integridad**: Al igual que con los empleados, se debe configurar la integridad referencial para que la eliminación o actualización de una editorial afecte en cascada a los libros relacionados (`ON DELETE CASCADE ON UPDATE CASCADE`).

---

### **Ejercicios sobre Integridad Referencial**

Una vez que la base de datos y las tablas se han creado con sus respectivas restricciones, se debe insertar una serie de registros y luego responder a las siguientes preguntas:

1.  **Eliminar una editorial**: ¿Qué sucede con los libros asociados si se elimina una editorial? Escriba la consulta SQL que elimine una editorial y sus libros relacionados.
2.  **Actualizar el nombre de una editorial**: ¿Qué sucede con los libros relacionados si se actualiza el nombre de una editorial? 
3.  **Eliminar un empleado**: ¿Qué sucede con los libros relacionados si se elimina un empleado? 
4.  **Actualizar el nombre de un empleado**: ¿Qué sucede con los libros relacionados con la editorial si se actualiza el nombre de un empleado? 
5.  **Eliminar un libro**: ¿Qué sucede con la relación con la editorial si se elimina un libro? 
6.  **Cambiar la editorial de un libro**: ¿Qué sucede con la relación con la editorial anterior si se cambia la editorial de un libro? 
7.  **Eliminar una editorial con empleados**: ¿Qué sucede si se intenta eliminar una editorial que tiene empleados asociados? 
8.  **Eliminar un empleado con libros**: ¿Qué sucede si se intenta eliminar un empleado que tiene libros asociados? 
9.  **Eliminar una editorial y sus empleados**: ¿Cómo se eliminaría una editorial y todos sus empleados? 
10. **Eliminar y transferir empleados**: ¿Cómo se eliminaría una editorial y se reasignaría a sus empleados a otra editorial? 
