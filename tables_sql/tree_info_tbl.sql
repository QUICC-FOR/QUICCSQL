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

SELECT DISTINCT CAST(qc_pp.pp_infogen.id_pep AS char(30))  AS plot_id,
    'qc_pp' :: char(30) AS org_db_loc,
    CAST(qc_pp.pp_tiges.no_arbre AS char(10)) AS tree_id
    FROM qc_pp.pp_infogen
LEFT JOIN qc_pp.pp_tiges ON qc_pp.pp_infogen.id_pep_mes = qc_pp.pp_tiges.id_pep_mes

UNION ALL

----------------------------------------------------------
-- Temporary sample plot from Quebec---
----------------------------------------------------------

SELECT DISTINCT CAST(qc_tp.infogen_pet2.id_pet AS char(30)) AS plot_id,
    'qc_pet2' :: char(30) AS org_db_loc,
    CAST(qc_tp.etudarbr_pet2.no_arbre AS char(10)) AS tree_id
FROM qc_tp.etudarbr_pet2
LEFT JOIN qc_tp.infogen_pet2 ON qc_tp.etudarbr_pet2.id_pet_mes = qc_tp.infogen_pet2.id_pet_mes

UNION ALL

SELECT DISTINCT CAST(qc_tp.infogen_pet3.id_pet AS char(30)) AS plot_id,
    'qc_pet3' :: char(30) AS org_db_loc,
    CAST(qc_tp.etudarbr_pet3.no_arbre AS char(10)) AS tree_id
FROM qc_tp.etudarbr_pet3
LEFT JOIN qc_tp.infogen_pet3 ON qc_tp.etudarbr_pet3.id_pet_mes = qc_tp.infogen_pet3.id_pet_mes

UNION ALL

SELECT DISTINCT CAST(qc_tp.infogen_pet4.id_pet AS char(30)) AS plot_id,
    'qc_pet4' :: char(30) AS org_db_loc,
    CAST(qc_tp.etudarbr_pet4.no_arbre AS char(10)) AS tree_id
FROM qc_tp.etudarbr_pet4
LEFT JOIN qc_tp.infogen_pet4 ON qc_tp.etudarbr_pet4.id_pet_mes = qc_tp.infogen_pet4.id_pet_mes

UNION ALL

----------------------------------------------------------
-- Permament sample plot from nb_pp ---
----------------------------------------------------------

SELECT DISTINCT CAST(nb_pp.psp_plots_yr.plot AS char(30)) AS plot_id,
    'nb_pp_partial_cut' :: char(30) AS org_db_loc,
    CAST(nb_pp.psp_tree_partialcut.treenum AS char(10)) AS tree_id
FROM nb_pp.psp_plots_yr
LEFT JOIN nb_pp.psp_tree_partialcut ON nb_pp.psp_plots_yr.remeasid = nb_pp.psp_tree_partialcut.remeasid

UNION ALL

SELECT DISTINCT CAST(nb_pp.psp_plots_yr.plot AS char(30)) AS plot_id,
    'nb_pp_cutandplant' :: char(30) AS org_db_loc,
    CAST(nb_pp.psp_tree_cutandplant.treenum AS char(10)) AS tree_id
FROM nb_pp.psp_plots_yr
LEFT JOIN nb_pp.psp_tree_cutandplant ON nb_pp.psp_plots_yr.remeasid = nb_pp.psp_tree_cutandplant.remeasid

UNION ALL

SELECT DISTINCT CAST(nb_pp.psp_plots_yr.plot AS char(30)) AS plot_id,
    'nb_pp_regenandthin' :: char(30) AS org_db_loc,
    CAST(nb_pp.psp_tree_regenandthin.treenum AS char(10)) AS tree_id
FROM nb_pp.psp_plots_yr
LEFT JOIN nb_pp.psp_tree_regenandthin ON nb_pp.psp_plots_yr.remeasid = nb_pp.psp_tree_regenandthin.remeasid

UNION ALL

SELECT DISTINCT CAST(nb_pp.psp_plots_yr.plot AS char(30)) AS plot_id,
    'nb_pp_YIMO' :: char(30) AS org_db_loc,
    CAST(nb_pp.psp_tree_yimo.treenum AS char(10)) AS tree_id
