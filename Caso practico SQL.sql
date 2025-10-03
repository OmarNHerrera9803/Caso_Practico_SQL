--menu_items 
--analisis exploratorio
SELECT * FROM menu_items;
--Encontrar el número de artículos en el menú.
-- 32
SELECT COUNT(menu_items) as recuento_platillos
from menu_items;
 --¿Cuálesel artículo menos caro y el más caro en el menú?
 -- Menos caro"Edamame" mas caro "Shrimp Scampi"
select ITEM_NAME, PRICE FROM MENU_ITEMS
ORDER BY PRICE
LIMIT 1;

select ITEM_NAME, PRICE FROM MENU_ITEMS
ORDER BY PRICE DESC
LIMIT 1;

SELECT ITEM_NAME, PRICE FROM MENU_ITEMS
WHERE PRICE IN (SELECT MIN(PRICE) FROM MENU_ITEMS)
UNION ALL
SELECT ITEM_NAME, PRICE FROM MENU_ITEMS
WHERE PRICE IN (SELECT MAX(PRICE) FROM MENU_ITEMS);

--¿Cuántos platos americanos hay en el menú?
-- 6
SELECT CATEGORY, COUNT (menu_item_id) FROM menu_items
GROUP BY 1;

--¿Cuálesel precio promedio de los platos?
--13.29
SELECT ROUND (AVG(PRICE),2) FROM MENU_ITEMS;

--order_details
SELECT * FROM order_details;
-- ¿Cuántos pedidos únicos se realizaron en total?
--5370
SELECT COUNT(DISTINCT ORDER_ID) FROM order_details;

-- ¿Cuáles son los 5 pedidos que tuvieron el mayor número de artículos?
-- 4305, 1957, 2675, 3473, 440, 443 y 330
SELECT ORDER_ID,  COUNT(ITEM_ID) AS RECUENTO_DE_PLATILLOS FROM order_details
GROUP BY 1
ORDER BY 2 DESC
LIMIT 7

-- ¿Cuándo se realizó el primer pedido y el último pedido?
-- 1er pedido el 01-01-2023 // ultimo pedido el 31-03-2023
SELECT MIN (ORDER_DATE) AS PRIMER_PEDIDO, MAX(ORDER_DATE) AS ULTIMMO_PEDIDO
FROM order_details;

-- ¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'?
--308
select count(DISTINCT ORDER_ID)
from order_details
where ORDER_DATE between '2023-01-01' and '2023-01-05';

-- 3. ANALISIS
SELECT *
	FROM order_details AS A
	LEFT JOIN MENU_ITEMS AS B
ON A.ITEM_ID=B.MENU_ITEM_ID;

--CINCO PUNTOS CLAVE

--1. Que tipo de comida es mas cara y cual menos cara
-- R. La comida Asian es mas barata y la mas cara es la comida Italiana
SELECT CATEGORY, PRICE FROM MENU_ITEMS
WHERE PRICE IN (SELECT MIN(PRICE) FROM MENU_ITEMS)
UNION ALL
SELECT CATEGORY, PRICE FROM MENU_ITEMS
WHERE PRICE IN (SELECT MAX(PRICE) FROM MENU_ITEMS);

--2. Cual es el platillo mas vendido	
-- "Chips & Salsa"
	SELECT ITEM_NAME AS PLATILLO, ORDER_ID AS PEDIDO
	FROM order_details AS A
	LEFT JOIN MENU_ITEMS AS B
ON A.ITEM_ID=B.MENU_ITEM_ID
GROUP BY 1,2
ORDER BY 2 DESC;

--3. Cual es el platillo menos vendido
-- R. El "Korean Beef Bowl"
	SELECT ITEM_NAME AS PLATILLO, ORDER_ID AS PEDIDO
	FROM order_details AS A
	LEFT JOIN MENU_ITEMS AS B
ON A.ITEM_ID=B.MENU_ITEM_ID
GROUP BY 1,2
ORDER BY 2 ASC;

--4. En que horario se vende más
--R. 22:15
SELECT ORDER_DETAILS_ID AS PEDIDO, ORDER_TIME AS HORARIO
	FROM order_details AS A
	LEFT JOIN MENU_ITEMS AS B
ON A.ITEM_ID=B.MENU_ITEM_ID
GROUP BY 1,2
ORDER BY 1 DESC;

--5. En que horario se vende menos
-- R. 11:38
SELECT ORDER_DETAILS_ID AS PEDIDO, ORDER_TIME AS HORARIO
	FROM order_details AS A
	LEFT JOIN MENU_ITEMS AS B
ON A.ITEM_ID=B.MENU_ITEM_ID
GROUP BY 1,2
ORDER BY 1 ASC;
