/* * PROYECTO: Lógica de Consultas SQL
 * --------------------------------
 * NOTA DE EJECUCIÓN:
 * Requisito previo: Ejecutar el script 'BBDD_Proyecto_shakila_sinuser.sql'
 * tras haber creado la base de datos 'shakila'.
 */


-- 1. Crea el esquema de la BBDD.
-- Para esta práctica se ha creado una base de datos independiente llamada 'shakila'.
-- El script de carga se ha ejecutado sobre el esquema 'public' de dicha base de datos
-- para garantizar la integridad de las secuencias y relaciones.

-- (Si quieres poner el comando que usaste para crear la base de datos):

CREATE DATABASE shakila;

-- 2. Muestra los nombres de todas las películas con una clasificación por edades de ‘R’.

select f.title
  from film f
 where f.rating = 'R';

-- 3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40.

select a.first_name, a.last_name 
  from actor a 
 where a.actor_id  between 30 and 40; 

-- 4. Obtén las películas cuyo idioma coincide con el idioma original.
-- * Nota: En este dataset, Todos 'original_language_id' son NULL, 
--         por lo que es normal que la consulta no devuelva resultados.

select f.title 
  from film f 
 where f.language_id  = f.original_language_id;

-- 5. Ordena las películas por duración de forma ascendente.

SELECT f.title, f.length 
  FROM film f 
 ORDER BY f.length ASC;

-- 6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.
-- * Nota: Se utiliza UPPER para asegurar que la búsqueda sea insensible a mayúsculas/minúsculas.

SELECT a.first_name, a.last_name 
  FROM actor a 
 WHERE UPPER(a.last_name) LIKE 'ALLEN';

-- * Nota: Si se quiere ser más flexible por si hay apellidos compuestos, usamos '%ALLEN%'

SELECT a.first_name, a.last_name 
  FROM actor a 
 WHERE UPPER(a.last_name) LIKE '%ALLEN%';

-- 7. Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y muestra la clasificación junto con el recuento.

SELECT f.rating, COUNT(*) AS recuento_peliculas
  FROM film f 
 GROUP BY f.rating;

-- 8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.

SELECT f.title as titulo, f.rating, f.length as duracion
  FROM film f 
 WHERE f.rating = 'PG-13' 
    OR f.length > 60*3;

-- 9. Encuentra la variabilidad de lo que costaría reemplazar las películas.

SELECT VAR_SAMP(f.replacement_cost) AS varianza_reemplazo, 
       STDDEV(f.replacement_cost) AS desviacion_estandar_reemplazo
  FROM film f;

-- 10. Encuentra la mayor y menor duración de una película de nuestra BBDD.

SELECT 
    MAX(f.length) AS duracion_maxima, 
    MIN(f.length) AS duracion_minima
FROM film f;

-- 11. Encuentra lo que costó el penultimo alquiler ordenado por día.

SELECT  p.amount
  FROM payment p 
 ORDER BY p.payment_date DESC 
 LIMIT 1 OFFSET 1;

-- 12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC17’ ni ‘G’ en cuanto a su clasificación.

SELECT f.title AS "Título", 
       f.rating AS "Clasificación"
  FROM film f 
 WHERE f.rating NOT IN ('NC-17', 'G');

-- 13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.

SELECT f.rating AS "Clasificación", 
       ROUND(AVG(f.length), 2) AS "Promedio_Duración"
  FROM film f 
 GROUP BY f.rating;

-- 14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.

SELECT f.title AS "Título", 
       f.length AS "Duración_Minutos"
  FROM film f 
 WHERE f.length > 180;

-- 15. ¿Cuánto dinero ha generado en total la empresa?

SELECT SUM(p.amount) AS "Recaudación_Total" 
  FROM payment p;

-- 16. Muestra los 10 clientes con mayor valor de id.

SELECT c.customer_id AS "ID_Cliente", 
       c.first_name AS "Nombre", 
       c.last_name AS "Apellido"
  FROM customer c 
 ORDER BY c.customer_id DESC 
 LIMIT 10;


-- 17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.

SELECT a.first_name AS "Nombre", 
       a.last_name AS "Apellido"
  FROM actor a
  INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
  INNER JOIN film f ON fa.film_id = f.film_id
 WHERE UPPER(f.title) = 'EGG IGBY';

-- 18. Selecciona todos los nombres de las películas únicos.

SELECT DISTINCT f.title AS "Título_Único"
  FROM film f;

-- 19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”.

