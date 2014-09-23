-- QUERY DESCRIPTION:
------------------------
-- Queries deleting doublons in the Ontario databases

-- By Steve Vissault


----------------------------
------      PGP       -----
----------------------------

DELETE FROM on_pp.pgp_plot_info WHERE ctid NOT IN
(SELECT max(ctid) FROM on_pp.pgp_plot_info GROUP BY on_pp.pgp_plot_info.*);

DELETE FROM on_pp.pgp_treedbh_ht WHERE ctid NOT IN
(SELECT max(ctid) FROM on_pp.pgp_treedbh_ht GROUP BY on_pp.pgp_treedbh_ht.*);

DELETE FROM on_pp.pgp_plot_soils WHERE ctid NOT IN
(SELECT max(ctid) FROM on_pp.pgp_plot_soils GROUP BY on_pp.pgp_plot_soils.*);


----------------------------
------      Boreal       -----
----------------------------

DELETE FROM on_pp.boral_psp_plot_info WHERE ctid NOT IN
(SELECT max(ctid) FROM on_pp.boral_psp_plot_info GROUP BY on_pp.boral_psp_plot_info.*);

DELETE FROM on_pp.boral_psp_plot_sizes WHERE ctid NOT IN
(SELECT max(ctid) FROM on_pp.boral_psp_plot_sizes GROUP BY on_pp.boral_psp_plot_sizes.*);

DELETE FROM on_pp.boral_psp_plot_soils WHERE ctid NOT IN
(SELECT max(ctid) FROM on_pp.boral_psp_plot_soils GROUP BY on_pp.boral_psp_plot_soils.*);

DELETE FROM on_pp.boral_psp_plot_treedbh_ht WHERE ctid NOT IN
(SELECT max(ctid) FROM on_pp.boral_psp_plot_treedbh_ht GROUP BY on_pp.boral_psp_plot_treedbh_ht.*);


----------------------------
------      GLSL       -----
----------------------------

DELETE FROM on_pp.glsl_psp_plotinfo WHERE ctid NOT IN
(SELECT max(ctid) FROM on_pp.glsl_psp_plotinfo GROUP BY on_pp.glsl_psp_plotinfo.*);

DELETE FROM on_pp.glsl_psp_plotsize WHERE ctid NOT IN
(SELECT max(ctid) FROM on_pp.glsl_psp_plotsize GROUP BY on_pp.glsl_psp_plotsize.*);

DELETE FROM on_pp.glsl_psp_soils WHERE ctid NOT IN
(SELECT max(ctid) FROM on_pp.glsl_psp_soils GROUP BY on_pp.glsl_psp_soils.*);

DELETE FROM on_pp.glsl_psp_trees_dbh_ht WHERE ctid NOT IN
(SELECT max(ctid) FROM on_pp.glsl_psp_trees_dbh_ht GROUP BY on_pp.glsl_psp_trees_dbh_ht.*);

