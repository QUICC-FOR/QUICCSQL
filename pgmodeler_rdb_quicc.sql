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

-- object: rdb_quicc.superplot | type: TABLE --
-- DROP TABLE rdb_quicc.superplot;
CREATE TABLE rdb_quicc.superplot(
	plot_id integer NOT NULL,
	tree_id integer,
	year_measured integer,
	CONSTRAINT plot_id PRIMARY KEY (plot_id)

);
-- ddl-end --
ALTER TABLE rdb_quicc.superplot OWNER TO vissst01;
-- ddl-end --

-- object: rdb_quicc.ref_tree_age_method | type: TABLE --
-- DROP TABLE rdb_quicc.ref_tree_age_method;
CREATE TABLE rdb_quicc.ref_tree_age_method(
	age_id_method character,
	age_desc character varying,
	tree_id integer NOT NULL,
	tree_id_class_tree integer,
	CONSTRAINT tree_id PRIMARY KEY (tree_id),
	CONSTRAINT ref_tree_age_method_uq UNIQUE (tree_id_class_tree)

);
-- ddl-end --
ALTER TABLE rdb_quicc.ref_tree_age_method OWNER TO vissst01;
-- ddl-end --

-- object: rdb_quicc.ref_tree_method | type: TABLE --
-- DROP TABLE rdb_quicc.ref_tree_method;
CREATE TABLE rdb_quicc.ref_tree_method(
	height_id_method character,
	height_desc character varying,
	tree_id integer,
	tree_id_class_tree integer,
	age_id_method character varying,
	CONSTRAINT ref_tree_method_uq UNIQUE (tree_id_class_tree)

);
-- ddl-end --
ALTER TABLE rdb_quicc.ref_tree_method OWNER TO vissst01;
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

-- object: rdb_quicc.tree_info | type: TABLE --
-- DROP TABLE rdb_quicc.tree_info;
CREATE TABLE rdb_quicc.tree_info(
	plot_id integer NOT NULL,
	tree_id_species integer NOT NULL DEFAULT nextval('tree_info_tree_id_species_seq'::regclass),
	org_db_location integer,
	org_db_id integer,
	tree_id_tree integer,
	tree_id_class_tree integer,
	CONSTRAINT tree_id_3 PRIMARY KEY (plot_id,tree_id_species),
	CONSTRAINT tree_info_uq UNIQUE (tree_id_tree)

);
-- ddl-end --
ALTER TABLE rdb_quicc.tree_info OWNER TO vissst01;
-- ddl-end --

-- object: rdb_quicc.tree | type: TABLE --
-- DROP TABLE rdb_quicc.tree;
CREATE TABLE rdb_quicc.tree(
	plot_id integer,
	tree_id integer NOT NULL,
	year_measured integer,
	"species_TSN" integer,
	height integer,
	dbh integer,
	age integer,
	sun_access integer,
	position_canopy character,
	is_sapling integer,
	is_planted integer,
	is_dead integer,
	species_id_ref_species integer,
	plot_id_superplot integer,
	plot_id_plot integer,
	CONSTRAINT tree_id_2 PRIMARY KEY (tree_id,plot_id,year_measured)

);
-- ddl-end --
ALTER TABLE rdb_quicc.tree OWNER TO vissst01;
-- ddl-end --

-- object: rdb_quicc.class_tree | type: TABLE --
-- DROP TABLE rdb_quicc.class_tree;
CREATE TABLE rdb_quicc.class_tree(
	plot_id integer,
	tree_class_id integer NOT NULL,
	year_measured integer,
	species_tsn integer,
	qc_dbh_class integer,
	qc_sapling_number integer,
	nb_height_class character,
	nb_sapling_number integer,
	tree_id_tree integer,
	CONSTRAINT tree_id_1 PRIMARY KEY (tree_class_id,plot_id,year_measured),
	CONSTRAINT class_tree_uq UNIQUE (tree_id_tree)

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
	CONSTRAINT species_id PRIMARY KEY (species_id)

);
-- ddl-end --
ALTER TABLE rdb_quicc.ref_species OWNER TO vissst01;
-- ddl-end --

