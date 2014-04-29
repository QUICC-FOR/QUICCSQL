----------------------------------------------------
----------------------------------------------------
-------------- Localisation table -------------
----------------------------------------------------
----------------------------------------------------

-- Extract and remove doublons on plot location from original database
-- By Steve Vissault

DROP MATERIALIZED VIEW IF EXISTS  temp_quicc.mv_localisation;
CREATE MATERIALIZED VIEW temp_quicc.mv_localisation AS

SELECT DISTINCT org_plot_id, max(yr_measured) AS yr_measured, longitude,latitude,srid,coord_geom,org_code_db
-- SECOND QUERY - remove all doublons on location plots
FROM
(
				-- FIRST QUERY - get all coarse location plots
				---------------------------------------
				-- Permanent sample plot from Quebec ---
				---------------------------------------

					SELECT DISTINCT
						qc_pp.pp_infogen.id_pep AS org_plot_id,
						date_part('year'::text, qc_pp.pp_infogen.date_sond::date) AS yr_measured,
						ST_X(qc_pp.pp_localis.coord_geom) AS longitude,
						ST_Y(qc_pp.pp_localis.coord_geom) AS latitude,
						ST_SRID(qc_pp.pp_localis.coord_geom) AS srid,
						qc_pp.pp_localis.coord_geom,
						'qc_pp' AS org_code_db
					FROM qc_pp.pp_infogen
					INNER JOIN qc_pp.pp_localis on qc_pp.pp_localis.id_pep_mes = qc_pp.pp_infogen.id_pep_mes
					-- LIMIT 100

					UNION ALL

					---------------------------------------
					-- Temporary sample plot from Quebec ---
					---------------------------------------

					SELECT DISTINCT
						qc_tp.infogen_pet2.id_pet AS org_plot_id,
						date_part('year'::text, qc_tp.infogen_pet2.date_sond::date) AS yr_measured,
						ST_X(qc_tp.localis_pet2.coord_geom) AS longitude,
						ST_Y(qc_tp.localis_pet2.coord_geom) AS latitude,
						ST_SRID(qc_tp.localis_pet2.coord_geom) AS srid,
						qc_tp.localis_pet2.coord_geom,
						'qc_tp2' AS org_code_db
					FROM qc_tp.infogen_pet2
					INNER JOIN qc_tp.localis_pet2 on qc_tp.localis_pet2.id_pet_mes = qc_tp.infogen_pet2.id_pet_mes
					--LIMIT 100


					UNION ALL

					SELECT DISTINCT
						qc_tp.infogen_pet3.id_pet AS org_plot_id,
						date_part('year'::text, qc_tp.infogen_pet3.date_sond::date) AS yr_measured,
						ST_X(qc_tp.localis_pet3.coord_geom) AS longitude,
						ST_Y(qc_tp.localis_pet3.coord_geom) AS latitude,
						ST_SRID(qc_tp.localis_pet3.coord_geom) AS srid,
						qc_tp.localis_pet3.coord_geom,
						'qc_tp3' AS org_code_db
					FROM qc_tp.infogen_pet3
					INNER JOIN qc_tp.localis_pet3 on qc_tp.localis_pet3.id_pet_mes = qc_tp.infogen_pet3.id_pet_mes
					--LIMIT 100

					UNION ALL

					SELECT DISTINCT
						qc_tp.infogen_pet4.id_pet AS org_plot_id,
						date_part('year'::text, qc_tp.infogen_pet4.date_sond::date) AS yr_measured,
						ST_X(qc_tp.localis_pet4.coord_geom) AS longitude,
						ST_Y(qc_tp.localis_pet4.coord_geom) AS latitude,
						ST_SRID(qc_tp.localis_pet4.coord_geom) AS srid,
						qc_tp.localis_pet4.coord_geom,
						'qc_tp4' AS org_code_db
					FROM qc_tp.infogen_pet4
					INNER JOIN qc_tp.localis_pet4 on qc_tp.localis_pet4.id_pet_mes = qc_tp.infogen_pet4.id_pet_mes
					--LIMIT 100

					UNION ALL

					-----------------------------------------------
					-- Permanent sample plot from New-Brunswick ---
					-----------------------------------------------

					SELECT DISTINCT
						nb_pp.psp_plots.plot AS org_plot_id,
						nb_pp.psp_plots_yr.year AS yr_measured,
						ST_X(nb_pp.psp_plots.coord_geom) AS longitude,
						ST_Y(nb_pp.psp_plots.coord_geom) AS latitude,
						ST_SRID(nb_pp.psp_plots.coord_geom) AS srid,
						nb_pp.psp_plots.coord_geom,
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
						on_pp.boreal_psp_treedbh_ht.plot_num AS org_plot_id,
						on_pp.boreal_psp_treedbh_ht.obs_year,
						ST_X(on_pp.boreal_psp_plot_info.coord_geom) AS longitude,
						ST_Y(on_pp.boreal_psp_plot_info.coord_geom) AS latitude,
						ST_SRID(on_pp.boreal_psp_plot_info.coord_geom) AS srid,
						on_pp.boreal_psp_plot_info.coord_geom,
						'on_pp_boreal' AS org_code_db
						FROM on_pp.boreal_psp_treedbh_ht
						INNER JOIN on_pp.boreal_psp_plot_info ON on_pp.boreal_psp_treedbh_ht.plot_num = on_pp.boreal_psp_plot_info.plot_num

					UNION ALL

					SELECT DISTINCT
						on_pp.glsl_psp_trees_dbh_ht.plotname AS org_plot_id,
						date_part('year'::text, on_pp.glsl_psp_trees_dbh_ht.msrdate::date) AS yr_measured,
						ST_X(on_pp.glsl_psp_plotinfo.coord_geom) AS longitude,
						ST_Y(on_pp.glsl_psp_plotinfo.coord_geom) AS latitude,
						ST_SRID(on_pp.glsl_psp_plotinfo.coord_geom) AS srid,
						on_pp.glsl_psp_plotinfo.coord_geom,
						'on_pp_glsl' AS org_code_db
						FROM on_pp.glsl_psp_trees_dbh_ht
						INNER JOIN on_pp.glsl_psp_plotinfo ON on_pp.glsl_psp_plotinfo.plotname = on_pp.glsl_psp_trees_dbh_ht.plotname


					UNION ALL

					SELECT DISTINCT
						on_pp.pgp_treedbh_ht.plot_num AS org_plot_id,
						on_pp.pgp_treedbh_ht.obs_year AS yr_measured,
						ST_X(on_pp.pgp_plot_info.coord_geom) AS longitude,
						ST_Y(on_pp.pgp_plot_info.coord_geom) AS latitude,
						ST_SRID(on_pp.pgp_plot_info.coord_geom) AS srid,
						on_pp.pgp_plot_info.coord_geom,
						'on_pp_pgp' AS org_code_db
						FROM on_pp.pgp_treedbh_ht
						INNER JOIN on_pp.pgp_plot_info ON on_pp.pgp_treedbh_ht.plot_num = on_pp.pgp_plot_info.plot_num


					-----------------------------------------------
					-- Permanent sample plot from FIA       ---
					-----------------------------------------------

					UNION ALL

					SELECT DISTINCT
						concat_ws('-',statecd,unitcd,countycd,plot) AS org_plot_id,
						us_pp.plot.measyear AS yr_measured,
						ST_X(us_pp.plot.coord_geom) AS longitude,
						ST_Y(us_pp.plot.coord_geom) AS latitude,
						ST_SRID(us_pp.plot.coord_geom) AS srid,
						us_pp.plot.coord_geom,
						'us_pp' AS org_code_db
					FROM us_pp.plot
) AS all_locations
WHERE
		latitude IS NOT NULL AND  longitude IS NOT NULL
		AND latitude <> 0 AND longitude <> 0
