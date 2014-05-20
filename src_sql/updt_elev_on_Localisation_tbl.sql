SELECT
  rdb_quicc_df.plot_id,
  temp_quicc.elev_tbl.latitude,
  temp_quicc.elev_tbl.longitude,
  temp_quicc.elev_tbl.elevation
FROM
  temp_quicc.elev_tbl
INNER JOIN (
SELECT rdb_quicc.plot_info.plot_id, rdb_quicc.plot_info.org_db_id, rdb_quicc.localisation.longitude, rdb_quicc.localisation.latitude FROM rdb_quicc.plot_info
INNER JOIN rdb_quicc.localisation ON rdb_quicc.plot_info.plot_id = rdb_quicc.localisation.plot_id
) AS rdb_quicc_df
ON temp_quicc.elev_tbl.org_db_id = rdb_quicc_df.org_db_id
AND temp_quicc.elev_tbl.longitude = rdb_quicc_df.longitude
AND temp_quicc.elev_tbl.latitude = rdb_quicc_df.latitude
LIMIT 200
;