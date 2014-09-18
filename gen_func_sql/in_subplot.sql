
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

	IF org_db = 'us_pp' THEN
	CASE 
		WHEN dbh < 127 THEN res := 1;
		WHEN dbh >= 127 THEN res := 0;
    END CASE;

    ELSIF org_db = 'qc_pp' OR org_db = 'qc_pet2' OR org_db = 'qc_pet3' OR org_db = 'qc_pet4' THEN res:= 0;
    
    ELSIF org_db = 'nb_pp_partial_cut' OR org_db = 'nb_pp_cutandplant' OR org_db = 'nb_pp_regenandthin'  THEN res :=0;

    ELSEIF org_db = 'on_pp_boreal' OR org_db = 'on_pp_glsl' OR org_db = 'on_pp_pgp' THEN res :=NULL;

    ELSE res := NULL;
    END IF;

RETURN res;
END;
$$
LANGUAGE plpgsql;


