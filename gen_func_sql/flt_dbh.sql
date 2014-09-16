
/*  Function:     temp_quicc.flt_dbh(org_db, dbh)
    Description:  Filters on dbh values
    Affects:      outlier dbh values and dbh values <= 0
    Arguments:    dbhmm and database source of the dbh (org_db) - DBH NEED TO BE in mm
    Returns:      integer
*/

DROP FUNCTION IF EXISTS temp_quicc.flt_dbh();

CREATE OR REPLACE FUNCTION temp_quicc.flt_dbh(org_db char, dbh integer)
RETURNS integer AS $$
DECLARE res integer;
BEGIN
	IF dbh <= 0 THEN res:= NULL;

    ELSIF  = 9999 THEN res := NULL;

    ELSE res := dbh;

    END IF;
RETURN res;
END;
$$
LANGUAGE plpgsql;


