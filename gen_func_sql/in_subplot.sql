
/*  Function:     temp_quicc.in_subplot(dbh)
    Description:  Return if the stem has been measured in subplot
    Affects:      in_subplot field
    Arguments:    dbh and source_db
    Returns:      1 or 0
    DBH NEED TO BE in MM !!!
*/

DROP FUNCTION IF EXISTS temp_quicc.in_subplot();

CREATE OR REPLACE FUNCTION temp_quicc.in_subplot(org_db char, dbh numeric)
RETURNS boolean AS $$
DECLARE res boolean;
BEGIN

	IF org_db = 'us_pp' AND dbh < 127 THEN res := 1;
	ELSIF org_db = 'us_pp' AND dbh >= 127 THEN res := 0;
    ELSE res := NULL;
    END IF;

RETURN res;
END;
$$
LANGUAGE plpgsql;


