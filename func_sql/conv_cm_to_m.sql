
/*  Function:     public.conv_cm_to_m(value)
    Description:  Conversion function - cm to meters
    Affects:      
    Arguments:    Value in cm
    Returns:      FLOAT
*/

CREATE OR REPLACE FUNCTION conv_cm_to_m(x float) RETURNS float AS $$
        BEGIN
                RETURN (x * 0.01);
        END;
$$ LANGUAGE plpgsql;--

