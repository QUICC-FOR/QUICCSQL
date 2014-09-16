
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