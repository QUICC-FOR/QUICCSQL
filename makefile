PG_USER = postgres
PG_DB = "QUICC-FOR-Dev"
PG_HOST = localhost
PG_PORT = 5433

SRC = tables_sql
CLIM = clim_data
ARCHI = archi_sql
SP = ref_species_R
FUNC = func_sql
REF = ref_tbl_sql

temp_sch:
	psql -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "DROP SCHEMA temp_quicc CASCADE;"
	psql -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "CREATE SCHEMA temp_quicc;"

rdb_sch:
	psql -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "DROP SCHEMA rdb_quicc CASCADE;"
	psql -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "\i ${ARCHI}/pgmodeler_script_rdb.sql;"

impl_ref:
	psql  -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "\i ${REF}/ref_height_method.sql;"

plot_info_tbl:
	psql  -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "\i ${SRC}/plot_info_tbl.sql;"

localisation_tbl:
	psql  -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "\i ${SRC}/localisation_tbl.sql;"

elev:
	psql  -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "\i ${SRC}/elev_tbl.sql;"
	psql -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "DELETE FROM  temp_quicc.elev_tbl;"
	psql -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "\copy temp_quicc.elev_tbl FROM '${CLIM}/plot_quicc_dem.csv';"
	psql  -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "\i ${SRC}/updt_elev_on_Localisation_tbl.sql;"

plot_tbl:
	psql  -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "\i ${SRC}/plot_tbl.sql;"

tree_info_tbl:
	psql  -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "\i ${SRC}/tree_info_tbl.sql;"

clim_tbl:
	sh ${CLIM}/post_trait_NRCan.sh
	psql  -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "REINDEX TABLE rdb_quicc.climatic_data;"
	clean

species:
	psql -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "\copy rdb_quicc.ref_species FROM '${SP}/final_ref_table_sql.csv' null '' ;"
	psql  -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "REINDEX TABLE rdb_quicc.ref_species;"

functions:
	psql  -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "\i ${FUNC}/conv_functions.sql;"
	psql  -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "\i ${FUNC}/gen_functions.sql;"

all: temp_sch rdb_sch clean functions impl_ref plot_info_tbl localisation_tbl plot_tbl species tree_info_tbl

clean:
	vacuumdb  -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} --analyze --verbose