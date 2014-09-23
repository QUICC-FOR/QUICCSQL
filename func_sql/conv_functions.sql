------------------------------------------------------------------------
---------   All conversions fonctions invoked by the QUICC-FOR Database
------------------------------------------------------------------------
-- By Steve Vissault

-- DROP functions

DROP FUNCTION IF EXISTS temp_quicc.conv_cm_to_m();
DROP FUNCTION IF EXISTS temp_quicc.conv_cm_to_mm();
DROP FUNCTION IF EXISTS temp_quicc.conv_dm_to_m();
DROP FUNCTION IF EXISTS temp_quicc.conv_feet_to_m();
DROP FUNCTION IF EXISTS temp_quicc.conv_in_to_mm();
DROP FUNCTION IF EXISTS temp_quicc.get_surf();

/*  Function:     temp_quicc.conv_cm_to_m(value)
    Description:  Conversion function - cm to meters
    Affects:      NA
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
    Affects:      NA
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
    Affects:      NA
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
    Affects:      NA
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
    Affects:      NA
    Arguments:    Value in inch
    Returns:      FLOAT
*/

CREATE OR REPLACE FUNCTION temp_quicc.conv_in_to_mm(x float) RETURNS double precision AS $$
        BEGIN
                RETURN x * 25.4;
        END;
$$ LANGUAGE plpgsql;--


/*  Function:     temp_quicc.get_surf(PARAM)
    Description:  Transform original code (radius size of the plot) to the surface of the sample plot
    Affects:      NA
    Arguments:    Radius of the sample plot
    Returns:      double
*/

CREATE OR REPLACE FUNCTION temp_quicc.get_surf(rad numeric)
RETURNS double precision AS $$
BEGIN
    RETURN (rad)^2*pi();
END;
$$
LANGUAGE plpgsql;
