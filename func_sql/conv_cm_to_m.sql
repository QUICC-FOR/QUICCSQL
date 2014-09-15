
/*  Function:     SCHEMA.NAME(PARAM)
    Description:  DESCRIPTION
    Affects:      
    Arguments:    
    Returns:      RETURN_TYPE
*/

CREATE OR REPLACE FUNCTION cm_to_m(x float) RETURNS float AS $$
        BEGIN
                RETURN (x * 0.01);
        END;
$$ LANGUAGE plpgsql;--

