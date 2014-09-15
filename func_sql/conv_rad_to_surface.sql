-------------------------------------------------------------------------------------------------------------
---------   Get the surface of the same plot based on the radius
--------------------------------------------------------------------
-- By Steve Vissault

/*  Function:     public.conv_rad_to_surface(PARAM)
    Description:  Transform original code to the surface of the sample plot
    Affects:      
    Arguments:    Radius of the sample plot
    Returns:      double
*/
DROP FUNCTION IF EXISTS temp_quicc.surf();

CREATE OR REPLACE FUNCTION temp_quicc.surf(rad numeric)
RETURNS double precision AS $$
BEGIN
    RETURN (rad)^2*pi();
END;
$$
LANGUAGE plpgsql;
