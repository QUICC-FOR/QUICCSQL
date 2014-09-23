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

CREATE OR REPLACE VIEW temp_quicc.mv_tree AS

SELECT DISTINCT CAST(qc_pp.pp_infogen.id_pep AS char(20))  AS plot_id,
	CAST(qc_pp.pp_tiges.no_arbre AS char(5)) AS tree_id,
	CAST(date_part('year'::text, qc_pp.pp_infogen.date_sond::date) AS integer) AS year_measured,
	CAST(qc_pp.pp_tiges.essence AS char(10)) AS species_code,
	temp_quicc.conv_dm_to_m(CAST(qc_pp.pp_etudarbr.hauteur AS integer)) AS height, 
	CAST(qc_pp.pp_tiges.dhpmm AS integer) AS dbh,
	CAST(qc_pp.pp_etudarbr.age AS integer)  AS age,
	-- CAST(qc_pp.pp_etudarbr.ensoleil AS char(5)) AS sun_access,
	-- CAST(qc_pp.pp_etudarbr.etage AS char(5)) AS position_canopy,
	NULL AS height_id_method,
	NULL AS in_macroplot,
	NULL AS in_subplot,
	CAST(NULL AS char(5)) AS is_planted,
	CAST(qc_pp.pp_tiges.etat AS char(5)) AS is_dead,
	'qc_pp' AS source_db
FROM qc_pp.pp_infogen
LEFT OUTER JOIN qc_pp.pp_tiges ON qc_pp.pp_infogen.id_pep_mes = qc_pp.pp_tiges.id_pep_mes
LEFT OUTER JOIN qc_pp.pp_etudarbr ON qc_pp.pp_etudarbr.id_pep_mes = qc_pp.pp_tiges.id_pep_mes AND qc_pp.pp_etudarbr.no_arbre = qc_pp.pp_tiges.no_arbre AND qc_pp.pp_etudarbr.essence = qc_pp.pp_tiges.essence
-- LIMIT 50

UNION ALL

---------------------------------------
-- Temporary sample plot from Quebec ---
---------------------------------------

SELECT DISTINCT CAST(qc_tp.infogen_pet2.id_pet AS char(20)) AS plot_id,
	CAST(qc_tp.etudarbr_pet2.no_arbre AS char(5)) AS tree_id,
	CAST(date_part('year'::text, infogen_pet2.date_sond::date) AS integer) AS year_measured,
	CAST(qc_tp.etudarbr_pet2.essence AS char(10)) AS species_code,
	temp_quicc.conv_dm_to_m(CAST(qc_tp.etudarbr_pet2.hauteur AS integer)) AS height,
	CAST(qc_tp.etudarbr_pet2.dhpmm AS integer) AS dbh,
	CAST(qc_tp.etudarbr_pet2.age AS integer) AS age,
	-- NULL :: char(5) AS sun_access,
	-- CAST(qc_tp.etudarbr_pet2.etage AS char(5)) AS position_canopy,
	NULL AS height_id_method,
	NULL AS in_macroplot,
	NULL AS in_subplot,
	CAST(NULL AS char(5)) AS is_planted,
	NULL :: char(5) AS is_dead,
	'qc_pet2' AS source_db
FROM qc_tp.etudarbr_pet2 LEFT OUTER JOIN qc_tp.infogen_pet2 ON qc_tp.etudarbr_pet2.id_pet_mes = qc_tp.infogen_pet2.id_pet_mes
-- LIMIT 50


UNION ALL

SELECT DISTINCT CAST(qc_tp.infogen_pet3.id_pet AS char(20)) AS plot_id,
	CAST(qc_tp.etudarbr_pet3.no_arbre AS char(5)) AS tree_id,
	CAST(date_part('year'::text, infogen_pet3.date_sond::date) AS integer) AS year_measured,
	CAST(qc_tp.etudarbr_pet3.essence AS char(10)) AS species_code,
	temp_quicc.conv_dm_to_m(CAST(qc_tp.etudarbr_pet3.hauteur AS integer)) AS height,
	CAST(qc_tp.etudarbr_pet3.dhpmm AS integer) AS dbh,
	CAST(qc_tp.etudarbr_pet3.age AS integer),
	-- NULL :: char(5) AS sun_access,
	-- CAST(qc_tp.etudarbr_pet3.etage AS char(5)) AS position_canopy,
	NULL AS height_id_method,
	NULL AS in_macroplot,
	NULL AS in_subplot,
	CAST(NULL AS char(5)) AS is_planted,
	NULL :: char(5) AS is_dead,
	'qc_pet3' AS source_db 
