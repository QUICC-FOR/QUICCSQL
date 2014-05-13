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

localisation_tbl:
	psql  -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "\i ${SRC}/localisation_tbl.sql;"

plot_tbl:
	psql  -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "\i ${SRC}/plot_tbl.sql;"

clim_tbl:
	sh ${CLIM}/post_trait_NRCan.sh

all: schema plot_info_tbl plot_tbl clim_tbl

clean:
	psql -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "DROP SCHEMA rdb_quicc CASCADE;"