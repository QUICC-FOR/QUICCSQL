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
GEN = gen_scripts

##################################################
## Prepare schema, reference tables and functions
##################################################

temp_sch:
	psql -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "DROP SCHEMA temp_quicc CASCADE;"
	psql -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "CREATE SCHEMA temp_quicc;"

rdb_sch:
	psql -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "DROP SCHEMA rdb_quicc CASCADE;"
	psql -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "\i ${ARCHI}/pgmodeler_script_rdb.sql;"

impl_ref:
	psql  -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "\i ${REF}/ref_height_method.sql;"

species:
	psql -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "\copy rdb_quicc.ref_species FROM '${SP}/final_ref_table_sql.csv' null '' ;"
	psql  -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "REINDEX TABLE rdb_quicc.ref_species;"

functions:
	psql  -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "\i ${FUNC}/conv_functions.sql;"
	psql  -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "\i ${FUNC}/gen_functions.sql;"


###########################################################################
### Create temporary tables (view) and populate relational database tables
###########################################################################


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

tree_doublons:
	psql  -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "\i ${GEN}/manage_doublons_on.sql;"

tree_info_tbl:
	psql  -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "\i ${SRC}/tree_info_tbl.sql;"

tree_tbl:
	psql  -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "\i ${SRC}/tree_tbl.sql;"



#######################
### Add climatic data
#######################

clim_tbl:
	sh ${CLIM}/post_trait_NRCan.sh
	psql  -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "REINDEX TABLE rdb_quicc.climatic_data;"
	clean


####################
### General command
####################

all: rdb_sch clean temp_sch impl_ref species functions plot_info_tbl localisation_tbl elev plot_tbl tree_doublons tree_info_tbl plot_tbl clim_tbl clean tree_tbl  

clean:
	vacuumdb  -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} --analyze --verbose