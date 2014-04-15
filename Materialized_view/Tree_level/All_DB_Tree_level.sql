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

DROP MATERIALIZED VIEW IF EXISTS "QC_PEP"."MV_QC_PEP_Tree";

CREATE MATERIALIZED VIEW "QC_PEP"."MV_QC_PEP_Tree" AS
SELECT "QC_PEP"."PP_INFOGEN"."ID_PEP", 
date_part('year'::text, "QC_PEP"."PP_INFOGEN"."DATE_SOND"::date) AS yr_measured,
	"QC_PEP"."PP_TIGES"."NO_ARBRE", 
	"QC_PEP"."PP_TIGES"."ESSENCE", 
	"QC_PEP"."PP_ETUDARBR"."HAUTEUR", 
	"QC_PEP"."PP_TIGES"."DHPMM", 
	"QC_PEP"."PP_ETUDARBR"."ENSOLEIL", 
	"QC_PEP"."PP_ETUDARBR"."ETAGE", 
	"QC_PEP"."PP_ETUDARBR"."AGE", 
	"QC_PEP"."PP_ETUDARBR"."SOURCE_AGE", 
	"QC_PEP"."PP_TIGES"."ETAT"
FROM "QC_PEP"."PP_INFOGEN" LEFT OUTER JOIN "QC_PEP"."PP_TIGES" ON "QC_PEP"."PP_INFOGEN"."ID_PEP_MES" = "QC_PEP"."PP_TIGES"."ID_PEP_MES"
	 LEFT OUTER JOIN "QC_PEP"."PP_ETUDARBR" ON "QC_PEP"."PP_ETUDARBR"."ID_PEP_MES" = "QC_PEP"."PP_TIGES"."ID_PEP_MES" AND "QC_PEP"."PP_ETUDARBR"."NO_ARBRE" = "QC_PEP"."PP_TIGES"."NO_ARBRE" AND "QC_PEP"."PP_ETUDARBR"."ESSENCE" = "QC_PEP"."PP_TIGES"."ESSENCE"
ORDER BY "QC_PEP"."PP_INFOGEN"."ID_PEP" ASC,
	yr_measured ASC,
	"QC_PEP"."PP_TIGES"."NO_ARBRE" ASC
-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200
;

---------------------------------------
-- Temporary sample plot from Quebec ---
---------------------------------------

DROP MATERIALIZED VIEW IF EXISTS "QC_PET"."MV_QC_PET2_Tree";

CREATE MATERIALIZED VIEW "QC_PET"."MV_QC_PET2_Tree" AS
SELECT "QC_PET"."INFOGEN_PET2"."ID_PET", 
	date_part('year'::text, "INFOGEN_PET2"."DATE_SOND"::date) AS yr_measured,
	"QC_PET"."ETUDARBR_PET2"."NO_ARBRE",
	"QC_PET"."ETUDARBR_PET2"."ESSENCE", 
	"QC_PET"."ETUDARBR_PET2"."HAUTEUR", 
	"QC_PET"."ETUDARBR_PET2"."DHPMM", 
	"QC_PET"."ETUDARBR_PET2"."ETAGE", 
	"QC_PET"."ETUDARBR_PET2"."AGE", 
	"QC_PET"."ETUDARBR_PET2"."SOURCE_AGE"
FROM "QC_PET"."ETUDARBR_PET2" LEFT OUTER JOIN "QC_PET"."INFOGEN_PET2" ON "QC_PET"."ETUDARBR_PET2"."ID_PET_MES" = "QC_PET"."INFOGEN_PET2"."ID_PET_MES"
ORDER BY 
	"QC_PET"."INFOGEN_PET2"."ID_PET" ASC, 
	yr_measured ASC,
	"QC_PET"."ETUDARBR_PET2"."NO_ARBRE" ASC
-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200
;

DROP MATERIALIZED VIEW IF EXISTS "QC_PET"."MV_QC_PET3_Tree";

CREATE MATERIALIZED VIEW "QC_PET"."MV_QC_PET3_Tree" AS
SELECT "QC_PET"."INFOGEN_PET3"."ID_PET", 
	date_part('year'::text, "INFOGEN_PET3"."DATE_SOND"::date) AS yr_measured,
	"QC_PET"."ETUDARBR_PET3"."NO_ARBRE",
	"QC_PET"."ETUDARBR_PET3"."ESSENCE", 
	"QC_PET"."ETUDARBR_PET3"."HAUTEUR", 
	"QC_PET"."ETUDARBR_PET3"."DHPMM", 
	"QC_PET"."ETUDARBR_PET3"."ETAGE", 
	"QC_PET"."ETUDARBR_PET3"."AGE", 
	"QC_PET"."ETUDARBR_PET3"."SOURCE_AGE"
FROM "QC_PET"."ETUDARBR_PET3" LEFT OUTER JOIN "QC_PET"."INFOGEN_PET3" ON "QC_PET"."ETUDARBR_PET3"."ID_PET_MES" = "QC_PET"."INFOGEN_PET3"."ID_PET_MES"
ORDER BY 
	"QC_PET"."INFOGEN_PET3"."ID_PET" ASC,
	yr_measured ASC,
	"QC_PET"."ETUDARBR_PET3"."NO_ARBRE" ASC
-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200
;

DROP MATERIALIZED VIEW IF EXISTS "QC_PET"."MV_QC_PET4_Tree";

CREATE MATERIALIZED VIEW "QC_PET"."MV_QC_PET4_Tree" AS
SELECT "QC_PET"."INFOGEN_PET4"."ID_PET", 
	date_part('year'::text, "INFOGEN_PET4"."DATE_SOND"::date) AS yr_measured,
	"QC_PET"."ETUDARBR_PET4"."NO_ARBRE",
	"QC_PET"."ETUDARBR_PET4"."ESSENCE", 
	"QC_PET"."ETUDARBR_PET4"."HAUTEUR", 
	"QC_PET"."ETUDARBR_PET4"."DHPMM", 
	"QC_PET"."ETUDARBR_PET4"."ETAGE", 
	"QC_PET"."ETUDARBR_PET4"."AGE", 
	"QC_PET"."ETUDARBR_PET4"."SOURCE_AGE"
FROM "QC_PET"."ETUDARBR_PET4" LEFT OUTER JOIN "QC_PET"."INFOGEN_PET4" ON "QC_PET"."ETUDARBR_PET4"."ID_PET_MES" = "QC_PET"."INFOGEN_PET4"."ID_PET_MES"
ORDER BY
	"QC_PET"."INFOGEN_PET4"."ID_PET" ASC, 
	yr_measured ASC,
	"QC_PET"."ETUDARBR_PET4"."NO_ARBRE" ASC
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