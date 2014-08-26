-- Extract Tree level information from coarse data
-- By Steve Vissault and Miranda Bryant

---------------------------------------
---------------------------------------
--------- Tree level -------------
---------------------------------------
---------------------------------------


---------------------------------------
-- Permanent sample plot from Quebec ---
---------------------------------------

DROP MATERIALIZED VIEW IF EXISTS temp_quicc.mv_tree;

CREATE MATERIALIZED VIEW temp_quicc.mv_tree AS

SELECT CAST(qc_pp.pp_infogen.id_pep AS char(10))  AS plot_id,
	CAST(qc_pp.pp_tiges.no_arbre AS char(5)) AS tree_id,
	CAST(date_part('year'::text, qc_pp.pp_infogen.date_sond::date) AS integer) AS year_measured,
	CAST(qc_pp.pp_tiges.essence AS char(10)) AS species_code,
	CAST(qc_pp.pp_etudarbr.hauteur AS integer) AS height,
	CAST(qc_pp.pp_tiges.dhpmm AS integer) AS dbh,
	CAST(qc_pp.pp_etudarbr.age AS char(5))  AS age,
	CAST(qc_pp.pp_etudarbr.ensoleil AS char(5)) AS sun_access,
	CAST(qc_pp.pp_etudarbr.etage AS char(5)) AS position_canopy,
	CAST(qc_pp.pp_etudarbr.source_age AS char(5)) AS age_id_method,
	NULL AS height_id_method,
	NULL AS is_sapling,
	CAST(NULL AS char(5)) AS is_planted,
	CAST(qc_pp.pp_tiges.etat AS char(5)) AS is_dead,
	'qc_pp' AS source_db
FROM qc_pp.pp_infogen
LEFT OUTER JOIN qc_pp.pp_tiges ON qc_pp.pp_infogen.id_pep_mes = qc_pp.pp_tiges.id_pep_mes
LEFT OUTER JOIN qc_pp.pp_etudarbr ON qc_pp.pp_etudarbr.id_pep_mes = qc_pp.pp_tiges.id_pep_mes AND qc_pp.pp_etudarbr.no_arbre = qc_pp.pp_tiges.no_arbre AND qc_pp.pp_etudarbr.essence = qc_pp.pp_tiges.essence

-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200

UNION ALL

---------------------------------------
-- Temporary sample plot from Quebec ---
---------------------------------------

SELECT CAST(qc_tp.infogen_pet2.id_pet AS char(10)) AS plot_id,
	CAST(qc_tp.etudarbr_pet2.no_arbre AS char(5)) AS tree_id,
	CAST(date_part('year'::text, infogen_pet2.date_sond::date) AS integer) AS year_measured,
	CAST(qc_tp.etudarbr_pet2.essence AS char(10)) AS species_code,
	CAST(qc_tp.etudarbr_pet2.hauteur AS integer) AS height,
	CAST(qc_tp.etudarbr_pet2.dhpmm AS integer) AS dbh,
	CAST(qc_tp.etudarbr_pet2.age AS char(5)) AS age,
	NULL :: char(5) AS sun_access,
	CAST(qc_tp.etudarbr_pet2.etage AS char(5)) AS position_canopy,
	CAST(qc_tp.etudarbr_pet2.source_age AS char(5)) AS age_id_method,
	NULL AS height_id_method,
	NULL AS is_sapling,
    	CAST(NULL AS char(5)) AS is_planted,
    	NULL :: char(5) AS is_dead,
    	'qc_pet2' AS source_db
FROM qc_tp.etudarbr_pet2 LEFT OUTER JOIN qc_tp.infogen_pet2 ON qc_tp.etudarbr_pet2.id_pet_mes = qc_tp.infogen_pet2.id_pet_mes

-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200


UNION ALL

SELECT CAST(qc_tp.infogen_pet3.id_pet AS char(10)) AS plot_id,
	CAST(qc_tp.etudarbr_pet3.no_arbre AS char(5)) AS tree_id,
	CAST(date_part('year'::text, infogen_pet3.date_sond::date) AS integer) AS year_measured,
	CAST(qc_tp.etudarbr_pet3.essence AS char(10)) AS species_code,
	CAST(qc_tp.etudarbr_pet3.hauteur AS integer) AS height,
	CAST(qc_tp.etudarbr_pet3.dhpmm AS integer) AS dbh,
	CAST(qc_tp.etudarbr_pet3.age AS char(5)),
	NULL :: char(5) AS sun_access,
	CAST(qc_tp.etudarbr_pet3.etage AS char(5)) AS position_canopy,
	CAST(qc_tp.etudarbr_pet3.source_age AS char(5)) AS age_id_method,
	NULL AS height_id_method,
	NULL AS is_sapling,
    	CAST(NULL AS char(5)) AS is_planted,
    	NULL :: char(5) AS is_dead,
    	'qc_pet3' AS source_db 
