CREATE OR REPLACE FUNCTION dbh_to_ba(i integer) RETURNS float AS $$
        BEGIN
                RETURN (i/2)^2*pi()*0.000001;
        END;
$$ LANGUAGE plpgsql;