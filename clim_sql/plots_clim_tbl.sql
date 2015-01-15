DROP TABLE IF EXISTS rdb_quicc.clim;
CREATE TABLE rdb_quicc.clim AS (

SELECT plot_id, biovar, year_measured, year_clim, ST_Value(rast,coord_postgis,false) AS val

FROM
(

    SELECT DISTINCT plot_id, year_measured, ST_Transform(coord_postgis,4269) as coord_postgis
    FROM rdb_quicc.plot
    RIGHT JOIN rdb_quicc.localisation USING (plot_id)

) As plot_points,
(
    SELECT * FROM clim_rs.clim_allbiovars
) AS clim_rasters

WHERE year_clim <= year_measured AND year_clim > year_measured-15
AND ST_Intersects(rast,coord_postgis)
);

ALTER TABLE rdb_quicc.clim ADD CONSTRAINT clim_tbl_pk PRIMARY KEY(plot_id,biovar,year_measured);

CREATE INDEX idx_clim_pk ON rdb_quicc.clim
USING btree
(
  plot_id ASC NULLS LAST,
  biovar ASC NULLS LAST,
  year_measured ASC NULLS LAST,
  year_clim ASC NULLS LAST
);