---------------------------------------
---------------------------------------
-------  Tree info table ---------
---------------------------------------
---------------------------------------

-- Extract plot level information from original database
-- By Steve Vissault, Miranda Bryant

CREATE OR REPLACE VIEW temp_quicc.mv_tree_info AS

----------------------------------------------------------
-- Permanent sample plot from Quebec---
----------------------------------------------------------

SELECT DISTINCT CAST(qc_pp.pp_infogen.id_pep AS character varying(30))  AS plot_id,
    'qc_pp' :: character varying(30) AS org_db_loc,
    CAST(qc_pp.pp_tiges.essence AS character varying(10)) AS species_code,
    CAST(qc_pp.pp_tiges.no_arbre AS character varying(10)) AS tree_id

    FROM qc_pp.pp_infogen
LEFT JOIN qc_pp.pp_tiges ON qc_pp.pp_infogen.id_pep_mes = qc_pp.pp_tiges.id_pep_mes

UNION ALL

----------------------------------------------------------
-- Temporary sample plot from Quebec---
----------------------------------------------------------

SELECT DISTINCT CAST(qc_tp.infogen_pet2.id_pet AS character varying(30)) AS plot_id,
    'qc_pet2' :: character varying(30) AS org_db_loc,
    CAST(qc_tp.etudarbr_pet2.essence AS character varying(10)) AS species_code,
    CAST(qc_tp.etudarbr_pet2.no_arbre AS character varying(10)) AS tree_id
FROM qc_tp.etudarbr_pet2
LEFT JOIN qc_tp.infogen_pet2 ON qc_tp.etudarbr_pet2.id_pet_mes = qc_tp.infogen_pet2.id_pet_mes

UNION ALL

SELECT DISTINCT CAST(qc_tp.infogen_pet3.id_pet AS character varying(30)) AS plot_id,
    'qc_pet3' :: character varying(30) AS org_db_loc,
    CAST(qc_tp.etudarbr_pet3.essence AS character varying(10)) AS species_code,
    CAST(qc_tp.etudarbr_pet3.no_arbre AS character varying(10)) AS tree_id
FROM qc_tp.etudarbr_pet3
LEFT JOIN qc_tp.infogen_pet3 ON qc_tp.etudarbr_pet3.id_pet_mes = qc_tp.infogen_pet3.id_pet_mes

UNION ALL

SELECT DISTINCT CAST(qc_tp.infogen_pet4.id_pet AS character varying(30)) AS plot_id,
    'qc_pet4' :: character varying(30) AS org_db_loc,
    CAST(qc_tp.etudarbr_pet4.essence AS character varying(10)) AS species_code,
    CAST(qc_tp.etudarbr_pet4.no_arbre AS character varying(10)) AS tree_id
FROM qc_tp.etudarbr_pet4
LEFT JOIN qc_tp.infogen_pet4 ON qc_tp.etudarbr_pet4.id_pet_mes = qc_tp.infogen_pet4.id_pet_mes

UNION ALL

----------------------------------------------------------
-- Permament sample plot from nb_pp ---
----------------------------------------------------------

SELECT DISTINCT CAST(nb_pp.psp_plots_yr.plot AS character varying(30)) AS plot_id,
    'nb_pp_partial_cut' :: character varying(30) AS org_db_loc,
    CAST(nb_pp.psp_tree_partialcut.species AS character varying(10)) AS species_code,
    CAST(nb_pp.psp_tree_partialcut.treenum AS character varying(10)) AS tree_id
FROM nb_pp.psp_plots_yr
LEFT JOIN nb_pp.psp_tree_partialcut ON nb_pp.psp_plots_yr.remeasid = nb_pp.psp_tree_partialcut.remeasid

UNION ALL

SELECT DISTINCT CAST(nb_pp.psp_plots_yr.plot AS character varying(30)) AS plot_id,
    'nb_pp_cutandplant' :: character varying(30) AS org_db_loc,
    CAST(nb_pp.psp_tree_cutandplant.species AS character varying(10)) AS species_code,
    CAST(nb_pp.psp_tree_cutandplant.treenum AS character varying(10)) AS tree_id
