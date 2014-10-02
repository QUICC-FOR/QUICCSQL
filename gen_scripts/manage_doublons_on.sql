----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
------- Manage doublons on ON schema creating tables on temp_quicc schema


-------- WARNING: Setup avg on doublons species, need to see with the ministery (perhaps multistem tree)
-- Setup update statement in order to get different ID_TREE 
-- Doublons on DBH, HEIGHT, SPE_CODE


-----------------------------------------
-----------Ontario Boreal Plots----------
-----------------------------------------

DROP MATERIALIZED VIEW IF EXISTS temp_quicc.mv_on_tree_doublons;

CREATE MATERIALIZED VIEW temp_quicc.mv_on_tree_doublons AS
SELECT row_number() OVER (PARTITION BY plot_id, tree_id, year_measured) AS rid, * FROM(
SELECT DISTINCT
	boreal_psp_treedbh_ht.plot_num,
	CAST(concat_ws('-',boreal_psp_treedbh_ht.plot_num, boreal_psp_treedbh_ht.subplot_id) AS character varying(20)) AS plot_id,
	CAST(boreal_psp_treedbh_ht.tree_id AS character varying(5)) AS tree_id,
	boreal_psp_treedbh_ht.obs_year AS year_measured,
	CAST(boreal_psp_treedbh_ht.tree_spec AS character varying(10)) AS species_code,
	boreal_psp_treedbh_ht.ht_total AS height,
	temp_quicc.conv_cm_to_mm(boreal_psp_treedbh_ht.dbh) AS dbh,
	CAST(NULL AS integer) age,
	-- NULL AS sun_access,
	-- NULL AS position_canopy,
	NULL AS height_id_method,
	NULL AS in_macroplot,
	NULL AS in_subplot,
	CAST(boreal_psp_treedbh_ht.origin  AS character varying(5)) AS is_planted, -- prob, this field is producing doublons !!
	CAST(boreal_psp_treedbh_ht.status  AS character varying(5)) AS is_dead,
	'on_pp_boreal' AS source_db
FROM on_pp.boreal_psp_treedbh_ht

-----------------------------------------
------------Ontario GLSL Plots-----------
-----------------------------------------

UNION ALL

SELECT DISTINCT 
	glsl_psp_trees_dbh_ht.plotname,
	CAST(replace(concat_ws('-',glsl_psp_trees_dbh_ht.plotname,glsl_psp_trees_dbh_ht.gpnum), ' ', '') AS character varying(20)) AS plot_id,
	CAST(glsl_psp_trees_dbh_ht.treeid AS character varying(5)) AS tree_id,
	CAST(date_part('year'::text, glsl_psp_trees_dbh_ht.msrdate::date) AS integer) AS year_measured,
	CAST(glsl_psp_trees_dbh_ht.speccode AS character varying(10)) AS species_code,
	glsl_psp_trees_dbh_ht.httot AS height,
	temp_quicc.conv_cm_to_mm(glsl_psp_trees_dbh_ht.dbh) AS dbh,
	CAST(NULL AS integer) AS age,
	-- NULL AS sun_access,
	-- NULL AS position_canopy,
	NULL AS height_id_method,
	NULL AS in_macroplot,
	NULL AS in_subplot,
	CAST(glsl_psp_trees_dbh_ht.lcr  AS character varying(5)) AS is_planted, -- prob, this field is producing doublons !!
	CAST(glsl_psp_trees_dbh_ht.treestatuscode AS character varying(5)) AS is_dead,
	'on_pp_glsl' AS source_db
FROM on_pp.glsl_psp_trees_dbh_ht

-- LIMIT 50

-----------------------------------------
-----------Ontario PGP Plots-------------
-----------------------------------------

UNION ALL

SELECT DISTINCT 
	pgp_treedbh_ht.plot_num,
	CAST(concat_ws('-',pgp_treedbh_ht.plot_num,pgp_treedbh_ht.subplot_id) AS character varying(20)) AS plot_id,
	CAST(pgp_treedbh_ht.tree_id AS character varying(5)) AS tree_id,
	pgp_treedbh_ht.obs_year AS year_measured,
	CAST(pgp_treedbh_ht.tree_spec AS character varying(10)) AS species_code,
	pgp_treedbh_ht.ht_total AS height,
	temp_quicc.conv_cm_to_mm(pgp_treedbh_ht.dbh) AS dbh,
	CAST(NULL AS integer) AS age,
	-- NULL AS sun_access,
	-- NULL AS position_canopy,
	NULL AS height_id_method,
	NULL AS in_macroplot,
	NULL AS in_subplot,
	CAST(pgp_treedbh_ht.origin  AS character varying(5)) AS is_planted,
	CAST(pgp_treedbh_ht.status AS character varying(5)) AS is_dead,
	'on_pp_pgp' AS source_db
FROM on_pp.pgp_treedbh_ht
-- LIMIT 50
) AS subquery;