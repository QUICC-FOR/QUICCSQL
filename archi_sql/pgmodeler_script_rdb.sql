-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.7.1
-- PostgreSQL version: 9.3
-- Project Site: pgmodeler.com.br
-- Model Author: Steve Vissault and Miranda Bryant

SET check_function_bodies = false;
-- ddl-end --

-- object: vissst01 | type: ROLE --
-- DROP ROLE vissst01;
CREATE ROLE vissst01 WITH 
	INHERIT
	LOGIN
	ENCRYPTED PASSWORD '********';
-- ddl-end --

-- object: "QUICC" | type: ROLE --
-- DROP ROLE "QUICC";
CREATE ROLE "QUICC" WITH 
	INHERIT
	ENCRYPTED PASSWORD '********'
	VALID UNTIL '2014-03-22 00:00:00'
	ROLE vissst01;
-- ddl-end --


-- Database creation must be done outside an multicommand file.
-- These commands were put in this file only for convenience.
-- -- object: db_quicc_for | type: DATABASE --
-- -- DROP DATABASE db_quicc_for;
-- CREATE DATABASE db_quicc_for
-- ;
-- -- ddl-end --
-- 

-- object: rdb_quicc | type: SCHEMA --
-- DROP SCHEMA rdb_quicc;
CREATE SCHEMA rdb_quicc;
ALTER SCHEMA rdb_quicc OWNER TO "QUICC";
-- ddl-end --

SET search_path TO pg_catalog,public,rdb_quicc;
-- ddl-end --

-- object: rdb_quicc.ref_tree_height_method | type: TABLE --
-- DROP TABLE rdb_quicc.ref_tree_height_method;
CREATE TABLE rdb_quicc.ref_tree_height_method(
	height_id_method character NOT NULL,
	height_desc character varying,
	CONSTRAINT tree_height_method_pk PRIMARY KEY (height_id_method)

);
-- ddl-end --
-- object: idx_height_method_pk | type: INDEX --
-- DROP INDEX rdb_quicc.idx_height_method_pk;
CREATE INDEX idx_height_method_pk ON rdb_quicc.ref_tree_height_method
	USING btree
	(
	  height_id_method ASC NULLS LAST
	);
-- ddl-end --


ALTER TABLE rdb_quicc.ref_tree_height_method OWNER TO "QUICC";
-- ddl-end --

-- object: rdb_quicc.tree_class_info | type: TABLE --
-- DROP TABLE rdb_quicc.tree_class_info;
CREATE TABLE rdb_quicc.tree_class_info(
	plot_id integer NOT NULL,
	tree_class_id integer NOT NULL,
	org_db_location integer,
	org_db_id integer,
	CONSTRAINT tree_class_info_tbl_pk PRIMARY KEY (plot_id,tree_class_id)

);
-- ddl-end --
-- object: idx_tree_class_info_pk | type: INDEX --
-- DROP INDEX rdb_quicc.idx_tree_class_info_pk;
CREATE INDEX idx_tree_class_info_pk ON rdb_quicc.tree_class_info
	USING btree
	(
	  plot_id ASC NULLS LAST,
	  tree_class_id ASC NULLS LAST
	);
-- ddl-end --


ALTER TABLE rdb_quicc.tree_class_info OWNER TO "QUICC";
-- ddl-end --

-- object: rdb_quicc.tree | type: TABLE --
-- DROP TABLE rdb_quicc.tree;
CREATE TABLE rdb_quicc.tree(
	plot_id integer NOT NULL,
	tree_id char(3) NOT NULL,
	year_measured integer NOT NULL,
	id_spe character(15) NOT NULL,
	height float4,
	dbh integer,
	age integer,
	sun_access integer,
	position_canopy character,
	height_id_method character,
	in_subplot boolean,
	in_macroplot boolean,
	is_planted boolean,
	is_dead boolean,
	plot_id_plot integer NOT NULL,
	year_measured_plot integer NOT NULL,
	plot_id_tree_info integer NOT NULL,
	tree_id_tree_info character(20) NOT NULL,
	id_spe_ref_species character(15) NOT NULL,
	height_id_method_ref_tree_height_method character NOT NULL,
	CONSTRAINT tree_table_pk PRIMARY KEY (plot_id,tree_id,year_measured)

);
-- ddl-end --
-- object: idx_tree_pk | type: INDEX --
-- DROP INDEX rdb_quicc.idx_tree_pk;
CREATE INDEX idx_tree_pk ON rdb_quicc.tree
	USING btree
	(
	  plot_id ASC NULLS LAST,
	  tree_id ASC NULLS LAST,
	  year_measured ASC NULLS LAST
	);