SELECT f.title AS "Título", 
       f.length AS "Duración"
  FROM film f
  INNER JOIN film_category fc ON f.film_id = fc.film_id
  INNER JOIN category c ON fc.category_id = c.category_id
 WHERE c.name = 'Comedy'
   AND f.length > 180;

-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.

SELECT c.name AS "Categoría", 
       ROUND(AVG(f.length), 2) AS "Promedio_Duración"
  FROM film f
  INNER JOIN film_category fc ON f.film_id = fc.film_id
  INNER JOIN category c ON fc.category_id = c.category_id
 GROUP BY c.name
HAVING AVG(f.length) > 110;

-- 21. ¿Cuál es la media de duración del alquiler de las películas?

SELECT ROUND(AVG(f.rental_duration), 2) AS "Media_Duración_Alquiler"
  FROM film f;

-- 22. Crea una columna con el nombre y apellidos de todos los actores y actrices.

SELECT a.first_name || ' ' || a.last_name AS "Nombre_Completo"
  FROM actor a;

-- 23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.

SELECT DATE(r.rental_date) AS "Fecha", 
       COUNT(*) AS "Total_Alquileres"
  FROM rental r 
 GROUP BY DATE(r.rental_date)
 ORDER BY "Total_Alquileres" DESC;

-- 24. Encuentra las películas con una duración superior al promedio.

SELECT f.title AS "Título", 
       f.length AS "Duración"
  FROM film f 
 WHERE f.length > (SELECT AVG(f2.length) FROM film f2);

-- 25. Averigua el número de alquileres registrados por mes.

SELECT TO_CHAR(r.rental_date, 'YYYY-MM') AS "Mes", 
       COUNT(*) AS "Total_Alquileres"
  FROM rental r 
 GROUP BY "Mes"
 ORDER BY "Mes";

-- 26. Encuentra el promedio, la desviación estándar y varianza del total pagado.

SELECT ROUND(AVG(p.amount), 2) AS "Promedio_Pago", 
       ROUND(STDDEV(p.amount), 2) AS "Desviación_Estándar", 
       ROUND(VARIANCE(p.amount), 2) AS "Varianza"
  FROM payment p;

-- 27. ¿Qué películas se alquilan por encima del precio medio?

SELECT f.title AS "Título", 
       f.rental_rate AS "Precio"
  FROM film f 
 WHERE f.rental_rate  > (SELECT AVG(f2.rental_rate ) FROM film f2);

-- 28. Muestra el id de los actores que hayan participado en más de 40 películas.

SELECT fa.actor_id AS "ID_Actor", 
       COUNT(fa.film_id) AS "Total_Películas"
  FROM film_actor fa
 GROUP BY fa.actor_id
HAVING COUNT(fa.film_id) > 40;

-- 29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.

SELECT f.film_id AS "ID",
       f.title AS "Título", 
       COUNT(i.inventory_id) AS "Cantidad_Disponible"
  FROM film f
  LEFT JOIN inventory i ON f.film_id = i.film_id
 GROUP BY f.film_id, f.title
 ORDER BY "Cantidad_Disponible" DESC;

-- 30. Obtener los actores y el número de películas en las que ha actuado.

SELECT a.first_name AS "Nombre", 
       a.last_name AS "Apellido", 
       COUNT(fa.film_id) AS "Número_Películas"
  FROM actor a
  INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
 GROUP BY a.actor_id, a.first_name, a.last_name
 ORDER BY "Número_Películas" DESC;

-- 31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.

select f.film_id as "ID",
       f.title AS "Película", 
       a.first_name AS "Nombre_Actor", 
       a.last_name AS "Apellido_Actor"
  FROM film f
  LEFT JOIN film_actor fa ON f.film_id = fa.film_id
  LEFT JOIN actor a ON fa.actor_id = a.actor_id
  order by "Película";


-- 32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.

 SELECT a.first_name AS "Nombre_Actor", 
       a.last_name AS "Apellido_Actor",
       f.title AS "Película"
  FROM actor a
  LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
  LEFT JOIN film f ON fa.film_id = f.film_id;
  
-- 33. Obtener todas las películas que tenemos y todos los registros de alquiler.
-- Uso LEFT JOIN para asegurar que salgan todas las películas,
-- incluso las que nunca han sido alquiladas.
 
 SELECT f.title AS "Película", 
       r.rental_id AS "ID_Alquiler", 
       r.rental_date AS "Fecha_Alquiler"
  FROM film f
  LEFT JOIN inventory i ON f.film_id = i.film_id
  LEFT JOIN rental r ON i.inventory_id = r.inventory_id;
 
