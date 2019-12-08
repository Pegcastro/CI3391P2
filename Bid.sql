-- Stored Procedure de bid. Considere casos borde. Concurrencia. Escalabilidad.
-- Manejo de Usuarios. INCOMPLETO falta manejo del usuario

-- Recibe subasta id, usuario id y monto
CREATE OR REPLACE FUNCTION bid(int4, int4, float8)
RETURNS boolean
LANGUAGE plpgsql 
AS $$
BEGIN 

	-- Chequea que el bid sea valido
	IF (SELECT EXISTS (SELECT s.id
		FROM Subastas as s 
		WHERE s.id = $1 AND (s.precio_actual >= $3 OR s.activa = FALSE OR s.winner_id = $2) ) ) THEN RETURN FALSE;
	END IF; 

	-- Agrega el Bid, de ser valido, a la tabla de Bids
	INSERT INTO Bids(monto, usuario_id, prev_bid)
	VALUES($3, $2, (SELECT bid_act FROM Subastas WHERE id = $1));

	-- Actualiza la tabla de Subastas
	UPDATE Subastas 
	SET precio_actual = $3, winner_id = $2
	WHERE id = $1;

	RETURN TRUE; 
END 
$$;