-- object: rdb_quicc.tbl_stand_disturbed | type: TABLE --
-- DROP TABLE rdb_quicc.tbl_stand_disturbed;
CREATE TABLE rdb_quicc.tbl_stand_disturbed(
	plot_id integer NOT NULL,
	year_disturbed integer,
	disturb_type character,
	disturb_severity character,
	logging_type character(2),
	is_planted boolean,
	plot_id_stand integer,
	CONSTRAINT plot_id_7 PRIMARY KEY (plot_id,year_disturbed)

);
-- ddl-end --
ALTER TABLE rdb_quicc.tbl_stand_disturbed OWNER TO vissst01;
-- ddl-end --

-- object: rdb_quicc.stand_method_info | type: TABLE --
-- DROP TABLE rdb_quicc.stand_method_info;
CREATE TABLE rdb_quicc.stand_method_info(
	plot_id integer NOT NULL,
	age_id_method character,
	age_desc character varying(255),
	disturbance_type character,
	disturbance_info character varying(255),
	height_method character,
	height_info character varying(255),
	CONSTRAINT plot_id_6 PRIMARY KEY (plot_id)

);
-- ddl-end --
ALTER TABLE rdb_quicc.stand_method_info OWNER TO vissst01;
-- ddl-end --

-- object: rdb_quicc.seedling_info | type: TABLE --
-- DROP TABLE rdb_quicc.seedling_info;
CREATE TABLE rdb_quicc.seedling_info(
	plot_id integer NOT NULL,
	seedling_id integer,
	org_db_location character(20),
	org_db_id integer,
	plot_id_seedling integer,
	CONSTRAINT plot_id_5 PRIMARY KEY (plot_id,seedling_id),
	CONSTRAINT seedling_info_uq UNIQUE (plot_id_seedling)

);
-- ddl-end --
ALTER TABLE rdb_quicc.seedling_info OWNER TO vissst01;
-- ddl-end --

-- object: rdb_quicc.seedling | type: TABLE --
-- DROP TABLE rdb_quicc.seedling;
CREATE TABLE rdb_quicc.seedling(
	plot_id integer NOT NULL,
	seedling_id integer,
	year_measured integer,
	species_tsn integer,
	height_class integer,
	nb_height_class integer,
	plot_id_plot integer,
	species_id_ref_species integer,
	CONSTRAINT plot_id_4 PRIMARY KEY (plot_id,seedling_id,year_measured),
	CONSTRAINT seedling_uq UNIQUE (species_id_ref_species)

);
-- ddl-end --
ALTER TABLE rdb_quicc.seedling OWNER TO vissst01;
-- ddl-end --

-- object: rdb_quicc.plot | type: TABLE --
-- DROP TABLE rdb_quicc.plot;
CREATE TABLE rdb_quicc.plot(
	plot_id integer NOT NULL,
	id_meas smallint,
	year_measured integer,
	plot_size double precision,
	seed_plot_size integer,
	sap_plot_size double precision,
	is_subplot boolean,
	is_temp boolean,
	has_superplot boolean,
	plot_id_plot_info integer,
	plot_id_superplot integer,
	plot_id_localisation integer,
	CONSTRAINT plot_id_3 PRIMARY KEY (plot_id,id_meas),
	CONSTRAINT plot_uq UNIQUE (plot_id_plot_info)

);
-- ddl-end --
ALTER TABLE rdb_quicc.plot OWNER TO vissst01;
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
	org_db_loc character(20),
	org_db_id character(20),
	CONSTRAINT plot_id_2 PRIMARY KEY (plot_id)

);
-- ddl-end --
ALTER TABLE rdb_quicc.plot_info OWNER TO vissst01;
-- ddl-end --

