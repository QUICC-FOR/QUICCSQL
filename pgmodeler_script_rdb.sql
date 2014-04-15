-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.7.0
-- PostgreSQL version: 9.3
-- Project Site: pgmodeler.com.br
-- Model Author: ---

SET check_function_bodies = false;
-- ddl-end --

-- object: "QUICC_CONSULT" | type: ROLE --
-- DROP ROLE "QUICC_CONSULT";
CREATE ROLE "QUICC_CONSULT" WITH
	INHERIT
	ENCRYPTED PASSWORD '********'
	ROLE gravdo01;
COMMENT ON ROLE "QUICC_CONSULT" IS 'Groupe quicc pour consultation';
-- ddl-end --


-- Database creation must be done outside an multicommand file.
-- These commands were put in this file only for convenience.
-- -- object: new_database | type: DATABASE --
-- -- DROP DATABASE new_database;
-- CREATE DATABASE new_database
-- ;
-- -- ddl-end --
--

-- object: rdb_quicc | type: SCHEMA --
-- DROP SCHEMA rdb_quicc;
CREATE SCHEMA rdb_quicc;
ALTER SCHEMA rdb_quicc OWNER TO vissst01;
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
ALTER SEQUENCE rdb_quicc.plot_info_plot_id_seq OWNER TO vissst01;
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
ALTER SEQUENCE rdb_quicc.tree_info_tree_id_species_seq OWNER TO vissst01;
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
ALTER TABLE rdb_quicc.superplot OWNER TO vissst01;
-- ddl-end --

-- object: rdb_quicc.ref_tree_age_method | type: TABLE --
-- DROP TABLE rdb_quicc.ref_tree_age_method;
CREATE TABLE rdb_quicc.ref_tree_age_method(
	age_id_method character NOT NULL,
	age_desc character varying,
	CONSTRAINT tree_age_method_pk PRIMARY KEY (age_id_method)

);
-- ddl-end --
ALTER TABLE rdb_quicc.ref_tree_age_method OWNER TO vissst01;
-- ddl-end --

-- object: rdb_quicc.ref_tree_height_method | type: TABLE --
-- DROP TABLE rdb_quicc.ref_tree_height_method;
CREATE TABLE rdb_quicc.ref_tree_height_method(
	height_id_method character NOT NULL,
	height_desc character varying,
	CONSTRAINT tree_height_method_pk PRIMARY KEY (height_id_method)

);
-- ddl-end --
ALTER TABLE rdb_quicc.ref_tree_height_method OWNER TO vissst01;
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
ALTER TABLE rdb_quicc.tree_class_info OWNER TO vissst01;
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
	is_sapling integer,
	is_planted integer,
	is_dead integer,
	plot_id_plot_meas integer NOT NULL,
	id_meas_plot_meas smallint NOT NULL,
	species_id_ref_species integer NOT NULL,
	plot_id_tree_info integer NOT NULL,
	tree_id_tree_info integer NOT NULL,
	age_id_method_ref_tree_age_method character NOT NULL,
	height_id_method_ref_tree_height_method character NOT NULL,
	CONSTRAINT tree_table_pk PRIMARY KEY (plot_id,tree_id,year_measured)

);
-- ddl-end --
ALTER TABLE rdb_quicc.tree OWNER TO vissst01;
-- ddl-end --

-- object: rdb_quicc.class_tree | type: TABLE --
-- DROP TABLE rdb_quicc.class_tree;
CREATE TABLE rdb_quicc.class_tree(
	plot_id integer NOT NULL,
	tree_class_id integer NOT NULL,
	year_measured integer NOT NULL,
	species_tsn integer,
	dbh_class integer,
	dbh_tree_number integer,
	height_class character,
	height_tree_number integer,
	plot_id_tree_class_info integer NOT NULL,
	tree_class_id_tree_class_info integer NOT NULL DEFAULT nextval('tree_info_tree_id_species_seq'::regclass),
	plot_id_plot_meas integer NOT NULL,
	id_meas_plot_meas smallint NOT NULL,
	species_id_ref_species integer NOT NULL,
	CONSTRAINT class_tree_tbl_pk PRIMARY KEY (plot_id,tree_class_id,year_measured)

);
-- ddl-end --
ALTER TABLE rdb_quicc.class_tree OWNER TO vissst01;
-- ddl-end --

