
SELECT DISTINCT id, longitude, latitude, org_code_db FROM(
---------------------------------------
-- Permanent sample plot from Quebec ---
---------------------------------------

  SELECT DISTINCT
    qc_pp.pp_infogen.id_pep AS id ,
    date_part('year'::text, qc_pp.pp_infogen.date_sond::date) AS yr_measured,
    ST_X(qc_pp.pp_localis.coord_geom) AS longitude,
    ST_Y(qc_pp.pp_localis.coord_geom) AS latitude,
    'qc_pp' AS org_code_db
  FROM qc_pp.pp_infogen
  INNER JOIN qc_pp.pp_localis on qc_pp.pp_localis.id_pep_mes = qc_pp.pp_infogen.id_pep_mes
  -- LIMIT 100

  UNION ALL

  ---------------------------------------
  -- Temporary sample plot from Quebec ---
  ---------------------------------------

  SELECT DISTINCT
    qc_tp.infogen_pet2.id_pet AS id,
    date_part('year'::text, qc_tp.infogen_pet2.date_sond::date) AS yr_measured,
    ST_X(qc_tp.localis_pet2.coord_geom) AS longitude,
    ST_Y(qc_tp.localis_pet2.coord_geom) AS latitude,
    'qc_tp2' AS org_code_db
  FROM qc_tp.infogen_pet2
  INNER JOIN qc_tp.localis_pet2 on qc_tp.localis_pet2.id_pet_mes = qc_tp.infogen_pet2.id_pet_mes
  --LIMIT 100


  UNION ALL

  SELECT DISTINCT
    qc_tp.infogen_pet3.id_pet AS id,
    date_part('year'::text, qc_tp.infogen_pet3.date_sond::date) AS yr_measured,
    ST_X(qc_tp.localis_pet3.coord_geom) AS longitude,
    ST_Y(qc_tp.localis_pet3.coord_geom) AS latitude,
    'qc_tp3' AS org_code_db
  FROM qc_tp.infogen_pet3
  INNER JOIN qc_tp.localis_pet3 on qc_tp.localis_pet3.id_pet_mes = qc_tp.infogen_pet3.id_pet_mes
  --LIMIT 100

  UNION ALL

  SELECT DISTINCT
    qc_tp.infogen_pet4.id_pet AS id,
    date_part('year'::text, qc_tp.infogen_pet4.date_sond::date) AS yr_measured,
    ST_X(qc_tp.localis_pet4.coord_geom) AS longitude,
    ST_Y(qc_tp.localis_pet4.coord_geom) AS latitude,
    'qc_tp4' AS org_code_db
  FROM qc_tp.infogen_pet4
  INNER JOIN qc_tp.localis_pet4 on qc_tp.localis_pet4.id_pet_mes = qc_tp.infogen_pet4.id_pet_mes
  --LIMIT 100

  UNION ALL

  -----------------------------------------------
  -- Permanent sample plot from New-Brunswick ---
  -----------------------------------------------

  SELECT DISTINCT
    nb_pp.psp_plots.plot AS id,
    nb_pp.psp_plots_yr.year AS yr_measured,
    ST_X(nb_pp.psp_plots.coord_geom) AS longitude,
    ST_Y(nb_pp.psp_plots.coord_geom) AS latitude,
    'nb_pp' AS org_code_db
  FROM nb_pp.psp_plots
  INNER JOIN nb_pp.psp_plots_yr ON nb_pp.psp_plots.plot = nb_pp.psp_plots_yr.plot
  --LIMIT 100

  UNION ALL

  -----------------------------------------------
  -- Permanent sample plot from Ontario       ---
  -----------------------------------------------

  -- Datum is different by year and from others databases

  SELECT DISTINCT
    on_pp.boreal_psp_treedbh_ht.plot_num AS id,
    on_pp.boreal_psp_treedbh_ht.obs_year,
    ST_X(on_pp.boreal_psp_plot_info.coord_geom) AS longitude,
    ST_Y(on_pp.boreal_psp_plot_info.coord_geom) AS latitude,
    'on_pp_boreal' AS org_code_db
    FROM on_pp.boreal_psp_treedbh_ht
    INNER JOIN on_pp.boreal_psp_plot_info ON on_pp.boreal_psp_treedbh_ht.plot_num = on_pp.boreal_psp_plot_info.plot_num

  UNION ALL

  SELECT DISTINCT
    on_pp.glsl_psp_trees_dbh_ht.plotname AS id,
    date_part('year'::text, on_pp.glsl_psp_trees_dbh_ht.msrdate::date) AS yr_measured,
    ST_X(on_pp.glsl_psp_plotinfo.coord_geom) AS longitude,
    ST_Y(on_pp.glsl_psp_plotinfo.coord_geom) AS latitude,
    'on_pp_glsl' AS org_code_db
    FROM on_pp.glsl_psp_trees_dbh_ht
    INNER JOIN on_pp.glsl_psp_plotinfo ON on_pp.glsl_psp_plotinfo.plotname = on_pp.glsl_psp_trees_dbh_ht.plotname


  UNION ALL

  SELECT DISTINCT
    on_pp.pgp_treedbh_ht.plot_num AS id,
    on_pp.pgp_treedbh_ht.obs_year,
    ST_X(on_pp.pgp_plot_info.coord_geom) AS longitude,
    ST_Y(on_pp.pgp_plot_info.coord_geom) AS latitude,
    'on_pp_pgp' AS org_code_db
    FROM on_pp.pgp_treedbh_ht
    INNER JOIN on_pp.pgp_plot_info ON on_pp.pgp_treedbh_ht.plot_num = on_pp.pgp_plot_info.plot_num


  -----------------------------------------------
  -- Permanent sample plot from FIA       ---
  -----------------------------------------------

  UNION ALL

  SELECT DISTINCT
  concat_ws('-',statecd,unitcd,countycd,plot)   AS id ,
    us_pp.plot.measyear,
    ST_X(us_pp.plot.coord_geom) AS longitude,
    ST_Y(us_pp.plot.coord_geom) AS latitude,
    'us_pp' AS org_code_db
  FROM us_pp.plot

    ) AS coords_all_plots
WHERE coords_all_plots.longitude <> 0 AND coords_all_plots.latitude <> 0;