-- ddl-end --


ALTER TABLE rdb_quicc.tree OWNER TO "QUICC";
-- ddl-end --

-- object: rdb_quicc.class_tree | type: TABLE --
-- DROP TABLE rdb_quicc.class_tree;
CREATE TABLE rdb_quicc.class_tree(
	plot_id integer NOT NULL,
	tree_class_id integer NOT NULL,
	year_measured integer NOT NULL,
	id_spe character(15) NOT NULL,
	dbh_class_id integer,
	dbh_tree_number integer,
	height_class_id integer,
	height_tree_number integer,
	plot_id_tree_class_info integer NOT NULL,
	tree_class_id_tree_class_info integer NOT NULL,
	plot_id_plot integer NOT NULL,
	year_measured_plot integer NOT NULL,
	dbh_class_id_conv_class_dbh integer NOT NULL,
	height_class_id_conv_class_height integer NOT NULL,
	id_spe_ref_species character(15) NOT NULL,
	CONSTRAINT class_tree_tbl_pk PRIMARY KEY (plot_id,tree_class_id,year_measured)

);
-- ddl-end --
-- object: idx_class_tree_pk | type: INDEX --
-- DROP INDEX rdb_quicc.idx_class_tree_pk;
CREATE INDEX idx_class_tree_pk ON rdb_quicc.class_tree
	USING btree
	(
	  plot_id ASC NULLS LAST,
	  tree_class_id ASC NULLS LAST,
	  year_measured ASC NULLS LAST
	);
-- ddl-end --


ALTER TABLE rdb_quicc.class_tree OWNER TO "QUICC";
-- ddl-end --

-- object: rdb_quicc.stand_disturbed | type: TABLE --
-- DROP TABLE rdb_quicc.stand_disturbed;
CREATE TABLE rdb_quicc.stand_disturbed(
	plot_id integer NOT NULL,
	year_disturbed integer NOT NULL,
	disturb_type character,
	disturb_severity character,
	logging_type character(2),
	is_planted boolean,
	plot_id_stand integer NOT NULL,
	year_measured_stand integer NOT NULL,
	disturb_type_ref_stand_disturb_type character NOT NULL,
	CONSTRAINT stand_disturbed_tbl_pk PRIMARY KEY (plot_id,year_disturbed)

);
-- ddl-end --
-- object: idx_stand_disturbed_pk | type: INDEX --
-- DROP INDEX rdb_quicc.idx_stand_disturbed_pk;
CREATE INDEX idx_stand_disturbed_pk ON rdb_quicc.stand_disturbed
	USING btree
	(
	  plot_id ASC NULLS LAST,
	  year_disturbed ASC NULLS LAST
	);
-- ddl-end --


ALTER TABLE rdb_quicc.stand_disturbed OWNER TO "QUICC";
-- ddl-end --

-- object: rdb_quicc.ref_stand_disturb_type | type: TABLE --
-- DROP TABLE rdb_quicc.ref_stand_disturb_type;
CREATE TABLE rdb_quicc.ref_stand_disturb_type(
	disturb_type character NOT NULL,
	disturb_desc character varying(255),
	CONSTRAINT ref_stand_disturb_type_pk PRIMARY KEY (disturb_type)

);
-- ddl-end --
ALTER TABLE rdb_quicc.ref_stand_disturb_type OWNER TO "QUICC";
-- ddl-end --

-- object: rdb_quicc.tree_info | type: TABLE --
-- DROP TABLE rdb_quicc.tree_info;
CREATE TABLE rdb_quicc.tree_info(
	plot_id integer NOT NULL,
	tree_id character(20) NOT NULL,
	org_db_loc character(30),
	org_db_id character(30),
	CONSTRAINT tree_info_tbl_pk PRIMARY KEY (plot_id,tree_id)

);
-- ddl-end --
-- object: idx_tree_info_pk | type: INDEX --
-- DROP INDEX rdb_quicc.idx_tree_info_pk;
CREATE INDEX idx_tree_info_pk ON rdb_quicc.tree_info
	USING btree
	(
	  plot_id ASC NULLS LAST,
	  tree_id ASC NULLS LAST
	);
