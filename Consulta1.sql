-- Query #1: En promedio, ¿Cuáles productos tienen precios de venta más alto? ¿Los que
-- empiezan con un precio base menor de $1 ó los que empiezan con un precio base de
-- por lo menos $1? (no puedo comparar precios de productos diferentes) NO PROBADO

CREATE VIEW precios_menor_1 AS
SELECT AVG(s.precio_actual), p.id, p.nombre
FROM subastas as s 
JOIN productos as p ON s.producto_id = p.id
WHERE s.precio_base < 1 AND s.activa = FALSE
GROUP BY p.id;

CREATE VIEW precios_almenos_1 AS
SELECT AVG(s.precio_actual), p.id, p.nombre
FROM subastas as s 
JOIN productos as p ON s.producto_id = p.id
WHERE s.precio_base >= 1 AND s.activa = FALSE
GROUP BY p.id;

--QUERY
SELECT p1.nombre, p1.avg < p2.avg as "La venta mas alta comenzo < 1$?"
FROM precios_menor_1 as p1 
JOIN precios_almenos_1 as p2 ON p1.id = p2.id;