CREATE OR REPLACE FUNCTION cm_to_m(x float) RETURNS float AS $$
        BEGIN
                RETURN (i * 0.01);
        END;
$$ LANGUAGE plpgsql;