FROM nb_pp.psp_plots_yr
LEFT JOIN nb_pp.psp_tree_cutandplant ON nb_pp.psp_plots_yr.remeasid = nb_pp.psp_tree_cutandplant.remeasid

UNION ALL

SELECT DISTINCT CAST(nb_pp.psp_plots_yr.plot AS character varying(30)) AS plot_id,
    'nb_pp_regenandthin' :: character varying(30) AS org_db_loc,
    CAST(nb_pp.psp_tree_regenandthin.species AS character varying(10)) AS species_code,
    CAST(nb_pp.psp_tree_regenandthin.treenum AS character varying(10)) AS tree_id
FROM nb_pp.psp_plots_yr
LEFT JOIN nb_pp.psp_tree_regenandthin ON nb_pp.psp_plots_yr.remeasid = nb_pp.psp_tree_regenandthin.remeasid

UNION ALL

SELECT DISTINCT CAST(nb_pp.psp_plots_yr.plot AS character varying(30)) AS plot_id,
    'nb_pp_YIMO' :: character varying(30) AS org_db_loc,
    CAST(nb_pp.psp_tree_yimo.species AS character varying(10)) AS species_code,
    CAST(nb_pp.psp_tree_yimo.treenum AS character varying(10)) AS tree_id
FROM nb_pp.psp_plots_yr
LEFT JOIN nb_pp.psp_tree_yimo ON nb_pp.psp_plots_yr.remeasid = nb_pp.psp_tree_yimo.remeasid

UNION ALL

-----------------------------------------
-----------ALL Ontario DBs----------
-----------------------------------------

SELECT DISTINCT
    CAST(mv_on_tree_doublons.plot_id AS character varying(30)) AS plot_id,
    mv_on_tree_doublons.source_db AS org_db_loc,
    CAST(mv_on_tree_doublons.species_code AS character varying(10)) AS tree_id,
    CAST(concat_ws('-',mv_on_tree_doublons.rid,mv_on_tree_doublons.tree_id :: char(1)) AS character varying(10)) AS tree_id
FROM
    temp_quicc.mv_on_tree_doublons

UNION ALL

----------------------------------------------------------
-- DOMTAR ---
----------------------------------------------------------

SELECT DISTINCT
    CAST(domtar_pp.domtar_data.idpep AS character varying(30)) AS plot_id,
    'domtar_pp' :: character varying(30) AS org_db_loc,
    CAST(domtar_pp.domtar_data.essence AS character varying(10)) AS species_code,
    CAST(domtar_pp.domtar_data.noarbre AS character varying(10)) AS tree_id
FROM
    domtar_pp.domtar_data

UNION ALL

----------------------------------------------------------
-- FIA database ---
----------------------------------------------------------

SELECT DISTINCT 
    CAST(concat_ws('-',statecd,unitcd,countycd,plot,subp) AS character varying(20)) AS plot_id,
    'us_pp' :: character varying(30) AS org_db_loc,
    CAST(us_pp.tree.spcd AS character varying(10)) AS species_code,
    CAST(us_pp.tree.tree  AS character varying(5)) AS tree_id
FROM us_pp.tree
;
-----------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------
-- INSERT DATA INTO TREE INFO TABLE ---
--------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------------------------
DELETE FROM rdb_quicc.tree_info;
INSERT INTO rdb_quicc.tree_info(org_tree_id,org_plot_id,org_db_loc)
SELECT
        temp_quicc.mv_tree_info.tree_id,
        temp_quicc.mv_tree_info.plot_id,
        temp_quicc.mv_tree_info.org_db_loc
FROM temp_quicc.mv_tree_info
WHERE  temp_quicc.mv_tree_info.plot_id IS NOT NULL AND
temp_quicc.mv_tree_info.tree_id IS NOT NULL;
REINDEX TABLE rdb_quicc.tree_info;

-----------------------------------------------------------------------------------------------------------------------------------------------------------