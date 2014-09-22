
--------------------------------------------------------------------
---------   All general fonctions invoked by the QUICC-FOR Database
--------------------------------------------------------------------
-- By Steve Vissault

/*  Function:     temp_quicc.flt_dbh(org_db, dbh)
    Description:  Filters on dbh values
    Affects:      outlier dbh values and dbh values <= 0
    Arguments:    dbhmm and database source of the dbh (org_db)
    Returns:      integer
    Warning:      DBH need to be in mm
*/


DROP FUNCTION IF EXISTS temp_quicc.flt_dbh();
DROP FUNCTION IF EXISTS temp_quicc.flt_height();
DROP FUNCTION IF EXISTS temp_quicc.get_height_method_tree();
DROP FUNCTION IF EXISTS temp_quicc.get_plot_size();
DROP FUNCTION IF EXISTS temp_quicc.get_tree_state();
DROP FUNCTION IF EXISTS temp_quicc.get_in_subplot();
DROP FUNCTION IF EXISTS temp_quicc.get_is_planted();
DROP FUNCTION IF EXISTS temp_quicc.get_new_spcode();
DROP FUNCTION IF EXISTS temp_quicc.get_source_nb_db();

CREATE OR REPLACE FUNCTION temp_quicc.flt_dbh(org_db char(15), dbh anyelement)
RETURNS integer AS $$
DECLARE res integer;
BEGIN
	IF dbh <= 0 THEN res:= NULL;
<
    ELSIF dbh > 10000 THEN res := NULL; -- superior to 10 meters of DBH

    ELSE res := dbh;

    END IF;
RETURN res;
END;
$$
LANGUAGE plpgsql;


/*  Function:     temp_quicc.flt_height(height)
    Description:  Filters on height values - Set height of the tree on NULL when height <= 0
    Affects:      Replace values <= 0
    Arguments:    only height of the tree
    Returns:      NULL value
*/


CREATE OR REPLACE FUNCTION temp_quicc.flt_height(org_db char(15), height anyelement)
RETURNS double precision AS $$
DECLARE res double precision;
BEGIN

	IF height <= 0 THEN res:= NULL;
    END IF;

RETURN res;
END;
$$
LANGUAGE plpgsql;


/*  Function:     temp_quicc.get_height_method_tree(org_db, height_id_method, height)
    Description:  Return method used to evaluate height of trees
    Affects:      height_id_method field
    Arguments:    database source, ID of the method used (code specific to the database), height of the tree
    Returns:      char
*/


CREATE OR REPLACE FUNCTION temp_quicc.get_height_method_tree(org_db char(15), height_id_method char, height double precision)
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

/*  Function:     public.get_plot_size(PARAM)
    Description:  Transform original code to the surface of the sample plot
    Affects:      
    Arguments:    Code
    Returns:      double
*/


CREATE OR REPLACE FUNCTION temp_quicc.get_plot_size(org_db char(15), size numeric)
RETURNS double precision AS $$
DECLARE res double precision;
BEGIN
     IF org_db = 'qc_pp' THEN
        CASE    WHEN size='4' OR  size='10' THEN res := temp_quicc.get_surf(11.28); -- m2
        ELSE res := NULL;
        END CASE;
    END IF;
    IF org_db = 'qc_tp2' OR org_db = 'qc_tp3' OR org_db = 'qc_tp4' THEN
        CASE    WHEN size='1' THEN res := 'Unwork'; -- Need investigation
            WHEN size='2' THEN res := temp_quicc.get_surf(5.64);
            WHEN size='3' THEN res := temp_quicc.get_surf(3.57);
            WHEN size='4' THEN res := temp_quicc.get_surf(11.28);
            WHEN size='5' THEN res := 200;
            WHEN size='6' THEN res := temp_quicc.get_surf(5.64);
            WHEN size='7' THEN res := temp_quicc.get_surf(3.57);
            WHEN size='8' THEN res := 'Unwork';  -- Need investigation
            WHEN size='9' THEN res := temp_quicc.get_surf(11.28);
            WHEN size='11' THEN res := 'Unwork'; -- Need investigation
            WHEN size='12' THEN res := temp_quicc.get_surf(5.64); -- Need investigation
        ELSE res := NULL;
        END CASE;
    END IF;
    IF org_db = 'nb_pp_partial_cut' OR org_db = 'nb_pp_YIMO' OR org_db = 'nb_pp_regenandthin' OR org_db = 'nb_pp_cutandplant' 
        THEN
        res := size;
    END IF;
             IF org_db = 'on_pp_glsl' OR org_db='on_pp_boreal' THEN
                          res := size;
            END IF;
