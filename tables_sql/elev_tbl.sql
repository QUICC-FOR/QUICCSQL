----------------------------------------------------
----------------------------------------------------
----- Elevation in temp schema      -----
----------------------------------------------------
----------------------------------------------------

-- By Steve Vissault

-- Post-traitment: Import elevation table

-- DROP TABLE temp_quicc.elev_tbl;
CREATE OR REPLACE TABLE IF NOT EXISTS temp_quicc.elev_tbl(
    org_db_id char(20),
    longitude float,
    latitude float,
    elevation real);
