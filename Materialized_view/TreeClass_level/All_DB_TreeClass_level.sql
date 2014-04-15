-- Extract TreeClass level information from coarse data
-- By Steve Vissault

---------------------------------------
---------------------------------------
--------- TreeClass level -------------
---------------------------------------
---------------------------------------


---------------------------------------
-- Permanent sample plot from Quebec ---
---------------------------------------

DROP MATERIALIZED VIEW IF EXISTS "QC_PEP"."MV_QC_PEP_TreeClass";

CREATE MATERIALIZED VIEW "QC_PEP"."MV_QC_PEP_TreeClass" AS
SELECT "QC_PEP"."PP_INFOGEN"."ID_PEP", 
	date_part('year'::text, "QC_PEP"."PP_INFOGEN"."DATE_SOND"::date) AS yr_measured, 
	"QC_PEP"."PP_GAULES"."ESSENCE", 
	"QC_PEP"."PP_GAULES"."CL_DHP", 
	"QC_PEP"."PP_GAULES"."NB_TIGE"
FROM "QC_PEP"."PP_GAULES" LEFT OUTER JOIN "QC_PEP"."PP_INFOGEN" ON "QC_PEP"."PP_GAULES"."ID_PEP_MES" = "QC_PEP"."PP_INFOGEN"."ID_PEP_MES"
ORDER BY 
	"QC_PEP"."PP_INFOGEN"."ID_PEP" ASC,
	yr_measured ASC
-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 1000
;

---------------------------------------
-- Temporary sample plot from Quebec ---
---------------------------------------

DROP MATERIALIZED VIEW IF EXISTS "QC_PET"."MV_QC_PET2_TreeClass";

CREATE MATERIALIZED VIEW "QC_PET"."MV_QC_PET2_TreeClass" AS
SELECT "QC_PET"."INFOGEN_PET2"."ID_PET", 
	date_part('year'::text, "QC_PET"."INFOGEN_PET2"."DATE_SOND"::date) AS yr_measured, 
	"QC_PET"."TIGES_PET2"."ESSENCE", 
	"QC_PET"."TIGES_PET2"."CL_DHP", 
	"QC_PET"."TIGES_PET2"."NB_TIGE"
FROM "QC_PET"."TIGES_PET2" LEFT OUTER JOIN "QC_PET"."INFOGEN_PET2" ON "QC_PET"."TIGES_PET2"."ID_PET_MES" = "QC_PET"."INFOGEN_PET2"."ID_PET_MES"
ORDER BY 
	"QC_PET"."INFOGEN_PET2"."ID_PET" ASC,
	yr_measured ASC
-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 1000
;

DROP MATERIALIZED VIEW IF EXISTS "QC_PET"."MV_QC_PET3_TreeClass";

CREATE MATERIALIZED VIEW "QC_PET"."MV_QC_PET3_TreeClass" AS
SELECT "QC_PET"."INFOGEN_PET3"."ID_PET", 
	date_part('year'::text, "QC_PET"."INFOGEN_PET3"."DATE_SOND"::date) AS yr_measured, 
	"QC_PET"."TIGES_PET3"."ESSENCE", 
	"QC_PET"."TIGES_PET3"."CL_DHP", 
	"QC_PET"."TIGES_PET3"."NB_TIGE"
FROM "QC_PET"."TIGES_PET3" LEFT OUTER JOIN "QC_PET"."INFOGEN_PET3" ON "QC_PET"."TIGES_PET3"."ID_PET_MES" = "QC_PET"."INFOGEN_PET3"."ID_PET_MES"

-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 500
UNION ALL

SELECT "QC_PET"."INFOGEN_PET3"."ID_PET", 
	date_part('year'::text, "QC_PET"."INFOGEN_PET3"."DATE_SOND"::date) AS yr_measured, 
	"QC_PET"."TIGAVENI_PET3"."ESSENCE", 
	"QC_PET"."TIGAVENI_PET3"."CL_TIGE", 
	"QC_PET"."TIGAVENI_PET3"."NB_TIGE"
FROM "QC_PET"."TIGAVENI_PET3" LEFT OUTER JOIN "QC_PET"."INFOGEN_PET3" ON "QC_PET"."TIGAVENI_PET3"."ID_PET_MES" = "QC_PET"."INFOGEN_PET3"."ID_PET_MES"

-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 500
;

DROP MATERIALIZED VIEW IF EXISTS "QC_PET"."MV_QC_PET4_TreeClass";

CREATE MATERIALIZED VIEW "QC_PET"."MV_QC_PET4_TreeClass" AS
SELECT "QC_PET"."INFOGEN_PET4"."ID_PET", 
	date_part('year'::text, "QC_PET"."INFOGEN_PET4"."DATE_SOND"::date) AS yr_measured, 
	"QC_PET"."TIGES_PET4"."ESSENCE", 
	"QC_PET"."TIGES_PET4"."CL_DHP", 
	"QC_PET"."TIGES_PET4"."NB_TIGE"
