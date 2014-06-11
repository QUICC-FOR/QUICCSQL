---------------------------------------
---------------------------------------
-------  Tree info table ---------
---------------------------------------
---------------------------------------

-- Extract plot level information from original database
-- By Steve Vissault, Miranda Bryant

-- DROP MATERIALIZED VIEW IF EXISTS  temp_quicc.mv_tree_info;
CREATE MATERIALIZED VIEW temp_quicc.mv_tree_info AS

----------------------------------------------------------
-- Permanent sample plot from Quebec---
----------------------------------------------------------

SELECT DISTINCT CAST(qc_pp.pp_infogen.id_pep AS char(20))  AS plot_id,
    'qc_pp' :: char(10) AS org_db_loc,
    CAST(qc_pp.pp_tiges.no_arbre AS char(3)) AS tree_id
    FROM qc_pp.pp_infogen
LEFT JOIN qc_pp.pp_tiges ON qc_pp.pp_infogen.id_pep_mes = qc_pp.pp_tiges.id_pep_mes

UNION ALL

----------------------------------------------------------
-- Temporary sample plot from Quebec---
----------------------------------------------------------

SELECT DISTINCT CAST(qc_tp.infogen_pet2.id_pet AS char(20)) AS plot_id,
    'qc_pet2' :: char(10) AS org_db_loc,
    CAST(qc_tp.etudarbr_pet2.no_arbre AS char(3)) AS tree_id
FROM qc_tp.etudarbr_pet2
LEFT JOIN qc_tp.infogen_pet2 ON qc_tp.etudarbr_pet2.id_pet_mes = qc_tp.infogen_pet2.id_pet_mes

UNION ALL

SELECT DISTINCT CAST(qc_tp.infogen_pet3.id_pet AS char(20)) AS plot_id,
    'qc_pet3' :: char(10) AS org_db_loc,
    CAST(qc_tp.etudarbr_pet3.no_arbre AS char(3)) AS tree_id
FROM qc_tp.etudarbr_pet3
LEFT JOIN qc_tp.infogen_pet3 ON qc_tp.etudarbr_pet3.id_pet_mes = qc_tp.infogen_pet3.id_pet_mes

UNION ALL

SELECT DISTINCT CAST(qc_tp.infogen_pet4.id_pet AS char(20)) AS plot_id,
    'qc_pet4' :: char(10) AS org_db_loc,
    CAST(qc_tp.etudarbr_pet4.no_arbre AS char(3)) AS tree_id
FROM qc_tp.etudarbr_pet4
LEFT JOIN qc_tp.infogen_pet4 ON qc_tp.etudarbr_pet4.id_pet_mes = qc_tp.infogen_pet4.id_pet_mes

UNION ALL

----------------------------------------------------------
-- Permament sample plot from nb_pp ---
----------------------------------------------------------

SELECT DISTINCT CAST(nb_pp.psp_plots_yr.plot AS char(20)) AS plot_id,
    'nb_pp' :: char(10) AS org_db_loc,
    CAST(nb_pp.psp_tree_partialcut.treenum AS char(3)) AS tree_id
FROM nb_pp.psp_plots_yr
LEFT JOIN nb_pp.psp_tree_partialcut ON nb_pp.psp_plots_yr.remeasid = nb_pp.psp_tree_partialcut.remeasid

UNION ALL

SELECT DISTINCT CAST(nb_pp.psp_plots_yr.plot AS char(20)) AS plot_id,
    'nb_pp' :: char(10) AS org_db_loc,
    CAST(nb_pp.psp_tree_10thyrplant.treenum AS char(3)) AS tree_id
FROM nb_pp.psp_plots_yr
LEFT JOIN nb_pp.psp_tree_10thyrplant ON nb_pp.psp_plots_yr.remeasid = nb_pp.psp_tree_10thyrplant.remeasid

UNION ALL

SELECT DISTINCT CAST(nb_pp.psp_plots_yr.plot AS char(20)) AS plot_id,
    'nb_pp' :: char(10) AS org_db_loc,
    CAST(nb_pp.psp_tree_cutandplant.treenum AS char(3)) AS tree_id
FROM nb_pp.psp_plots_yr
LEFT JOIN nb_pp.psp_tree_cutandplant ON nb_pp.psp_plots_yr.remeasid = nb_pp.psp_tree_cutandplant.remeasid

UNION ALL

