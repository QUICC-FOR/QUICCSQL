--------------------------------------
---------------------------------------
--------  Plot info table ----------
---------------------------------------
---------------------------------------

-- Extract plot level information from original database
-- By Steve Vissault

-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- DROP MATERIALIZED VIEW IF EXISTS  temp_quicc.mv_plot_info;
REFRESH MATERIALIZED VIEW temp_quicc.mv_tree_info;
CREATE MATERIALIZED VIEW temp_quicc.mv_plot_info AS

---------------------------------------
------  FIA database
---------------------------------------

  SELECT DISTINCT

    concat_ws('-',statecd,unitcd,countycd,plot)   AS id ,
    'us_pp' AS org_code_db
  FROM
    us_pp.plot
WHERE us_pp.plot.coord_geom IS NOT NULL

---------------------------------------
------ QC_PP database
---------------------------------------

UNION ALL

SELECT DISTINCT
    CAST(qc_pp.pp_infogen.id_pep AS char(20)) AS plot_id,
    'qc_pp' :: char(20) AS org_code_db
FROM
    qc_pp.pp_infogen
INNER JOIN qc_pp.pp_localis on qc_pp.pp_localis.id_pep_mes = qc_pp.pp_infogen.id_pep_mes
WHERE qc_pp.pp_localis.coord_geom IS NOT NULL

---------------------------------------
------ QC_PT database
---------------------------------------

UNION ALL

SELECT DISTINCT
    CAST(qc_tp.infogen_pet2.id_pet AS char(20)) AS plot_id,
    'qc_tp2' :: char(20) AS org_code_db
FROM
    qc_tp.infogen_pet2
INNER JOIN qc_tp.localis_pet2 on qc_tp.localis_pet2.id_pet_mes = qc_tp.infogen_pet2.id_pet_mes
WHERE qc_tp.localis_pet2.coord_geom IS NOT NULL

UNION ALL

SELECT DISTINCT
    CAST(qc_tp.infogen_pet3.id_pet AS char(20)) AS plot_id,
    'qc_tp3' :: char(20) AS org_code_db
FROM
    qc_tp.infogen_pet3
INNER JOIN qc_tp.localis_pet3 on qc_tp.localis_pet3.id_pet_mes = qc_tp.infogen_pet3.id_pet_mes
WHERE qc_tp.localis_pet3.coord_geom IS NOT NULL

UNION ALL

SELECT DISTINCT
    CAST(qc_tp.infogen_pet4.id_pet AS char(20)) AS plot_id,
    'qc_tp4' :: char(20) AS org_code_db
FROM
    qc_tp.infogen_pet4
INNER JOIN qc_tp.localis_pet4 on qc_tp.localis_pet4.id_pet_mes = qc_tp.infogen_pet4.id_pet_mes
WHERE qc_tp.localis_pet4.coord_geom IS NOT NULL

---------------------------------------
------ NB_PP database
---------------------------------------

UNION ALL

SELECT DISTINCT
    CAST(nb_pp.psp_plots.plot AS char(20)) AS plot_id,
    'nb_pp' :: char(20) AS org_code_db
FROM
    nb_pp.psp_plots
WHERE nb_pp.psp_plots.coord_geom IS NOT NULL

---------------------------------------
------ ON_PP database
---------------------------------------

UNION ALL

SELECT DISTINCT
    CAST(on_pp.boreal_psp_plot_info.plot_num AS char(20)) AS plot_id,
    'on_pp_boreal' :: char(20) AS org_code_db
FROM
    on_pp.boreal_psp_plot_info
 WHERE  on_pp.boreal_psp_plot_info.coord_geom IS NOT NULL

---- glsl_on

UNION ALL

SELECT DISTINCT
    CAST(on_pp.glsl_psp_plotinfo.plotname AS char(20)) AS plot_id,
    'on_pp_glsl' :: char(20) AS org_code_db
FROM
    on_pp.glsl_psp_plotinfo
WHERE on_pp.glsl_psp_plotinfo.coord_geom IS NOT NULL


UNION ALL

SELECT DISTINCT
    CAST(on_pp.pgp_plot_info.plot_num AS char(20)) AS plot_id,
    'on_pp_pgp' :: char(20) AS org_code_db
FROM
    on_pp.pgp_plot_info
WHERE on_pp.pgp_plot_info.coord_geom IS NOT NULL;

-----------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------
-- INSERT DATA INTO PLOT INFO TABLE ---
--------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------------------------

DELETE FROM rdb_quicc.plot_info;
INSERT INTO rdb_quicc.plot_info (org_db_loc,org_db_id) SELECT org_code_db, id FROM temp_quicc.mv_plot_info;

-----------------------------------------------------------------------------------------------------------------------------------------------------------