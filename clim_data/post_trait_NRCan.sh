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

# Pre-traitement config Path
SRC=$(pwd)
EXPORT=$SRC/export_climat
TABLE=$SRC/src_sql
DATACLIM=$SRC/clim_data/pntgrids

if [ "$POST" = "no" ]; then
rm -R $EXPORT
mkdir -vp $EXPORT

cd $DATACLIM

for i in $( ls ); do
           cd $i
           echo "Path:" `pwd`
           echo "Unzip txt file in folder:" $i
            gzip -df *.txt.gz
            awk -v yr=$i '{$(NF+1)= yr}1' OFS='|' out$i.txt > $EXPORT/format$i.csv
           cd ..
done
fi

echo "------- SQL: DROP and CREATE climatic tables..."
psql -U $USER -h $HOST -p $PORT -d $DB -c "\i $TABLE/annual_climate_temp_tbl.sql"
psql -U $USER -h $HOST -p $PORT -d $DB -c "\i $TABLE/climate_tbl.sql"

echo "------- SQL: CREATE VIEW range_years...."

psql -U $USER -h $HOST -p $PORT -d $DB -c "
CREATE OR REPLACE VIEW temp_quicc.range_yrs_clim AS
 SELECT DISTINCT plot_info.plot_id,
    plot_info.org_db_id,
    localisation.latitude,
    localisation.longitude,
    plot.year_measured AS year_max,
    plot.year_measured - 16 AS year_min
   FROM rdb_quicc.localisation
   JOIN rdb_quicc.plot_info ON localisation.plot_id = plot_info.plot_id
   JOIN rdb_quicc.plot ON localisation.plot_id = plot.plot_id
  ORDER BY plot_info.plot_id;"

echo "------- SQL:  Import csv file into the temp climatic table..."

