PG_USER = postgres
PG_DB = "QUICC-FOR-Dev"
PG_HOST = localhost
PG_PORT = 5433
SRC = src_sql

.PHONY: Reinitialize rdb_quicc schema...
schema:
	psql -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "DROP SCHEMA rdb_quicc CASCADE;"
	psql -U ${PG_USER} -h ${PG_HOST} -p ${PG_PORT} -d ${PG_DB} -c "\i ${SRC}/pgmodeler_script_rdb.sql;"

.PHONY: Import data on plot_info_tbl
plot_info_tbll:
	psql  -U ${PG_USER} -h ${PG_DB} -p ${PG_PORT} -d ${PG_DB} -c "\i ${SRC}/plot_info_tbl.sql;"
