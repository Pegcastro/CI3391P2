-- Query 2: ¿Cuántas subastas se realizan por mes por categoría? (tomar en cuenta todas las
-- categorías) 

WITH RECURSIVE subastas_por_categorias AS (
SELECT date_part('month', s.inicio) as mes, c.nombre, c.id, c.parent_id, COUNT(*) as subastas
FROM subastas as s
JOIN productos as p ON s.producto_id = p.id
JOIN categorias as c ON p.categoria_id = c.id
GROUP BY mes, c.nombre, c.id, c.parent_id
UNION
SELECT s.mes, c.nombre, c.id, c.parent_id, s.subastas
FROM subastas_por_categorias as s
JOIN categorias as c ON s.parent_id = c.id)
SELECT mes, nombre, parent_id, SUM(subastas)
FROM subastas_por_categorias
GROUP BY mes, nombre, id, parent_id
ORDER BY id DESC;