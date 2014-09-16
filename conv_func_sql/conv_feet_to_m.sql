
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
