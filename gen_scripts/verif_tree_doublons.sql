-- QUERY DESCRIPTION:
------------------------
-- Check if any doublons are present in view "temp_quicc.mv_tree"

-- By Steve Vissault

SELECT DISTINCT * FROM (SELECT plot_id, tree_id, year_measured, species_code, source_db, count(*) AS rec 
	FROM temp_quicc.mv_tree 
GROUP BY  plot_id, tree_id, year_measured, source_db, species_code) AS subquery
WHERE rec>=2;
