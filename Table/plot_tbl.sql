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

SELECT
    CAST(qc_pp.pp_infogen.id_pep AS char(10)) AS plot_id,
    'qc_pp' :: char(5) AS org_code_db,
    CAST(qc_pp.pp_infogen.dimension AS numeric) AS plot_size,
    CAST(qc_pp.pp_infogen.dimension AS numeric) AS sapling_plot_size,
    CAST(qc_pp.pp_infogen.dimension AS numeric) AS seedling_plot_size,
    qc_pp.pp_localis.coord_geom AS coord_postgis,
    ST_X(qc_pp.pp_localis.coord_geom) AS latitude,
    ST_Y(qc_pp.pp_localis.coord_geom) AS longitude,
    ST_SRID(qc_pp.pp_localis.coord_geom) AS projection_srid,
    0 :: boolean AS has_superplot,
    0 :: boolean AS is_templot
FROM
    qc_pp.pp_infogen
INNER JOIN qc_pp.pp_localis on qc_pp.pp_infogen.id_pep_mes = qc_pp.pp_localis.id_pep_mes
WHERE
    qc_pp.pp_localis.coord_geom IS NOT NULL
-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200


UNION ALL

---------------------------------------
-- Temporary sample plot from Quebec---
---------------------------------------

SELECT
    CAST(qc_tp.infogen_pet2.id_pet AS char(10)) AS plot_id,
    'qc_tp2' :: char(5) AS org_code_db,
    CAST(qc_tp.infogen_pet2.dimension AS numeric) AS plot_size,
    CAST(qc_tp.infogen_pet2.dimension AS numeric) AS sapling_plot_size,
    CAST(qc_tp.infogen_pet2.dimension AS numeric) AS seedling_plot_size,
    qc_tp.localis_pet2.coord_geom AS coord_postgis,
    ST_X(qc_tp.localis_pet2.coord_geom) AS longitude,
    ST_Y(qc_tp.localis_pet2.coord_geom) AS latitude,
    ST_SRID(qc_tp.localis_pet2.coord_geom) AS projection_srid,
    0 :: boolean AS has_superplot,
    1 :: boolean AS is_templot
FROM
    qc_tp.infogen_pet2
INNER JOIN qc_tp.localis_pet2 ON qc_tp.infogen_pet2.id_pet_mes = qc_tp.localis_pet2.id_pet_mes
WHERE
    qc_tp.localis_pet2.coord_geom IS NOT NULL
-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200

UNION ALL

SELECT
    CAST(qc_tp.infogen_pet3.id_pet AS char(10)) AS plot_id,
    'qc_tp3' :: char(5) AS org_code_db,
    CAST(qc_tp.infogen_pet3.dimension AS numeric) AS plot_size,
    CAST(qc_tp.infogen_pet3.dimension AS numeric) AS sapling_plot_size,
    CAST(qc_tp.infogen_pet3.dimension AS numeric) AS seedling_plot_size,
    qc_tp.localis_pet3.coord_geom AS coord_postgis,
    ST_X(qc_tp.localis_pet3.coord_geom) AS longitude,
    ST_Y(qc_tp.localis_pet3.coord_geom) AS latitude,
    ST_SRID(qc_tp.localis_pet3.coord_geom) AS projection_srid,
    0 :: boolean AS has_superplot,
    1 :: boolean AS is_templot
FROM
    qc_tp.infogen_pet3
INNER JOIN qc_tp.localis_pet3 ON qc_tp.infogen_pet3.id_pet_mes = qc_tp.localis_pet3.id_pet_mes
WHERE
    qc_tp.localis_pet3.coord_geom IS NOT NULL
-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200

UNION ALL

SELECT
    CAST(qc_tp.infogen_pet4.id_pet AS char(10)) AS plot_id,
    'qc_tp4' :: char(5) AS org_code_db,
    CAST(qc_tp.infogen_pet4.dimension AS numeric) AS plot_size,
    CAST(qc_tp.infogen_pet4.dimension AS numeric) AS sapling_plot_size,
    CAST(qc_tp.infogen_pet4.dimension AS numeric) AS seedling_plot_size,
    qc_tp.localis_pet4.coord_geom AS coord_postgis,
    ST_X(qc_tp.localis_pet4.coord_geom) AS longitude,
    ST_Y(qc_tp.localis_pet4.coord_geom) AS latitude,
    ST_SRID(qc_tp.localis_pet4.coord_geom) AS projection_srid,
    0 :: boolean AS has_superplot,
    1 :: boolean AS is_templot
FROM
    qc_tp.infogen_pet4
INNER JOIN qc_tp.localis_pet4 ON qc_tp.infogen_pet4.id_pet_mes = qc_tp.localis_pet4.id_pet_mes
WHERE
    qc_tp.localis_pet4.coord_geom IS NOT NULL
-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200

----------------------------------------------
-- Permenent sample plot from New-Brunswick --
----------------------------------------------
UNION ALL

