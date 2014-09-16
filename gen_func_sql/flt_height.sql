
/*  Function:     temp_quicc.flt_height(height)
    Description:  Filters on height values - Set height of the tree on NULL when height <= 0
    Affects:      Replace values <= 0
    Arguments:    only height of the tree
    Returns:      NULL value
*/

DROP FUNCTION IF EXISTS temp_quicc.flt_height();

CREATE OR REPLACE FUNCTION temp_quicc.flt_height(org_db char, dbh integer)
RETURNS integer AS $$
DECLARE res integer;
BEGIN

	IF height <= 0 THEN res:= NULL;
    END IF;

RETURN res;
END;
$$
LANGUAGE plpgsql;