FROM qc_tp.etudarbr_pet3 LEFT OUTER JOIN qc_tp.infogen_pet3 ON qc_tp.etudarbr_pet3.id_pet_mes = qc_tp.infogen_pet3.id_pet_mes

UNION ALL

SELECT CAST(qc_tp.infogen_pet4.id_pet AS char(10)) AS plot_id,
	CAST(qc_tp.etudarbr_pet4.no_arbre AS char(5)) AS tree_id,
	CAST(date_part('year'::text, infogen_pet4.date_sond::date) AS integer) AS year_measured,
	CAST(qc_tp.etudarbr_pet4.essence AS char(10)) AS species_code,
	CAST(qc_tp.etudarbr_pet4.hauteur AS integer) AS height,
	CAST(qc_tp.etudarbr_pet4.dhpmm AS integer) AS dbh,
	CAST(qc_tp.etudarbr_pet4.age AS char(5)) AS age,
	NULL :: char(5) AS sun_access,
	CAST(qc_tp.etudarbr_pet4.etage AS char(5)) AS position_canopy,
	CAST(qc_tp.etudarbr_pet4.source_age AS char(5)) AS age_id_method,
	NULL AS height_id_method,
	NULL AS is_sapling,
    	CAST(NULL AS char(5)) AS is_planted,
    	NULL :: char(5) AS is_dead,
    	'qc_pet4' AS source_db
FROM qc_tp.etudarbr_pet4 LEFT OUTER JOIN qc_tp.infogen_pet4 ON qc_tp.etudarbr_pet4.id_pet_mes = qc_tp.infogen_pet4.id_pet_mes


-----------------------------------------------
-- Permanent sample plot from New-Brunswick ---
-----------------------------------------------

UNION ALL

SELECT CAST(nb_pp.psp_plots_yr.plot AS char(10)) AS plot_id,
	CAST(nb_pp.psp_tree_partialcut.treenum AS char(5)) AS tree_id,
	CAST(nb_pp.psp_plots_yr.year  AS integer) AS year_measured,
	CAST(nb_pp.psp_tree_partialcut.species AS char(10)) AS species_code,
	nb_pp.psp_tree_partialcut.totalHt AS height,
	nb_pp.psp_tree_partialcut.dbh AS dbh,
	NULL AS age,
	NULL AS sun_access,
	NULL AS position_canopy,
	NULL AS age_id_method,
	NULL AS height_id_method,
	NULL AS is_sapling,
    	CAST(NULL AS char(5)) AS is_planted,
    	nb_pp.psp_tree_partialcut.cause AS is_dead,
    	'pp_nb_partial_cut' AS source_db
FROM nb_pp.psp_plots_yr INNER JOIN nb_pp.psp_tree_partialcut ON nb_pp.psp_plots_yr.remeasid = nb_pp.psp_tree_partialcut.remeasid
-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200

UNION ALL

SELECT CAST(nb_pp.psp_plots_yr.plot AS char(10)) AS plot_id,
	CAST(nb_pp.psp_tree_yimo.treenum AS char(5)) AS tree_id,
	CAST(nb_pp.psp_plots_yr.year  AS integer) AS year_measured,
	CAST(nb_pp.psp_tree_yimo.species AS char(10)) AS species_code,
	NULL AS height,
	nb_pp.psp_tree_yimo.dbh AS dbh,
	nb_pp.psp_tree_yimo.agecl AS age,
	NULL AS sun_access,
	NULL AS position_canopy,
	NULL AS age_id_method,
	NULL AS height_id_method,
	NULL AS is_sapling,
    	CAST(NULL AS char(5)) AS is_planted,
    	nb_pp.psp_tree_yimo.cause AS is_dead,
    	'pp_nb_YIMO' AS source_db
FROM nb_pp.psp_plots_yr INNER JOIN nb_pp.psp_tree_yimo ON nb_pp.psp_plots_yr.remeasid = nb_pp.psp_tree_yimo.remeasid

-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200

UNION ALL