SELECT
    CAST(nb_pp.psp_plots.plot AS char(10)) AS plot_id,
    'nb_pp' :: char(5) AS org_code_db,
    CAST(nb_pp.psp_plots.plotsize AS numeric) AS plot_size,
    CAST(nb_pp.psp_plots.plotsize AS numeric) AS sapling_plot_size,
    CAST(nb_pp.psp_plots.plotsize AS numeric) AS seedling_plot_size,
    nb_pp.psp_plots.coord_geom AS coord_postgis,
    ST_X(nb_pp.psp_plots.coord_geom) AS longitude,
    ST_Y(nb_pp.psp_plots.coord_geom) AS latitude,
    ST_SRID(nb_pp.psp_plots.coord_geom) AS projection_srid,
    0 :: boolean AS has_superplot,
    0 :: boolean AS is_templot
FROM
    nb_pp.psp_plots
WHERE
    nb_pp.psp_plots.coord_geom IS NOT NULL
-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200

----------------------------------------------
-- Permanent sample plot from Ontario --
----------------------------------------------

---- boreal_psp_plot_info

UNION ALL

SELECT
    CAST(on_pp.boreal_psp_plot_info.plot_num AS char(10)) AS plot_id,
    'on_pp_boreal' :: char(5) AS org_code_db,
    CAST( tbl_plot.area AS numeric) AS plot_size,
    CAST( 0 AS numeric) AS sapling_plot_size,
    CAST( 0 AS numeric) AS seedling_plot_size,
    on_pp.boreal_psp_plot_info.coord_geom AS coord_postgis,
    ST_X(on_pp.boreal_psp_plot_info.coord_geom) AS longitude,
    ST_Y(on_pp.boreal_psp_plot_info.coord_geom) AS latitude,
    ST_SRID(on_pp.boreal_psp_plot_info.coord_geom) AS projection_srid,
    0 :: boolean AS has_superplot,
    0 :: boolean AS is_templot
FROM
    on_pp.boreal_psp_plot_info,
    (SELECT on_pp.boreal_psp_plot_sizes.plot_num,
        max(on_pp.boreal_psp_plot_sizes.area) as area
    FROM on_pp.boreal_psp_plot_sizes
    WHERE on_pp.boreal_psp_plot_sizes.area IS NOT NULL
    GROUP BY  on_pp.boreal_psp_plot_sizes.plot_num
    ORDER BY on_pp.boreal_psp_plot_sizes.plot_num) AS tbl_plot
WHERE
    tbl_plot.plot_num = on_pp.boreal_psp_plot_info.plot_num
AND
    on_pp.boreal_psp_plot_info.coord_geom IS NOT NULL

---- glsl_on

UNION ALL

SELECT
    CAST(on_pp.glsl_psp_plotinfo.plotname AS char(10)) AS plot_id,
    'on_pp_glsl' :: char(5) AS org_code_db,
    CAST( tbl_plot.area AS numeric) AS plot_size,
    CAST( 0 AS numeric) AS sapling_plot_size,
    CAST( 0 AS numeric) AS seedling_plot_size,
    on_pp.glsl_psp_plotinfo.coord_geom AS coord_postgis,
    ST_X(on_pp.glsl_psp_plotinfo.coord_geom) AS longitude,
    ST_Y(on_pp.glsl_psp_plotinfo.coord_geom) AS latitude,
    ST_SRID(on_pp.glsl_psp_plotinfo.coord_geom) AS projection_srid,
    0 :: boolean AS has_superplot,
    0 :: boolean AS is_templot
FROM
    on_pp.glsl_psp_plotinfo,
    (SELECT on_pp.glsl_psp_plotsize.plotname,
        max(on_pp.glsl_psp_plotsize.area) AS area
    FROM on_pp.glsl_psp_plotsize
    WHERE on_pp.glsl_psp_plotsize.area IS NOT NULL
    GROUP BY on_pp.glsl_psp_plotsize.plotname
    ORDER BY on_pp.glsl_psp_plotsize.plotname) AS tbl_plot
WHERE
    tbl_plot.plotname = on_pp.glsl_psp_plotinfo.plotname
AND
    on_pp.glsl_psp_plotinfo.coord_geom IS NOT NULL
-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200
;

INSERT INTO rdb_quicc.plot SELECT
    rdb_quicc.plot_info.plot_id,
    rdb_quicc.plot_info.org_db_loc,
    temp_quicc.mv_plot.latitude,
    temp_quicc.mv_plot.longitude,
    temp_quicc.mv_plot.projection_srid,
    0 :: integer AS elevation,
    temp_quicc.plot_size(temp_quicc.mv_plot.org_code_db,temp_quicc.mv_plot.plot_size),
    temp_quicc.plot_size(temp_quicc.mv_plot.org_code_db,temp_quicc.mv_plot.sapling_plot_size),
    temp_quicc.plot_size(temp_quicc.mv_plot.org_code_db,temp_quicc.mv_plot.seedling_plot_size),
    0 :: boolean AS is_subplot,
    temp_quicc.mv_plot.has_superplot,
    temp_quicc.mv_plot.is_templot
FROM temp_quicc.mv_plot
JOIN rdb_quicc.plot_info ON temp_quicc.mv_plot.plot_id = rdb_quicc.plot_info.org_db_id;

