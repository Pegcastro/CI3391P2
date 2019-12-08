Stored Procedure de bid. Considere casos borde. Concurrencia. Escalabilidad.
Manejo de Usuarios. INCOMPLETO falta manejo del usuario

--recibe subasta id, usuario id y monto
CREATE OR REPLACE FUNCTION bid(int4, int4, float8)
RETURNS boolean
LANGUAGE plpgsql 
AS $$
BEGIN 
	IF (SELECT s.precio_actual 
		FROM subastas as s 
		WHERE s.precio_actual >= $3 OR s.activa = FALSE THEN 
		RETURN FALSE;
	END IF; 

	UPDATE subastas 
	SET monto_actual = $3
	WHERE id = $1;

	RETURN TRUE; 
END 
$$;



En promedio, ¿Cuáles productos tienen precios de venta más alto? ¿Los que
empiezan con un precio base menor de $1 ó los que empiezan con un precio base de
por lo menos $1? (no puedo comparar precios de productos diferentes) NO PROBADO

CREATE VIEW precios_menor_1 AS
SELECT AVG(precio_actual), p.id, p.nombre
FROM subastas as s JOIN productos as p ON s.producto_id = p.id
WHERE s.precio_base < 1 AND s.activa = FALSE
GROUP BY p.id;

CREATE VIEW precios_almenos_1 AS
SELECT AVG(precio_actual), p.id, p.nombre
FROM subastas as s JOIN productos as p ON s.producto_id = p.id
WHERE s.precio_base >= 1 AND s.activa = FALSE
GROUP BY p.id;

--QUERY
SELECT p1.nombre, p1.avg < p2.avg as "La venta mas alta comenzo < 1$?"
FROM precios_menor_1 as p1 JOIN precios_almenos_1 as p2 ON p1.id = p2.id;


¿Cuántas subastas se realizan por mes por categoría? (tomar en cuenta todas las
categorías) PROBADO

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