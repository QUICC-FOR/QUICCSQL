---------------------------------------
---------------------------------------
-------------- Stand table -----------
---------------------------------------
---------------------------------------

-- Extract stand level informations from original databases
-- By Steve Vissault

---------------------------------------
-- Permanent sample plot from Quebec---
---------------------------------------

CREATE OR REPLACE VIEW temp_quicc.mv_plot AS

SELECT DISTINCT
    CAST(qc_pp.pp_infogen.id_pep AS character varying(30)) AS plot_id,
    'qc_pp' :: character varying(30) AS org_code_db,
    CAST(date_part('year'::text, qc_pp.pp_infogen.date_sond::date) AS integer) AS year_measured,
    pp_peuobser.cl_age AS age,
    NULL AS age_id_method,
    pp_peuobser.cl_haut AS height,
    NULL AS height_id_method,
    pp_peucarto.dep_sur AS surface_deposit,
    pp_peuobser.cl_drai AS drainage,
    pp_peuobser.cl_pent AS slope,
    pp_peuobser.perturb AS is_disturbed,
    NULL AS is_planted
FROM
    qc_pp.pp_infogen
INNER JOIN qc_pp.pp_peuobser on qc_pp.pp_infogen.id_pep_mes = qc_pp.pp_peuobser.id_pep_mes
INNER JOIN qc_pp.pp_peucarto on qc_pp.pp_infogen.id_pep_mes = qc_pp.pp_peucarto.id_pep_mes
-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200


UNION ALL

---------------------------------------
-- Temporary sample plot from Quebec---
---------------------------------------

SELECT DISTINCT
    CAST(qc_tp.infogen_pet2.id_pet AS character varying(30)) AS plot_id,
    'qc_tp2' :: character varying(30) AS org_code_db,
    CAST(date_part('year'::text, qc_tp.infogen_pet2.date_sond::date) AS integer) AS year_measured,
    peuobser_pet2.cl_age AS age,
    NULL AS age_id_method,
    peuobser_pet2.cl_haut AS height,
    NULL AS height_id_method,
    peucarto_pet2.dep_sur AS surface_deposit,
    NULL AS drainage,
    peuobser_pet2.cl_pent AS slope,
    peuobser_pet2.perturb AS is_disturbed,
    NULL AS is_planted
FROM
    qc_tp.infogen_pet2
INNER JOIN qc_tp.peuobser_pet2 ON qc_tp.infogen_pet2.id_pet_mes = qc_tp.peuobser_pet2.id_pet_mes
INNER JOIN qc_tp.peucarto_pet2 on qc_tp.infogen_pet2.id_pet_mes = qc_tp.peucarto_pet2.id_pet_mes
-- LIMIT 200

UNION ALL

SELECT DISTINCT
    CAST(qc_tp.infogen_pet3.id_pet AS character varying(30)) AS plot_id,
    'qc_tp2' :: character varying(30) AS org_code_db,
    CAST(date_part('year'::text, qc_tp.infogen_pet3.date_sond::date) AS integer) AS year_measured,
    peuobser_pet3.cl_age AS age,
    NULL AS age_id_method,
    peuobser_pet3.cl_haut AS height,
    NULL AS height_id_method,
    peucarto_pet3.dep_sur AS surface_deposit,
    peuobser_pet3.cl_drai AS drainage,
    peuobser_pet3.cl_pent AS slope,
    peuobser_pet3.perturb AS is_disturbed,
    NULL AS is_planted
FROM
    qc_tp.infogen_pet3
INNER JOIN qc_tp.peuobser_pet3 ON qc_tp.infogen_pet3.id_pet_mes = qc_tp.peuobser_pet3.id_pet_mes
INNER JOIN qc_tp.peucarto_pet3 on qc_tp.infogen_pet3.id_pet_mes = qc_tp.peucarto_pet3.id_pet_mes
-- LIMIT 200

UNION ALL

SELECT DISTINCT
    CAST(qc_tp.infogen_pet4.id_pet AS character varying(30)) AS plot_id,
    'qc_tp2' :: character varying(30) AS org_code_db,
    CAST(date_part('year'::text, qc_tp.infogen_pet4.date_sond::date) AS integer) AS year_measured,
    peuobser_pet4.cl_age AS age,
    NULL AS age_id_method,
    peuobser_pet4.cl_haut AS height,
    NULL AS height_id_method,
    peucarto_pet4.dep_sur AS surface_deposit,
    peuobser_pet4.cl_drai AS drainage,
    peuobser_pet4.cl_pent AS slope,
    peuobser_pet4.perturb AS is_disturbed,
    NULL AS is_planted
FROM
    qc_tp.infogen_pet4
INNER JOIN qc_tp.peuobser_pet4 ON qc_tp.infogen_pet4.id_pet_mes = qc_tp.peuobser_pet4.id_pet_mes
INNER JOIN qc_tp.peucarto_pet4 on qc_tp.infogen_pet4.id_pet_mes = qc_tp.peucarto_pet4.id_pet_mes

-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200

----------------------------------------------
-- Permenent sample plot from New-Brunswick --
----------------------------------------------
UNION ALL