RETURN res;
END;
$$
LANGUAGE plpgsql;

/*  Function:     temp_quicc.get_tree_state(PARAM)
    Description:   Get if the tree is alive or dead
    Affects:      
    Arguments:    Code
    Returns:      double
*/


CREATE OR REPLACE FUNCTION temp_quicc.get_tree_state(org_db char(15), code char(5))
RETURNS boolean AS $$
DECLARE res boolean;
BEGIN
-- ALIVE
     IF org_db = 'qc_pp' OR org_db = 'qc_pet2' OR org_db = 'qc_pet3' OR org_db = 'qc_pet4' THEN
        CASE  
         WHEN code='10' 
            OR  code='12'
            OR  code='30'
            OR  code='32'
            OR  code='40'
            OR  code='42'
            OR  code='50'
            OR  code='52'
            OR  code='GV'
        THEN res := 0;
-- DEAD
        WHEN code='14' 
            OR  code='16'
            OR  code='17'
            OR  code='24'
            OR  code='25'
            OR  code='26'
            OR  code='34'
            OR  code='36'
            OR  code='44'
            OR  code='46'
            OR  code='54'
            OR  code='56'
            OR  code='48'
            OR  code='68'
            OR  code='78'
            OR  code='88'
            OR  code='98'
            OR  code='GM'
        THEN res := 1;
-- UNKNOW
        WHEN code='18' 
            OR  code='23'
            OR  code='29'
            OR  code='24'
            OR  code=NULL
        THEN res := NULL;
        END CASE;
----------------------------------------------------------------------------
       
    ELSIF org_db = 'domtar_pp' THEN
        CASE  
        WHEN code='5' 
            OR  code='7'
            OR  code='10'
            OR  code='11'
            OR  code='12'
            OR  code='30'
            OR  code='40'
            OR  code='42'
            OR  code='43'
        THEN res := 0;
-- DEAD
        WHEN code='13' 
            OR  code='14'
            OR  code='16'
            OR  code='24'
            OR  code='34'
            OR  code='26'
            OR  code='34'
        THEN res := 1;
-- UNKNOW
        WHEN code='19' 
            OR  code='25'
            OR  code='26'
            OR  code='29'
            OR  code='31'
            OR  code='32'
            OR  code='41'
            OR  code='50'
            OR  code='51'
            OR  code='52'
            OR  code='54'
            OR  code='60'
            OR  code='70'
            OR  code='71'
            OR  code='72'
            OR  code='74'
            OR  code=NULL
        THEN res := NULL;
        END CASE;

----------------------------------------------------------------------------

    ELSIF org_db = 'nb_pp_partial_cut' OR org_db = 'nb_pp_YIMO' OR org_db = 'nb_pp_regenandthin' OR org_db = 'nb_pp_cutandplant' 

    THEN
    -- If field is not NULL then tree is dead
    -- '-1' code is unreferenced in code tables

        IF code IS NOT NULL AND code != 0 THEN res:= 1; 
        ELSE res := 0;
        END IF;
    
----------------------------------------------------------------------------

    ELSIF org_db = 'us_pp' THEN
        CASE  
        WHEN code='1' 
        THEN res := 0;
-- DEAD
        WHEN code='2'  
            OR  code='3'
        THEN res := 1;
-- UNKNOW
        WHEN code='0' 
            OR  code='9'
            OR  code=NULL
        THEN res := NULL;
        END CASE;

----------------------------------------------------------------------------

    ELSEIF org_db = 'on_pp_boreal' OR org_db = 'on_pp_glsl' OR org_db = 'on_pp_pgp' THEN
        CASE  
        WHEN code='L'
        OR code='V'
        OR code='M' 
        OR code='l'
        THEN res := 0;
-- DEAD
        WHEN code='CM'
        OR  code='CN'
        OR  code='D'
        OR  code='DV'
        OR  code='X'
        OR  code='C'
        THEN res := 1;
-- UNKNOW
        WHEN code='E' 
        OR  code=NULL
        THEN res := NULL;
        
        END CASE;

    END IF;

RETURN res;
END;
$$
LANGUAGE plpgsql;


/*  Function:     temp_quicc.get_in_subplot(dbh)
    Description:  Return if the stem has been measured in subplot
    Affects:      in_subplot field
    Arguments:    dbh and source_db
    Returns:      1 or 0
    DBH NEED TO BE in MM !!!
*/


