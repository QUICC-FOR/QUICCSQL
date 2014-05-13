-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.7.0
-- PostgreSQL version: 9.3
-- Project Site: pgmodeler.com.br
-- Model Author: Steve Vissault and Miranda Bryant

SET check_function_bodies = false;
-- ddl-end --

-- object: "QUICC" | type: ROLE --
-- DROP ROLE "QUICC";
CREATE ROLE "QUICC" WITH
	INHERIT
	ENCRYPTED PASSWORD '********'
	VALID UNTIL '2014-03-22 00:00:00'
	ROLE "QUICC";
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
ALTER SEQUENCE rdb_quicc.plot_info_plot_id_seq OWNER TO "QUICC";
-- ddl-end --


-- object: rdb_quicc.tree_info_tree_id_species_seq | type: SEQUENCE --
-- DROP SEQUENCE rdb_quicc.tree_info_tree_id_species_seq;
CREATE SEQUENCE rdb_quicc.tree_info_tree_id_species_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
ALTER SEQUENCE rdb_quicc.tree_info_tree_id_species_seq OWNER TO "QUICC";
-- ddl-end --

-- object: rdb_quicc.superplot | type: TABLE --
-- DROP TABLE rdb_quicc.superplot;
CREATE TABLE rdb_quicc.superplot(
	plot_id integer NOT NULL,
	tree_id integer,
	year_measured integer,
	CONSTRAINT superplot_tbl_pk PRIMARY KEY (plot_id)

);
-- ddl-end --
ALTER TABLE rdb_quicc.superplot OWNER TO "QUICC";
-- ddl-end --

-- object: rdb_quicc.ref_tree_age_method | type: TABLE --
-- DROP TABLE rdb_quicc.ref_tree_age_method;
CREATE TABLE rdb_quicc.ref_tree_age_method(
	age_id_method character NOT NULL,
	age_desc character varying,
	CONSTRAINT tree_age_method_pk PRIMARY KEY (age_id_method)

);
-- ddl-end --
ALTER TABLE rdb_quicc.ref_tree_age_method OWNER TO "QUICC";
-- ddl-end --

-- object: rdb_quicc.ref_tree_height_method | type: TABLE --
-- DROP TABLE rdb_quicc.ref_tree_height_method;
CREATE TABLE rdb_quicc.ref_tree_height_method(
	height_id_method character NOT NULL,
	height_desc character varying,
	CONSTRAINT tree_height_method_pk PRIMARY KEY (height_id_method)

);
-- ddl-end --
ALTER TABLE rdb_quicc.ref_tree_height_method OWNER TO "QUICC";
-- ddl-end --



-- object: rdb_quicc.tree_class_info | type: TABLE --
-- DROP TABLE rdb_quicc.tree_class_info;
CREATE TABLE rdb_quicc.tree_class_info(
	plot_id integer NOT NULL,
	tree_class_id integer NOT NULL DEFAULT nextval('tree_info_tree_id_species_seq'::regclass),
	org_db_location integer,
	org_db_id integer,
	CONSTRAINT tree_class_info_tbl_pk PRIMARY KEY (plot_id,tree_class_id)

);
-- ddl-end --
ALTER TABLE rdb_quicc.tree_class_info OWNER TO "QUICC";
-- ddl-end --

-- object: rdb_quicc.tree | type: TABLE --
-- DROP TABLE rdb_quicc.tree;
CREATE TABLE rdb_quicc.tree(
	plot_id integer NOT NULL,
	tree_id integer NOT NULL,
	year_measured integer NOT NULL,
	"species_TSN" integer,
	height integer,
	dbh integer,
	age integer,
	sun_access integer,
	position_canopy character,
	age_id_method character,
	height_id_method character,
	is_sapling boolean,
	is_planted boolean,
	is_dead boolean,
	plot_id_plot integer NOT NULL,
	year_measured_plot integer NOT NULL,
	species_tsn_ref_species integer NOT NULL,
	plot_id_tree_info integer NOT NULL,
	tree_id_tree_info integer NOT NULL,
	age_id_method_ref_tree_age_method character NOT NULL,
	height_id_method_ref_tree_height_method character NOT NULL,
	CONSTRAINT tree_table_pk PRIMARY KEY (plot_id,tree_id,year_measured)

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
	species_tsn integer,
	dbh_class_id integer,
	dbh_tree_number integer,
	height_class_id integer,
	height_tree_number integer,
	plot_id_tree_class_info integer NOT NULL,
	tree_class_id_tree_class_info integer NOT NULL DEFAULT nextval('tree_info_tree_id_species_seq'::regclass),
	plot_id_plot integer NOT NULL,
	year_measured_plot integer NOT NULL,
	species_tsn_ref_species integer NOT NULL,
	dbh_class_id_conv_class_dbh integer NOT NULL,
	height_class_id_conv_class_height integer NOT NULL,
	CONSTRAINT class_tree_tbl_pk PRIMARY KEY (plot_id,tree_class_id,year_measured)

);
-- ddl-end --
ALTER TABLE rdb_quicc.class_tree OWNER TO "QUICC";
-- ddl-end --