-- 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.

SELECT c.customer_id AS "ID", 
       c.first_name AS "Nombre", 
       c.last_name AS "Apellido", 
       SUM(p.amount) AS "Total_Gastado"
  FROM customer c
  INNER JOIN payment p ON c.customer_id = p.customer_id
 GROUP BY c.customer_id, c.first_name, c.last_name
 ORDER BY "Total_Gastado" DESC
 LIMIT 5;
 
-- 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.

SELECT a.first_name AS "Nombre", 
       a.last_name AS "Apellido"
  FROM actor a
 WHERE UPPER(a.first_name) = 'JOHNNY';

-- 36. Renombra la columna “first_name” como Nombre y “last_name” como Apellido.

SELECT a.first_name AS "Nombre", 
       a.last_name AS "Apellido"
  FROM actor a;

-- 37. Encuentra el ID del actor más bajo y más alto en la tabla actor.

SELECT MIN(a.actor_id) AS "ID_Mínimo", 
       MAX(a.actor_id) AS "ID_Máximo"
  FROM actor a;

-- 38. Cuenta cuántos actores hay en la tabla “actor”.

SELECT COUNT(*) AS "Total_Actores"
  FROM actor a;

-- 39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.

SELECT a.first_name AS "Nombre", 
       a.last_name AS "Apellido"
  FROM actor a
 ORDER BY a.last_name ASC;

-- 40. Selecciona las primeras 5 películas de la tabla “film”.

SELECT f.title AS "Título"
  FROM film f
 LIMIT 5;

-- 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?

SELECT a.first_name AS "Nombre", 
       COUNT(*) AS "Repeticiones"
  FROM actor a
 GROUP BY a.first_name
 ORDER BY "Repeticiones" DESC
 LIMIT 1;

-- NOTA: Al ejecutar la query básica con LIMIT 1, observamos que existen varios nombres 
-- (Julia, Kenneth, Penelope) empatados con el máximo de 4 repeticiones. 
-- Para evitar sesgos y mostrar todos los registros máximos, ajustamos la query usando una subconsulta en el HAVING:

SELECT a.first_name AS "Nombre", 
       COUNT(*) AS "Repeticiones"
  FROM actor a
 GROUP BY a.first_name
HAVING COUNT(*) = (
    SELECT COUNT(*) 
      FROM actor 
     GROUP BY first_name 
     ORDER BY 1 DESC 
     LIMIT 1
);
 

-- 42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.

SELECT r.rental_id AS "ID_Alquiler", 
       c.first_name AS "Nombre_Cliente", 
       c.last_name AS "Apellido_Cliente"
  FROM rental r
  INNER JOIN customer c ON r.customer_id = c.customer_id;

-- 43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.

SELECT c.first_name AS "Nombre", 
       c.last_name AS "Apellido", 
       r.rental_id AS "ID_Alquiler"
  FROM customer c
  LEFT JOIN rental r ON c.customer_id = r.customer_id;

-- 44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.
-- Nota: No aporta valor real porque asocia cada película con TODAS las categorías 
-- existentes, creando combinaciones que no existen en la realidad.

SELECT f.title, c.name AS "Categoría"
  FROM film f
  CROSS JOIN category c;

-- 45. Encuentra los actores que han participado en películas de la categoría 'Action'.
-- Nota: Usamos DISTINCT para que un actor no aparezca repetido si ha hecho varias de acción.

SELECT DISTINCT a.actor_id as "ID",
          a.first_name AS "Nombre", 
       a.last_name AS "Apellido" 
  FROM actor a
INNER JOIN film_actor fa  on a.actor_id = fa.actor_id
INNER JOIN film_category fc on fa.film_id = fc.film_id 
INNER JOIN category c on c.category_id = fc.category_id 
WHERE c.name  = 'Action';

-- 46. Encuentra todos los actores que no han participado en películas.
-- Nota: Usamos LEFT JOIN para encontrar los registros en 'actor' que no tienen pareja en 'film_actor'.

SELECT a.first_name AS "Nombre", 
       a.last_name AS "Apellido"
  FROM actor a
  LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
 WHERE fa.film_id IS NULL;
  
-- Versión optimizada con NOT EXISTS
SELECT a.first_name AS "Nombre", 
       a.last_name AS "Apellido"
  FROM actor a
 WHERE NOT EXISTS (
    SELECT 1 
      FROM film_actor fa 
     WHERE a.actor_id = fa.actor_id
 );
  
-- 47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.