CREATE OR REPLACE FUNCTION temp_quicc.get_in_subplot(org_db char(15), dbh integer)
RETURNS boolean AS $$
DECLARE res boolean;
BEGIN

	IF org_db = 'us_pp' THEN
    	CASE 
    		WHEN dbh < 127 THEN res := 1;
    		WHEN dbh >= 127 THEN res := 0;
        END CASE;

    ELSIF org_db = 'qc_pp' OR org_db = 'qc_pet2' OR org_db = 'qc_pet3' OR org_db = 'qc_pet4' THEN res:= 0;
    
    ELSIF org_db = 'nb_pp_partial_cut' OR org_db = 'nb_pp_YIMO' OR org_db = 'nb_pp_regenandthin' OR org_db = 'nb_pp_cutandplant'  THEN res :=0;

    ELSEIF org_db = 'on_pp_boreal' OR org_db = 'on_pp_glsl' OR org_db = 'on_pp_pgp' THEN res :=NULL;

    ELSE res := NULL;
    END IF;

RETURN res;
END;
$$
LANGUAGE plpgsql;



/*  Function:     temp_quicc.get_is_planted(org_db, is_planted)
    Description:  Return if the tree has been planted
    Affects:      is_planted
    Arguments:    database source, Code is_planted (code specific to the database), height of the tree
    Returns:      boolean
*/


/*  Function:     temp_quicc.get_new_spcode(org_db, species_code)
    Description:  Return the species code specific to the QUICC-FOR database. 
    Arguments:    database source, original code of the species
    Returns:      char
*/

CREATE OR REPLACE FUNCTION temp_quicc.get_new_spcode(org_db char(15), species_code char(10))
RETURNS char(15) AS $$
DECLARE res char(15);
BEGIN

        IF org_db = 'us_pp' THEN
            EXECUTE 
            format('SELECT ref_species.id_spe FROM rdb_quicc.ref_species WHERE us_code = %L', species_code)
            INTO res;

        ELSIF org_db = 'qc_pp' OR org_db = 'qc_pet2' OR org_db = 'qc_pet3' OR org_db = 'qc_pet4' THEN 
            EXECUTE 
            format('SELECT ref_species.id_spe FROM rdb_quicc.ref_species WHERE qc_code = %L', species_code)
            INTO res;

        ELSIF org_db = 'nb_pp_partial_cut' OR org_db = 'nb_pp_YIMO' OR org_db = 'nb_pp_regenandthin' OR org_db = 'nb_pp_cutandplant'   THEN 
            EXECUTE 
            format('SELECT ref_species.id_spe FROM rdb_quicc.ref_species WHERE nb_code = %L', species_code)
            INTO res;

        ELSIF org_db = 'on_pp_boreal' OR org_db = 'on_pp_glsl' OR org_db = 'on_pp_pgp' THEN 
            EXECUTE 
            format('SELECT ref_species.id_spe FROM rdb_quicc.ref_species WHERE on_tree_code = %L', species_code)
            INTO res;

        ELSIF org_db = 'domtar_pp' THEN 
            EXECUTE 
            format('SELECT ref_species.id_spe FROM rdb_quicc.ref_species WHERE qc_code = %L', species_code)
            INTO res;

        ELSE res := NULL;

        END IF;

    RETURN res;
END;
$$ LANGUAGE plpgsql;


/*  Function:     temp_quicc.get_source_nb_db(id_plot)
    Description:  Get the traitment applied on the plot - Specific to New-Brunswick plots
    Arguments:    id of the nb plot
    Returns:      char
*/

CREATE OR REPLACE FUNCTION temp_quicc.get_source_nb_db(id_plot char(30))
RETURNS char(30) AS $$
DECLARE datasource char(30); res char(30);
BEGIN
            EXECUTE 
            format('SELECT nb_pp.psp_plots.datasource FROM nb_pp.psp_plots WHERE id_plot = %L', id_plot)
            INTO datasource;

            IF datasource = 'NBCoopYIMO' THEN res = 'nb_pp_YIMO';
            ELSIF datasource = 'NBCoopCutAndPlant' THEN res = 'nb_pp_cutandplant';
            ELSIF datasource = 'NBCoopRegenAndThin' THEN res =  'nb_pp_regenandthin';
            ELSIF datasource = 'NBCoopPartialCut' THEN res = 'nb_pp_partial_cut';
            END IF;

RETURN res;
END;
$$ LANGUAGE plpgsql;