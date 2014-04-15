-- Test SQL to convert datum

-- ALTER TABLE QC_PEP.PP_LOCALIS DROP COLUMN coord_geom;
-- SELECT * FROM public.spatial_ref_sys WHERE srid = 914;
-- INSERT into spatial_ref_sys (srid, auth_name, auth_srid, proj4text, srtext) values (914, sr-org, 14, +proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs , GEOGCS[GCS_WGS_1984,DATUM[WGS_1984,SPHEROID[WGS_1984,6378137,298.257223563]],PRIMEM[Greenwich,0],UNIT[Degree,0.0'17453292519943295']]);

---------- Add spatial column with postgis : Proj = WSG84

----------------------------
------ 		  QC 	   -----
----------------------------
ALTER TABLE qc_pep.pp_localis DROP COLUMN IF EXISTS coord_geom;
ALTER TABLE qc_tp.localis_pet2 DROP COLUMN IF EXISTS coord_geom;
ALTER TABLE qc_tp.localis_pet3 DROP COLUMN IF EXISTS coord_geom;
ALTER TABLE qc_tp.localis_pet4 DROP COLUMN IF EXISTS coord_geom;

SELECT AddGeometryColumn('qc_pp', 'pp_localis', 'coord_geom', 4326,'POINT', 2 );
UPDATE qc_pp.pp_localis SET coord_geom = ST_Transform(ST_SetSRID(ST_MakePoint(longitude,latitude),4326), 4326);

SELECT AddGeometryColumn('qc_tp', 'localis_pet2', 'coord_geom', 4326, 'POINT', 2 );
UPDATE qc_tp.localis_pet2 SET coord_geom = ST_Transform(ST_SetSRID(ST_MakePoint(longitude,latitude),4326), 4326);

SELECT AddGeometryColumn('qc_tp', 'localis_pet3', 'coord_geom', 4326,' POINT', 2 );
UPDATE qc_tp.localis_pet3 SET coord_geom = ST_Transform(ST_SetSRID(ST_MakePoint(longitude,latitude),4326), 4326);

SELECT AddGeometryColumn('qc_tp', 'localis_pet4', 'coord_geom', 4326, 'POINT', 2 );
UPDATE qc_tp.localis_pet4 SET coord_geom = ST_Transform(ST_SetSRID(ST_MakePoint(longitude,latitude),4326), 4326);

----------------------------
------ 		  nb_pp 	   -----
----------------------------

ALTER TABLE nb_pp.psp_plots DROP COLUMN IF EXISTS 'coord_geom';

SELECT AddGeometryColumn('nb_pp', 'psp_plots', 'coord_geom', 4326, 'POINT', 2 );
UPDATE nb_pp.psp_plots SET coord_geom = ST_Transform(ST_SetSRID(ST_MakePoint(gps_ycoordinate,gps_xcoordinate),4326), 4326);

----------------------------
------ 		  ON 	       -----
----------------------------

---------------------------------------------------------------------------------------------

----------------------------
------      GLSL       -----
----------------------------

--- 'NAD83' (SRID=3161) and 'NAD27' (SRID=32098)
------- ERROR: Length of MeasDatum is around 10 - prob with blank character

ALTER TABLE on_pp.glsl_psp_plotinfo DROP COLUMN IF EXISTS coord_geom;
UPDATE on_pp.glsl_psp_plotinfo SET measutmdatum = rtrim(measutmdatum);
UPDATE on_pp.glsl_psp_plotinfo SET measutmzone = trim(measutmzone);


SELECT DISTINCT
  on_pp.glsl_psp_plotinfo.measutmzone,
  length(on_pp.glsl_psp_plotinfo.measutmzone),
  on_pp.glsl_psp_plotinfo.measutmdatum,
  length(on_pp.glsl_psp_plotinfo.measutmdatum)
  FROM on_pp.glsl_psp_plotinfo;

--- 'NAD27'

SELECT AddGeometryColumn('on_pp', 'glsl_psp_plotinfo', 'coord_geom', 4326, 'POINT', 2 );

UPDATE on_pp.glsl_psp_plotinfo SET coord_geom = ST_Transform(ST_SetSRID(ST_MakePoint(measutmeasting,measutmnorthing),2031), 4326)
WHERE on_pp.glsl_psp_plotinfo.measutmdatum = 'NAD27' AND on_pp.glsl_psp_plotinfo.measutmzone = '17';

UPDATE on_pp.glsl_psp_plotinfo SET coord_geom = ST_Transform(ST_SetSRID(ST_MakePoint(measutmeasting,measutmnorthing),2032), 4326)
WHERE on_pp.glsl_psp_plotinfo.measutmdatum = 'NAD27' AND on_pp.glsl_psp_plotinfo.measutmzone = '18';

UPDATE on_pp.glsl_psp_plotinfo SET coord_geom = ST_Transform(ST_SetSRID(ST_MakePoint(measutmeasting,measutmnorthing),2032), 4326)
WHERE on_pp.glsl_psp_plotinfo.measutmdatum = 'NAD27' AND on_pp.glsl_psp_plotinfo.measutmzone = '18T';

---- 'NAD83'

UPDATE on_pp.glsl_psp_plotinfo SET coord_geom = ST_Transform(ST_SetSRID(ST_MakePoint(measutmeasting,measutmnorthing),2150), 4326)
WHERE on_pp.glsl_psp_plotinfo.measutmdatum = 'NAD83' AND on_pp.glsl_psp_plotinfo.measutmzone = '17';