SELECT DISTINCT
    CAST(nb_pp.psp_plots.plot AS character varying(30)) AS plot_id,
    temp_quicc.get_source_nb_db(nb_pp.psp_plots.plot) AS org_code_db,
    CAST(nb_pp.psp_plots_yr.year AS integer) AS year_measured,
    NULL AS age,
    NULL AS age_id_method,
    NULL AS height,
    NULL AS height_id_method,
    psp_plots.soil AS surface_deposit,
    psp_plots.drainage AS drainage,
    NULL AS slope,
    psp_plots.datasource AS is_disturbed,
    psp_plots.plottype AS is_planted
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
    CAST(concat_ws('-',boreal_psp_treedbh_ht.plot_num, boreal_psp_treedbh_ht.subplot_id) AS character varying(20)) AS plot_id,
    'on_pp_boreal' :: character varying(30) AS org_code_db,
    on_pp.boreal_psp_treedbh_ht.obs_year :: integer AS year_measured,
    NULL AS age,
    NULL AS age_id_method,
    NULL AS height,
    NULL AS height_id_method,
    concat_ws('',boreal_psp_plot_soils.mode_dep1, boreal_psp_plot_soils.mode_dep2) AS surface_deposit,
    boreal_psp_plot_soils.drainage AS drainage,
    boreal_psp_plot_soils.slope_pct AS slope,
    NULL AS is_disturbed,
    NULL AS is_planted
FROM
    on_pp.boreal_psp_treedbh_ht
LEFT JOIN on_pp.boreal_psp_plot_soils ON concat_ws('-',boreal_psp_treedbh_ht.plot_num, boreal_psp_treedbh_ht.subplot_id) = concat_ws('-',boreal_psp_plot_soils.plot_num, boreal_psp_plot_soils.subplot_id)

-----------------------------------------)
------------Ontario GLSL Plots-----------
-----------------------------------------

UNION ALL

SELECT DISTINCT
    CAST(replace(concat_ws('-',glsl_psp_trees_dbh_ht.plotname,glsl_psp_trees_dbh_ht.gpnum), ' ', '') AS character varying(20)) AS plot_id,
    'on_pp_glsl' :: character varying(30) AS org_code_db,
    CAST(date_part('year'::text, on_pp.glsl_psp_trees_dbh_ht.msrdate::date) AS integer) AS year_measured,
    NULL AS age,
    NULL AS age_id_method,
    NULL AS height,
    NULL AS height_id_method,
    replace(concat_ws('',glsl_psp_soils.mode_dep1, glsl_psp_soils.mode_dep2),' ', '') AS surface_deposit,
    glsl_psp_soils.drainage AS drainage,
    glsl_psp_soils.slope_pct AS slope,
    NULL AS is_disturbed,
    NULL AS is_planted
FROM
    on_pp.glsl_psp_trees_dbh_ht
LEFT JOIN on_pp.glsl_psp_soils ON replace(concat_ws('-',glsl_psp_trees_dbh_ht.plotname,glsl_psp_trees_dbh_ht.gpnum), ' ', '') = replace(concat_ws('-',glsl_psp_soils.plotname,glsl_psp_soils.gp_num), ' ', '')

UNION ALL

-----------------------------------------
-----------Ontario PGP Plots-------------
-----------------------------------------

SELECT DISTINCT
    CAST(concat_ws('-',pgp_treedbh_ht.plot_num,pgp_treedbh_ht.subplot_id) AS character varying(20)) AS plot_id,
    'on_pp_pgp' :: character varying(30) AS org_code_db,
    on_pp.pgp_treedbh_ht.obs_year :: integer AS year_measured,
    NULL AS age,
    NULL AS age_id_method,
    NULL AS height,
    NULL AS height_id_method,
    replace(concat_ws('',pgp_plot_soils.mode_dep1, pgp_plot_soils.mode_dep2),' ', '') AS surface_deposit,
    pgp_plot_soils.drainage AS drainage,
    pgp_plot_soils.slope_pct AS slope,
    NULL AS is_disturbed,
    NULL AS is_planted
FROM
    on_pp.pgp_treedbh_ht
LEFT JOIN on_pp.pgp_plot_soils ON replace(concat_ws('-',pgp_treedbh_ht.plot_num,pgp_treedbh_ht.subplot_id), ' ', '') = replace(concat_ws('-',pgp_plot_soils.plot_num,pgp_plot_soils.subplot_id), ' ', '')

-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200

UNION ALL

----------------------------------------------
-- FIA   --
----------------------------------------------

SELECT DISTINCT
    CAST(concat_ws('-',us_pp.subplot.statecd,us_pp.subplot.unitcd,us_pp.subplot.countycd,us_pp.subplot.plot,us_pp.subplot.subp) AS character varying(20)) AS plot_id,
    'us_pp' :: character varying(30) AS org_code_db,
    us_pp.plot.measyear :: integer AS year_measured,
    NULL AS age,
    NULL AS age_id_method,
    NULL AS height,
    NULL AS height_id_method,
    NULL AS surface_deposit,
    NULL AS drainage,
    NULL AS slope,
    NULL AS is_disturbed,
    NULL AS is_planted
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
    'domtar_pp' :: character varying(30) AS org_code_db,
    CAST(domtar_pp.domtar_data.annee_sondage AS integer) AS yr_measured,
    CAST(NULL AS double precision) AS macroplot_size,
    NULL AS age,
    NULL AS age_id_method,
    NULL AS height,
    NULL AS height_id_method,
    NULL AS surface_deposit,
    NULL AS drainage,
    NULL AS slope,
    NULL AS is_disturbed,
    NULL AS is_planted
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