-- ddl-end --


ALTER TABLE rdb_quicc.tree_info OWNER TO "QUICC";
-- ddl-end --

-- object: rdb_quicc.plot | type: TABLE --
-- DROP TABLE rdb_quicc.plot;
CREATE TABLE rdb_quicc.plot(
	plot_id integer NOT NULL,
	year_measured integer,
	plot_size double precision,
	subplot_size double precision,
	microplot_size double precision,
	has_macroplot boolean,
	is_temp boolean,
	plot_id_localisation integer,
	plot_id_plot_info integer NOT NULL,
	CONSTRAINT plot_tbl_pk PRIMARY KEY (plot_id,year_measured)

);
-- ddl-end --
-- object: idx_plot | type: INDEX --
-- DROP INDEX rdb_quicc.idx_plot;
CREATE INDEX idx_plot ON rdb_quicc.plot
	USING btree
	(
	  plot_id ASC NULLS LAST,
	  year_measured ASC NULLS LAST
	);
-- ddl-end --


ALTER TABLE rdb_quicc.plot OWNER TO "QUICC";
-- ddl-end --

-- object: rdb_quicc.plot_info_plot_id_seq | type: SEQUENCE --
-- DROP SEQUENCE rdb_quicc.plot_info_plot_id_seq;
CREATE SEQUENCE rdb_quicc.plot_info_plot_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
ALTER SEQUENCE rdb_quicc.plot_info_plot_id_seq OWNER TO vissst01;
-- ddl-end --

-- object: rdb_quicc.plot_info | type: TABLE --
-- DROP TABLE rdb_quicc.plot_info;
CREATE TABLE rdb_quicc.plot_info(
	plot_id integer NOT NULL DEFAULT nextval('plot_info_plot_id_seq'::regclass),
	org_db_loc character(30),
	org_db_id character(30),
	CONSTRAINT plot_info_tbl_pk PRIMARY KEY (plot_id)

);
-- ddl-end --
-- object: idx_plot_info_pk | type: INDEX --
-- DROP INDEX rdb_quicc.idx_plot_info_pk;
CREATE INDEX idx_plot_info_pk ON rdb_quicc.plot_info
	USING btree
	(
	  plot_id ASC NULLS LAST
	);
-- ddl-end --


ALTER TABLE rdb_quicc.plot_info OWNER TO "QUICC";
-- ddl-end --

-- object: rdb_quicc.stand | type: TABLE --
-- DROP TABLE rdb_quicc.stand;
CREATE TABLE rdb_quicc.stand(
	plot_id integer NOT NULL,
	year_measured integer NOT NULL,
	age integer,
	age_id_method character,
	height float4,
	height_id_method character,
	surface_deposit character(3),
	drainage character,
	slope character,
	is_disturbed boolean,
	is_planted boolean,
	plot_id_plot integer NOT NULL,
	year_measured_plot integer NOT NULL,
	age_id_method_ref_stand_age_method character NOT NULL,
	height_id_method_ref_stand_height_method character NOT NULL,
	CONSTRAINT stand_tbl_pk PRIMARY KEY (plot_id,year_measured)

);
-- ddl-end --
-- object: idx_stand_pk | type: INDEX --
-- DROP INDEX rdb_quicc.idx_stand_pk;
CREATE INDEX idx_stand_pk ON rdb_quicc.stand
	USING btree
	(
	  plot_id ASC NULLS LAST,
	  year_measured ASC NULLS LAST
	);
-- ddl-end --


ALTER TABLE rdb_quicc.stand OWNER TO "QUICC";
-- ddl-end --

