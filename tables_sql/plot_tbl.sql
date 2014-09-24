---------------------------------------
---------------------------------------
-------------- Plot table -----------
---------------------------------------
---------------------------------------

-- Extract plot level information from original database
-- By Steve Vissault

---------------------------------------
-- Permanent sample plot from Quebec---
---------------------------------------

CREATE OR REPLACE VIEW temp_quicc.mv_plot AS

SELECT DISTINCT
    CAST(qc_pp.pp_infogen.id_pep AS char(30)) AS plot_id,
    'qc_pp' :: char(30) AS org_code_db,
    CAST(date_part('year'::text, qc_pp.pp_infogen.date_sond::date) AS integer) AS year_measured,
    CAST(NULL AS numeric) AS macroplot_size,
    temp_quicc.get_plot_size('qc_pp' :: char(15),CAST(qc_pp.pp_infogen.dimension AS char(10))) AS plot_size,
    CAST(NULL AS numeric) AS microplot_size,
    0 :: boolean AS is_templot,
    0 :: boolean AS has_macroplot
FROM
    qc_pp.pp_infogen
INNER JOIN qc_pp.pp_localis on qc_pp.pp_infogen.id_pep_mes = qc_pp.pp_localis.id_pep_mes
-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200


UNION ALL

---------------------------------------
-- Temporary sample plot from Quebec---
---------------------------------------

SELECT DISTINCT
    CAST(qc_tp.infogen_pet2.id_pet AS char(30)) AS plot_id,
    'qc_tp2' :: char(30) AS org_code_db,
    CAST(date_part('year'::text, qc_tp.infogen_pet2.date_sond::date) AS integer) AS year_measured,
    CAST(NULL AS numeric) AS macroplot_size,
    temp_quicc.get_plot_size('qc_tp2' :: char(15),CAST(qc_tp.infogen_pet2.dimension AS char(10))) AS plot_size,
    CAST(NULL AS numeric) AS microplot_size,
    1 :: boolean AS is_templot,
    0 :: boolean AS has_macroplot
FROM
    qc_tp.infogen_pet2
INNER JOIN qc_tp.localis_pet2 ON qc_tp.infogen_pet2.id_pet_mes = qc_tp.localis_pet2.id_pet_mes
-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200

UNION ALL

SELECT DISTINCT
    CAST(qc_tp.infogen_pet3.id_pet AS char(30)) AS plot_id,
    'qc_tp3' :: char(30) AS org_code_db,
    CAST(date_part('year'::text, qc_tp.infogen_pet3.date_sond::date) AS integer) AS year_measured,
    CAST(NULL AS numeric) AS macroplot_size,
    temp_quicc.get_plot_size('qc_tp3' :: char(15),CAST(qc_tp.infogen_pet3.dimension AS char(10))) AS plot_size,
    CAST(NULL AS numeric) AS microplot_size,
    1 :: boolean AS is_templot,
    0 :: boolean AS has_macroplot
FROM
    qc_tp.infogen_pet3
INNER JOIN qc_tp.localis_pet3 ON qc_tp.infogen_pet3.id_pet_mes = qc_tp.localis_pet3.id_pet_mes
-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200

UNION ALL

SELECT DISTINCT
    CAST(qc_tp.infogen_pet4.id_pet AS char(30)) AS plot_id,
    'qc_tp4' :: char(30) AS org_code_db,
    CAST(date_part('year'::text, qc_tp.infogen_pet4.date_sond::date) AS integer) AS year_measured,
    CAST(NULL AS numeric) AS macroplot_size,
    temp_quicc.get_plot_size('qc_tp4' :: char(15),CAST(qc_tp.infogen_pet4.dimension AS char(10))) AS plot_size,
    CAST(NULL AS numeric) AS microplot_size,
    1 :: boolean AS is_templot,
    0 :: boolean AS has_macroplot
FROM
    qc_tp.infogen_pet4
