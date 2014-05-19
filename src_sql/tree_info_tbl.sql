---------------------------------------
---------------------------------------
-------  Tree info table ---------
---------------------------------------
---------------------------------------

-- Extract plot level information from original database
-- By Steve Vissault

----------------------------------------------------------
-- Permanent sample plot from Quebec---
----------------------------------------------------------

SELECT DISTINCT CAST(qc_pp.pp_infogen.id_pep AS char(20))  AS plot_id,
    'qc_pp' :: char(10) AS org_db_loc,
    CAST(qc_pp.pp_tiges.no_arbre AS char(10)) AS tree_id
    FROM qc_pp.pp_infogen
LEFT JOIN qc_pp.pp_tiges ON qc_pp.pp_infogen.id_pep_mes = qc_pp.pp_tiges.id_pep_mes

UNION ALL

----------------------------------------------------------
-- Temporary sample plot from Quebec---
----------------------------------------------------------

SELECT DISTINCT CAST(qc_tp.infogen_pet2.id_pet AS char(20)) AS plot_id,
    'qc_pet2' :: char(10) AS org_db_loc,
    CAST(qc_tp.etudarbr_pet2.no_arbre AS char(10)) AS tree_id
FROM qc_tp.etudarbr_pet2
LEFT JOIN qc_tp.infogen_pet2 ON qc_tp.etudarbr_pet2.id_pet_mes = qc_tp.infogen_pet2.id_pet_mes

UNION ALL

SELECT DISTINCT CAST(qc_tp.infogen_pet3.id_pet AS char(20)) AS plot_id,
    'qc_pet3' :: char(10) AS org_db_loc,
    CAST(qc_tp.etudarbr_pet3.no_arbre AS char(10)) AS tree_id
FROM qc_tp.etudarbr_pet3
LEFT JOIN qc_tp.infogen_pet3 ON qc_tp.etudarbr_pet3.id_pet_mes = qc_tp.infogen_pet3.id_pet_mes

UNION ALL

SELECT DISTINCT CAST(qc_tp.infogen_pet4.id_pet AS char(20)) AS plot_id,
    'qc_pet4' :: char(10) AS org_db_loc,
    CAST(qc_tp.etudarbr_pet4.no_arbre AS char(10)) AS tree_id
FROM qc_tp.etudarbr_pet4
LEFT JOIN qc_tp.infogen_pet4 ON qc_tp.etudarbr_pet4.id_pet_mes = qc_tp.infogen_pet4.id_pet_mes

UNION ALL

----------------------------------------------------------
-- Permament sample plot from nb_pp ---
----------------------------------------------------------

SELECT DISTINCT CAST(nb_pp.psp_plots_yr.plot AS char(20)) AS plot_id,
    'nb_pp' :: char(10) AS org_db_loc,
    CAST(nb_pp.psp_tree_partialcut.treenum AS char(10)) AS tree_id
FROM nb_pp.psp_plots_yr
LEFT JOIN nb_pp.psp_tree_partialcut ON nb_pp.psp_plots_yr.remeasid = nb_pp.psp_tree_partialcut.remeasid

UNION ALL

SELECT DISTINCT CAST(nb_pp.psp_plots_yr.plot AS char(20)) AS plot_id,
    'nb_pp' :: char(10) AS org_db_loc,
    CAST(nb_pp.psp_tree_10thyrplant.treenum AS char(10)) AS tree_id
FROM nb_pp.psp_plots_yr
LEFT JOIN nb_pp.psp_tree_10thyrplant ON nb_pp.psp_plots_yr.remeasid = nb_pp.psp_tree_10thyrplant.remeasid

UNION ALL

SELECT DISTINCT CAST(nb_pp.psp_plots_yr.plot AS char(20)) AS plot_id,
    'nb_pp' :: char(10) AS org_db_loc,
    CAST(nb_pp.psp_tree_cutandplant.treenum AS char(10)) AS tree_id
FROM nb_pp.psp_plots_yr
LEFT JOIN nb_pp.psp_tree_cutandplant ON nb_pp.psp_plots_yr.remeasid = nb_pp.psp_tree_cutandplant.remeasid

UNION ALL

SELECT DISTINCT CAST(nb_pp.psp_plots_yr.plot AS char(20)) AS plot_id,
    'nb_pp' :: char(10) AS org_db_loc,
    CAST(nb_pp.psp_tree_regenandthin.treenum AS char(10)) AS tree_id
FROM nb_pp.psp_plots_yr
LEFT JOIN nb_pp.psp_tree_regenandthin ON nb_pp.psp_plots_yr.remeasid = nb_pp.psp_tree_regenandthin.remeasid

UNION ALL

SELECT DISTINCT CAST(nb_pp.psp_plots_yr.plot AS char(20)) AS plot_id,
    'nb_pp' :: char(10) AS org_db_loc,
    CAST(nb_pp.psp_tree_yimo.treenum AS char(10)) AS tree_id
FROM nb_pp.psp_plots_yr
LEFT JOIN nb_pp.psp_tree_yimo ON nb_pp.psp_plots_yr.remeasid = nb_pp.psp_tree_yimo.remeasid

----------------------------------------------------------
-- Permament sample plot from on_pp ---
----------------------------------------------------------