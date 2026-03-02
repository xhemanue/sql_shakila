# 📊 Proyecto: SQL Sakila - Resolución de Consultas Avanzadas

Este repositorio contiene la resolución detallada de **64 ejercicios prácticos** realizados sobre la base de datos **Shakila** utilizando **PostgreSQL**. El proyecto cumple con todos los requisitos técnicos solicitados para la gestión y análisis de bases de datos relacionales.

## 🛠️ Tecnologías y Herramientas
* **Base de Datos:** PostgreSQL 
* **Entorno de Desarrollo:** DBeaver / pgAdmin 4
* **Lenguaje:** SQL

## 🎯 Requisitos del Proyecto Cumplidos
A lo largo de este script se demuestran los siguientes conocimientos técnicos:

* **Manejo de DBeaver:** Gestión de scripts, ejecución de consultas y visualización de resultados.
* **Consultas de tabla única:** Filtrado, ordenación y alias.
* **Relaciones entre tablas:** Uso experto de `INNER JOIN`, `LEFT JOIN` y `CROSS JOIN`.
* **Subconsultas Avanzadas:** Consultas anidadas y correlacionadas en `WHERE` y `FROM`.
* **Filtrado Agregado (`HAVING`):** Uso de filtros sobre funciones de agregación (`COUNT`, `SUM`) para segmentar grupos de datos.
* **Lógica de Existencia (`EXISTS` / `NOT EXISTS`):** Implementación de semántica de conjuntos para optimizar búsquedas.
* **Vistas (`VIEW`):** Creación de objetos para la persistencia de lógica de negocio.
* **Estructuras Temporales (`TEMP TABLE`):** Uso de tablas de sesión para procesar datos intermedios.
* **Buenas Prácticas:** Indentación clara, comentarios técnicos y uso de `UPPER()` para normalización de búsquedas.

## 🛠️ Instrucciones de Uso

Para replicar el proyecto completo, siga la secuencia lógica definida en los scripts:

1. **Inicio del Proyecto (Ejercicio 1):** Abra el archivo `sql_shakila.sql`. El primer paso documentado es la creación del esquema de la base de datos (`CREATE DATABASE shakila;`).
2. **Carga de Datos:** Una vez creado el esquema, utilice el archivo `BBDD_Proyecto_shakila_sinuser.sql` para realizar el volcado de tablas, relaciones e inserción de registros (esto permite que el resto de ejercicios tengan datos sobre los que trabajar).
3. **Resolución de Consultas (Ejercicios 2-64):** Continúe con la ejecución secuencial del script `sql_shakila.sql`, donde se resuelven los retos de filtrado, agregación, vistas y estructuras temporales.

## 📂 Estructura del Repositorio
* **`BBDD_Proyecto_shakila_sinuser.sql`**: Script de creación y carga de la base de datos Shakila (esquema y datos).
* `sql_shakila.sql`: Script principal con las 64 consultas debidamente comentadas y organizadas.
* `README.md`: Documentación del proyecto (este archivo).

## 📝 Conclusiones
La realización de esta práctica ha permitido profundizar en la arquitectura de las bases de datos relacionales, comprendiendo cómo el **inventario**, los **alquileres** y los **clientes** se entrelazan para generar información de valor para la toma de decisiones.

---
**Desarrollado como parte de la formación de Data & Analytics V3 - Bases de Datos** - ThePower
