-- QUERY DESCRIPTION:
------------------------
-- Visualize and validate the time interval covered by the climatic data 

-- By Steve Vissault

SELECT
  rdb_quicc.climatic_data.plot_id,
  rdb_quicc.plot.year_measured,
  max(rdb_quicc.climatic_data.year_clim),
  min(rdb_quicc.climatic_data.year_clim)
FROM
  rdb_quicc.climatic_data
LEFT JOIN rdb_quicc.plot ON rdb_quicc.climatic_data.plot_id = rdb_quicc.plot.plot_id
GROUP BY
  climatic_data.plot_id,
  rdb_quicc.plot.year_measured;