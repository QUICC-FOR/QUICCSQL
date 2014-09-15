
/*  Function:     public.conv_cm_to_mm(value)
    Description:  Conversion function - cm to millimeters
    Affects:      
    Arguments:    Value in cm
    Returns:      FLOAT
*/

CREATE OR REPLACE FUNCTION conv_cm_to_mm(x float) RETURNS float AS $$
        BEGIN
                RETURN (x * 10);
        END;
$$ LANGUAGE plpgsql;--