SELECT DISTINCT CAST(nb_pp.psp_plots_yr.plot AS char(20)) AS plot_id,
    'nb_pp' :: char(10) AS org_db_loc,
    CAST(nb_pp.psp_tree_regenandthin.treenum AS char(3)) AS tree_id
FROM nb_pp.psp_plots_yr
LEFT JOIN nb_pp.psp_tree_regenandthin ON nb_pp.psp_plots_yr.remeasid = nb_pp.psp_tree_regenandthin.remeasid

UNION ALL

SELECT DISTINCT CAST(nb_pp.psp_plots_yr.plot AS char(20)) AS plot_id,
    'nb_pp' :: char(10) AS org_db_loc,
    CAST(nb_pp.psp_tree_yimo.treenum AS char(3)) AS tree_id
FROM nb_pp.psp_plots_yr
LEFT JOIN nb_pp.psp_tree_yimo ON nb_pp.psp_plots_yr.remeasid = nb_pp.psp_tree_yimo.remeasid

----------------------------------------------------------
-- Permament sample plot from on_pp ---
----------------------------------------------------------
UNION ALL

SELECT DISTINCT
    CAST(on_pp.boreal_psp_plot_info.plot_num AS char(20)) AS plot_id,
    'on_pp_boreal' :: char(20) AS org_code_db,
    CAST(on_pp.boreal_psp_treedbh_ht.tree_id AS char(3)) AS tree_id
FROM
    on_pp.boreal_psp_plot_info
LEFT JOIN on_pp.boreal_psp_treedbh_ht ON on_pp.boreal_psp_plot_info.plot_num = on_pp.boreal_psp_treedbh_ht.plot_num


---- glsl_on

UNION ALL

SELECT DISTINCT
    CAST(on_pp.glsl_psp_plotinfo.plotname AS char(20)) AS plot_id,
    'on_pp_glsl' :: char(20) AS org_code_db,
    CAST(on_pp.glsl_psp_trees_dbh_ht.treeid AS char(3)) AS tree_id
FROM
    on_pp.glsl_psp_plotinfo
LEFT JOIN on_pp.glsl_psp_trees_dbh_ht ON on_pp.glsl_psp_plotinfo.plotname = on_pp.glsl_psp_trees_dbh_ht.plotname

UNION ALL

SELECT DISTINCT
    CAST(on_pp.pgp_plot_info.plot_num AS char(20)) AS plot_id,
    'on_pp_pgp' :: char(20) AS org_code_db,
    CAST(on_pp.pgp_treedbh_ht.tree_id AS char(3)) AS tree_id
FROM
    on_pp.pgp_plot_info
LEFT JOIN on_pp.pgp_treedbh_ht ON on_pp.pgp_plot_info.plot_num =on_pp.pgp_treedbh_ht.plot_num

UNION ALL

----------------------------------------------------------
-- DOMTAR ---
----------------------------------------------------------

SELECT DISTINCT
    CAST(domtar_pp.domtar_data.idpep AS char(20)) AS plot_id,
    'domtar_pp' :: char(20) AS org_code_db,
    CAST(domtar_pp.domtar_data.noarbre AS char(3)) AS tree_id
FROM
    domtar_pp.domtar_data
;

-----------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------
-- INSERT DATA INTO TREE INFO TABLE ---
--------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------------------------


DELETE FROM rdb_quicc.tree_info;
INSERT INTO rdb_quicc.tree_info
    SELECT DISTINCT
        rdb_quicc.plot_info.plot_id,
        temp_quicc.mv_tree_info.tree_id,
        temp_quicc.mv_tree_info.org_db_loc,
        temp_quicc.mv_tree_info.plot_id
FROM temp_quicc.mv_tree_info
INNER JOIN rdb_quicc.plot_info ON temp_quicc.mv_tree_info.plot_id = rdb_quicc.plot_info.org_db_id
AND temp_quicc.mv_tree_info.org_db_loc = rdb_quicc.plot_info.org_db_loc
WHERE  temp_quicc.mv_tree_info.plot_id IS NOT NULL AND
temp_quicc.mv_tree_info.tree_id IS NOT NULL;

---- plot_id integer NOT NULL,
---- tree_id integer NOT NULL,
---- org_db_location character(20),
---- org_db_id integer,
---- CONSTRAINT tree_info_tbl_pk PRIMARY KEY (plot_id, tree_id)

-----------------------------------------------------------------------------------------------------------------------------------------------------------