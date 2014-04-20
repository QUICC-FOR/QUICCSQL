-- Table: qc_pp.pp_climatic_data

DROP TABLE rdb_quicc.climatic_data;

CREATE TABLE rdb_quicc.climatic_data
(
  id_plot character varying NOT NULL,
  x_longitude double precision,
  y_latitiude double precision,
  z_elevation double precision,
  mean_diurnal_range double precision,
  isothermality double precision,
  temp_seasonality double precision,
  max_temp_warmest_period double precision,
  min_temp_coldest_period double precision,
  temp_annual_range double precision,
  mean_temperatre_wettest_quarter double precision,
  mean_temp_driest_quarter double precision,
  mean_temp_warmest_quarter double precision,
  mean_temp_coldest_quarter double precision,
  annual_pp double precision,
  pp_wettest_period double precision,
  pp_driest_period double precision,
  pp_seasonality double precision,
  pp_wettest_quarter double precision,
  pp_driest_quarter double precision,
  pp_warmest_quarter double precision,
  pp_coldest_quarter double precision,
  julian_day_number_start_growing_season double precision,
  julian_day_number_at_end_growing_season double precision,
  number_days_growing_season double precision,
  total_pp_for_period_1 double precision,
  total_pp_for_period_3 double precision,
  gdd_above_base_temp_for_period_3 double precision,
  annual_mean_temp double precision,
  annual_min_temp double precision,
  annual_max_temp double precision,
  mean_temp_for_period_3 double precision,
  temp_range_for_period_3 double precision,
  january_mean_monthly_min_temp double precision,
  february_mean_monthly_min_temp double precision,
  march_mean_monthly_min_temp double precision,
  april_mean_monthly_min_temp double precision,
  may_mean_monthly_min_temp double precision,
  june_mean_monthly_min_temp double precision,
  july_mean_monthly_min_temp double precision,
  august_mean_monthly_min_temp double precision,
  september_mean_monthly_min_temp double precision,
  october_mean_monthly_min_temp double precision,
  november_mean_monthly_min_temp double precision,
  december_mean_monthly_min_temp double precision,
  january_mean_monthly_max_temp double precision,
  february_mean_monthly_max_temp double precision,
  march_mean_monthly_max_temp double precision,
  april_mean_monthly_max_temp double precision,
  may_mean_monthly_max_temp double precision,
  june_mean_monthly_max_temp double precision,
  july_mean_monthly_max_temp double precision,
  august_mean_monthly_max_temp double precision,
  september_mean_monthly_max_temp double precision,
  october_mean_monthly_max_temp double precision,
  november_mean_monthly_max_temp double precision,
  december_mean_monthly_max_temp double precision,
  january_mean_monthly_pp double precision,
  february_mean_monthly_pp double precision,
  march_mean_monthly_pp double precision,
  april_mean_monthly_pp double precision,
  may_mean_monthly_pp double precision,
  june_mean_monthly_pp double precision,
  july_mean_monthly_pp double precision,
  august_mean_monthly_pp double precision,
  september_mean_monthly_pp double precision,
  october_mean_monthly_pp double precision,
  november_mean_monthly_pp double precision,
  december_mean_monthly_pp double precision,
  year_data integer NOT NULL,
  CONSTRAINT climatic_data_pk PRIMARY KEY (id_plot,year_data)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE rdb_quicc.climatic_data
  OWNER TO "QUICC";