-- object: rdb_quicc.stand | type: TABLE --
-- DROP TABLE rdb_quicc.stand;
CREATE TABLE rdb_quicc.stand(
	plot_id integer NOT NULL,
	year_measured integer,
	age integer,
	age_id_method character,
	height integer,
	height_id_method character,
	surface_deposit character(3),
	drainage character,
	slope character,
	is_disturbed boolean,
	is_planted boolean,
	plot_id_stand_method_info integer,
	plot_id_superplot integer,
	CONSTRAINT plot_id_1 PRIMARY KEY (plot_id,year_measured)

);
-- ddl-end --
ALTER TABLE rdb_quicc.stand OWNER TO vissst01;
-- ddl-end --

-- object: rdb_quicc.localisation | type: TABLE --
-- DROP TABLE rdb_quicc.localisation;
CREATE TABLE rdb_quicc.localisation(
	plot_id integer,
	latitude double precision,
	longitude double precision,
	coord_postgis point,
	srid integer,
	elevation integer,
	plot_location character(10),
	CONSTRAINT plot_id_10 PRIMARY KEY (plot_id)

);
-- ddl-end --
ALTER TABLE rdb_quicc.localisation OWNER TO vissst01;
-- ddl-end --

-- object: localisation_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.plot DROP CONSTRAINT localisation_fk;
ALTER TABLE rdb_quicc.plot ADD CONSTRAINT localisation_fk FOREIGN KEY (plot_id_localisation)
REFERENCES rdb_quicc.localisation (plot_id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --


-- object: class_tree_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.ref_tree_age_method DROP CONSTRAINT class_tree_fk;
ALTER TABLE rdb_quicc.ref_tree_age_method ADD CONSTRAINT class_tree_fk FOREIGN KEY (tree_id_class_tree)
REFERENCES rdb_quicc.class_tree (tree_class_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --


-- object: class_tree_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.ref_tree_method DROP CONSTRAINT class_tree_fk;
ALTER TABLE rdb_quicc.ref_tree_method ADD CONSTRAINT class_tree_fk FOREIGN KEY (tree_id_class_tree)
REFERENCES rdb_quicc.class_tree (tree_class_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --


-- object: tree_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.tree_info DROP CONSTRAINT tree_fk;
ALTER TABLE rdb_quicc.tree_info ADD CONSTRAINT tree_fk FOREIGN KEY (tree_id_tree)
REFERENCES rdb_quicc.tree (tree_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --


-- object: class_tree_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.tree_info DROP CONSTRAINT class_tree_fk;
ALTER TABLE rdb_quicc.tree_info ADD CONSTRAINT class_tree_fk FOREIGN KEY (tree_id_class_tree)
REFERENCES rdb_quicc.class_tree (tree_class_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --


-- object: ref_species_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.tree DROP CONSTRAINT ref_species_fk;
ALTER TABLE rdb_quicc.tree ADD CONSTRAINT ref_species_fk FOREIGN KEY (species_id_ref_species)
REFERENCES rdb_quicc.ref_species (species_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --


-- object: superplot_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.tree DROP CONSTRAINT superplot_fk;
ALTER TABLE rdb_quicc.tree ADD CONSTRAINT superplot_fk FOREIGN KEY (plot_id_superplot)
REFERENCES rdb_quicc.superplot (plot_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --


-- object: plot_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.tree DROP CONSTRAINT plot_fk;
ALTER TABLE rdb_quicc.tree ADD CONSTRAINT plot_fk FOREIGN KEY (plot_id_plot)
REFERENCES rdb_quicc.plot (plot_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --


-- object: tree_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.class_tree DROP CONSTRAINT tree_fk;
ALTER TABLE rdb_quicc.class_tree ADD CONSTRAINT tree_fk FOREIGN KEY (tree_id_tree)
REFERENCES rdb_quicc.tree (tree_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --


-- object: stand_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.tbl_stand_disturbed DROP CONSTRAINT stand_fk;
ALTER TABLE rdb_quicc.tbl_stand_disturbed ADD CONSTRAINT stand_fk FOREIGN KEY (plot_id_stand)
REFERENCES rdb_quicc.stand (plot_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --


-- object: seedling_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.seedling_info DROP CONSTRAINT seedling_fk;
ALTER TABLE rdb_quicc.seedling_info ADD CONSTRAINT seedling_fk FOREIGN KEY (plot_id_seedling)
REFERENCES rdb_quicc.seedling (plot_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --


-- object: plot_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.seedling DROP CONSTRAINT plot_fk;
ALTER TABLE rdb_quicc.seedling ADD CONSTRAINT plot_fk FOREIGN KEY (plot_id_plot)
REFERENCES rdb_quicc.plot (plot_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --


-- object: ref_species_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.seedling DROP CONSTRAINT ref_species_fk;
ALTER TABLE rdb_quicc.seedling ADD CONSTRAINT ref_species_fk FOREIGN KEY (species_id_ref_species)
REFERENCES rdb_quicc.ref_species (species_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --


-- object: plot_info_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.plot DROP CONSTRAINT plot_info_fk;
ALTER TABLE rdb_quicc.plot ADD CONSTRAINT plot_info_fk FOREIGN KEY (plot_id_plot_info)
REFERENCES rdb_quicc.plot_info (plot_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --


-- object: superplot_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.plot DROP CONSTRAINT superplot_fk;
ALTER TABLE rdb_quicc.plot ADD CONSTRAINT superplot_fk FOREIGN KEY (plot_id_superplot)
REFERENCES rdb_quicc.superplot (plot_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --


-- object: stand_method_info_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.stand DROP CONSTRAINT stand_method_info_fk;
ALTER TABLE rdb_quicc.stand ADD CONSTRAINT stand_method_info_fk FOREIGN KEY (plot_id_stand_method_info)
REFERENCES rdb_quicc.stand_method_info (plot_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --


-- object: superplot_fk | type: CONSTRAINT --
-- ALTER TABLE rdb_quicc.stand DROP CONSTRAINT superplot_fk;
ALTER TABLE rdb_quicc.stand ADD CONSTRAINT superplot_fk FOREIGN KEY (plot_id_superplot)
REFERENCES rdb_quicc.superplot (plot_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --


-- object: grant_1746c094ed | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.superplot
   TO vissst01;
;
-- ddl-end --

-- object: grant_8be8e7041f | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.ref_tree_age_method
   TO vissst01;
;
-- ddl-end --

-- object: grant_77925c9781 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.ref_tree_method
   TO vissst01;
;
-- ddl-end --

-- object: grant_3903d71c6b | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.tree_info
   TO vissst01;
;
-- ddl-end --

-- object: grant_c9953974bd | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.tree
   TO vissst01;
;
-- ddl-end --

-- object: grant_9f694fdd9c | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.class_tree
   TO vissst01;
;
-- ddl-end --

-- object: grant_715b0bdf70 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.ref_species
   TO vissst01;
;
-- ddl-end --

-- object: grant_ebbc6a6780 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.tbl_stand_disturbed
   TO vissst01;
;
-- ddl-end --

-- object: grant_b8d238e060 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.stand_method_info
   TO vissst01;
;
-- ddl-end --

-- object: grant_139e36910a | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.seedling_info
   TO vissst01;
;
-- ddl-end --

-- object: grant_3af24c3227 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.seedling
   TO vissst01;
;
-- ddl-end --

-- object: grant_024b65998a | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.plot
   TO vissst01;
;
-- ddl-end --

-- object: grant_808077afc5 | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.plot_info
   TO vissst01;
;
-- ddl-end --

-- object: grant_3866534cbb | type: PERMISSION --
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER
   ON TABLE rdb_quicc.stand
   TO vissst01;
;
-- ddl-end --


