CREATE OR REPLACE FUNCTION dm_to_m(x float) RETURNS float AS $$
        BEGIN
                RETURN (i * 0.1);
        END;
$$ LANGUAGE plpgsql;