FROM qc_tp.etudarbr_pet3 LEFT OUTER JOIN qc_tp.infogen_pet3 ON qc_tp.etudarbr_pet3.id_pet_mes = qc_tp.infogen_pet3.id_pet_mes
-- LIMIT 50

UNION ALL

SELECT DISTINCT CAST(qc_tp.infogen_pet4.id_pet AS char(20)) AS plot_id,
	CAST(qc_tp.etudarbr_pet4.no_arbre AS char(5)) AS tree_id,
	CAST(date_part('year'::text, infogen_pet4.date_sond::date) AS integer) AS year_measured,
	CAST(qc_tp.etudarbr_pet4.essence AS char(10)) AS species_code,
	temp_quicc.conv_dm_to_m(CAST(qc_tp.etudarbr_pet4.hauteur AS integer)) AS height,
	CAST(qc_tp.etudarbr_pet4.dhpmm AS integer) AS dbh,
	CAST(qc_tp.etudarbr_pet4.age AS integer) AS age,
	-- NULL :: char(5) AS sun_access,
	-- CAST(qc_tp.etudarbr_pet4.etage AS char(5)) AS position_canopy,
	NULL AS height_id_method,
	NULL AS in_macroplot,
	NULL AS in_subplot,
	CAST(NULL AS char(5)) AS is_planted,
	NULL :: char(5) AS is_dead,
	'qc_pet4' AS source_db
FROM qc_tp.etudarbr_pet4 LEFT OUTER JOIN qc_tp.infogen_pet4 ON qc_tp.etudarbr_pet4.id_pet_mes = qc_tp.infogen_pet4.id_pet_mes
-- LIMIT 50

-----------------------------------------------
-- Permanent sample plot from New-Brunswick ---
-----------------------------------------------

UNION ALL

SELECT DISTINCT CAST(nb_pp.psp_plots_yr.plot AS char(20)) AS plot_id,
	CAST(nb_pp.psp_tree_partialcut.treenum AS char(5)) AS tree_id,
	CAST(nb_pp.psp_plots_yr.year  AS integer) AS year_measured,
	CAST(nb_pp.psp_tree_partialcut.species AS char(10)) AS species_code,
	temp_quicc.conv_cm_to_m(nb_pp.psp_tree_partialcut.totalHt) AS height,
	nb_pp.psp_tree_partialcut.dbh AS dbh, -- cm
	CAST(NULL AS integer)AS age,
	-- NULL AS sun_access,
	-- NULL AS position_canopy,
	NULL AS height_id_method,
	NULL AS in_macroplot,
	NULL AS in_subplot,
	CAST(NULL AS char(5)) AS is_planted,
	nb_pp.psp_tree_partialcut.cause AS is_dead,
	'nb_pp_partial_cut' AS source_db
FROM nb_pp.psp_plots_yr 
LEFT OUTER JOIN nb_pp.psp_tree_partialcut ON nb_pp.psp_plots_yr.remeasid = nb_pp.psp_tree_partialcut.remeasid
-- LIMIT 50

UNION ALL

SELECT DISTINCT CAST(nb_pp.psp_plots_yr.plot AS char(20)) AS plot_id,
	CAST(nb_pp.psp_tree_yimo.treenum AS char(5)) AS tree_id,
	CAST(nb_pp.psp_plots_yr.year  AS integer) AS year_measured,
	CAST(nb_pp.psp_tree_yimo.species AS char(10)) AS species_code,
	CAST(NULL AS double precision) AS height,
	nb_pp.psp_tree_yimo.dbh AS dbh,
	CAST(NULL AS integer) AS age,
	-- NULL AS sun_access,
	-- NULL AS position_canopy,
	NULL AS height_id_method,
	NULL AS in_macroplot,
	NULL AS in_subplot,
	CAST(NULL AS char(5)) AS is_planted,
	nb_pp.psp_tree_yimo.cause AS is_dead,
	'nb_pp_YIMO' AS source_db
