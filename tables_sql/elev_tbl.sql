----------------------------------------------------
----------------------------------------------------
----- Elevation in temp schema      -----
----------------------------------------------------
----------------------------------------------------

-- By Steve Vissault

-- Post-traitment: Import elevation table

CREATE TABLE IF NOT EXISTS temp_quicc.elev_tbl(
    org_plot_id char(20),
    longitude float,
    latitude float,
    elevation real);
