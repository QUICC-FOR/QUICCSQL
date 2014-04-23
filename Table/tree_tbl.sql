-- Extract Tree level information from coarse data
-- By Steve Vissault

---------------------------------------
---------------------------------------
--------- Tree level -------------
---------------------------------------
---------------------------------------


---------------------------------------
-- Permanent sample plot from Quebec ---
---------------------------------------

DROP MATERIALIZED VIEW IF EXISTS temp_quicc.mv_tree;

CREATE MATERIALIZED VIEW temp_quicc.mv_tree AS

SELECT CAST(qc_pp.pp_infogen.id_pep AS char(10))  AS plot_id,
	CAST(qc_pp.pp_tiges.no_arbre AS integer) AS tree_id,
	CAST(date_part('year'::text, qc_pp.pp_infogen.date_sond::date) AS integer) AS year_measured,
	CAST(qc_pp.pp_tiges.essence AS char(10)) AS species_code,
	CAST(qc_pp.pp_etudarbr.hauteur AS integer) AS height,
	CAST(qc_pp.pp_tiges.dhpmm AS integer) AS dbh,
	CAST(qc_pp.pp_etudarbr.age AS char(5)) ,
	CAST(qc_pp.pp_etudarbr.ensoleil AS char(5)) AS sun_access,
	CAST(qc_pp.pp_etudarbr.etage AS char(5)) AS position_canopy,
	CAST(qc_pp.pp_etudarbr.source_age AS char(5)) AS age_id,
	0 :: boolean AS is_sapling,
	0 :: boolean AS is_planted,
	CAST(qc_pp.pp_tiges.etat AS char(5)) AS is_dead

FROM qc_pp.pp_infogen

LEFT OUTER JOIN qc_pp.pp_tiges ON qc_pp.pp_infogen.id_pep_mes = qc_pp.pp_tiges.id_pep_mes
LEFT OUTER JOIN qc_pp.pp_etudarbr ON qc_pp.pp_etudarbr.id_pep_mes = qc_pp.pp_tiges.id_pep_mes AND qc_pp.pp_etudarbr.no_arbre = qc_pp.pp_tiges.no_arbre AND qc_pp.pp_etudarbr.essence = qc_pp.pp_tiges.essence

-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200

UNION ALL

---------------------------------------
-- Temporary sample plot from Quebec ---
---------------------------------------

SELECT CAST(qc_tp.infogen_pet2.id_pet AS char(10)) AS plot_id,
	CAST(qc_tp.etudarbr_pet2.no_arbre AS integer) AS tree_id,
	CAST(date_part('year'::text, infogen_pet2.date_sond::date) AS integer) AS year_measured,
	CAST(qc_tp.etudarbr_pet2.essence AS char(10)) AS species_code,
	CAST(qc_tp.etudarbr_pet2.hauteur AS integer) AS height,
	CAST(qc_tp.etudarbr_pet2.dhpmm AS integer) AS dbh,
	CAST(qc_tp.etudarbr_pet2.age AS char(5)),
	NULL :: char(5) AS sun_access,
	CAST(qc_tp.etudarbr_pet2.etage AS char(5)) AS position_canopy,
	CAST(qc_tp.etudarbr_pet2.source_age AS char(5)) AS age_id,
	0 :: boolean AS is_sapling,
    	0 :: boolean AS is_planted,
    	NULL :: boolean AS is_dead
FROM qc_tp.etudarbr_pet2 LEFT OUTER JOIN qc_tp.infogen_pet2 ON qc_tp.etudarbr_pet2.id_pet_mes = qc_tp.infogen_pet2.id_pet_mes

-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200


UNION ALL

SELECT CAST(qc_tp.infogen_pet3.id_pet AS char(10)) AS plot_id,
	CAST(qc_tp.etudarbr_pet3.no_arbre AS integer) AS tree_id,
	CAST(date_part('year'::text, infogen_pet3.date_sond::date) AS integer) AS year_measured,
	CAST(qc_tp.etudarbr_pet3.essence AS char(10)) AS species_code,
	CAST(qc_tp.etudarbr_pet3.hauteur AS integer) AS height,
	CAST(qc_tp.etudarbr_pet3.dhpmm AS integer) AS dbh,
	CAST(qc_tp.etudarbr_pet3.age AS char(5)),
	NULL :: char(5) AS sun_access,
	CAST(qc_tp.etudarbr_pet3.etage AS char(5)) AS position_canopy,
	CAST(qc_tp.etudarbr_pet3.source_age AS char(5)) AS age_id,
	0 :: boolean AS is_sapling,
    	0 :: boolean AS is_planted,
    	NULL :: boolean AS is_dead
FROM qc_tp.etudarbr_pet3 LEFT OUTER JOIN qc_tp.infogen_pet3 ON qc_tp.etudarbr_pet3.id_pet_mes = qc_tp.infogen_pet3.id_pet_mes

;

CREATE MATERIALIZED VIEW qc_tp.mvqc_tp_ree AS
SELECT qc_tp.infogen_pet4."ID_PET",
	date_part('year'::text, "INFOGEN_PET4"."DATE_SOND"::date) AS yr_measured,
	qc_tp.etudarbr_pet4."NO_ARBRE",
	qc_tp.etudarbr_pet4."ESSENCE",
	qc_tp.etudarbr_pet4."HAUTEUR",
	qc_tp.etudarbr_pet4."DHPMM",
	qc_tp.etudarbr_pet4."ETAGE",
	qc_tp.etudarbr_pet4."AGE",
	qc_tp.etudarbr_pet4."SOURCE_AGE"