FROM nb_pp.psp_plots_yr 
LEFT OUTER JOIN nb_pp.psp_tree_yimo ON nb_pp.psp_plots_yr.remeasid = nb_pp.psp_tree_yimo.remeasid

-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200

UNION ALL

SELECT DISTINCT CAST(nb_pp.psp_plots_yr.plot AS char(20)) AS plot_id,
	CAST(nb_pp.psp_tree_regenandthin.treenum AS char(5)) AS tree_id,
	CAST(nb_pp.psp_plots_yr.year  AS integer) AS year_measured,
	CAST(nb_pp.psp_tree_regenandthin.species AS char(10)) AS species_code,
	temp_quicc.conv_cm_to_m(nb_pp.psp_tree_regenandthin.hgt) AS height,
	nb_pp.psp_tree_regenandthin.dbh AS dbh,
	CAST(NULL AS integer) AS age,
	-- NULL AS sun_access,
	-- NULL AS position_canopy,
	NULL AS height_id_method,
	NULL AS in_macroplot,
	NULL AS in_subplot,
	CAST(nb_pp.psp_tree_regenandthin.origin AS char(5)) AS is_planted,
	nb_pp.psp_tree_regenandthin.cause AS is_dead,
		'nb_pp_regenandthin' AS source_db
FROM nb_pp.psp_plots_yr 
LEFT OUTER JOIN nb_pp.psp_tree_regenandthin ON nb_pp.psp_plots_yr.remeasid = nb_pp.psp_tree_regenandthin.remeasid
-- LIMIT 50

UNION ALL

SELECT DISTINCT CAST(nb_pp.psp_plots_yr.plot AS char(20)) AS plot_id,
	CAST(nb_pp.psp_tree_cutandplant.treenum AS char(5)) AS tree_id,
	CAST(nb_pp.psp_plots_yr.year  AS integer) AS year_measured,
	CAST(nb_pp.psp_tree_cutandplant.species AS char(10)) AS species_code,
	temp_quicc.conv_cm_to_m(nb_pp.psp_tree_cutandplant.hgt) AS height,
	nb_pp.psp_tree_cutandplant.dbh AS dbh,
	CAST(NULL AS integer) AS age,
	-- NULL AS sun_access,
	-- NULL AS position_canopy,
	NULL AS height_id_method,
	NULL AS in_macroplot,
	NULL AS in_subplot,
	CAST(nb_pp.psp_tree_cutandplant.origin AS char(5)) AS is_planted,
	nb_pp.psp_tree_cutandplant.cause AS is_dead,
	'nb_pp_cutandplant' AS source_db
FROM nb_pp.psp_plots_yr 
LEFT OUTER JOIN nb_pp.psp_tree_cutandplant ON nb_pp.psp_plots_yr.remeasid = nb_pp.psp_tree_cutandplant.remeasid
-- LIMIT 50

UNION ALL

-----------------------------------------------
-- Permenent sample plot from FIA ---
-----------------------------------------------
-----------------------------------------
------------Plots FIA Database-----------
-----------------------------------------
SELECT DISTINCT CAST(concat_ws('-',statecd,unitcd,countycd,plot,subp) AS char(20))   AS plot_id ,
	CAST(us_pp.tree.tree  AS char(5)) AS tree_id,
	us_pp.tree.invyr AS year_measured,
	CAST(us_pp.tree.spcd AS char(10)) AS species_code,
	temp_quicc.conv_feet_to_m(us_pp.tree.ht) AS height, ---- WARNING FEETS !!!!!!!!!!!!!!!!
	temp_quicc.conv_in_to_mm(us_pp.tree.dia) AS dbh, --- WARNING: INCHES !!!!!!!!!!!!!!!!
	CAST(us_pp.tree.totage AS integer) AS age, 
	-- CAST(us_pp.tree.clightcd AS char(5)) AS sun_access,
	-- CAST(us_pp.tree.cposcd AS char(5)) AS position_canopy, -- Core sample (p.123)
	CAST(us_pp.tree.htcd AS char(5)) AS height_id_method, -- Details (p.111)
	NULL AS in_macroplot,
	NULL AS in_subplot,
	NULL AS is_planted,
	CAST(us_pp.tree.statuscd AS char(5)) AS is_dead,
	'us_pp' AS source_db