SELECT CAST(nb_pp.psp_plots_yr.plot AS char(10)) AS plot_id,
	CAST(nb_pp.psp_tree_regenandthin.treenum AS char(5)) AS tree_id,
	CAST(nb_pp.psp_plots_yr.year  AS integer) AS year_measured,
	CAST(nb_pp.psp_tree_regenandthin.species AS char(10)) AS species_code,
	nb_pp.psp_tree_regenandthin.hgt AS height,
	nb_pp.psp_tree_regenandthin.dbh AS dbh,
	NULL AS age,
	NULL AS sun_access,
	NULL AS position_canopy,
	NULL AS age_id_method,
	NULL AS height_id_method,
	NULL AS is_sapling,
	CAST(nb_pp.psp_tree_regenandthin.origin AS char(5)) AS is_planted,
	nb_pp.psp_tree_regenandthin.cause AS is_dead,
    	'pp_nb_regenandthin' AS source_db
FROM nb_pp.psp_plots_yr INNER JOIN nb_pp.psp_tree_regenandthin ON nb_pp.psp_plots_yr.remeasid = nb_pp.psp_tree_regenandthin.remeasid

-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200

UNION ALL

SELECT CAST(nb_pp.psp_plots_yr.plot AS char(10)) AS plot_id,
	CAST(nb_pp.psp_tree_cutandplant.treenum AS char(5)) AS tree_id,
	CAST(nb_pp.psp_plots_yr.year  AS integer) AS year_measured,
	CAST(nb_pp.psp_tree_cutandplant.species AS char(10)) AS species_code,
	nb_pp.psp_tree_cutandplant.hgt AS height,
	nb_pp.psp_tree_cutandplant.dbh AS dbh,
	NULL AS age,
	NULL AS sun_access,
	NULL AS position_canopy,
	NULL AS age_id_method,
	NULL AS height_id_method,
	NULL AS is_sapling,
	CAST(nb_pp.psp_tree_cutandplant.origin AS char(5)) AS is_planted,
	nb_pp.psp_tree_cutandplant.cause AS is_dead,
	'pp_nb_cutandplant' AS source_db
FROM nb_pp.psp_plots_yr INNER JOIN nb_pp.psp_tree_cutandplant ON nb_pp.psp_plots_yr.remeasid = nb_pp.psp_tree_cutandplant.remeasid
-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200

UNION ALL

-----------------------------------------------
-- Permenent sample plot from FIA ---
-----------------------------------------------
-----------------------------------------
------------Plots FIA Database-----------
-----------------------------------------
SELECT us_pp.tree.plot,
	us_pp.tree.invyr,
	us_pp.tree.tree,
	us_pp.tree.spcd,
	us_pp.tree.actualht,
	us_pp.tree.dia,
	us_pp.tree.statecd,
	CAST (us_pp.tree.mortyr AS boolean) AS survival
FROM us_pp.tree
-- Uncomment the line below for smallest query (100 records)
--LIMIT 100

UNION ALL

-----------------------------------------------
-- Permenent sample plot from Ontario---
-----------------------------------------------

-----------------------------------------
-----------Ontario Boreal Plots----------
-----------------------------------------

SELECT boreal_psp_treedbh_ht.plot_num,
    boreal_psp_treedbh_ht.obs_year,
    boreal_psp_treedbh_ht.tree_id,
    boreal_psp_treedbh_ht.tree_spec,
    boreal_psp_treedbh_ht.dbh_ht,
    boreal_psp_treedbh_ht.dbh,
    boreal_psp_treedbh_ht.status
FROM on_pp.boreal_psp_treedbh_ht
-- Uncomment the line below for smallest query (100 records)
--LIMIT 10

-----------------------------------------
------------Ontario GLSL Plots-----------
-----------------------------------------

UNION ALL

SELECT glsl_psp_trees_dbh_ht.plotname,
   CAST(date_part('year'::text, glsl_psp_trees_dbh_ht.msrdate::date) AS integer) AS year_measured,
   glsl_psp_trees_dbh_ht.treeid,
   glsl_psp_trees_dbh_ht.speccode,
   glsl_psp_trees_dbh_ht.htofdbh,
   glsl_psp_trees_dbh_ht.dbh,
   glsl_psp_trees_dbh_ht.treestatuscode
FROM on_pp.glsl_psp_trees_dbh_ht
-- Uncomment the line below for smallest query (100 records)
--LIMIT 10

-----------------------------------------
-----------Ontario PGP Plots-------------
-----------------------------------------

UNION ALL

SELECT pgp_treedbh_ht.plot_num,
   pgp_treedbh_ht.obs_year,
   pgp_treedbh_ht.tree_id,
   pgp_treedbh_ht.tree_spec,
   pgp_treedbh_ht.dbh_ht,
   pgp_treedbh_ht.dbh,
   pgp_treedbh_ht.status
FROM on_pp.pgp_treedbh_ht
-- Uncomment the line below for smallest query (100 records)
--LIMIT 10
;
-----------------------------------------