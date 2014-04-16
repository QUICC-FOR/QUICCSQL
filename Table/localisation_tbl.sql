---------------------------------------
---------------------------------------
------- Localisation table --------
---------------------------------------
---------------------------------------

-- Extract plots location from original database
-- By Steve Vissault

---------------------------------------
-- Permanent sample plot from Quebec---
---------------------------------------

DROP MATERIALIZED VIEW IF EXISTS  temp_quicc.mv_localisation;
CREATE MATERIALIZED VIEW temp_quicc.mv_localisation AS

SELECT DISTINCT
    CAST(qc_pp.pp_infogen.id_pep AS char(10)) AS plot_id,
    ST_X(qc_pp.pp_localis.coord_geom) AS latitude,
    ST_Y(qc_pp.pp_localis.coord_geom) AS longitude,
    qc_pp.pp_localis.coord_geom AS coord_postgis,
    ST_SRID(qc_pp.pp_localis.coord_geom) AS projection_srid,
    0 :: integer AS elevation,
    'qc_pp' :: char(5) AS org_code_db
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
    CAST(qc_tp.infogen_pet2.id_pet AS char(10)) AS plot_id,
    ST_X(qc_tp.localis_pet2.coord_geom) AS longitude,
    ST_Y(qc_tp.localis_pet2.coord_geom) AS latitude,
    qc_tp.localis_pet2.coord_geom AS coord_postgis,
    ST_SRID(qc_tp.localis_pet2.coord_geom) AS projection_srid,
    0 :: integer AS elevation,
    'qc_tp2' :: char(5) AS org_code_db
FROM
    qc_tp.infogen_pet2
INNER JOIN qc_tp.localis_pet2 ON qc_tp.infogen_pet2.id_pet_mes = qc_tp.localis_pet2.id_pet_mes
-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200

UNION ALL

SELECT DISTINCT
    CAST(qc_tp.infogen_pet3.id_pet AS char(10)) AS plot_id,
    ST_X(qc_tp.localis_pet3.coord_geom) AS longitude,
    ST_Y(qc_tp.localis_pet3.coord_geom) AS latitude,
    qc_tp.localis_pet3.coord_geom AS coord_postgis,
    ST_SRID(qc_tp.localis_pet3.coord_geom) AS projection_srid,
     0 :: integer AS elevation,
    'qc_tp3' :: char(5) AS org_code_db
FROM
    qc_tp.infogen_pet3
INNER JOIN qc_tp.localis_pet3 ON qc_tp.infogen_pet3.id_pet_mes = qc_tp.localis_pet3.id_pet_mes
-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200

UNION ALL

SELECT DISTINCT
    CAST(qc_tp.infogen_pet4.id_pet AS char(10)) AS plot_id,
    ST_X(qc_tp.localis_pet4.coord_geom) AS longitude,
    ST_Y(qc_tp.localis_pet4.coord_geom) AS latitude,
    qc_tp.localis_pet4.coord_geom AS coord_postgis,
    ST_SRID(qc_tp.localis_pet4.coord_geom) AS projection_srid,
     0 :: integer AS elevation,
    'qc_tp4' :: char(5) AS org_code_db
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
    CAST(nb_pp.psp_plots.plot AS char(10)) AS plot_id,
    ST_X(nb_pp.psp_plots.coord_geom) AS longitude,
    ST_Y(nb_pp.psp_plots.coord_geom) AS latitude,
    nb_pp.psp_plots.coord_geom AS coord_postgis,
    ST_SRID(nb_pp.psp_plots.coord_geom) AS projection_srid,
    0 :: integer AS elevation,
    'nb_pp' :: char(5) AS org_code_db
FROM
    nb_pp.psp_plots
-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200

----------------------------------------------
-- Permanent sample plot from Ontario --
----------------------------------------------

---- boreal_psp_plot_info

UNION ALL

SELECT DISTINCT
    CAST(on_pp.boreal_psp_plot_info.plot_num AS char(10)) AS plot_id,
    ST_X(on_pp.boreal_psp_plot_info.coord_geom) AS longitude,
    ST_Y(on_pp.boreal_psp_plot_info.coord_geom) AS latitude,
    on_pp.boreal_psp_plot_info.coord_geom AS coord_postgis,
    ST_SRID(on_pp.boreal_psp_plot_info.coord_geom) AS projection_srid,
    0 :: integer AS elevation,
    'on_pp_boreal' :: char(5) AS org_code_db
FROM
    on_pp.boreal_psp_plot_info

---- glsl_on

UNION ALL

SELECT DISTINCT
    CAST(on_pp.glsl_psp_plotinfo.plotname AS char(10)) AS plot_id,
    ST_X(on_pp.glsl_psp_plotinfo.coord_geom) AS longitude,
    ST_Y(on_pp.glsl_psp_plotinfo.coord_geom) AS latitude,
    on_pp.glsl_psp_plotinfo.coord_geom AS coord_postgis,
    ST_SRID(on_pp.glsl_psp_plotinfo.coord_geom) AS projection_srid,
    0 :: integer AS elevation,
    'on_pp_glsl' :: char(5) AS org_code_db
FROM
    on_pp.glsl_psp_plotinfo
-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200
;

--- Checking doublons

SELECT  temp_quicc.mv_localisation.plot_id,
    temp_quicc.mv_localisation.longitude,
    temp_quicc.mv_localisation.latitude,
    temp_quicc.mv_localisation.org_code_db
FROM temp_quicc.mv_localisation
GROUP BY
    temp_quicc.mv_localisation.plot_id,
    temp_quicc.mv_localisation.longitude,
    temp_quicc.mv_localisation.latitude,
    temp_quicc.mv_localisation.org_code_db
 HAVING COUNT(plot_id) > 1
 ORDER BY temp_quicc.mv_localisation.plot_id;