FROM us_pp.tree
-- LIMIT 50

UNION ALL

-----------------------------------------------
-- Permenent sample plot from Ontario---
-----------------------------------------------

-----------------------------------------
-----------Ontario Boreal Plots----------
-----------------------------------------

SELECT DISTINCT CAST(concat_ws('-',boreal_psp_treedbh_ht.plot_num, boreal_psp_treedbh_ht.subplot_id) AS char(20)) AS plot_id,
		CAST(boreal_psp_treedbh_ht.tree_id AS char(5)) AS tree_id,
		boreal_psp_treedbh_ht.obs_year AS year_measured,
		CAST(boreal_psp_treedbh_ht.tree_spec AS char(10)) AS species_code,
		boreal_psp_treedbh_ht.ht_total AS height,
		temp_quicc.conv_cm_to_mm(boreal_psp_treedbh_ht.dbh) AS dbh,
		CAST(NULL AS integer) age,
	-- NULL AS sun_access,
	-- NULL AS position_canopy,
	NULL AS height_id_method,
	NULL AS in_macroplot,
	NULL AS in_subplot,
	NULL AS is_planted, --CAST(boreal_psp_treedbh_ht.origin  AS char(5)) AS is_planted, -- prob, this field is producing doublons !!
	CAST(boreal_psp_treedbh_ht.status  AS char(5)) AS is_dead,
	'on_pp_boreal' AS source_db
FROM on_pp.boreal_psp_treedbh_ht
-- LIMIT 50

-----------------------------------------
------------Ontario GLSL Plots-----------
-----------------------------------------

UNION ALL

SELECT DISTINCT CAST(replace(concat_ws('-',glsl_psp_trees_dbh_ht.plotname,glsl_psp_trees_dbh_ht.gpnum), ' ', '') AS char(20)) AS plot_id,
	CAST(glsl_psp_trees_dbh_ht.treeid AS char(5)) AS tree_id,
	CAST(date_part('year'::text, glsl_psp_trees_dbh_ht.msrdate::date) AS integer) AS year_measured,
	CAST(glsl_psp_trees_dbh_ht.speccode AS char(10)) AS species_code,
	glsl_psp_trees_dbh_ht.httot AS height,
	temp_quicc.conv_cm_to_mm(glsl_psp_trees_dbh_ht.dbh) AS dbh,
	CAST(NULL AS integer) AS age,
	-- NULL AS sun_access,
	-- NULL AS position_canopy,
	NULL AS height_id_method,
	NULL AS in_macroplot,
	NULL AS in_subplot,
	NULL AS is_planted, -- CAST(glsl_psp_trees_dbh_ht.lcr  AS char(5)) AS is_planted, -- prob, this field is producing doublons !!
	CAST(glsl_psp_trees_dbh_ht.treestatuscode AS char(5)) AS is_dead,
	'on_pp_glsl' AS source_db
FROM on_pp.glsl_psp_trees_dbh_ht
-- LIMIT 50

-----------------------------------------
-----------Ontario PGP Plots-------------
-----------------------------------------

UNION ALL

SELECT DISTINCT CAST(concat_ws('-',pgp_treedbh_ht.plot_num,pgp_treedbh_ht.subplot_id) AS char(20)) AS plot_id,
	CAST(pgp_treedbh_ht.tree_id AS char(5)) AS tree_id,
	pgp_treedbh_ht.obs_year AS year_measured,
	CAST(pgp_treedbh_ht.tree_spec AS char(10)) AS species_code,
	pgp_treedbh_ht.ht_total AS height,
	temp_quicc.conv_cm_to_mm(pgp_treedbh_ht.dbh) AS dbh,
	CAST(NULL AS integer) AS age,
	-- NULL AS sun_access,
	-- NULL AS position_canopy,
	NULL AS height_id_method,
	NULL AS in_macroplot,
	NULL AS in_subplot,
	CAST(pgp_treedbh_ht.origin  AS char(5)) AS is_planted,
	CAST(pgp_treedbh_ht.status AS char(5)) AS is_dead,
	'on_pp_pgp' AS source_db
FROM on_pp.pgp_treedbh_ht
-- LIMIT 50

UNION ALL

