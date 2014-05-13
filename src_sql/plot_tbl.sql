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

DROP MATERIALIZED VIEW IF EXISTS  temp_quicc.mv_plot;
CREATE MATERIALIZED VIEW temp_quicc.mv_plot AS

-- aller chercher ID d'origine


SELECT
    CAST(qc_pp.pp_infogen.id_pep AS char(20)) AS plot_id,
    'qc_pp' :: char(10) AS org_code_db,
    CAST(date_part('year'::text, qc_pp.pp_infogen.date_sond::date) AS integer) AS year_measured,
    CAST(qc_pp.pp_infogen.dimension AS numeric) AS plot_size,
    CAST(qc_pp.pp_infogen.dimension AS numeric) AS sapling_plot_size,
    CAST(qc_pp.pp_infogen.dimension AS numeric) AS seedling_plot_size,
    0 :: boolean AS is_templot,
    0 :: boolean AS has_superplot
FROM
    qc_pp.pp_infogen
INNER JOIN qc_pp.pp_localis on qc_pp.pp_infogen.id_pep_mes = qc_pp.pp_localis.id_pep_mes
-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200


UNION ALL

---------------------------------------
-- Temporary sample plot from Quebec---
---------------------------------------

SELECT
    CAST(qc_tp.infogen_pet2.id_pet AS char(20)) AS plot_id,
    'qc_tp2' :: char(10) AS org_code_db,
    CAST(date_part('year'::text, qc_tp.infogen_pet2.date_sond::date) AS integer) AS year_measured,
    CAST(qc_tp.infogen_pet2.dimension AS numeric) AS plot_size,
    CAST(qc_tp.infogen_pet2.dimension AS numeric) AS sapling_plot_size,
    CAST(qc_tp.infogen_pet2.dimension AS numeric) AS seedling_plot_size,
    1 :: boolean AS is_templot,
    0 :: boolean AS has_superplot
FROM
    qc_tp.infogen_pet2
INNER JOIN qc_tp.localis_pet2 ON qc_tp.infogen_pet2.id_pet_mes = qc_tp.localis_pet2.id_pet_mes
-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200

UNION ALL

SELECT
    CAST(qc_tp.infogen_pet3.id_pet AS char(20)) AS plot_id,
    'qc_tp3' :: char(10) AS org_code_db,
    CAST(date_part('year'::text, qc_tp.infogen_pet3.date_sond::date) AS integer) AS year_measured,
    CAST(qc_tp.infogen_pet3.dimension AS numeric) AS plot_size,
    CAST(qc_tp.infogen_pet3.dimension AS numeric) AS sapling_plot_size,
    CAST(qc_tp.infogen_pet3.dimension AS numeric) AS seedling_plot_size,
    1 :: boolean AS is_templot,
    0 :: boolean AS has_superplot
FROM
    qc_tp.infogen_pet3
INNER JOIN qc_tp.localis_pet3 ON qc_tp.infogen_pet3.id_pet_mes = qc_tp.localis_pet3.id_pet_mes
-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200

UNION ALL

SELECT
    CAST(qc_tp.infogen_pet4.id_pet AS char(20)) AS plot_id,
    'qc_tp4' :: char(10) AS org_code_db,
    CAST(date_part('year'::text, qc_tp.infogen_pet4.date_sond::date) AS integer) AS year_measured,
    CAST(qc_tp.infogen_pet4.dimension AS numeric) AS plot_size,
    CAST(qc_tp.infogen_pet4.dimension AS numeric) AS sapling_plot_size,
    CAST(qc_tp.infogen_pet4.dimension AS numeric) AS seedling_plot_size,
    1 :: boolean AS is_templot,
    0 :: boolean AS has_superplot
FROM
    qc_tp.infogen_pet4
INNER JOIN qc_tp.localis_pet4 ON qc_tp.infogen_pet4.id_pet_mes = qc_tp.localis_pet4.id_pet_mes

-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200

----------------------------------------------
-- Permenent sample plot from New-Brunswick --
----------------------------------------------
UNION ALL

SELECT
    CAST(nb_pp.psp_plots.plot AS char(20)) AS plot_id,
    'nb_pp' :: char(10) AS org_code_db,
    CAST(nb_pp.psp_plots_yr.year AS integer) AS year_measured,
    CAST(nb_pp.psp_plots.plotsize AS numeric) AS plot_size,
    CAST(nb_pp.psp_plots.plotsize AS numeric) AS sapling_plot_size,
    CAST(nb_pp.psp_plots.plotsize AS numeric) AS seedling_plot_size,
    0 :: boolean AS is_templot,
    0 :: boolean AS has_superplot
