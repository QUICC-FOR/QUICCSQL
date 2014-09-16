
/*  Function:     temp_quicc.get_height_method_tree(org_db, height_id_method, height)
    Description:  Return method used to evaluate height of trees
    Affects:      height_id_method field
    Arguments:    database source, ID of the method used (code specific to the database), height of the tree
    Returns:      char
*/

DROP FUNCTION IF EXISTS temp_quicc.get_height_method_tree();

CREATE OR REPLACE FUNCTION temp_quicc.get_height_method_tree(org_db char, height_id_method char, height double precision)
RETURNS char AS $$
DECLARE res char;
BEGIN

	IF height IS NOT NULL THEN
		IF height <= 0 THEN res:= NULL;
	    	ELSIF (org_db = 'pp_on_boreal' 
		    	OR org_db = 'pp_on_glsl'
		    	OR org_db = 'pp_on_pgp') 
		    	AND height < 12
	    	THEN res := 'E';

		    ELSIF (org_db = 'pp_on_boreal' 
		    	OR org_db = 'pp_on_glsl'
		    	OR org_db = 'pp_on_pgp') 
		    	AND height >= 12
		    THEN res := 'D';

		    ELSIF org_db = 'qc_pp'
		    	OR org_db = 'qc_pet2'
		    	OR org_db = 'qc_pet3'
		    	OR org_db = 'qc_pet4'
		    THEN res := 'D';

		    ELSIF org_db = 'pp_nb_partial_cut' 
		    	OR org_db = 'pp_nb_YIMO'
		    	OR org_db = 'pp_nb_regenandthin'
		    	OR org_db = 'pp_nb_cutandplant'
		    THEN res := 'U';

		    ELSIF org_db = 'us_pp' THEN
		      CASE    
		      	WHEN height_id_method='1' THEN res := 'A';
		      	WHEN height_id_method='2' THEN res := 'B';
		      	WHEN height_id_method='3' THEN res := 'B';
		      	WHEN height_id_method='4' THEN res := 'C';
		      END CASE;
    	END IF;

    ELSE res := NULL;

    END IF;
RETURN res;
END;
$$
LANGUAGE plpgsql;