INNER JOIN qc_tp.localis_pet4 ON qc_tp.infogen_pet4.id_pet_mes = qc_tp.localis_pet4.id_pet_mes

-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200

----------------------------------------------
-- Permenent sample plot from New-Brunswick --
----------------------------------------------
UNION ALL

SELECT DISTINCT
    CAST(nb_pp.psp_plots.plot AS char(30)) AS plot_id,
    temp_quicc.get_source_nb_db(nb_pp.psp_plots.plot) AS org_code_db,
    CAST(nb_pp.psp_plots_yr.year AS integer) AS year_measured,
    CAST(NULL AS numeric) AS macroplot_size,
    CAST(nb_pp.psp_plots.plotsize AS numeric) AS plot_size,
    CAST(NULL AS numeric) AS microplot_size,
    0 :: boolean AS is_templot,
    0 :: boolean AS has_macroplot
FROM
    nb_pp.psp_plots
LEFT JOIN  nb_pp.psp_plots_yr ON nb_pp.psp_plots.plot = nb_pp.psp_plots_yr.plot

-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200

----------------------------------------------
-- Permanent sample plot from Ontario --
----------------------------------------------

-----------------------------------------
-----------Ontario Boreal Plots----------
-----------------------------------------

UNION ALL

SELECT DISTINCT
    CAST(concat_ws('-',boreal_psp_treedbh_ht.plot_num, boreal_psp_treedbh_ht.subplot_id) AS char(20)) AS plot_id,
    'on_pp_boreal' :: char(30) AS org_code_db,
    on_pp.boreal_psp_treedbh_ht.obs_year :: integer AS year_measured,
    CAST(NULL AS numeric) AS macroplot_size,
    CAST(temp_quicc.get_surf(boreal_psp_plot_sizes.radius) AS numeric) AS plot_size,
    CAST(NULL AS numeric) AS microplot_size,
    0 :: boolean AS is_templot,
    1 :: boolean AS has_macroplot
FROM
    on_pp.boreal_psp_treedbh_ht
LEFT JOIN on_pp.boreal_psp_plot_sizes ON concat_ws('-',boreal_psp_treedbh_ht.plot_num, boreal_psp_treedbh_ht.subplot_id) = concat_ws('-',boreal_psp_plot_sizes.plot_num, boreal_psp_plot_sizes.subplot_id)
AND boreal_psp_treedbh_ht.msr_num = on_pp.boreal_psp_plot_sizes.msr_num

-----------------------------------------)
------------Ontario GLSL Plots-----------
-----------------------------------------

UNION ALL

SELECT DISTINCT
    CAST(replace(concat_ws('-',glsl_psp_trees_dbh_ht.plotname,glsl_psp_trees_dbh_ht.gpnum), ' ', '') AS char(20)) AS plot_id,
    'on_pp_glsl' :: char(30) AS org_code_db,
    CAST(date_part('year'::text, on_pp.glsl_psp_trees_dbh_ht.msrdate::date) AS integer) AS year_measured,
    CAST(NULL AS numeric) AS macroplot_size,
    temp_quicc.get_surf(11.28) AS plot_size,
    CAST(NULL AS numeric) AS microplot_size,
    0 :: boolean AS is_templot,
    1 :: boolean AS has_macroplot
FROM
    on_pp.glsl_psp_trees_dbh_ht
LEFT JOIN on_pp.glsl_psp_plotsize ON replace(concat_ws('-',glsl_psp_trees_dbh_ht.plotname,glsl_psp_trees_dbh_ht.gpnum), ' ', '') = replace(concat_ws('-',glsl_psp_plotsize.plotname,glsl_psp_plotsize.gpnum), ' ', '')

UNION ALL

-----------------------------------------
-----------Ontario PGP Plots-------------
-----------------------------------------