for file in $EXPORT/*; do
    echo $file
    cat $file | psql -U $USER -h $HOST -p $PORT -d $DB -c "\copy temp_quicc.climatic_data FROM stdin WITH DELIMITER AS '|' CSV HEADER;"

echo "------- SQL: Import data to final rdb"

psql -U $USER -h $HOST -p $PORT -d $DB -c "
INSERT INTO rdb_quicc.climatic_data
SELECT DISTINCT
  CAST(plot_id AS integer),
  year_data,
  mean_diurnal_range,
  isothermality,
  temp_seasonality,
  max_temp_warmest_period,
  min_temp_coldest_period,
  temp_annual_range,
  mean_temperatre_wettest_quarter,
  mean_temp_driest_quarter,
  mean_temp_warmest_quarter,
  mean_temp_coldest_quarter,
  annual_pp,
  pp_wettest_period,
  pp_driest_period,
  pp_seasonality,
  pp_wettest_quarter,
  pp_driest_quarter,
  pp_warmest_quarter,
  pp_coldest_quarter,
  julian_day_number_start_growing_season,
  julian_day_number_at_end_growing_season,
  number_days_growing_season,
  total_pp_for_period_1,
  total_pp_for_period_3,
  gdd_above_base_temp_for_period_3,
  annual_mean_temp,
  annual_min_temp,
  annual_max_temp,
  mean_temp_for_period_3,
  temp_range_for_period_3,
  january_mean_monthly_min_temp,
  february_mean_monthly_min_temp,
  march_mean_monthly_min_temp,
  april_mean_monthly_min_temp,
  may_mean_monthly_min_temp,
  june_mean_monthly_min_temp,
  july_mean_monthly_min_temp,
  august_mean_monthly_min_temp,
  september_mean_monthly_min_temp,
  october_mean_monthly_min_temp,
  november_mean_monthly_min_temp,
  december_mean_monthly_min_temp,
  january_mean_monthly_max_temp,
  february_mean_monthly_max_temp,
  march_mean_monthly_max_temp,
  april_mean_monthly_max_temp,
  may_mean_monthly_max_temp,
  june_mean_monthly_max_temp,
  july_mean_monthly_max_temp,
  august_mean_monthly_max_temp,
  september_mean_monthly_max_temp,
  october_mean_monthly_max_temp,
  november_mean_monthly_max_temp,
  december_mean_monthly_max_temp,
  january_mean_monthly_pp,
  february_mean_monthly_pp,
  march_mean_monthly_pp,
  april_mean_monthly_pp,
  may_mean_monthly_pp,
  june_mean_monthly_pp,
  july_mean_monthly_pp,
  august_mean_monthly_pp,
  september_mean_monthly_pp,
  october_mean_monthly_pp,
  november_mean_monthly_pp,
  december_mean_monthly_pp
  FROM(SELECT DISTINCT
  climatic_data.id_plot AS org_db_id,
  climatic_data.x_longitude,
  climatic_data.y_latitude,
  climatic_data.year_data,
  temp_quicc.range_yrs_clim.plot_id AS plot_id,
  mean_diurnal_range,
  isothermality,
  temp_seasonality,
  max_temp_warmest_period,
  min_temp_coldest_period,
  temp_annual_range,
  mean_temperatre_wettest_quarter,
  mean_temp_driest_quarter,
  mean_temp_warmest_quarter,
  mean_temp_coldest_quarter,
  annual_pp,
  pp_wettest_period,
  pp_driest_period,
  pp_seasonality,
  pp_wettest_quarter,
  pp_driest_quarter,
  pp_warmest_quarter,
  pp_coldest_quarter,
  julian_day_number_start_growing_season,
  julian_day_number_at_end_growing_season,
  number_days_growing_season,
  total_pp_for_period_1,
  total_pp_for_period_3,
  gdd_above_base_temp_for_period_3,
  annual_mean_temp,
  annual_min_temp,
  annual_max_temp,
  mean_temp_for_period_3,
  temp_range_for_period_3,
  january_mean_monthly_min_temp,
  february_mean_monthly_min_temp,
  march_mean_monthly_min_temp,
  april_mean_monthly_min_temp,
  may_mean_monthly_min_temp,
  june_mean_monthly_min_temp,
  july_mean_monthly_min_temp,
  august_mean_monthly_min_temp,
  september_mean_monthly_min_temp,
  october_mean_monthly_min_temp,
  november_mean_monthly_min_temp,
  december_mean_monthly_min_temp,
  january_mean_monthly_max_temp,
  february_mean_monthly_max_temp,
  march_mean_monthly_max_temp,
  april_mean_monthly_max_temp,
  may_mean_monthly_max_temp,
  june_mean_monthly_max_temp,
  july_mean_monthly_max_temp,
  august_mean_monthly_max_temp,
  september_mean_monthly_max_temp,
  october_mean_monthly_max_temp,
  november_mean_monthly_max_temp,
  december_mean_monthly_max_temp,
  january_mean_monthly_pp,
  february_mean_monthly_pp,
  march_mean_monthly_pp,
  april_mean_monthly_pp,
  may_mean_monthly_pp,
  june_mean_monthly_pp,
  july_mean_monthly_pp,
  august_mean_monthly_pp,
  september_mean_monthly_pp,
  october_mean_monthly_pp,
  november_mean_monthly_pp,
  december_mean_monthly_pp
FROM
  temp_quicc.climatic_data
LEFT JOIN temp_quicc.range_yrs_clim ON
climatic_data.id_plot = temp_quicc.range_yrs_clim.org_db_id AND
climatic_data.x_longitude = temp_quicc.range_yrs_clim.longitude AND
climatic_data.y_latitude = temp_quicc.range_yrs_clim.latitude
WHERE
temp_quicc.range_yrs_clim.plot_id IS NOT NULL AND
temp_quicc.climatic_data.year_data > temp_quicc.range_yrs_clim.year_min AND
temp_quicc.climatic_data.year_data <= temp_quicc.range_yrs_clim.year_max) AS filter;"


echo "------- SQL: Clear temp table"

psql -U $USER -h $HOST -p $PORT -d $DB -c "
DELETE FROM temp_quicc.climatic_data;"


 done

 psql -U $USER -h $HOST -p $PORT -d $DB -c "
DROP TABLE temp_quicc.climatic_data CASCADE;"