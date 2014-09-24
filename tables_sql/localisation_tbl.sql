----------------------------------------------------
----------------------------------------------------
-------------- Localisation table -------------
----------------------------------------------------
----------------------------------------------------

-- Extract and remove doublons on plot location from original database
-- By Steve Vissault

CREATE OR REPLACE VIEW temp_quicc.mv_localisation AS

SELECT org_plot_id, max(coord_geom) AS coord_geom ,org_code_db FROM (
SELECT org_plot_id, max(yr_measured) AS yr_measured, coord_geom,org_code_db
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
				qc_pp.pp_localis.coord_geom,
				'qc_pp' AS org_code_db
			FROM qc_pp.pp_infogen
			INNER JOIN qc_pp.pp_localis on qc_pp.pp_localis.id_pep_mes = qc_pp.pp_infogen.id_pep_mes
			-- LIMIT 100

			UNION ALL
			
			---------------------------------------
			-- Temporary sample plots from Quebec ---
			---------------------------------------

			SELECT DISTINCT
				qc_tp.infogen_pet2.id_pet AS org_plot_id,
				date_part('year'::text, qc_tp.infogen_pet2.date_sond::date) AS yr_measured,
				qc_tp.localis_pet2.coord_geom,
				'qc_tp2' AS org_code_db
			FROM qc_tp.infogen_pet2
			INNER JOIN qc_tp.localis_pet2 on qc_tp.localis_pet2.id_pet_mes = qc_tp.infogen_pet2.id_pet_mes
			--LIMIT 100
			
			UNION ALL
			
			SELECT DISTINCT
				qc_tp.infogen_pet3.id_pet AS org_plot_id,
				date_part('year'::text, qc_tp.infogen_pet3.date_sond::date) AS yr_measured,
				qc_tp.localis_pet3.coord_geom,
				'qc_tp3' AS org_code_db
			FROM qc_tp.infogen_pet3
			INNER JOIN qc_tp.localis_pet3 on qc_tp.localis_pet3.id_pet_mes = qc_tp.infogen_pet3.id_pet_mes
			--LIMIT 100
			
			UNION ALL

			SELECT DISTINCT
				qc_tp.infogen_pet4.id_pet AS org_plot_id,
				date_part('year'::text, qc_tp.infogen_pet4.date_sond::date) AS yr_measured,
				qc_tp.localis_pet4.coord_geom,
				'qc_tp4' AS org_code_db
			FROM qc_tp.infogen_pet4
			INNER JOIN qc_tp.localis_pet4 on qc_tp.localis_pet4.id_pet_mes = qc_tp.infogen_pet4.id_pet_mes
			--LIMIT 100
			
			UNION ALL

			-----------------------------------------------
			-- Permanent sample plots from New-Brunswick ---
			-----------------------------------------------
			SELECT DISTINCT
				nb_pp.psp_plots.plot AS org_plot_id,
				nb_pp.psp_plots_yr.year AS yr_measured,
				nb_pp.psp_plots.coord_geom,
				 temp_quicc.get_source_nb_db(nb_pp.psp_plots.plot) AS org_code_db
			FROM nb_pp.psp_plots
			INNER JOIN nb_pp.psp_plots_yr ON nb_pp.psp_plots.plot = nb_pp.psp_plots_yr.plot
			--LIMIT 100
			
			UNION ALL

			-----------------------------------------------
			-- Permanent sample plots from Ontario       ---
			-----------------------------------------------
			
			SELECT DISTINCT
				CAST(concat_ws('-',boreal_psp_treedbh_ht.plot_num, boreal_psp_treedbh_ht.subplot_id) AS char(20)) AS plot_id,
				on_pp.boreal_psp_treedbh_ht.obs_year,
				on_pp.boreal_psp_plot_info.coord_geom,
				'on_pp_boreal' AS org_code_db
				FROM on_pp.boreal_psp_treedbh_ht
				INNER JOIN on_pp.boreal_psp_plot_info ON on_pp.boreal_psp_treedbh_ht.plot_num = on_pp.boreal_psp_plot_info.plot_num
			
			UNION ALL

			SELECT DISTINCT
				CAST(replace(concat_ws('-',glsl_psp_trees_dbh_ht.plotname,glsl_psp_trees_dbh_ht.gpnum), ' ', '') AS char(20)) AS plot_id,
				date_part('year'::text, on_pp.glsl_psp_trees_dbh_ht.msrdate::date) AS yr_measured,
				on_pp.glsl_psp_plotinfo.coord_geom,
				'on_pp_glsl' AS org_code_db
				FROM on_pp.glsl_psp_trees_dbh_ht
				INNER JOIN on_pp.glsl_psp_plotinfo ON on_pp.glsl_psp_plotinfo.plotname = on_pp.glsl_psp_trees_dbh_ht.plotname
			
			UNION ALL

			SELECT DISTINCT
				CAST(concat_ws('-',pgp_treedbh_ht.plot_num,pgp_treedbh_ht.subplot_id) AS char(20)) AS plot_id,
				on_pp.pgp_treedbh_ht.obs_year AS yr_measured,
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
				us_pp.plot.coord_geom,
				'us_pp' AS org_code_db
			FROM us_pp.plot

			-----------------------------------------------
			-- 	DOMTAR   	             ---
			-----------------------------------------------
			
			UNION ALL

			SELECT DISTINCT
				domtar_pp.domtar_data.idpep AS org_plot_id,
				CAST(domtar_pp.domtar_data.annee_corrigee AS integer) AS yr_measured,
				domtar_pp.domtar_data.coord_geom,
				'domtar_pp' AS org_code_db
			FROM domtar_pp.domtar_data
) AS all_locations
WHERE
		coord_geom IS NOT NULL
