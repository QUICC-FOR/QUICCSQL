------------------------------------------------------------------------
---------   All conversions fonctions invoked by the QUICC-FOR Database
------------------------------------------------------------------------
-- By Steve Vissault

-- DROP functions

DROP FUNCTION IF EXISTS temp_quicc.conv_cm_to_m(x double precision) CASCADE;
DROP FUNCTION IF EXISTS temp_quicc.conv_cm_to_mm(x double precision) CASCADE;
DROP FUNCTION IF EXISTS temp_quicc.conv_dm_to_m(x double precision) CASCADE;
DROP FUNCTION IF EXISTS temp_quicc.conv_feet_to_m(x double precision) CASCADE;
DROP FUNCTION IF EXISTS temp_quicc.conv_in_to_mm(x double precision) CASCADE;
DROP FUNCTION IF EXISTS temp_quicc.get_surf(metric double precision, type_metric character) CASCADE;

/*  Function:     temp_quicc.conv_cm_to_m(value)
    Description:  Conversion function - cm to meters
    Affects:      NA
    Arguments:    Value in cm
    Returns:      double precision
*/

CREATE OR REPLACE FUNCTION temp_quicc.conv_cm_to_m(x double precision) RETURNS double precision AS $$
        BEGIN
                RETURN (x * 0.01);
        END;
$$ LANGUAGE plpgsql;--


/*  Function:     temp_quicc.conv_cm_to_mm(value)
    Description:  Conversion function - cm to millimeters
    Affects:      NA
    Arguments:    Value in cm
    Returns:      double precision
*/

CREATE OR REPLACE FUNCTION temp_quicc.conv_cm_to_mm(x double precision) RETURNS double precision AS $$
        BEGIN
                RETURN (x * 10);
        END;
$$ LANGUAGE plpgsql;--


/*  Function:     temp_quicc.conv_dm_to_m(value)
    Description:  Conversion function - dm to meters
    Affects:      NA
    Arguments:    Value in dm
    Returns:      double precision
*/

CREATE OR REPLACE FUNCTION temp_quicc.conv_dm_to_m(x double precision) RETURNS double precision AS $$
        BEGIN
                RETURN (x * 0.1);
        END;
$$ LANGUAGE plpgsql;


/*  Function:     temp_quicc.conv_feets_to_m(value)
    Description:  Conversion function - cm to meters
    Affects:      NA
    Arguments:    Value in feet
    Returns:      double precision
*/

CREATE OR REPLACE FUNCTION temp_quicc.conv_feet_to_m(x double precision) RETURNS double precision AS $$
        BEGIN
                RETURN (x * 0.3048);
        END;
$$ LANGUAGE plpgsql;--


/*  Function:     temp_quicc.conv_in_to_mm(value)
    Description:  Conversion function - inch to millimeters
    Affects:      NA
    Arguments:    Value in inch
    Returns:      double precision
*/

CREATE OR REPLACE FUNCTION temp_quicc.conv_in_to_mm(x double precision) RETURNS double precision AS $$
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

CREATE OR REPLACE FUNCTION temp_quicc.get_surf(metric double precision, type_metric character)
RETURNS double precision AS $$
BEGIN
CASE
WHEN type_metric = 'radius' THEN
    RETURN (metric)^2*pi();
WHEN type_metric = 'diameter' THEN
    RETURN (metric/2)^2*pi();
END CASE;
END;
$$
LANGUAGE plpgsql;