SELECT a.first_name AS "Nombre", 
       a.last_name AS "Apellido", 
       COUNT(fa.film_id) AS "Total_Películas"
  FROM actor a
  LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
 GROUP BY a.actor_id, a.first_name, a.last_name
 ORDER BY "Total_Películas" DESC;

-- 48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y el número de películas en las que han participado.

CREATE OR REPLACE VIEW actor_num_peliculas AS
SELECT a.first_name AS "Nombre", 
       a.last_name AS "Apellido", 
       COUNT(fa.film_id) AS "Total_Películas"
  FROM actor a
  LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
 GROUP BY a.actor_id, a.first_name, a.last_name;


-- 49. Calcula el número total de alquileres realizados por cada cliente.

SELECT c.first_name AS "Nombre", 
       c.last_name AS "Apellido", 
       COUNT(r.rental_id) AS "Total_Alquileres"
  FROM customer c
  LEFT JOIN rental r ON c.customer_id = r.customer_id
 GROUP BY c.customer_id, c.first_name, c.last_name
 ORDER BY "Total_Alquileres" DESC;

-- 50. Calcula la duración total de las películas en la categoría 'Action'.

SELECT c.name AS "Categoría", 
       SUM(f.length) AS "Duración_Total_Minutos"
  FROM film f
  INNER JOIN film_category fc ON f.film_id = fc.film_id
  INNER JOIN category c ON fc.category_id = c.category_id
 WHERE c.name = 'Action'
 GROUP BY c.name;

-- 51. Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.
-- Nota: Esta tabla solo existirá durante la sesión actual 

CREATE TEMP TABLE cliente_rentas_temporal AS
SELECT c.customer_id, 
       c.first_name, 
       c.last_name, 
       COUNT(r.rental_id) AS total_alquileres
  FROM customer c
  INNER JOIN rental r ON c.customer_id = r.customer_id
 GROUP BY c.customer_id, c.first_name, c.last_name;

-- NOTA: Para verificar que la tabla temporal se creó correctamente:
SELECT * FROM cliente_rentas_temporal;

-- 52 Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las
-- películas que han sido alquiladas al menos 10 veces.

CREATE TEMP TABLE peliculas_alquiladas AS
SELECT f.title, COUNT(r.rental_id) AS total_alquileres
  FROM film f
  JOIN inventory i ON f.film_id = i.film_id
  JOIN rental r ON i.inventory_id = r.inventory_id
 GROUP BY f.film_id, f.title
HAVING COUNT(r.rental_id) >= 10;


-- 53. Encuentra el título de las películas que han sido alquiladas por el cliente
-- con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena
-- los resultados alfabéticamente por título de película.

-- NOTA: Filtramos por return_date IS NULL ya que, en la estructura de base de datos, 
-- un valor nulo en la fecha de devolución indica que el cliente aún tiene la película.
-- Usamos UPPER para asegurar la coincidencia exacta de los nombres

SELECT f.title
  FROM film f
  JOIN inventory i ON f.film_id = i.film_id
  JOIN rental r ON i.inventory_id = r.inventory_id
  JOIN customer c ON r.customer_id = c.customer_id
 WHERE UPPER(c.first_name) = UPPER('Tammy') AND UPPER(c.last_name) = UPPER('Sanders')
   AND r.return_date IS NULL
 ORDER BY f.title ASC;

-- 54. Encuentra los nombres de los actores que han actuado en al menos una
-- película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados
-- alfabéticamente por apellido.

SELECT DISTINCT a.first_name, a.last_name
  FROM actor a
  JOIN film_actor fa ON a.actor_id = fa.actor_id
  JOIN film_category fc ON fa.film_id = fc.film_id
  JOIN category c ON fc.category_id = c.category_id
 WHERE c.name = 'Sci-Fi'
 ORDER BY a.last_name ASC;

-- 55. Encuentra el nombre y apellido de los actores que han actuado en
-- películas que se alquilaron después de que la película ‘Spartacus Cheaper’ 
-- se alquilara por primera vez. Ordena los resultados
-- alfabéticamente por apellido.
-- Usamos UPPER para asegurar la coincidencia exacta del titulo.

SELECT DISTINCT a.first_name, a.last_name
  FROM actor a
  JOIN film_actor fa ON a.actor_id = fa.actor_id
  JOIN inventory i ON fa.film_id = i.film_id
  JOIN rental r ON i.inventory_id = r.inventory_id
 WHERE r.rental_date > (
    SELECT MIN(r2.rental_date)
      FROM rental r2
      JOIN inventory i2 ON r2.inventory_id = i2.inventory_id
      JOIN film f2 ON i2.film_id = f2.film_id
     WHERE UPPER(f2.title) = UPPER('Spartacus Cheaper')
 )
 ORDER BY a.last_name ASC;

