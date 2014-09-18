
/*  Function:     temp_quicc.get_tree_state(PARAM)
    Description:   Get if the tree is alive or dead
    Affects:      
    Arguments:    Code
    Returns:      double
*/

DROP FUNCTION IF EXISTS temp_quicc.get_plot_size();

CREATE OR REPLACE FUNCTION temp_quicc.get_plot_size(org_db char, code char)
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

    ELSIF org_db = 'nb_pp_partial_cut' OR org_db = 'nb_pp_cutandplant' OR org_db = 'nb_pp_regenandthin'  

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