FROM "QC_PET"."TIGES_PET4" LEFT OUTER JOIN "QC_PET"."INFOGEN_PET4" ON "QC_PET"."TIGES_PET4"."ID_PET_MES" = "QC_PET"."INFOGEN_PET4"."ID_PET_MES"

-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 500
UNION ALL

SELECT "QC_PET"."INFOGEN_PET4"."ID_PET", 
	date_part('year'::text, "QC_PET"."INFOGEN_PET4"."DATE_SOND"::date) AS yr_measured, 
	"QC_PET"."TIGAVENI_PET4"."ESSENCE", 
	"QC_PET"."TIGAVENI_PET4"."CL_TIGE", 
	"QC_PET"."TIGAVENI_PET4"."NB_TIGE"
FROM "QC_PET"."TIGAVENI_PET4" LEFT OUTER JOIN "QC_PET"."INFOGEN_PET4" ON "QC_PET"."TIGAVENI_PET4"."ID_PET_MES" = "QC_PET"."INFOGEN_PET4"."ID_PET_MES"

-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 500
;

-----------------------------------------------
-- Permenent sample plot from New-Brunswick ---
-----------------------------------------------

DROP MATERIALIZED VIEW IF EXISTS "NB"."MV_ON_RegenThin_TreeClass";

CREATE MATERIALIZED VIEW "NB"."MV_ON_RegenThin_TreeClass" AS
SELECT "NB"."PSP_PLOTS_YR"."Plot", 
	"NB"."PSP_PLOTS_YR"."Year", 
	"NB"."Thin_Regen_regen_tally_1"."Species", 
	"NB"."Thin_Regen_regen_tally_1"."Ht Class", 
	"NB"."Thin_Regen_regen_tally_1"."Tally"
FROM "NB"."Thin_Regen_regen_tally_1" LEFT OUTER JOIN "NB"."PSP_PLOTS_YR" ON "NB"."Thin_Regen_regen_tally_1"."RemeasID" = "NB"."PSP_PLOTS_YR"."RemeasID"
;


DROP MATERIALIZED VIEW IF EXISTS "NB"."MV_ON_YIMO_TreeClass";

CREATE MATERIALIZED VIEW "NB"."MV_ON_YIMO_TreeClass" AS
SELECT "NB"."PSP_PLOTS_YR"."Plot", 
	"NB"."PSP_PLOTS_YR"."Year", 
	"NB"."PSP_REGEN_YIMO".species, 
	"NB"."PSP_REGEN_YIMO"."regenHtClassYIMO", 
	"NB"."PSP_REGEN_YIMO".tally
FROM "NB"."PSP_REGEN_YIMO" LEFT OUTER JOIN "NB"."PSP_PLOTS_YR" ON "NB"."PSP_REGEN_YIMO"."RemeasID" = "NB"."PSP_PLOTS_YR"."RemeasID"
;


DROP MATERIALIZED VIEW IF EXISTS "NB"."MV_ON_YIMO_TreeClass";

CREATE MATERIALIZED VIEW "NB"."MV_ON_YIMO_TreeClass" AS
SELECT "NB"."PSP_PLOTS_YR"."Plot", 
	"NB"."PSP_PLOTS_YR"."Year", 
	"NB"."PSP_REGEN_YIMO".species, 
	"NB"."PSP_REGEN_YIMO"."regenHtClassYIMO", 
	"NB"."PSP_REGEN_YIMO".tally
FROM "NB"."PSP_REGEN_YIMO" LEFT OUTER JOIN "NB"."PSP_PLOTS_YR" ON "NB"."PSP_REGEN_YIMO"."RemeasID" = "NB"."PSP_PLOTS_YR"."RemeasID"
;

DROP MATERIALIZED VIEW IF EXISTS "NB"."MV_ON_CutPlantRegen_TreeClass";

CREATE MATERIALIZED VIEW "NB"."MV_ON_CutPlantRegen_TreeClass" AS
SELECT "NB"."PSP_PLOTS_YR"."Plot", 
	"NB"."PSP_PLOTS_YR"."Year", 
	"NB"."Cut_Plant_regen_tally_1"."Species", 
	"NB"."Cut_Plant_regen_tally_1"."regenHtClass", 
	"NB"."Cut_Plant_regen_tally_1"."Tally"
FROM "NB"."Cut_Plant_regen_tally_1" LEFT OUTER JOIN "NB"."PSP_PLOTS_YR" ON "NB"."Cut_Plant_regen_tally_1"."RemeasID" = "NB"."PSP_PLOTS_YR"."RemeasID"
;

-----------------------------------------
-- Permenent sample plot from Ontario ---
-----------------------------------------