GROUP BY
		org_plot_id,
		longitude,
		latitude,
		srid,
		coord_geom,
		org_code_db;

--------------------------------------------------------------------------------------------------------------------------------------
--- Query on MV in order to validate if any doublons are present
--------------------------------------------------------------------------------------------------------------------------------------

SELECT temp_quicc.mv_localisation.org_plot_id,
		count(temp_quicc.mv_localisation.org_plot_id),
		temp_quicc.mv_localisation.org_code_db,
		temp_quicc.mv_localisation.latitude,
		temp_quicc.mv_localisation.longitude,
		temp_quicc.mv_localisation.yr_measured
FROM temp_quicc.mv_localisation
GROUP BY
		temp_quicc.mv_localisation.org_plot_id,
		temp_quicc.mv_localisation.org_code_db,
		temp_quicc.mv_localisation.latitude,
		temp_quicc.mv_localisation.longitude,
		temp_quicc.mv_localisation.yr_measured
HAVING count(temp_quicc.mv_localisation.org_plot_id)>1;

-----------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------
-- INSERT DATA INTO LOCALISATION TABLE ---
--------------------------------------------------------
-- Dependancies:
	-- Plot info table need to be already created and inserted
	-- Climatic_data table  need to be already created and inserted
-----------------------------------------------------------------------------------------------------------------------------------------------------------

DELETE

INSERT INTO rdb_quicc.plot_localisation
SELECT rdb_quicc.plot_info.plot_id,
		temp_quicc.mv_localisation.latitude,
		temp_quicc.mv_localisation.longitude,
		temp_quicc.mv_localisation.coord_geom AS coord_postgis,
		temp_quicc.mv_localisation.srid,
		rdb_quicc.climatic_data.z_elevation AS elevation,
		temp_quicc.mv_localisation.org_code_db AS plot_location
FROM temp_quicc.mv_localisation
RIGHT JOIN rdb_quicc.plot_info ON temp_quicc.mv_localisation.org_plot_id = rdb_quicc.plot_info.org_db_id
RIGHT JOIN rdb_quicc.climatic_data ON temp_quicc.mv_localisation.org_plot_id = rdb_quicc.climatic_data.id_plot
LIMIT 200;