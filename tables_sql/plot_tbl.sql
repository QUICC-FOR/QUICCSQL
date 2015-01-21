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
    CAST(qc_pp.pp_infogen.id_pep AS character varying(30)) AS plot_id,
    CAST(0 AS smallint) AS subplot_id,
    'qc_pp' :: character varying(30) AS org_code_db,
    CAST(date_part('year'::text, qc_pp.pp_infogen.date_sond::date) AS integer) AS year_measured,
    temp_quicc.get_plot_size('qc_pp' :: character varying(15),CAST(qc_pp.pp_infogen.dimension AS character varying(10))) AS plot_size,
    CAST(NULL AS double precision) AS saplingplot_size,
    CAST(NULL AS double precision) AS seedlingplot_size,
    0 :: boolean AS is_temp
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
    CAST(qc_tp.infogen_pet2.id_pet AS character varying(30)) AS plot_id,
    CAST(0 AS smallint) AS subplot_id,
    'qc_tp2' :: character varying(30) AS org_code_db,
    CAST(date_part('year'::text, qc_tp.infogen_pet2.date_sond::date) AS integer) AS year_measured,
    temp_quicc.get_plot_size('qc_tp2' :: character varying(15),CAST(qc_tp.infogen_pet2.dimension AS character varying(10))) AS plot_size,
    CAST(NULL AS double precision) AS saplingplot_size,
    CAST(NULL AS double precision) AS seedlingplot_size,
    1 :: boolean AS is_temp
FROM
    qc_tp.infogen_pet2
INNER JOIN qc_tp.localis_pet2 ON qc_tp.infogen_pet2.id_pet_mes = qc_tp.localis_pet2.id_pet_mes
-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200

UNION ALL

SELECT DISTINCT
    CAST(qc_tp.infogen_pet3.id_pet AS character varying(30)) AS plot_id,
    CAST(0 AS smallint) AS subplot_id,
    'qc_tp3' :: character varying(30) AS org_code_db,
    CAST(date_part('year'::text, qc_tp.infogen_pet3.date_sond::date) AS integer) AS year_measured,
    temp_quicc.get_plot_size('qc_tp3' :: character varying(15),CAST(qc_tp.infogen_pet3.dimension AS character varying(10))) AS plot_size,
    CAST(NULL AS double precision) AS saplingplot_size,
    CAST(NULL AS double precision) AS seedlingplot_size,
    1 :: boolean AS is_temp
FROM
    qc_tp.infogen_pet3
INNER JOIN qc_tp.localis_pet3 ON qc_tp.infogen_pet3.id_pet_mes = qc_tp.localis_pet3.id_pet_mes
-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200

UNION ALL

SELECT DISTINCT
    CAST(qc_tp.infogen_pet4.id_pet AS character varying(30)) AS plot_id,
    CAST(0 AS smallint) AS subplot_id,
    'qc_tp4' :: character varying(30) AS org_code_db,
    CAST(date_part('year'::text, qc_tp.infogen_pet4.date_sond::date) AS integer) AS year_measured,
    temp_quicc.get_plot_size('qc_tp4' :: character varying(15),CAST(qc_tp.infogen_pet4.dimension AS character varying(10))) AS plot_size,
    CAST(NULL AS double precision) AS saplingplot_size,
    CAST(NULL AS double precision) AS seedlingplot_size,
    0 :: boolean AS is_temp
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
    CAST(nb_pp.psp_plots.plot AS character varying(30)) AS plot_id,
    CAST(0 AS smallint) AS subplot_id,
    temp_quicc.get_source_nb_db(nb_pp.psp_plots.plot) AS org_code_db,
    CAST(nb_pp.psp_plots_yr.year AS integer) AS year_measured,
    CAST(nb_pp.psp_plots.plotsize AS double precision) AS plot_size,
    CAST(NULL AS double precision) AS saplingplot_size,
    CAST(NULL AS double precision) AS seedlingplot_size,
    0 :: boolean AS is_temp
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
    CAST(boreal_psp_treedbh_ht.plot_num AS character varying(20)) AS plot_id,
    CAST(boreal_psp_treedbh_ht.subplot_id AS smallint) AS subplot_id,
    'on_pp_boreal' :: character varying(30) AS org_code_db,
    on_pp.boreal_psp_treedbh_ht.obs_year :: integer AS year_measured,
    CAST(temp_quicc.get_surf(boreal_psp_plot_sizes.radius,'radius') AS double precision) AS plot_size,
    CAST(NULL AS double precision) AS saplingplot_size,
    CAST(NULL AS double precision) AS seedlingplot_size,
    0 :: boolean AS is_temp
FROM
    on_pp.boreal_psp_treedbh_ht
LEFT JOIN on_pp.boreal_psp_plot_sizes ON boreal_psp_treedbh_ht.plot_num = boreal_psp_plot_sizes.plot_num
AND boreal_psp_treedbh_ht.msr_num = on_pp.boreal_psp_plot_sizes.msr_num
WHERE boreal_psp_plot_sizes.radius IS NOT NULL -- Add filter because some rows are duplicated with no size of the plot

