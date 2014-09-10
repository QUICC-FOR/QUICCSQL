-------------------------------------------------------------------------------------------------------------
---------   Plot size conversion
--------------------------------------------------------------------
-- By Steve Vissault
-- Inputs: original code of the  database;  Size corresponding to the plot
-------------------------------------------------------------------

DROP FUNCTION IF EXISTS temp_quicc.plot_size();

CREATE OR REPLACE FUNCTION temp_quicc.plot_size(org_db char, size numeric)
RETURNS double precision AS $$
DECLARE res double precision;
BEGIN
     IF org_db = 'qc_pp' THEN
        CASE    WHEN size='4' OR  size='10' THEN res := temp_quicc.surf(11.28); -- m2
        ELSE res := NULL;
        END CASE;
    END IF;
    IF org_db = 'qc_tp2' OR org_db = 'qc_tp3' OR org_db = 'qc_tp4' THEN
        CASE    WHEN size='1' THEN res := 'Unwork'; -- Need investigation
            WHEN size='2' THEN res := temp_quicc.surf(5.64);
            WHEN size='3' THEN res := temp_quicc.surf(3.57);
            WHEN size='4' THEN res := temp_quicc.surf(11.28);
            WHEN size='5' THEN res := 200;
            WHEN size='6' THEN res := temp_quicc.surf(5.64);
            WHEN size='7' THEN res := temp_quicc.surf(3.57);
            WHEN size='8' THEN res := 'Unwork';  -- Need investigation
            WHEN size='9' THEN res := temp_quicc.surf(11.28);
            WHEN size='11' THEN res := 'Unwork'; -- Need investigation
            WHEN size='12' THEN res := temp_quicc.surf(5.64); -- Need investigation
        ELSE res := NULL;
        END CASE;
    END IF;
    IF org_db = 'nb_pp' THEN
        res := size;
    END IF;
             IF org_db = 'on_pp_glsl' OR org_db='on_pp_boreal' THEN
                          res := size;
            END IF;
RETURN res;
END;
$$
LANGUAGE plpgsql;
