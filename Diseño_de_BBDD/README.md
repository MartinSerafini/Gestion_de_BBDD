### Diseño y Gestión de Base de Datos

A partir del siguiente conjunto de ejercicios, un analista deberá aplicar sus conocimientos para diseñar y gestionar una base de datos.

---

#### 1. Recopilación de Datos y Diseño Conceptual
* **Determinar las entidades principales** que son relevantes para el sistema.
* **Identificar los atributos clave** para cada entidad.

---

#### 2. Modelado de la Base de Datos
* Crear un **Diagrama de Entidad-Relación (DER)**.
* Desarrollar un **Diccionario de Datos** que describa cada entidad y sus atributos.

---

#### 3. Implementación y Estructura
* Elaborar el **Diagrama de Tablas**.
* Implementar la base de datos en código **SQL**.

---

#### 4. Pruebas y Consultas
* Crear al menos **dos consultas relacionadas** para validar y probar la funcionalidad de la base de datos.

---

### Especificaciones del Sistema

La empresa, ubicada en Tierra del Fuego, se especializa en el ensamblaje de televisores. El proceso de producción implica la gestión de componentes, la fabricación interna de piezas, y el ensamblaje de modelos de televisores.

* **Componentes y Proveedores**: Algunos componentes se compran a un **importador**, y cada compra viene con su **factura**.
* **Fabricación Interna**: Otras piezas se **fabrican** internamente en la empresa.
    * A cada tipo de pieza fabricada se le asigna **un operario**.
    * Sin embargo, una sola pieza puede ser fabricada por **varios operarios**.
    * Los operarios registran la **fecha** y la **cantidad** de piezas fabricadas en una "hoja de confección".
* **Ensamblaje de Televisores**: Los modelos de televisores se componen de **300 o más piezas**.
    * Una misma pieza puede ser utilizada en **múltiples modelos de televisores**.
    * Existe un **mapa de armado** para cada modelo, que especifica la **ubicación** y el **orden** de las piezas.