UPDATE on_pp.glsl_psp_plotinfo SET coord_geom = ST_Transform(ST_SetSRID(ST_MakePoint(measutmeasting,measutmnorthing),2150), 4326)
WHERE on_pp.glsl_psp_plotinfo.measutmdatum = 'NAD83' AND on_pp.glsl_psp_plotinfo.measutmzone = '17T';

UPDATE on_pp.glsl_psp_plotinfo SET coord_geom = ST_Transform(ST_SetSRID(ST_MakePoint(measutmeasting,measutmnorthing),2149), 4326)
WHERE on_pp.glsl_psp_plotinfo.measutmdatum = 'NAD83' AND on_pp.glsl_psp_plotinfo.measutmzone = '18T';

UPDATE on_pp.glsl_psp_plotinfo SET coord_geom = ST_Transform(ST_SetSRID(ST_MakePoint(measutmeasting,measutmnorthing),2149), 4326)
WHERE on_pp.glsl_psp_plotinfo.measutmdatum = 'NAD83' AND on_pp.glsl_psp_plotinfo.measutmzone = '18';

UPDATE on_pp.glsl_psp_plotinfo SET coord_geom = ST_Transform(ST_SetSRID(ST_MakePoint(measutmeasting,measutmnorthing),3160), 4326)
WHERE on_pp.glsl_psp_plotinfo.measutmdatum = 'NAD83' AND on_pp.glsl_psp_plotinfo.measutmzone = '16T';

----------------------------
------   Boreal-PSP    -----
----------------------------

ALTER TABLE on_pp.boreal_psp_plot_info DROP COLUMN IF EXISTS coord_geom;

SELECT DISTINCT
  on_pp.boreal_psp_plot_info.map_datum,
   on_pp.boreal_psp_plot_info.map_zone
FROM on_pp.boreal_psp_plot_info;

--- 'NAD27'

SELECT AddGeometryColumn('on_pp', 'boreal_psp_plot_info', 'coord_geom', 4326, 'POINT', 2 );

UPDATE on_pp.boreal_psp_plot_info SET coord_geom = ST_Transform(ST_SetSRID(ST_MakePoint(map_east,map_north),2027), 4326)
WHERE on_pp.boreal_psp_plot_info.map_datum = 27 AND on_pp.boreal_psp_plot_info.map_zone = '15';

UPDATE on_pp.boreal_psp_plot_info SET coord_geom = ST_Transform(ST_SetSRID(ST_MakePoint(map_east,map_north),2028), 4326)
WHERE on_pp.boreal_psp_plot_info.map_datum = 27 AND on_pp.boreal_psp_plot_info.map_zone = '16';

UPDATE on_pp.boreal_psp_plot_info SET coord_geom = ST_Transform(ST_SetSRID(ST_MakePoint(map_east,map_north),2029), 4326)
WHERE on_pp.boreal_psp_plot_info.map_datum = 27 AND on_pp.boreal_psp_plot_info.map_zone = '17';

---- 'NAD83'

UPDATE on_pp.boreal_psp_plot_info SET coord_geom = ST_Transform(ST_SetSRID(ST_MakePoint(map_east,map_north),3160), 4326)
WHERE on_pp.boreal_psp_plot_info.map_datum = 83 AND on_pp.boreal_psp_plot_info.map_zone = '16';

----------------------------
------  PGP-Plot-info   -----
----------------------------

ALTER TABLE on_pp.pgp_plot_info DROP COLUMN IF EXISTS coord_geom;

SELECT DISTINCT
  on_pp.pgp_plot_info.map_datum,
  on_pp.pgp_plot_info.map_zone
  FROM on_pp.pgp_plot_info;

--- 'NAD27'

SELECT AddGeometryColumn('on_pp', 'pgp_plot_info', 'coord_geom', 4326, 'POINT', 2 );

UPDATE on_pp.pgp_plot_info SET coord_geom = ST_Transform(ST_SetSRID(ST_MakePoint(map_east,map_north),2029), 4326)
WHERE on_pp.pgp_plot_info.map_datum = 27 AND on_pp.pgp_plot_info.map_zone = '17';

---- 'NAD83'

UPDATE on_pp.pgp_plot_info SET coord_geom = ST_Transform(ST_SetSRID(ST_MakePoint(map_east,map_north),3160), 4326)
WHERE on_pp.pgp_plot_info.map_datum = 83 AND on_pp.pgp_plot_info.map_zone = '16';

UPDATE on_pp.pgp_plot_info SET coord_geom = ST_Transform(ST_SetSRID(ST_MakePoint(map_east,map_north),2150), 4326)
WHERE on_pp.pgp_plot_info.map_datum = 83 AND on_pp.pgp_plot_info.map_zone = '17';


----------------------------
------      FIA         -----
----------------------------

---------------------------------------------------------------------------------------------

-- NAD83: SRID=3161

ALTER TABLE us_pp.plot DROP COLUMN IF EXISTS coord_geom;
SELECT AddGeometryColumn('us_pp', 'plot', 'coord_geom', 4326,'POINT', 2 );
UPDATE us_pp.plot SET coord_geom = ST_Transform(ST_SetSRID(ST_MakePoint(lon,lat),4269), 4326);