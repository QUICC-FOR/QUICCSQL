export PGPORT ?= 4488
PG_PATH ?= $(shell if test -d /usr/lib/postgresql/9.1; then echo /usr/lib/postgresql/9.1; else echo /usr/lib/postgresql/8.4; fi)
PG_DIR = ${PWD}/instance/var
PG_DATA = ${PG_DIR}/data
PG_RUN = ${PG_DIR}/run
PG_LOG = ${PG_DIR}/log
PG_SOCKET = ${PG_RUN}/.s.PGSQL.${PGPORT}
PGPARAMS = -D ${PG_DATA} -o "-F -c unix_socket_directory=${PG_RUN} -c custom_variable_classes='busy' -c busy.active_user=0" -l ${PG_LOG}/pg.log


${PG_DATA}/postgresql.conf:
    mkdir -p ${PG_DATA}
    ${PG_PATH}/bin/initdb -D ${PG_DATA} -E UNICODE

${PG_DATA}/initialized:
    ${PG_PATH}/bin/createdb -E UTF8 test -h ${PG_RUN}
    ${PG_PATH}/bin/createdb -E UTF8 development -h ${PG_RUN}
    echo 1 > ${PG_DATA}/initialized

instance/done: ${PG_DATA}/postgresql.conf
    $(MAKE) start_database
    $(MAKE) ${PG_DATA}/initialized
    $(MAKE) stop_database
    echo 1 > ${PWD}/instance/done

${PG_SOCKET}:
    mkdir -p ${PG_RUN}
    mkdir -p ${PG_LOG}
    ${PG_PATH}/bin/pg_ctl $(PGPARAMS) start -w

.PHONY: testpsql
testpsql:
    psql -h ${PG_RUN}/ -d test

.PHONY: devpsql
devpsql: ${PG_RUN}/.s.PGSQL.${PGPORT}
    psql -h ${PG_RUN}/ -d development

.PHONY: reset_development
reset_development: ${PG_SOCKET}
    psql -h ${PG_RUN}/ -d development -c "drop schema public cascade"
    psql -h ${PG_RUN}/ -d development -c "create schema public"

.PHONY: reset_test
reset_test: ${PG_SOCKET}
    psql -h ${PG_RUN}/ -d development -c "drop schema public cascade"
    psql -h ${PG_RUN}/ -d development -c "create schema public"

.PHONY: start_database
start_database: ${PG_DATA}/postgresql.conf ${PG_RUN}/.s.PGSQL.${PGPORT}

.PHONY: force_start_database
force_start_database:
    ${PG_PATH}/bin/pg_ctl $(PGPARAMS) start -w

.PHONY: database_status
database_status:
    ${PG_PATH}/bin/pg_ctl $(PGPARAMS) status

.PHONY: stop_database
stop_database:
    test -f ${PG_DATA}/postmaster.pid && ${PG_PATH}/bin/pg_ctl $(PGPARAMS) stop -m i || true

schema.sql:
    ${PG_PATH}/bin/pg_dump --format=p -h ${PG_RUN}/ development -s -x -O > schema.sql

.PHONY: download_backup
download_backup:
    mkdir -p backup
    scp server:/var/backup/example.com/dbdump ./backup/dbdump

.PHONY: import_backup
import_backup: ${PG_SOCKET}
    psql -h ${PG_RUN}/ -d development -c "drop schema public cascade"
    ${PG_PATH}/bin/droplang plpgsql development -h ${PG_RUN}/ || true
    psql -h ${PG_RUN}/ -d development -c "create schema public"
    ${PG_PATH}/bin/pg_restore -d development -h ${PG_RUN} --no-owner < backup/dbdump || true
    psql -h ${PG_RUN}/ -d development -c "update users set password = '\$$2a\$$04\$$DqEhufK/FNt46xIhKDQDO.OJNGKFMFAS5R4tOTV2JmjrmhPyuGHDS'"

.PHONY: dbdump
dbdump: ${PG_SOCKET}
    ${PG_PATH}/bin/pg_dump --format=c -h ${PG_RUN}/ development > dbdump
