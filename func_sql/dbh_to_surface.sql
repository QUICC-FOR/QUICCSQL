CREATE OR REPLACE FUNCTION dbhtoba(i float) RETURNS float AS $$
        BEGIN
                RETURN (i/2)^2*pi()*0.000001;
        END;
$$ LANGUAGE plpgsql;