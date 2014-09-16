
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

