--------------------------------------
---------------------------------------
--------  Plot info table ----------
---------------------------------------
---------------------------------------

-- Extract plot level information from original database
-- By Steve Vissault

-----------------------------------------------------------------------------------------------------------------------------------------------------------

DROP MATERIALIZED VIEW IF EXISTS  temp_quicc.mv_plot_info;
CREATE MATERIALIZED VIEW temp_quicc.mv_plot_info AS

---------------------------------------
------  FIA database
---------------------------------------

  SELECT DISTINCT

    concat_ws('-',statecd,unitcd,countycd,plot)   AS id ,
    'us_pp' AS org_code_db
  FROM
    us_pp.plot

---------------------------------------
------ QC_PP database
---------------------------------------

UNION ALL

SELECT
    CAST(qc_pp.pp_infogen.id_pep AS char(20)) AS plot_id,
    'qc_pp' :: char(20) AS org_code_db
FROM
    qc_pp.pp_infogen

---------------------------------------
------ QC_PT database
---------------------------------------

UNION ALL

SELECT DISTINCT
    CAST(qc_tp.infogen_pet2.id_pet AS char(20)) AS plot_id,
    'qc_tp2' :: char(20) AS org_code_db
FROM
    qc_tp.infogen_pet2

UNION ALL

SELECT DISTINCT
    CAST(qc_tp.infogen_pet3.id_pet AS char(20)) AS plot_id,
    'qc_tp3' :: char(20) AS org_code_db
FROM
    qc_tp.infogen_pet3

UNION ALL

SELECT DISTINCT
    CAST(qc_tp.infogen_pet4.id_pet AS char(20)) AS plot_id,
    'qc_tp4' :: char(20) AS org_code_db
FROM
    qc_tp.infogen_pet4

---------------------------------------
------ NB_PP database
---------------------------------------

UNION ALL

SELECT DISTINCT
    CAST(nb_pp.psp_plots.plot AS char(20)) AS plot_id,
    'nb_pp' :: char(20) AS org_code_db
FROM
    nb_pp.psp_plots

---------------------------------------
------ NB_PP database
---------------------------------------

UNION ALL

SELECT DISTINCT
    CAST(on_pp.boreal_psp_plot_info.plot_num AS char(20)) AS plot_id,
    'on_pp_boreal' :: char(20) AS org_code_db
FROM
    on_pp.boreal_psp_plot_info

---- glsl_on

UNION ALL

SELECT DISTINCT
    CAST(on_pp.glsl_psp_plotinfo.plotname AS char(20)) AS plot_id,
    'on_pp_glsl' :: char(20) AS org_code_db
FROM
    on_pp.glsl_psp_plotinfo

UNION ALL

SELECT DISTINCT
    CAST(on_pp.pgp_plot_info.plot_num AS char(20)) AS plot_id,
    'on_pp_pgp' :: char(20) AS org_code_db
FROM
    on_pp.pgp_plot_info;

-----------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------
-- INSERT DATA INTO PLOT INFO TABLE ---
--------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------------------------

DELETE FROM rdb_quicc.plot_info;
INSERT INTO rdb_quicc.plot_info (org_db_loc,org_db_id) SELECT org_code_db, id FROM temp_quicc.mv_plot_info;

-----------------------------------------------------------------------------------------------------------------------------------------------------------