-- object: rdb_quicc.localisation | type: TABLE --
-- DROP TABLE rdb_quicc.localisation;
CREATE TABLE rdb_quicc.localisation(
	plot_id integer NOT NULL,
	latitude double precision,
	longitude double precision,
	coord_postgis geometry(POINT, 4326),
	srid integer,
	elevation integer,
	plot_location character(20),
	CONSTRAINT localis_tbl_pk PRIMARY KEY (plot_id)

);
-- ddl-end --
-- object: idx_localisation_pk | type: INDEX --
-- DROP INDEX rdb_quicc.idx_localisation_pk;
CREATE INDEX idx_localisation_pk ON rdb_quicc.localisation
	USING btree
	(
	  plot_id ASC NULLS LAST
	);
-- ddl-end --

-- object: idx_spatial | type: INDEX --
-- DROP INDEX rdb_quicc.idx_spatial;
CREATE INDEX idx_spatial ON rdb_quicc.localisation
	USING btree
	(
	  coord_postgis ASC NULLS LAST,
	  plot_location ASC NULLS LAST
	);
-- ddl-end --


ALTER TABLE rdb_quicc.localisation OWNER TO "QUICC";
-- ddl-end --

-- object: plot_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.stand DROP CONSTRAINT plot_fk;
ALTER TABLE rdb_quicc.stand ADD CONSTRAINT plot_fk FOREIGN KEY (plot_id_plot,year_measured_plot)
REFERENCES rdb_quicc.plot (plot_id,year_measured) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --


