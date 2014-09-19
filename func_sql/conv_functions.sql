
/*  Function:     temp_quicc.conv_cm_to_m(value)
    Description:  Conversion function - cm to meters
    Affects:      
    Arguments:    Value in cm
    Returns:      FLOAT
*/

CREATE OR REPLACE FUNCTION temp_quicc.conv_cm_to_m(x float) RETURNS float AS $$
        BEGIN
                RETURN (x * 0.01);
        END;
$$ LANGUAGE plpgsql;--


/*  Function:     temp_quicc.conv_cm_to_mm(value)
    Description:  Conversion function - cm to millimeters
    Affects:      
    Arguments:    Value in cm
    Returns:      FLOAT
*/

CREATE OR REPLACE FUNCTION temp_quicc.conv_cm_to_mm(x float) RETURNS float AS $$
        BEGIN
                RETURN (x * 10);
        END;
$$ LANGUAGE plpgsql;--


/*  Function:     temp_quicc.conv_dm_to_m(value)
    Description:  Conversion function - dm to meters
    Affects:      
    Arguments:    Value in dm
    Returns:      FLOAT
*/

CREATE OR REPLACE FUNCTION temp_quicc.conv_dm_to_m(x float) RETURNS float AS $$
        BEGIN
                RETURN (x * 0.1);
        END;
$$ LANGUAGE plpgsql;


/*  Function:     temp_quicc.conv_feets_to_m(value)
    Description:  Conversion function - cm to meters
    Affects:      
    Arguments:    Value in feet
    Returns:      FLOAT
*/

CREATE OR REPLACE FUNCTION temp_quicc.conv_feet_to_m(x float) RETURNS float AS $$
        BEGIN
                RETURN (x * 0.3048);
        END;
$$ LANGUAGE plpgsql;--


/*  Function:     temp_quicc.conv_in_to_mm(value)
    Description:  Conversion function - inch to millimeters
    Affects:      
    Arguments:    Value in in
    Returns:      FLOAT
*/

CREATE OR REPLACE FUNCTION temp_quicc.conv_in_to_mm(x float) RETURNS float AS $$
        BEGIN
                RETURN (x * 25.4);
        END;
$$ LANGUAGE plpgsql;--


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
