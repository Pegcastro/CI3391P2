-- UndoLastBid Function: Este será utilizado por un administrador en caso
-- de que el bid más alto en una subasta sea fraudulento.

-- Recibe subasta_id
CREATE OR REPLACE FUNCTION UndoLastBid(int4)
RETURNS boolean
LANGUAGE plpgsql 
AS $$
DECLARE elim INT4;
BEGIN 

	elim:= (SELECT bid_act FROM Subastas WHERE id = $1);

	UPDATE Subastas
	SET bid_act = (SELECT prev_bid FROM Bids WHERE id = bid_act)
	WHERE id = $1;

	UPDATE Subastas
	SET precio_actual = (SELECT monto FROM Bids WHERE id = bid_act), winner_id = (SELECT usuario_id FROM Bids WHERE id = bid_act)
	WHERE id = $1;

	DELETE FROM Bids
	WHERE id = elim; 

	RETURN TRUE; 
END 
$$;