-- object: rdb_quicc.ref_species | type: TABLE --
-- DROP TABLE rdb_quicc.ref_species;
CREATE TABLE rdb_quicc.ref_species(
	species_tsn integer NOT NULL,
	qc_sp_id character(3),
	nb_sp_id integer,
	on_sp_id integer,
	us_sp_id integer,
	genus character(60),
	species character(60),
	fr_common_name character(100),
	en_common_name character(100),
	CONSTRAINT species_tbl_pk PRIMARY KEY (species_tsn)

);
-- ddl-end --
ALTER TABLE rdb_quicc.ref_species OWNER TO "QUICC";
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
	tree_id integer NOT NULL,
	org_db_location character(20),
	org_db_id integer,
	CONSTRAINT tree_info_tbl_pk PRIMARY KEY (plot_id,tree_id)

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
	seed_plot_size double precision,
	sap_plot_size double precision,
	is_temp boolean,
	has_superplot boolean,
	plot_id_localisation integer,
	plot_id_plot_info integer NOT NULL DEFAULT nextval('plot_info_plot_id_seq'::regclass),
	CONSTRAINT plot_tbl_pk PRIMARY KEY (plot_id,year_measured)

);
-- ddl-end --
ALTER TABLE rdb_quicc.plot OWNER TO "QUICC";
-- ddl-end --

-- object: rdb_quicc.plot_info | type: TABLE --
-- DROP TABLE rdb_quicc.plot_info;
CREATE TABLE rdb_quicc.plot_info(
	plot_id integer NOT NULL DEFAULT nextval('plot_info_plot_id_seq'::regclass),
	org_db_loc character(20),
	org_db_id character(20),
	CONSTRAINT plot_info_tbl_pk PRIMARY KEY (plot_id)

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
	height integer,
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


-- object: ref_species_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.class_tree DROP CONSTRAINT ref_species_fk;
ALTER TABLE rdb_quicc.class_tree ADD CONSTRAINT ref_species_fk FOREIGN KEY (species_tsn_ref_species)
REFERENCES rdb_quicc.ref_species (species_tsn) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --


-- object: ref_species_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.tree DROP CONSTRAINT ref_species_fk;
ALTER TABLE rdb_quicc.tree ADD CONSTRAINT ref_species_fk FOREIGN KEY (species_tsn_ref_species)
REFERENCES rdb_quicc.ref_species (species_tsn) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --


-- object: tree_info_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.tree DROP CONSTRAINT tree_info_fk;
ALTER TABLE rdb_quicc.tree ADD CONSTRAINT tree_info_fk FOREIGN KEY (plot_id_tree_info,tree_id_tree_info)
REFERENCES rdb_quicc.tree_info (plot_id,tree_id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --


-- object: ref_tree_age_method_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.tree DROP CONSTRAINT ref_tree_age_method_fk;
ALTER TABLE rdb_quicc.tree ADD CONSTRAINT ref_tree_age_method_fk FOREIGN KEY (age_id_method_ref_tree_age_method)
REFERENCES rdb_quicc.ref_tree_age_method (age_id_method) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --


-- object: ref_tree_height_method_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.tree DROP CONSTRAINT ref_tree_height_method_fk;
ALTER TABLE rdb_quicc.tree ADD CONSTRAINT ref_tree_height_method_fk FOREIGN KEY (height_id_method_ref_tree_height_method)
REFERENCES rdb_quicc.ref_tree_height_method (height_id_method) MATCH FULL
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
	org_db_location integer,
	CONSTRAINT conv_class_dbh_pk PRIMARY KEY (dbh_class_id)

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
	org_db_location character,
	CONSTRAINT conv_class_height_pk PRIMARY KEY (height_class_id)

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
ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE INITIALLY IMMEDIATE;
-- ddl-end --


-- object: grant_870c782777 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.superplot
   TO "QUICC";
;
-- ddl-end --

-- object: grant_120ff8fe46 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.ref_tree_age_method
   TO "QUICC";
;
-- ddl-end --

-- object: grant_ad1563ade4 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.ref_tree_height_method
   TO "QUICC";
;
-- ddl-end --

-- object: grant_4bbe2fb281 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.tree_class_info
   TO "QUICC";
;
-- ddl-end --

-- object: grant_8ed76f804d | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.tree
   TO "QUICC";
;
-- ddl-end --

-- object: grant_7ec8af7351 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.class_tree
   TO "QUICC";
;
-- ddl-end --

-- object: grant_43b283b01d | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.ref_species
   TO "QUICC";
;
-- ddl-end --

-- object: grant_4c3f21c0fc | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.stand_disturbed
   TO "QUICC";
;
-- ddl-end --

-- object: grant_af0008d158 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.ref_stand_disturb_type
   TO "QUICC";
;
-- ddl-end --

-- object: grant_ab56c24382 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.tree_info
   TO "QUICC";
;
-- ddl-end --

-- object: grant_2ab825024b | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.plot
   TO "QUICC";
;
-- ddl-end --

-- object: grant_1a0027173c | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.plot_info
   TO "QUICC";
;
-- ddl-end --

-- object: grant_4a91e5fd3a | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.stand
   TO "QUICC";
;
-- ddl-end --