SELECT DISTINCT
    CAST(concat_ws('-',pgp_treedbh_ht.plot_num,pgp_treedbh_ht.subplot_id) AS char(20)) AS plot_id,
    'on_pp_pgp' :: char(30) AS org_code_db,
    on_pp.pgp_treedbh_ht.obs_year :: integer AS year_measured,
    CAST(NULL AS numeric) AS macroplot_size,
    CAST(NULL AS numeric) AS plot_size,
    CAST(NULL AS numeric) AS microplot_size,
    0 :: boolean AS is_templot,
    1 :: boolean AS has_macroplot
FROM
    on_pp.pgp_treedbh_ht

-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200

UNION ALL

----------------------------------------------
-- FIA   --
----------------------------------------------

SELECT DISTINCT
    CAST(concat_ws('-',us_pp.subplot.statecd,us_pp.subplot.unitcd,us_pp.subplot.countycd,us_pp.subplot.plot,us_pp.subplot.subp) AS char(20)) AS plot_id,
    'us_pp' :: char(30) AS org_code_db,
    us_pp.plot.measyear :: integer AS year_measured,
    CAST(temp_quicc.get_surf(temp_quicc.conv_feet_to_m(58.9 :: double precision)) AS numeric) AS macroplot_size,
    CAST(temp_quicc.get_surf(temp_quicc.conv_feet_to_m(24.0 :: double precision)) AS numeric) AS plot_size,
    CAST(temp_quicc.get_surf(temp_quicc.conv_feet_to_m(6.8 :: double precision)) AS numeric) AS microplot_size,
    0 :: boolean AS is_templot,
    1 :: boolean AS has_macroplot
FROM
    us_pp.plot
INNER JOIN us_pp.subplot ON concat_ws('-',plot.statecd,plot.unitcd,plot.countycd,plot.plot) = concat_ws('-',subplot.statecd,subplot.unitcd,subplot.countycd,subplot.plot)

UNION ALL

----------------------------------------------
-- DOMTAR   --
----------------------------------------------
-- No sapling and seedling plots


SELECT DISTINCT
    CAST(domtar_pp.domtar_data.idpep AS char(30)) AS plot_id,
    'domtar_pp' :: char(30) AS org_code_db,
    CAST(domtar_pp.domtar_data.annee_corrigee AS integer) AS yr_measured,
    CAST(NULL AS numeric) AS macroplot_size,
    CAST(temp_quicc.get_surf(11.28) AS numeric) AS plot_size,
    CAST(NULL AS numeric) AS microplot_size,
    0 :: boolean AS is_templot,
    0 :: boolean AS has_macroplot
FROM
    domtar_pp.domtar_data
;


-----------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------
-- INSERT DATA INTO PLOT INFO TABLE ---
--------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------------------------
DELETE FROM rdb_quicc.plot;
    INSERT INTO rdb_quicc.plot
    SELECT DISTINCT
        rdb_quicc.plot_info.plot_id,
        temp_quicc.mv_plot.year_measured,
        temp_quicc.mv_plot.macroplot_size,
        temp_quicc.flt_plot_size(temp_quicc.mv_plot.plot_size),
        temp_quicc.mv_plot.microplot_size,
        temp_quicc.mv_plot.is_templot,
        temp_quicc.mv_plot.has_macroplot,
        rdb_quicc.localisation.plot_id,
        rdb_quicc.plot_info.plot_id
    FROM temp_quicc.mv_plot
    RIGHT OUTER JOIN rdb_quicc.plot_info ON temp_quicc.mv_plot.plot_id = rdb_quicc.plot_info.org_plot_id
        AND temp_quicc.mv_plot.org_code_db = rdb_quicc.plot_info.org_db_loc
    LEFT JOIN rdb_quicc.localisation ON rdb_quicc.plot_info.plot_id = rdb_quicc.localisation.plot_id
    WHERE temp_quicc.mv_plot.year_measured IS NOT NULL;
REINDEX TABLE rdb_quicc.plot;
-----------------------------------------------------------------------------------------------------------------------------------------------------------