-- 56. Encuentra el nombre y apellido de los actores que no han actuado en
-- ninguna película de la categoría ‘Music’.

SELECT a.first_name, a.last_name
  FROM actor a
 WHERE NOT EXISTS (
    SELECT 1 
      FROM film_actor fa
      JOIN film_category fc ON fa.film_id = fc.film_id
      JOIN category c ON fc.category_id = c.category_id
     WHERE fa.actor_id = a.actor_id AND c.name = 'Music'
 )
 ORDER BY a.last_name ASC;

-- 57. Encuentra el título de todas las películas que fueron alquiladas por más
-- de 8 días.

SELECT DISTINCT f.title
  FROM film f
  JOIN inventory i ON f.film_id = i.film_id
  JOIN rental r ON i.inventory_id = r.inventory_id
 WHERE (r.return_date - r.rental_date) > INTERVAL '8 days';

-- 58. Encuentra el título de todas las películas que son de la misma categoría
-- que ‘Animation’.

SELECT f.title
  FROM film f
  JOIN film_category fc ON f.film_id = fc.film_id
 WHERE fc.category_id in (
    SELECT category_id FROM category WHERE name = 'Animation'
 );

-- NOTA: También se podría resolver utilizando EXISTS 
SELECT f.title
  FROM film f
  JOIN film_category fc ON f.film_id = fc.film_id
 WHERE EXISTS (
    SELECT 1 
      FROM category c 
     WHERE fc.category_id = c.category_id 
       AND c.name = 'Animation'
 );

-- 59. Encuentra los nombres de las películas que tienen la misma duración
-- que la película con el título ‘Dancing Fever’. Ordena los resultados
-- alfabéticamente por título de película.
-- NOTA: Utilizamos el upper para asegurar la coincidencia exacta del titulo.

SELECT title
  FROM film
 WHERE length = (SELECT length FROM film WHERE upper(title) = 'DANCING FEVER')
   AND upper(title) <> 'DANCING FEVER' -- Excluimos la película de referencia
 ORDER BY title ASC;

-- 60. Encuentra los nombres de los clientes que han alquilado al menos 7
-- películas distintas. Ordena los resultados alfabéticamente por apellido.

-- NOTA: Utilizamos COUNT(DISTINCT i.film_id) para asegurar que contamos títulos únicos. 
-- Esto evita contar dos veces a un cliente si alquiló diferentes copias físicas (inventory_id) de la misma película.

SELECT c.first_name AS "Nombre", 
       c.last_name AS "Apellido",
       COUNT(DISTINCT i.film_id) AS "Titulos_Distintos"
  FROM customer c
  JOIN rental r ON c.customer_id = r.customer_id
  JOIN inventory i ON r.inventory_id = i.inventory_id
 GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT i.film_id) >= 7
 ORDER BY c.last_name ASC;

-- 61. Encuentra la cantidad total de películas alquiladas por categoría y
-- muestra el nombre de la categoría junto con el recuento de alquileres.

SELECT c.name AS "Categoría", COUNT(r.rental_id) AS "Total_Alquileres"
  FROM category c
  JOIN film_category fc ON c.category_id = fc.category_id
  JOIN inventory i ON fc.film_id = i.film_id
  JOIN rental r ON i.inventory_id = r.inventory_id
 GROUP BY c.name;

-- 62. Encuentra el número de películas por categoría estrenadas en 2006.

SELECT c.name AS "Categoría", COUNT(f.film_id) AS "Peliculas_2006"
  FROM category c
  JOIN film_category fc ON c.category_id = fc.category_id
  JOIN film f ON fc.film_id = f.film_id
 WHERE f.release_year = 2006
 GROUP BY c.name;

-- 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas
-- que tenemos.

SELECT s.first_name AS "Empleado", st.store_id AS "Tienda"
  FROM staff s
  CROSS JOIN store st;

-- 64. Encuentra la cantidad total de películas alquiladas por cada cliente y
-- muestra el ID del cliente, su nombre y apellido junto con la cantidad de
-- películas alquiladas.

SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS "Total_Alquiladas"
  FROM customer c
  JOIN rental r ON c.customer_id = r.customer_id
 GROUP BY c.customer_id, c.first_name, c.last_name;
