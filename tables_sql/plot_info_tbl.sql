--------------------------------------
---------------------------------------
--------  Plot info table ----------
---------------------------------------
---------------------------------------

-- Extract plot level information from original database
-- By Steve Vissault

-----------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE VIEW temp_quicc.mv_plot_info AS
---------------------------------------
------ QC_PP database
---------------------------------------

SELECT DISTINCT
    CAST(qc_pp.pp_infogen.id_pep AS character varying(30)) AS plot_id,
    'qc_pp' :: character varying(30) AS org_db_loc
FROM
    qc_pp.pp_infogen
INNER JOIN qc_pp.pp_localis on qc_pp.pp_localis.id_pep_mes = qc_pp.pp_infogen.id_pep_mes

---------------------------------------
------ QC_PT database
---------------------------------------

UNION ALL

SELECT DISTINCT
    CAST(qc_tp.infogen_pet2.id_pet AS character varying(30)) AS plot_id,
    'qc_tp2' :: character varying(30) AS org_db_loc
FROM
    qc_tp.infogen_pet2
INNER JOIN qc_tp.localis_pet2 on qc_tp.localis_pet2.id_pet_mes = qc_tp.infogen_pet2.id_pet_mes

UNION ALL

SELECT DISTINCT
    CAST(qc_tp.infogen_pet3.id_pet AS character varying(30)) AS plot_id,
    'qc_tp3' :: character varying(30) AS org_db_loc
FROM
    qc_tp.infogen_pet3
INNER JOIN qc_tp.localis_pet3 on qc_tp.localis_pet3.id_pet_mes = qc_tp.infogen_pet3.id_pet_mes

UNION ALL

SELECT DISTINCT
    CAST(qc_tp.infogen_pet4.id_pet AS character varying(30)) AS plot_id,
    'qc_tp4' :: character varying(30) AS org_db_loc
FROM
    qc_tp.infogen_pet4
INNER JOIN qc_tp.localis_pet4 on qc_tp.localis_pet4.id_pet_mes = qc_tp.infogen_pet4.id_pet_mes

---------------------------------------
------ NB_PP database
---------------------------------------

UNION ALL

SELECT DISTINCT
    CAST(nb_pp.psp_plots.plot AS character varying(30)) AS plot_id,
     temp_quicc.get_source_nb_db(nb_pp.psp_plots.plot) AS org_db_loc
FROM
    nb_pp.psp_plots

UNION ALL

---------------------------------------
------ ON_PP database
---------------------------------------

-----------------------------------------
-----------Ontario Boreal Plots----------
-----------------------------------------

SELECT DISTINCT
    CAST(concat_ws('-',boreal_psp_treedbh_ht.plot_num, boreal_psp_treedbh_ht.subplot_id) AS character varying(30)) AS plot_id,
    'on_pp_boreal' :: character varying(30) AS org_db_loc
FROM
    on_pp.boreal_psp_treedbh_ht

-----------------------------------------
------------Ontario GLSL Plots-----------
-----------------------------------------

UNION ALL

SELECT DISTINCT
    CAST(replace(concat_ws('-',glsl_psp_trees_dbh_ht.plotname,glsl_psp_trees_dbh_ht.gpnum), ' ', '') AS character varying(30)) AS plot_id,
    'on_pp_glsl' :: character varying(30) AS org_db_loc
FROM
    on_pp.glsl_psp_trees_dbh_ht

-----------------------------------------
-----------Ontario PGP Plots-------------
-----------------------------------------

UNION ALL

SELECT DISTINCT
    CAST(concat_ws('-',pgp_treedbh_ht.plot_num,pgp_treedbh_ht.subplot_id) AS character varying(30)) AS plot_id,
    'on_pp_pgp' :: character varying(30) AS org_db_loc
FROM
    on_pp.pgp_treedbh_ht

UNION ALL

---------------------------------------
------  FIA database
---------------------------------------

SELECT DISTINCT
    CAST(concat_ws('-',subplot.statecd,subplot.unitcd,subplot.countycd,subplot.plot,subplot.subp) AS character varying(30)) AS plot_id,
    'us_pp' :: character varying(30) AS org_db_loc
  FROM
    us_pp.plot
INNER JOIN us_pp.subplot ON concat_ws('-',plot.statecd,plot.unitcd,plot.countycd,plot.plot) = concat_ws('-',subplot.statecd,subplot.unitcd,subplot.countycd,subplot.plot)
WHERE (us_pp.plot.designcd = 1 OR 
    us_pp.plot.designcd = 314 OR us_pp.plot.designcd = 312 OR 
    us_pp.plot.designcd = 220 OR us_pp.plot.designcd = 240 OR
    us_pp.plot.designcd = 311 OR us_pp.plot.designcd = 313 OR
    us_pp.plot.designcd = 328 OR us_pp.plot.designcd = 502 OR
    us_pp.plot.designcd = 503 OR us_pp.plot.designcd = 504 OR
    us_pp.plot.designcd = 505) AND (us_pp.plot.kindcd > 0 AND us_pp.plot.kindcd < 4) AND 
    us_pp.plot.manual >= 1


UNION ALL
-----------------------------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------
------  DOMTAR database
---------------------------------------

SELECT DISTINCT
    CAST(domtar_pp.domtar_data.idpep AS character varying (30)) AS plot_id,
    'domtar_pp' :: character varying(30) AS org_db_loc
FROM
    domtar_pp.domtar_data;

--------------------------------------------------------
-- INSERT DATA INTO PLOT INFO TABLE ---
--------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------------------------

DELETE FROM rdb_quicc.plot_info;
INSERT INTO rdb_quicc.plot_info (org_plot_id,org_db_loc) SELECT plot_id, org_db_loc FROM temp_quicc.mv_plot_info WHERE plot_id IS NOT NULL AND org_db_loc IS NOT NULL;
REINDEX TABLE rdb_quicc.plot_info;

-----------------------------------------------------------------------------------------------------------------------------------------------------------