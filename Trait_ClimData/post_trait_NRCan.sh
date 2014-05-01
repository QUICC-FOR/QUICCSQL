#!/bin/bash

# General config
echo -n "Data folder named 'Export' contains annual climatic data (yes or no) ? "
read  POST

echo -n "Import on remote (UQAR) or local postgres server? "
read  CON

# Database settings
if [ "$CON" = "local" ]; then
  HOST="localhost"
  DB="QUICC-FOR-Dev"
  USER="postgres"
  PORT=5433
fi

if [ "$CON" = "remote" ]; then
  HOST="srbd04.uqar.ca"
  DB="db_quicc_for"
  USER="vissst01"
  PORT=5432
fi

# Pre-traitement config
TRAIT=~/Documents/QUICC_FOR/Climat_data_trait/
EXPORT=~/Documents/QUICC_FOR/Climat_data_trait/Export_climat

if [ "$POST" = "no" ]; then
rm -R $EXPORT
cd $TRAIT
mkdir -vp $EXPORT
cd ./pntgrids

for i in $( ls ); do
           cd $i
           echo "Path:" `pwd`
           echo "Unzip txt file in folder:" $i
            gzip -dkf *.txt.gz
            awk -v yr=$i '{$(NF+1)= yr}1' OFS='|' out$i.txt > $EXPORT/format$i.csv
           cd ..
done
fi

echo "DROP and CREATE climatic table..."
psql -U $USER -h $HOST -p $PORT -d $DB -c "\i ~/Documents/GitHub/QUICC-SQL/Table/climate_tbl.sql"

echo "Import csv file into the climatic table..."

for file in $EXPORT/*; do
    echo $file
     cat $file | psql -U $USER -h $HOST -p $PORT -d $DB -c "\copy rdb_quicc.climatic_data FROM stdin WITH DELIMITER AS '|' CSV HEADER;"
 done

echo "Cleaning climatic data table..."

psql -U postgres -h localhost -p 5433 -d QUICC-FOR-Dev -c "
DELETE FROM rdb_quicc.climatic_data
USING (SELECT rdb_quicc.climatic_data.id_plot,
  rdb_quicc.climatic_data.x_longitude,
  rdb_quicc.climatic_data.y_latitude,
  rdb_quicc.climatic_data.year_data
FROM rdb_quicc.climatic_data
LEFT JOIN (SELECT
  rdb_quicc.plot_info.org_db_id,
  rdb_quicc.plot_info.org_db_loc,
  rdb_quicc.localisation.latitude,
  rdb_quicc.localisation.longitude
FROM
  rdb_quicc.localisation
INNER JOIN rdb_quicc.plot_info ON rdb_quicc.localisation.plot_id = rdb_quicc.plot_info.plot_id) AS ID_query
ON
 ID_query.org_db_id = rdb_quicc.climatic_data.id_plot AND ID_query.latitude = rdb_quicc.climatic_data.y_latitude
  AND longitude = rdb_quicc.climatic_data.x_longitude
WHERE ID_query.org_db_id IS NULL) AS del_rec
WHERE
  rdb_quicc.climatic_data.id_plot=del_rec.id_plot
AND rdb_quicc.climatic_data.x_longitude=del_rec.x_longitude
AND rdb_quicc.climatic_data.y_latitude=del_rec.y_latitude
AND rdb_quicc.climatic_data.year_data=del_rec.year_data;
"

#echo "Updating climatic_data.id_plot to new id generated in rdb_quicc.plot_info... "
#
#psql -U postgres -h localhost -p 5433 -d $DB -c "
#UPDATE rdb_quicc.climatic_data
#SET id_plot=subquery.new_id
#FROM (SELECT  rdb_quicc.plot_info.org_db_id,
#    rdb_quicc.plot_info.plot_id AS new_id,
#    rdb_quicc.localisation.latitude,
#    rdb_quicc.localisation.longitude
#  FROM rdb_quicc.plot_info
# LEFT JOIN rdb_quicc.localisation ON rdb_quicc.plot_info.plot_id = rdb_quicc.localisation.plot_id) AS subquery
#WHERE rdb_quicc.climatic_data.id_plot=subquery.org_db_id
#AND rdb_quicc.climatic_data.y_latitude = subquery.latitude
#AND rdb_quicc.climatic_data.x_longitude = subquery.longitude;"