FROM qc_tp.etudarbr_pet4 LEFT OUTER JOIN qc_tp.infogen_pet4 ON qc_tp.etudarbr_pet4."ID_PET_MES" = qc_tp.infogen_pet4."ID_PET_MES"
ORDER BY
	qc_tp.infogen_pet4."ID_PET" ASC,
	yr_measured ASC,
	qc_tp.etudarbr_pet4."NO_ARBRE" ASC
-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200
;

-----------------------------------------------
-- Permenent sample plot from New-Brunswick ---
-----------------------------------------------

DROP MATERIALIZED VIEW IF EXISTS "NB"."MV_NB_PartialCut_Tree";

CREATE MATERIALIZED VIEW "NB"."MV_NB_PartialCut_Tree" AS
SELECT "NB"."PSP_PLOTS_YR"."Plot",
	"NB"."PSP_PLOTS_YR"."Year",
	"NB"."PSP_TREE_PartialCut".treenum,
	"NB"."PSP_TREE_PartialCut".species,
	"NB"."PSP_TREE_PartialCut"."totalHt",
	"NB"."PSP_TREE_PartialCut".dbh
FROM "NB"."PSP_PLOTS_YR" INNER JOIN "NB"."PSP_TREE_PartialCut" ON "NB"."PSP_PLOTS_YR"."RemeasID" = "NB"."PSP_TREE_PartialCut"."RemeasID"
ORDER BY
	"NB"."PSP_PLOTS_YR"."Plot" ASC,
	"NB"."PSP_PLOTS_YR"."Year" ASC,
	"NB"."PSP_TREE_PartialCut".treenum ASC
-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200
;

DROP MATERIALIZED VIEW IF EXISTS "NB"."MV_NB_YIMO_Tree";

CREATE MATERIALIZED VIEW "NB"."MV_NB_YIMO_Tree" AS
SELECT "NB"."PSP_PLOTS_YR"."Plot",
	"NB"."PSP_PLOTS_YR"."Year",
	"NB"."PSP_TREE_YIMO".treenum,
	"NB"."PSP_TREE_YIMO".species,
	"NB"."PSP_TREE_YIMO".dbh,
	"NB"."PSP_TREE_YIMO".agecl,
	"NB"."PSP_TREE_YIMO".lat
FROM "NB"."PSP_PLOTS_YR" INNER JOIN "NB"."PSP_TREE_YIMO" ON "NB"."PSP_PLOTS_YR"."RemeasID" = "NB"."PSP_TREE_YIMO"."RemeasID"
ORDER BY
	"NB"."PSP_PLOTS_YR"."Plot" ASC,
	"NB"."PSP_PLOTS_YR"."Year" ASC,
	"NB"."PSP_TREE_YIMO".treenum ASC
-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200
;

DROP MATERIALIZED VIEW IF EXISTS "NB"."MV_NB_RegenThin_Tree";

CREATE MATERIALIZED VIEW "NB"."MV_NB_RegenThin_Tree" AS
SELECT "NB"."PSP_PLOTS_YR"."Plot",
	"NB"."PSP_PLOTS_YR"."Year",
	"NB"."PSP_TREE_RegenAndThin".treenum,
	"NB"."PSP_TREE_RegenAndThin".species,
	"NB"."PSP_TREE_RegenAndThin".hgt,
	"NB"."PSP_TREE_RegenAndThin".dbh,
	"NB"."PSP_TREE_RegenAndThin".origin
FROM "NB"."PSP_PLOTS_YR" INNER JOIN "NB"."PSP_TREE_RegenAndThin" ON "NB"."PSP_PLOTS_YR"."RemeasID" = "NB"."PSP_TREE_RegenAndThin"."RemeasID"
ORDER BY
	"NB"."PSP_PLOTS_YR"."Plot" ASC,
	"NB"."PSP_PLOTS_YR"."Year" ASC,
	"NB"."PSP_TREE_RegenAndThin".treenum ASC
-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200
;

DROP MATERIALIZED VIEW IF EXISTS "NB"."MV_NB_CutPlant_Tree";

CREATE MATERIALIZED VIEW "NB"."MV_NB_CutPlant_Tree" AS
SELECT "NB"."PSP_PLOTS_YR"."Plot",
	"NB"."PSP_PLOTS_YR"."Year",
	"NB"."PSP_TREE_CutAndPlant".treenum,
	"NB"."PSP_TREE_CutAndPlant".species,
	"NB"."PSP_TREE_CutAndPlant".hgt,
	"NB"."PSP_TREE_CutAndPlant".dbh,
	"NB"."PSP_TREE_CutAndPlant".origin,
	"NB"."PSP_TREE_CutAndPlant".survival
FROM "NB"."PSP_PLOTS_YR" INNER JOIN "NB"."PSP_TREE_CutAndPlant" ON "NB"."PSP_PLOTS_YR"."RemeasID" = "NB"."PSP_TREE_CutAndPlant"."RemeasID"
ORDER BY
	"NB"."PSP_PLOTS_YR"."Plot" ASC,
	"NB"."PSP_PLOTS_YR"."Year" ASC,
	"NB"."PSP_TREE_CutAndPlant".treenum ASC
-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200
;

-----------------------------------------
-- Permenent sample plot from Ontario ---
-----------------------------------------