-- object: tree_class_info_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.class_tree DROP CONSTRAINT tree_class_info_fk;
ALTER TABLE rdb_quicc.class_tree ADD CONSTRAINT tree_class_info_fk FOREIGN KEY (plot_id_tree_class_info,tree_class_id_tree_class_info)
REFERENCES rdb_quicc.tree_class_info (plot_id,tree_class_id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --


-- object: plot_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.class_tree DROP CONSTRAINT plot_fk;
ALTER TABLE rdb_quicc.class_tree ADD CONSTRAINT plot_fk FOREIGN KEY (plot_id_plot,year_measured_plot)
REFERENCES rdb_quicc.plot (plot_id,year_measured) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --


-- object: plot_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.tree DROP CONSTRAINT plot_fk;
ALTER TABLE rdb_quicc.tree ADD CONSTRAINT plot_fk FOREIGN KEY (plot_id_plot,year_measured_plot)
REFERENCES rdb_quicc.plot (plot_id,year_measured) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --


-- object: tree_info_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.tree DROP CONSTRAINT tree_info_fk;
ALTER TABLE rdb_quicc.tree ADD CONSTRAINT tree_info_fk FOREIGN KEY (plot_id_tree_info,tree_id_tree_info)
REFERENCES rdb_quicc.tree_info (plot_id,tree_id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --


-- object: rdb_quicc.ref_stand_age_method | type: TABLE --
-- DROP TABLE rdb_quicc.ref_stand_age_method;
CREATE TABLE rdb_quicc.ref_stand_age_method(
	age_id_method character NOT NULL,
	age_desc character varying,
	CONSTRAINT ref_stand_age_method_pk PRIMARY KEY (age_id_method)

);
-- ddl-end --
-- object: idx_stand_age_method_pk | type: INDEX --
-- DROP INDEX rdb_quicc.idx_stand_age_method_pk;
CREATE INDEX idx_stand_age_method_pk ON rdb_quicc.ref_stand_age_method
	USING btree
	(
	  age_id_method ASC NULLS LAST
	);
-- ddl-end --


ALTER TABLE rdb_quicc.ref_stand_age_method OWNER TO "QUICC";
-- ddl-end --

-- object: rdb_quicc.ref_stand_height_method | type: TABLE --
-- DROP TABLE rdb_quicc.ref_stand_height_method;
CREATE TABLE rdb_quicc.ref_stand_height_method(
	height_id_method character NOT NULL,
	height_desc character varying,
	CONSTRAINT ref_stand_height_method_pk PRIMARY KEY (height_id_method)

);
-- ddl-end --
-- object: idx_stand_height_method_pk | type: INDEX --
-- DROP INDEX rdb_quicc.idx_stand_height_method_pk;
CREATE INDEX idx_stand_height_method_pk ON rdb_quicc.ref_stand_height_method
	USING btree
	(
	  height_id_method ASC NULLS LAST
	);
-- ddl-end --


ALTER TABLE rdb_quicc.ref_stand_height_method OWNER TO "QUICC";
-- ddl-end --

-- object: stand_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.stand_disturbed DROP CONSTRAINT stand_fk;
ALTER TABLE rdb_quicc.stand_disturbed ADD CONSTRAINT stand_fk FOREIGN KEY (plot_id_stand,year_measured_stand)
REFERENCES rdb_quicc.stand (plot_id,year_measured) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --


-- object: ref_stand_age_method_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.stand DROP CONSTRAINT ref_stand_age_method_fk;
ALTER TABLE rdb_quicc.stand ADD CONSTRAINT ref_stand_age_method_fk FOREIGN KEY (age_id_method_ref_stand_age_method)
REFERENCES rdb_quicc.ref_stand_age_method (age_id_method) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --


-- object: ref_stand_height_method_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.stand DROP CONSTRAINT ref_stand_height_method_fk;
ALTER TABLE rdb_quicc.stand ADD CONSTRAINT ref_stand_height_method_fk FOREIGN KEY (height_id_method_ref_stand_height_method)
REFERENCES rdb_quicc.ref_stand_height_method (height_id_method) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --


-- object: ref_stand_disturb_type_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.stand_disturbed DROP CONSTRAINT ref_stand_disturb_type_fk;
ALTER TABLE rdb_quicc.stand_disturbed ADD CONSTRAINT ref_stand_disturb_type_fk FOREIGN KEY (disturb_type_ref_stand_disturb_type)
REFERENCES rdb_quicc.ref_stand_disturb_type (disturb_type) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --


-- object: rdb_quicc.conv_class_dbh | type: TABLE --
-- DROP TABLE rdb_quicc.conv_class_dbh;
CREATE TABLE rdb_quicc.conv_class_dbh(
	dbh_class_id integer NOT NULL,
	dbh_min integer,
	dbh_max integer,
	org_db_loc char(20),
	org_db_id char(10),
	CONSTRAINT conv_class_dbh_pk PRIMARY KEY (dbh_class_id)

);
-- ddl-end --
-- object: idx_conv_class_dbh_pk | type: INDEX --
-- DROP INDEX rdb_quicc.idx_conv_class_dbh_pk;
CREATE INDEX idx_conv_class_dbh_pk ON rdb_quicc.conv_class_dbh
	USING btree
	(
	  dbh_class_id ASC NULLS LAST
	);
-- ddl-end --


ALTER TABLE rdb_quicc.conv_class_dbh OWNER TO "QUICC";
-- ddl-end --

-- object: rdb_quicc.conv_class_height | type: TABLE --
-- DROP TABLE rdb_quicc.conv_class_height;
CREATE TABLE rdb_quicc.conv_class_height(
	height_class_id integer NOT NULL,
	height_min integer,
	height_max integer,
	org_db_loc char(20),
	org_db_id char(10),
	CONSTRAINT conv_class_height_pk PRIMARY KEY (height_class_id)

);
-- ddl-end --
-- object: idx_conv_class_height_pk | type: INDEX --
-- DROP INDEX rdb_quicc.idx_conv_class_height_pk;
CREATE INDEX idx_conv_class_height_pk ON rdb_quicc.conv_class_height
	USING btree
	(
	  height_class_id ASC NULLS LAST
	);
-- ddl-end --


ALTER TABLE rdb_quicc.conv_class_height OWNER TO "QUICC";
-- ddl-end --

-- object: conv_class_dbh_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.class_tree DROP CONSTRAINT conv_class_dbh_fk;
ALTER TABLE rdb_quicc.class_tree ADD CONSTRAINT conv_class_dbh_fk FOREIGN KEY (dbh_class_id_conv_class_dbh)
REFERENCES rdb_quicc.conv_class_dbh (dbh_class_id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --


-- object: conv_class_height_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.class_tree DROP CONSTRAINT conv_class_height_fk;
ALTER TABLE rdb_quicc.class_tree ADD CONSTRAINT conv_class_height_fk FOREIGN KEY (height_class_id_conv_class_height)
REFERENCES rdb_quicc.conv_class_height (height_class_id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --


-- object: localisation_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.plot DROP CONSTRAINT localisation_fk;
ALTER TABLE rdb_quicc.plot ADD CONSTRAINT localisation_fk FOREIGN KEY (plot_id_localisation)
REFERENCES rdb_quicc.localisation (plot_id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --


-- object: plot_info_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.plot DROP CONSTRAINT plot_info_fk;
ALTER TABLE rdb_quicc.plot ADD CONSTRAINT plot_info_fk FOREIGN KEY (plot_id_plot_info)
REFERENCES rdb_quicc.plot_info (plot_id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --


-- object: rdb_quicc.ref_species | type: TABLE --
-- DROP TABLE rdb_quicc.ref_species;
CREATE TABLE rdb_quicc.ref_species(
	id_spe character(15) NOT NULL,
	tsn integer,
	genus character(60),
	species character(60),
	en_common_name character(100),
	fr_common_name character(100),
	qc_code character(3),
	on_tree_code integer,
	on_alpha_code character(3),
	us_code integer,
	nb_code integer,
	CONSTRAINT ref_species_tbl_pk PRIMARY KEY (id_spe)

);
-- ddl-end --
-- object: idx_ref_species_pk | type: INDEX --
-- DROP INDEX rdb_quicc.idx_ref_species_pk;
CREATE INDEX idx_ref_species_pk ON rdb_quicc.ref_species
	USING btree
	(
	  id_spe ASC NULLS LAST
	);
-- ddl-end --

-- object: idx_ref_species_qc | type: INDEX --
-- DROP INDEX rdb_quicc.idx_ref_species_qc;
CREATE INDEX idx_ref_species_qc ON rdb_quicc.ref_species
	USING btree
	(
	  qc_code ASC NULLS LAST
	);
-- ddl-end --

-- object: idx_ref_species_on | type: INDEX --
-- DROP INDEX rdb_quicc.idx_ref_species_on;
CREATE INDEX idx_ref_species_on ON rdb_quicc.ref_species
	USING btree
	(
	  on_tree_code ASC NULLS LAST
	);
-- ddl-end --

-- object: idx_ref_species_us | type: INDEX --
-- DROP INDEX rdb_quicc.idx_ref_species_us;
CREATE INDEX idx_ref_species_us ON rdb_quicc.ref_species
	USING btree
	(
	  us_code ASC NULLS LAST
	);
-- ddl-end --

-- object: idx_ref_species_nb | type: INDEX --
-- DROP INDEX rdb_quicc.idx_ref_species_nb;
CREATE INDEX idx_ref_species_nb ON rdb_quicc.ref_species
	USING btree
	(
	  nb_code ASC NULLS LAST
	);
-- ddl-end --


ALTER TABLE rdb_quicc.ref_species OWNER TO postgres;
-- ddl-end --

-- object: ref_species_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.class_tree DROP CONSTRAINT ref_species_fk;
ALTER TABLE rdb_quicc.class_tree ADD CONSTRAINT ref_species_fk FOREIGN KEY (id_spe_ref_species)
REFERENCES rdb_quicc.ref_species (id_spe) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --


-- object: ref_species_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.tree DROP CONSTRAINT ref_species_fk;
ALTER TABLE rdb_quicc.tree ADD CONSTRAINT ref_species_fk FOREIGN KEY (id_spe_ref_species)
REFERENCES rdb_quicc.ref_species (id_spe) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --


-- object: rdb_quicc.climatic_data | type: TABLE --
-- DROP TABLE rdb_quicc.climatic_data;
CREATE TABLE rdb_quicc.climatic_data(
	plot_id integer NOT NULL,
	year_clim integer NOT NULL,
	mean_diurnal_range real,
	isothermality real,
	temp_seasonality real,
	max_temp_warmest_period real,
	min_temp_coldest_period real,
	temp_annual_range real,
	mean_temperatre_wettest_quarter real,
	mean_temp_driest_quarter real,
	mean_temp_warmest_quarter real,
	mean_temp_coldest_quarter real,
	annual_pp real,
	pp_wettest_period real,
	pp_driest_period real,
	pp_seasonality real,
	pp_wettest_quarter real,
	pp_driest_quarter real,
	pp_warmest_quarter real,
	pp_coldest_quarter real,
	julian_day_number_start_growing_season real,
	julian_day_number_at_end_growing_season real,
	number_days_growing_season real,
	total_pp_for_period_1 real,
	total_pp_for_period_3 real,
	gdd_above_base_temp_for_period_3 real,
	annual_mean_temp real,
	annual_min_temp real,
	annual_max_temp real,
	mean_temp_for_period_3 real,
	temp_range_for_period_3 real,
	january_mean_monthly_min_temp real,
	february_mean_monthly_min_temp real,
	march_mean_monthly_min_temp real,
	april_mean_monthly_min_temp real,
	may_mean_monthly_min_temp real,
	june_mean_monthly_min_temp real,
	july_mean_monthly_min_temp real,
	august_mean_monthly_min_temp real,
	september_mean_monthly_min_temp real,
	october_mean_monthly_min_temp real,
	november_mean_monthly_min_temp real,
	december_mean_monthly_min_temp real,
	january_mean_monthly_max_temp real,
	february_mean_monthly_max_temp real,
	march_mean_monthly_max_temp real,
	april_mean_monthly_max_temp real,
	may_mean_monthly_max_temp real,
	june_mean_monthly_max_temp real,
	july_mean_monthly_max_temp real,
	august_mean_monthly_max_temp real,
	september_mean_monthly_max_temp real,
	october_mean_monthly_max_temp real,
	november_mean_monthly_max_temp real,
	december_mean_monthly_max_temp real,
	january_mean_monthly_pp real,
	february_mean_monthly_pp real,
	march_mean_monthly_pp real,
	april_mean_monthly_pp real,
	may_mean_monthly_pp real,
	june_mean_monthly_pp real,
	july_mean_monthly_pp real,
	august_mean_monthly_pp real,
	september_mean_monthly_pp real,
	october_mean_monthly_pp real,
	november_mean_monthly_pp real,
	december_mean_monthly_pp real,
	plot_id_plot integer NOT NULL,
	year_measured_plot integer NOT NULL,
	CONSTRAINT clim_tbl_pk PRIMARY KEY (plot_id,year_clim)

);
-- ddl-end --
-- object: idx_clim_data_pk | type: INDEX --
-- DROP INDEX rdb_quicc.idx_clim_data_pk;
CREATE INDEX idx_clim_data_pk ON rdb_quicc.climatic_data
	USING btree
	(
	  plot_id ASC NULLS LAST,
	  year_clim ASC NULLS LAST
	);
-- ddl-end --


ALTER TABLE rdb_quicc.climatic_data OWNER TO "QUICC";
-- ddl-end --

-- object: plot_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.climatic_data DROP CONSTRAINT plot_fk;
ALTER TABLE rdb_quicc.climatic_data ADD CONSTRAINT plot_fk FOREIGN KEY (plot_id_plot,year_measured_plot)
REFERENCES rdb_quicc.plot (plot_id,year_measured) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --


-- object: ref_tree_height_method_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.tree DROP CONSTRAINT ref_tree_height_method_fk;
ALTER TABLE rdb_quicc.tree ADD CONSTRAINT ref_tree_height_method_fk FOREIGN KEY (height_id_method_ref_tree_height_method)
REFERENCES rdb_quicc.ref_tree_height_method (height_id_method) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --


-- object: grant_796b112b4f | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.ref_tree_height_method
   TO vissst01;
-- ddl-end --

-- object: grant_ff3f469b80 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.tree_class_info
   TO vissst01;
-- ddl-end --

-- object: grant_6130269bb5 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.tree
   TO vissst01;
-- ddl-end --

-- object: grant_d9c3a8b376 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.class_tree
   TO vissst01;
-- ddl-end --

-- object: grant_a218da4cdc | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.stand_disturbed
   TO vissst01;
-- ddl-end --

-- object: grant_a8edec173b | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.ref_stand_disturb_type
   TO vissst01;
-- ddl-end --

-- object: grant_feb0cbdea7 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.tree_info
   TO vissst01;
-- ddl-end --

-- object: grant_f235673df2 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.plot
   TO vissst01;
-- ddl-end --

-- object: grant_ac677237d9 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.plot_info
   TO vissst01;
-- ddl-end --

-- object: grant_3c5a724a41 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.stand
   TO vissst01;
-- ddl-end --