GROUP BY
		org_plot_id,
		coord_geom,
		org_code_db) AS max_all_locations
GROUP BY
	org_plot_id,
	org_code_db;
--------------------------------------------------------------------------------------------------------------------------------------
--- Query on MV in order to validate if any doublons are present
--------------------------------------------------------------------------------------------------------------------------------------
--- SELECT temp_quicc.mv_localisation.org_plot_id,
--- 		count(temp_quicc.mv_localisation.org_plot_id),
--- 		temp_quicc.mv_localisation.org_code_db,
--- 		temp_quicc.mv_localisation.latitude,
--- 		temp_quicc.mv_localisation.longitude
--- FROM temp_quicc.mv_localisation
--- GROUP BY
--- 		temp_quicc.mv_localisation.org_plot_id,
--- 		temp_quicc.mv_localisation.org_code_db,
--- 		temp_quicc.mv_localisation.latitude,
--- 		temp_quicc.mv_localisation.longitude
--- HAVING count(temp_quicc.mv_localisation.org_plot_id)>1;

-----------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------
-- INSERT DATA INTO LOCALISATION TABLE ---
--------------------------------------------------------
-- Dependancies:
	-- Plot info table need to be already created and inserted
	-- Climatic_data table  need to be already created and inserted
-----------------------------------------------------------------------------------------------------------------------------------------------------------

DELETE FROM rdb_quicc.localisation;

INSERT INTO rdb_quicc.localisation (plot_id, latitude, longitude, coord_postgis, srid,plot_location)
SELECT DISTINCT rdb_quicc.plot_info.plot_id,
		ST_Y(temp_quicc.mv_localisation.coord_geom) AS latitude,
		ST_X(temp_quicc.mv_localisation.coord_geom)  AS longitude,
		temp_quicc.mv_localisation.coord_geom AS coord_postgis,
		ST_SRID(temp_quicc.mv_localisation.coord_geom)  AS srid,
		temp_quicc.mv_localisation.org_code_db AS plot_location
FROM temp_quicc.mv_localisation
RIGHT OUTER JOIN rdb_quicc.plot_info ON temp_quicc.mv_localisation.org_plot_id = rdb_quicc.plot_info.org_db_id AND temp_quicc.mv_localisation.org_code_db = rdb_quicc.plot_info.org_db_loc
WHERE ST_Y(temp_quicc.mv_localisation.coord_geom) IS NOT NULL AND ST_Y(temp_quicc.mv_localisation.coord_geom) = 0 
AND ST_X(temp_quicc.mv_localisation.coord_geom) IS NOT NULL AND ST_X(temp_quicc.mv_localisation.coord_geom) = 0;
REINDEX TABLE rdb_quicc.localisation;