-- Table: rdb_quicc.ref_species

DROP TABLE rdb_quicc.ref_species CASCADE;

CREATE TABLE rdb_quicc.ref_species
(
  id_spe character varying(15) NOT NULL,
  tsn integer,
  genus character varying(60),
  species character varying(60),
  en_common_name character varying(100),
  fr_common_name character varying(100),
  qc_code character varying(3),
  on_tree_code integer,
  on_alpha_code character varying(3),
  us_code integer,
  nb_code integer,
  CONSTRAINT ref_species_tbl_pk PRIMARY KEY (id_spe)
);

ALTER TABLE rdb_quicc.climatic_data
  OWNER TO "QUICC";