FROM
    nb_pp.psp_plots
LEFT JOIN  nb_pp.psp_plots_yr ON nb_pp.psp_plots.plot = nb_pp.psp_plots_yr.plot

-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200

----------------------------------------------
-- Permanent sample plot from Ontario --
----------------------------------------------

---- boreal_psp_plot_info

UNION ALL

SELECT DISTINCT
    CAST(on_pp.boreal_psp_treedbh_ht.plot_num AS char(20)) AS plot_id,
    'on_pp_boreal' :: char(10) AS org_code_db,
    on_pp.boreal_psp_treedbh_ht.obs_year :: integer AS year_measured,
    CAST( 0 AS numeric) AS plot_size,
    CAST( 0 AS numeric) AS sapling_plot_size,
    CAST( 0 AS numeric) AS seedling_plot_size,
    0 :: boolean AS is_templot,
    0 :: boolean AS has_superplot
FROM
    on_pp.boreal_psp_treedbh_ht
LEFT JOIN on_pp.boreal_psp_plot_sizes ON on_pp.boreal_psp_treedbh_ht.plot_num = on_pp.boreal_psp_plot_sizes.plot_num

---- glsl_on

UNION ALL

SELECT DISTINCT
    CAST(on_pp.glsl_psp_trees_dbh_ht.plotname AS char(20)) AS plot_id,
    'on_pp_glsl' :: char(10) AS org_code_db,
    CAST(date_part('year'::text, on_pp.glsl_psp_trees_dbh_ht.msrdate::date) AS integer) AS year_measured,
    CAST( 0 AS numeric) AS plot_size,
    CAST( 0 AS numeric) AS sapling_plot_size,
    CAST( 0 AS numeric) AS seedling_plot_size,
    0 :: boolean AS is_templot,
    0 :: boolean AS has_superplot
FROM
    on_pp.glsl_psp_trees_dbh_ht
LEFT JOIN on_pp.glsl_psp_plotsize ON on_pp.glsl_psp_trees_dbh_ht.plotname = on_pp.glsl_psp_plotsize.plotname

UNION ALL

---- pgp_on --- no info on plot_size -- see the MANUAL

SELECT DISTINCT
    CAST(on_pp.pgp_treedbh_ht.plot_num AS char(20)) AS plot_id,
    'on_pp_pgp' :: char(10) AS org_code_db,
    on_pp.pgp_treedbh_ht.obs_year :: integer AS year_measured,
    CAST( 0 AS numeric) AS plot_size,
    CAST( 0 AS numeric) AS sapling_plot_size,
    CAST( 0 AS numeric) AS seedling_plot_size,
    0 :: boolean AS is_templot,
    0 :: boolean AS has_superplot
FROM
    on_pp.pgp_treedbh_ht

-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200

UNION ALL

----------------------------------------------
-- FIA   --
----------------------------------------------

SELECT DISTINCT
    CAST(concat_ws('-',statecd,unitcd,countycd,plot)  AS char(20)) AS plot_id,
    'us_pp' :: char(10) AS org_code_db,
    us_pp.plot.measyear :: integer AS year_measured,
    CAST( 0 AS numeric) AS plot_size,
    CAST( 0 AS numeric) AS sapling_plot_size,
    CAST( 0 AS numeric) AS seedling_plot_size,
    0 :: boolean AS is_templot,
    0 :: boolean AS has_superplot
FROM
    us_pp.plot
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
        temp_quicc.mv_plot.plot_size,
        temp_quicc.mv_plot.sapling_plot_size,
        temp_quicc.mv_plot.seedling_plot_size,
        temp_quicc.mv_plot.is_templot,
        temp_quicc.mv_plot.has_superplot,
        rdb_quicc.plot_info.plot_id,
        rdb_quicc.plot_info.plot_id
    FROM temp_quicc.mv_plot
    INNER JOIN rdb_quicc.plot_info ON temp_quicc.mv_plot.plot_id = rdb_quicc.plot_info.org_db_id
        AND temp_quicc.mv_plot.org_code_db = rdb_quicc.plot_info.org_db_loc
    WHERE temp_quicc.mv_plot.year_measured IS NOT NULL;

-----------------------------------------------------------------------------------------------------------------------------------------------------------