-- object: rdb_quicc.ref_species | type: TABLE --
-- DROP TABLE rdb_quicc.ref_species;
CREATE TABLE rdb_quicc.ref_species(
	species_id integer NOT NULL,
	qc_sp_id character(3),
	nb_sp_id integer,
	on_sp_id integer,
	us_sp_id integer,
	genus character(60),
	species character(60),
	fr_common_name character(60),
	en_common_name character(60),
	CONSTRAINT species_tbl_pk PRIMARY KEY (species_id)

);
-- ddl-end --
ALTER TABLE rdb_quicc.ref_species OWNER TO vissst01;
-- ddl-end --

-- object: rdb_quicc.tbl_stand_disturbed | type: TABLE --
-- DROP TABLE rdb_quicc.tbl_stand_disturbed;
CREATE TABLE rdb_quicc.tbl_stand_disturbed(
	plot_id integer NOT NULL,
	year_disturbed integer NOT NULL,
	disturb_type character,
	disturb_severity character,
	logging_type character(2),
	is_planted boolean,
	plot_id_stand integer,
	plot_id_stand1 integer NOT NULL,
	year_measured_stand integer NOT NULL,
	CONSTRAINT stand_disturbed_tbl_pk PRIMARY KEY (plot_id,year_disturbed)

);
-- ddl-end --
ALTER TABLE rdb_quicc.tbl_stand_disturbed OWNER TO vissst01;
-- ddl-end --

-- object: rdb_quicc.ref_stand_method | type: TABLE --
-- DROP TABLE rdb_quicc.ref_stand_method;
CREATE TABLE rdb_quicc.ref_stand_method(
	plot_id integer NOT NULL,
	age_id_method character,
	age_desc character varying(255),
	disturbance_type character,
	disturbance_info character varying(255),
	height_method character,
	height_info character varying(255),
	CONSTRAINT ref_stand_meth_tbl_pk PRIMARY KEY (plot_id)

);
-- ddl-end --
ALTER TABLE rdb_quicc.ref_stand_method OWNER TO vissst01;
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
ALTER TABLE rdb_quicc.tree_info OWNER TO vissst01;
-- ddl-end --

-- object: rdb_quicc.plot_meas | type: TABLE --
-- DROP TABLE rdb_quicc.plot_meas;
CREATE TABLE rdb_quicc.plot_meas(
	plot_id integer NOT NULL,
	id_meas smallint NOT NULL,
	year_measured integer,
	plot_size double precision,
	seed_plot_size integer,
	sap_plot_size double precision,
	is_subplot boolean,
	is_temp boolean,
	has_superplot boolean,
	plot_id_localisation integer NOT NULL,
	plot_id_plot_info integer NOT NULL DEFAULT nextval('plot_info_plot_id_seq'::regclass),
	CONSTRAINT plot_tbl_pk PRIMARY KEY (plot_id,id_meas)

);
-- ddl-end --
ALTER TABLE rdb_quicc.plot_meas OWNER TO vissst01;
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
ALTER TABLE rdb_quicc.plot_info OWNER TO vissst01;
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
	plot_id_plot_meas integer NOT NULL,
	id_meas_plot_meas smallint NOT NULL,
	CONSTRAINT stand_tbl_pk PRIMARY KEY (plot_id,year_measured)

);
-- ddl-end --
ALTER TABLE rdb_quicc.stand OWNER TO vissst01;
-- ddl-end --

-- object: rdb_quicc.localisation | type: TABLE --
-- DROP TABLE rdb_quicc.localisation;
CREATE TABLE rdb_quicc.localisation(
	plot_id integer NOT NULL,
	latitude double precision,
	longitude double precision,
	coord_postgis point,
	srid integer,
	elevation integer,
	plot_location character(10),
	CONSTRAINT localis_tbl_pk PRIMARY KEY (plot_id)

);
-- ddl-end --
ALTER TABLE rdb_quicc.localisation OWNER TO vissst01;
-- ddl-end --

