-- Extract Seedling level information from coarse data
-- By Steve Vissault

---------------------------------------
---------------------------------------
--------- Seedling level -------------
---------------------------------------
---------------------------------------

---------------------------------------
-- Permanent sample plot from Quebec ---
---------------------------------------

DROP MATERIALIZED VIEW IF EXISTS "QC_PEP"."MV_QC_PEP_Seedling";

CREATE MATERIALIZED VIEW "QC_PEP"."MV_QC_PEP_Seedling" AS
SELECT
	"QC_PEP"."PP_INFOGEN"."ID_PEP",
	date_part(
		'year' :: TEXT,
		"QC_PEP"."PP_INFOGEN"."DATE_SOND" :: DATE
	) AS yr_measured,
	"QC_PEP"."PP_SEMIS"."MICRO_PE",
	"QC_PEP"."PP_SEMIS"."ESSENCE",
	"QC_PEP"."PP_SEMIS"."CL_HT_SEMI"
FROM
	"QC_PEP"."PP_INFOGEN"
INNER JOIN "QC_PEP"."PP_SEMIS" ON "QC_PEP"."PP_INFOGEN"."ID_PEP_MES" = "QC_PEP"."PP_SEMIS"."ID_PEP_MES"
ORDER BY
	"QC_PEP"."PP_INFOGEN"."ID_PEP" ASC,
	yr_measured ASC,
	"QC_PEP"."PP_SEMIS"."MICRO_PE" ASC
-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200
;

---------------------------------------
-- Temporary sample plot from Quebec ---
---------------------------------------

-- Seedling absent in PET2
-- See PET3&4_TIGES et PET3&4_TIGAVENI (Stored on TreeClass because the number of individual tree is include)
-- Specific seedling table available on PET3 

DROP MATERIALIZED VIEW IF EXISTS "QC_PET"."MV_QC_PET3_Seedling";

CREATE MATERIALIZED VIEW "QC_PET"."MV_QC_PET3_Seedling" AS
SELECT
	"QC_PET"."INFOGEN_PET3"."ID_PET",
	date_part(
		'year' :: TEXT,
		"QC_PET"."INFOGEN_PET3"."DATE_SOND" :: DATE
	) AS yr_measured,
	"QC_PET"."SEMIS_PET3"."MICRO_PE",
	"QC_PET"."SEMIS_PET3"."ESSENCE",
	"QC_PET"."SEMIS_PET3"."CL_HT_SEMI"
FROM
	"QC_PET"."INFOGEN_PET3"
INNER JOIN "QC_PET"."SEMIS_PET3" ON "QC_PET"."INFOGEN_PET3"."ID_PET_MES" = "QC_PET"."SEMIS_PET3"."ID_PET_MES"
ORDER BY
	"QC_PET"."INFOGEN_PET3"."ID_PET" ASC,
	yr_measured ASC,
	"QC_PET"."SEMIS_PET3"."MICRO_PE" ASC
-- Uncomment the line below for smallest query (1000 records)
-- LIMIT 200
;

-----------------------------------------------
-- Permenent sample plot from New-Brunswick ---
-----------------------------------------------

-- No seedling tables

-----------------------------------------
-- Permenent sample plot from Ontario ---
-----------------------------------------