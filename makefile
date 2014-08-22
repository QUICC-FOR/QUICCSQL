PG_USER = postgres
PG_DB = "QUICC-FOR-Dev"
PG_HOST = localhost
PG_PORT = 5433
SRC = src_sql
CLIM = clim_data
SP = ref_species_R

temp_sch:
	psql -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "DROP SCHEMA temp_quicc CASCADE;"
	psql -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "CREATE SCHEMA temp_quicc;"

rdb_sch:
	psql -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "DROP SCHEMA rdb_quicc CASCADE;"
	psql -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "\i ${SRC}/pgmodeler_script_rdb.sql;"

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

species:
	psql  -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "\i ${SRC}/ref_species_tbl.sql;"
	psql -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "\copy rdb_quicc.ref_species FROM '${SP}/final_ref_table.csv' null '' ;"


all: temp_sch rdb_sch  species plot_info_tbl localisation_tbl elev plot_tbl tree_info_tbl

clean:
	vacuumdb  -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} --analyze --verbose
