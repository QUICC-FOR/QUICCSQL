-------------------------------------------------------------------------------------------------------------
---------   Circle radius to surface
--------------------------------------------------------------------
-- By Steve Vissault
-- Input:  radius of the plot
-- !!! WARNING !!! Look the units
-------------------------------------------------------------------

/*  Function:     SCHEMA.NAME(PARAM)
    Description:  DESCRIPTION
    Affects:      
    Arguments:    
    Returns:      RETURN_TYPE
*/

DROP FUNCTION IF EXISTS temp_quicc.surf();

CREATE OR REPLACE FUNCTION temp_quicc.surf(rad numeric)
RETURNS double precision AS $$
BEGIN
    RETURN (rad)^2*pi();
END;
$$
LANGUAGE plpgsql;
