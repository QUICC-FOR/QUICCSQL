UPDATE rdb_quicc.localisation
SET elevation = temp_quicc.elev_tbl.elevation
FROM temp_quicc.elev_tbl
WHERE
 temp_quicc.elev_tbl.longitude =  rdb_quicc.localisation.longitude
AND temp_quicc.elev_tbl.latitude =  rdb_quicc.localisation.latitude;