-----------------------------------------)
------------Ontario GLSL Plots-----------
-----------------------------------------

UNION ALL

SELECT DISTINCT
    CAST(replace(glsl_psp_trees_dbh_ht.plotname, ' ', '') AS character varying(20)) AS plot_id,
    CAST(glsl_psp_trees_dbh_ht.gpnum AS smallint) AS subplot_id,
    'on_pp_glsl' :: character varying(30) AS org_code_db,
    CAST(date_part('year'::text, on_pp.glsl_psp_trees_dbh_ht.msrdate::date) AS integer) AS year_measured,
    temp_quicc.get_surf(11.28,'radius') AS plot_size,
    CAST(NULL AS double precision) AS saplingplot_size,
    CAST(NULL AS double precision) AS seedlingplot_size,
    0 :: boolean AS is_temp
FROM
    on_pp.glsl_psp_trees_dbh_ht
LEFT JOIN on_pp.glsl_psp_plotsize ON replace(glsl_psp_trees_dbh_ht.plotname, ' ', '') = replace(glsl_psp_plotsize.plotname, ' ', '')

UNION ALL

-----------------------------------------
-----------Ontario PGP Plots-------------
-----------------------------------------

SELECT DISTINCT
    CAST(pgp_treedbh_ht.plot_num AS character varying(20)) AS plot_id,
    CAST(pgp_treedbh_ht.subplot_id AS smallint) AS subplot_id,
    'on_pp_pgp' :: character varying(30) AS org_code_db,
    on_pp.pgp_treedbh_ht.obs_year :: integer AS year_measured,
    CAST(NULL AS double precision) AS plot_size,
    CAST(NULL AS double precision) AS saplingplot_size,
    CAST(NULL AS double precision) AS seedlingplot_size,
    0 :: boolean AS is_temp
FROM
    on_pp.pgp_treedbh_ht

-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200

UNION ALL

-- ----------------------------------------------
-- -- FIA   --
-- ----------------------------------------------

SELECT DISTINCT
    CAST(concat_ws('-',us_pp.plot.statecd,us_pp.plot.unitcd,us_pp.plot.countycd,us_pp.plot.plot) AS character varying(20)) AS plot_id,
    CAST(us_pp.subplot.subp AS smallint) AS subplot_id,
    'us_pp' :: character varying(30) AS org_code_db,
    us_pp.plot.measyear :: integer AS year_measured,
    CAST(temp_quicc.get_surf(temp_quicc.conv_feet_to_m(24.0 :: double precision),'radius') AS double precision) AS plot_size,
    CAST(NULL AS double precision) AS saplingplot_size,
    CAST(NULL AS double precision) AS seedlingplot_size,
    0 :: boolean AS is_temp
FROM
    us_pp.plot
INNER JOIN us_pp.subplot ON concat_ws('-',plot.statecd,plot.unitcd,plot.countycd,plot.plot) = concat_ws('-',subplot.statecd,subplot.unitcd,subplot.countycd,subplot.plot)

UNION ALL

----------------------------------------------
-- DOMTAR   --
----------------------------------------------
-- No sapling and seedling plots


SELECT DISTINCT
    CAST(domtar_pp.domtar_data.idpep AS character varying(30)) AS plot_id,
    CAST(0 AS smallint) AS subplot_id,
    'domtar_pp' :: character varying(30) AS org_code_db,
    CAST(domtar_pp.domtar_data.annee_sondage AS integer) AS yr_measured,
    CAST(temp_quicc.get_surf(11.28,'radius') AS double precision) AS plot_size,
    CAST(NULL AS double precision) AS saplingplot_size,
    CAST(NULL AS double precision) AS seedlingplot_size,
    0 :: boolean AS is_temp
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
        temp_quicc.mv_plot.subplot_id,
        temp_quicc.mv_plot.year_measured,
        temp_quicc.flt_plot_size(temp_quicc.mv_plot.plot_size) AS plot_size,
        temp_quicc.mv_plot.saplingplot_size,
        temp_quicc.mv_plot.seedlingplot_size,
        temp_quicc.mv_plot.is_temp,
        rdb_quicc.localisation.plot_id,
        rdb_quicc.plot_info.plot_id
    FROM temp_quicc.mv_plot
    RIGHT OUTER JOIN rdb_quicc.plot_info ON temp_quicc.mv_plot.plot_id = rdb_quicc.plot_info.org_plot_id
        AND temp_quicc.mv_plot.org_code_db = rdb_quicc.plot_info.org_db_loc
    LEFT JOIN rdb_quicc.localisation ON rdb_quicc.plot_info.plot_id = rdb_quicc.localisation.plot_id
    WHERE temp_quicc.mv_plot.year_measured IS NOT NULL;
REINDEX TABLE rdb_quicc.plot;
-----------------------------------------------------------------------------------------------------------------------------------------------------------