-----------------------------------------------
-- Permenent sample plot from DOMTAR---
-----------------------------------------------

SELECT DISTINCT CAST(domtar_pp.domtar_data.idpep AS char(10))  AS plot_id,
	CAST(domtar_pp.domtar_data.noarbre AS char(5)) AS tree_id,
	CAST(domtar_pp.domtar_data.annee_sondage AS integer) AS year_measured,
	CAST(domtar_pp.domtar_data.essence AS char(10)) AS species_code,
	CAST(NULL AS double precision) AS height,
	CAST(domtar_pp.domtar_data.dhpmm AS integer) AS dbh,
	CAST(NULL AS integer) AS age,
	-- CAST(domtar_pp.domtar_data.ensoleillement AS char(5)) AS sun_access,
	-- CAST(domtar_pp.domtar_data.etage AS char(5)) AS position_canopy,
	NULL AS height_id_method,
	NULL AS in_macroplot,
	NULL AS in_subplot,
	CAST(NULL AS char(5)) AS is_planted,
	CAST(domtar_pp.domtar_data.etat AS char(5)) AS is_dead,
	'domtar_pp' AS source_db
FROM domtar_pp.domtar_data
-- LIMIT 50;
-----------------------------------------


-----------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------
-- INSERT DATA INTO PLOT INFO TABLE ---
--------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------------------------
DELETE FROM rdb_quicc.tree;
INSERT INTO rdb_quicc.tree
SELECT DISTINCT
		rdb_quicc.plot_info.plot_id,
		rdb_quicc.tree_info.tree_id,
		temp_quicc.mv_tree.year_measured,
		temp_quicc.get_new_spcode(temp_quicc.mv_tree.source_db, temp_quicc.mv_tree.species_code),
		temp_quicc.flt_height(temp_quicc.mv_tree.source_db, temp_quicc.mv_tree.height),
		temp_quicc.flt_dbh(temp_quicc.mv_tree.source_db, CAST(round(temp_quicc.mv_tree.dbh) AS integer)),
		temp_quicc.mv_tree.age AS age,
		0 AS sun_access,
		0 AS position_canopy,
		temp_quicc.get_height_method_tree(temp_quicc.mv_tree.source_db, temp_quicc.mv_tree.height_id_method, temp_quicc.flt_height(temp_quicc.mv_tree.source_db, temp_quicc.mv_tree.height)),
		temp_quicc.get_in_subplot(temp_quicc.mv_tree.source_db, temp_quicc.flt_dbh(temp_quicc.mv_tree.source_db, CAST(round(temp_quicc.mv_tree.dbh) AS integer))),
		false AS in_macroplot,
		false AS is_planted,
		temp_quicc.get_tree_state(temp_quicc.mv_tree.source_db, temp_quicc.mv_tree.is_dead),
		rdb_quicc.plot_info.plot_id,
		temp_quicc.mv_tree.year_measured,
		rdb_quicc.tree_info.plot_id,
		rdb_quicc.tree_info.tree_id,
		temp_quicc.get_new_spcode_height_method_tree(temp_quicc.mv_tree.source_db, temp_quicc.mv_tree.height_id_method, temp_quicc.flt_height(temp_quicc.mv_tree.source_db, temp_quicc.mv_tree.height)),
		temp_quicc.get_new_spcode(temp_quicc.mv_tree.source_db, temp_quicc.mv_tree.species_code)
	FROM temp_quicc.mv_tree
	RIGHT OUTER JOIN rdb_quicc.plot_info ON temp_quicc.mv_tree.plot_id = rdb_quicc.plot_info.org_db_id
		AND temp_quicc.mv_tree.source_db = rdb_quicc.plot_info.org_db_loc 
	RIGHT OUTER JOIN rdb_quicc.tree_info ON temp_quicc.mv_tree.tree_id = rdb_quicc.tree_info.tree_id
		AND temp_quicc.mv_tree.source_db = rdb_quicc.tree_info.org_db_loc AND temp_quicc.mv_tree.plot_id = rdb_quicc.tree_info.org_db_id;
	WHERE temp_quicc.get_new_spcode(temp_quicc.mv_tree.source_db, temp_quicc.mv_tree.species_code) IS NOT NULL;
REINDEX TABLE rdb_quicc.tree;