FROM nb_pp.psp_plots_yr
LEFT JOIN nb_pp.psp_tree_yimo ON nb_pp.psp_plots_yr.remeasid = nb_pp.psp_tree_yimo.remeasid

UNION ALL

----------------------------------------------------------
-- Permament sample plot from on_pp ---
----------------------------------------------------------

-----------------------------------------
-----------Ontario Boreal Plots----------
-----------------------------------------

SELECT DISTINCT
    CAST(concat_ws('-',boreal_psp_plot_info.plot_num, boreal_psp_plot_info.subplot_id) AS char(20)) AS plot_id,
    'on_pp_boreal' :: char(30) AS org_code_db,
    CAST(on_pp.boreal_psp_treedbh_ht.tree_id AS char(10)) AS tree_id
FROM
    on_pp.boreal_psp_plot_info
LEFT JOIN on_pp.boreal_psp_treedbh_ht ON on_pp.boreal_psp_plot_info.plot_num = on_pp.boreal_psp_treedbh_ht.plot_num

-----------------------------------------
------------Ontario GLSL Plots-----------
-----------------------------------------

UNION ALL

SELECT DISTINCT
    CAST(replace(concat_ws('-',glsl_psp_plotinfo.plotname,glsl_psp_plotinfo.gpnum), ' ', '') AS char(20)) AS plot_id,
    'on_pp_glsl' :: char(30) AS org_code_db,
    CAST(on_pp.glsl_psp_trees_dbh_ht.treeid AS char(10)) AS tree_id
FROM
    on_pp.glsl_psp_plotinfo
LEFT JOIN on_pp.glsl_psp_trees_dbh_ht ON on_pp.glsl_psp_plotinfo.plotname = on_pp.glsl_psp_trees_dbh_ht.plotname

-----------------------------------------
-----------Ontario PGP Plots-------------
-----------------------------------------

UNION ALL

SELECT DISTINCT
    CAST(concat_ws('-',pgp_plot_info.plot_num,pgp_plot_info.subplot_id) AS char(20)) AS plot_id,
    'on_pp_pgp' :: char(30) AS org_code_db,
    CAST(on_pp.pgp_treedbh_ht.tree_id AS char(10)) AS tree_id
FROM
    on_pp.pgp_plot_info
LEFT JOIN on_pp.pgp_treedbh_ht ON on_pp.pgp_plot_info.plot_num =on_pp.pgp_treedbh_ht.plot_num

UNION ALL

----------------------------------------------------------
-- DOMTAR ---
----------------------------------------------------------

SELECT DISTINCT
    CAST(domtar_pp.domtar_data.idpep AS char(30)) AS plot_id,
    'domtar_pp' :: char(30) AS org_code_db,
    CAST(domtar_pp.domtar_data.noarbre AS char(10)) AS tree_id
FROM
    domtar_pp.domtar_data
;

----------------------------------------------------------
-- FIA database ---
----------------------------------------------------------

SELECT DISTINCT 
    CAST(concat_ws('-',statecd,unitcd,countycd,plot,subp) AS char(20)) AS plot_id,
    'us_pp' :: char(30) AS org_code_db,
    CAST(us_pp.tree.tree  AS char(5)) AS tree_id
FROM us_pp.tree

UNION ALL

-----------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------
-- INSERT DATA INTO TREE INFO TABLE ---
--------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------------------------
DELETE FROM rdb_quicc.tree_info;
INSERT INTO rdb_quicc.tree_info(org_tree_id,org_plot_id,org_db_loc)
SELECT DISTINCT
        temp_quicc.mv_tree_info.tree_id,
        temp_quicc.mv_tree_info.plot_id
        temp_quicc.mv_tree_info.org_db_loc
FROM temp_quicc.mv_tree_info
WHERE  temp_quicc.mv_tree_info.plot_id IS NOT NULL AND
temp_quicc.mv_tree_info.tree_id IS NOT NULL;
REINDEX TABLE rdb_quicc.tree_info;

-----------------------------------------------------------------------------------------------------------------------------------------------------------