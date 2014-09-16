
/*  Function:     temp_quicc.conv_rad_to_surface(PARAM)
    Description:  Transform original code (radius size of the plot) to the surface of the sample plot
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