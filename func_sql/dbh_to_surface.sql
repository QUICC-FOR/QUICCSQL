/*  Function:     SCHEMA.NAME(PARAM)
    Description:  DESCRIPTION
    Affects:      
    Arguments:    
    Returns:      RETURN_TYPE
*/

CREATE OR REPLACE FUNCTION dbh_to_ba(x integer) RETURNS float AS $$
        BEGIN
                RETURN (x/2)^2*pi()*0.000001;
        END;
$$ LANGUAGE plpgsql;