-- object: localisation_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.plot_meas DROP CONSTRAINT localisation_fk;
ALTER TABLE rdb_quicc.plot_meas ADD CONSTRAINT localisation_fk FOREIGN KEY (plot_id_localisation)
REFERENCES rdb_quicc.localisation (plot_id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --


-- object: plot_info_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.plot_meas DROP CONSTRAINT plot_info_fk;
ALTER TABLE rdb_quicc.plot_meas ADD CONSTRAINT plot_info_fk FOREIGN KEY (plot_id_plot_info)
REFERENCES rdb_quicc.plot_info (plot_id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --


-- object: plot_meas_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.stand DROP CONSTRAINT plot_meas_fk;
ALTER TABLE rdb_quicc.stand ADD CONSTRAINT plot_meas_fk FOREIGN KEY (plot_id_plot_meas,id_meas_plot_meas)
REFERENCES rdb_quicc.plot_meas (plot_id,id_meas) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --


-- object: stand_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.tbl_stand_disturbed DROP CONSTRAINT stand_fk;
ALTER TABLE rdb_quicc.tbl_stand_disturbed ADD CONSTRAINT stand_fk FOREIGN KEY (plot_id_stand1,year_measured_stand)
REFERENCES rdb_quicc.stand (plot_id,year_measured) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --


-- object: tree_class_info_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.class_tree DROP CONSTRAINT tree_class_info_fk;
ALTER TABLE rdb_quicc.class_tree ADD CONSTRAINT tree_class_info_fk FOREIGN KEY (plot_id_tree_class_info,tree_class_id_tree_class_info)
REFERENCES rdb_quicc.tree_class_info (plot_id,tree_class_id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --


-- object: plot_meas_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.class_tree DROP CONSTRAINT plot_meas_fk;
ALTER TABLE rdb_quicc.class_tree ADD CONSTRAINT plot_meas_fk FOREIGN KEY (plot_id_plot_meas,id_meas_plot_meas)
REFERENCES rdb_quicc.plot_meas (plot_id,id_meas) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --


-- object: plot_meas_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.tree DROP CONSTRAINT plot_meas_fk;
ALTER TABLE rdb_quicc.tree ADD CONSTRAINT plot_meas_fk FOREIGN KEY (plot_id_plot_meas,id_meas_plot_meas)
REFERENCES rdb_quicc.plot_meas (plot_id,id_meas) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --


-- object: ref_species_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.class_tree DROP CONSTRAINT ref_species_fk;
ALTER TABLE rdb_quicc.class_tree ADD CONSTRAINT ref_species_fk FOREIGN KEY (species_id_ref_species)
REFERENCES rdb_quicc.ref_species (species_id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --


-- object: ref_species_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.tree DROP CONSTRAINT ref_species_fk;
ALTER TABLE rdb_quicc.tree ADD CONSTRAINT ref_species_fk FOREIGN KEY (species_id_ref_species)
REFERENCES rdb_quicc.ref_species (species_id) MATCH FULL
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


-- object: grant_c762205cd3 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.superplot
   TO vissst01;
;
-- ddl-end --

-- object: grant_2a2f805d33 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.ref_tree_age_method
   TO vissst01;
;
-- ddl-end --

-- object: grant_40682b70a7 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.ref_tree_height_method
   TO vissst01;
;
-- ddl-end --

-- object: grant_6a72cdf293 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.tree_class_info
   TO vissst01;
;
-- ddl-end --

-- object: grant_efb03bc6f8 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.tree
   TO vissst01;
;
-- ddl-end --

-- object: grant_b95f7bbf34 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.class_tree
   TO vissst01;
;
-- ddl-end --

-- object: grant_27b555483a | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.ref_species
   TO vissst01;
;
-- ddl-end --

-- object: grant_d80d5ec090 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.tbl_stand_disturbed
   TO vissst01;
;
-- ddl-end --

-- object: grant_f7d9aff9c6 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.ref_stand_method
   TO vissst01;
;
-- ddl-end --

-- object: grant_4e25465b36 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.tree_info
   TO vissst01;
;
-- ddl-end --

-- object: grant_fd6f10bae5 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.plot_meas
   TO vissst01;
;
-- ddl-end --

-- object: grant_391fe03a2b | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.plot_info
   TO vissst01;
;
-- ddl-end --

-- object: grant_0c78e34767 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.stand
   TO vissst01;
;
-- ddl-end --


