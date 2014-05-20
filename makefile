PG_USER = postgres
PG_DB = "QUICC-FOR-Dev"
PG_HOST = localhost
PG_PORT = 5433
SRC = src_sql
CLIM = clim_data

schema:
	psql -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "DROP SCHEMA rdb_quicc CASCADE;"
	psql -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "\i ${SRC}/pgmodeler_script_rdb.sql;"

plot_info_tbl:
	psql  -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "\i ${SRC}/plot_info_tbl.sql;"

elev:
	psql  -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "\i ${SRC}/elev_tbl.sql;"
	psql -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "DELETE FROM  temp_quicc.elev_tbl;"
	psql -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "\copy temp_quicc.elev_tbl FROM './clim_data/plot_quicc_dem.csv';"
	psql  -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "\i ${SRC}/updt_elev_on_Localisation_tbl.sql;"

localisation_tbl:
	psql  -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "\i ${SRC}/localisation_tbl.sql;"

plot_tbl:
	psql  -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "\i ${SRC}/plot_tbl.sql;"

tree_info_tbl:
	psql  -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "\i ${SRC}/tree_info_tbl.sql;"

clim_tbl:
	sh ${CLIM}/post_trait_NRCan.sh


all: schema plot_info_tbl elev localisation_tbl plot_tbl tree_info_tbl

clean:
	vacuumdb  -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} --analyze --verbose