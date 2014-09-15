DROP TABLE rdb_quicc.climatic_data CASCADE;

CREATE TABLE rdb_quicc.climatic_data
(
  plot_id integer NOT NULL,
  year_clim integer NOT NULL,
  mean_diurnal_range real,
  isothermality real,
  temp_seasonality real,
  max_temp_warmest_period real,
  min_temp_coldest_period real,
  temp_annual_range real,
  mean_temperatre_wettest_quarter real,
  mean_temp_driest_quarter real,
  mean_temp_warmest_quarter real,
  mean_temp_coldest_quarter real,
  annual_pp real,
  pp_wettest_period real,
  pp_driest_period real,
  pp_seasonality real,
  pp_wettest_quarter real,
  pp_driest_quarter real,
  pp_warmest_quarter real,
  pp_coldest_quarter real,
  julian_day_number_start_growing_season real,
  julian_day_number_at_end_growing_season real,
  number_days_growing_season real,
  total_pp_for_period_1 real,
  total_pp_for_period_3 real,
  gdd_above_base_temp_for_period_3 real,
  annual_mean_temp real,
  annual_min_temp real,
  annual_max_temp real,
  mean_temp_for_period_3 real,
  temp_range_for_period_3 real,
  january_mean_monthly_min_temp real,
  february_mean_monthly_min_temp real,
  march_mean_monthly_min_temp real,
  april_mean_monthly_min_temp real,
  may_mean_monthly_min_temp real,
  june_mean_monthly_min_temp real,
  july_mean_monthly_min_temp real,
  august_mean_monthly_min_temp real,
  september_mean_monthly_min_temp real,
  october_mean_monthly_min_temp real,
  november_mean_monthly_min_temp real,
  december_mean_monthly_min_temp real,
  january_mean_monthly_max_temp real,
  february_mean_monthly_max_temp real,
  march_mean_monthly_max_temp real,
  april_mean_monthly_max_temp real,
  may_mean_monthly_max_temp real,
  june_mean_monthly_max_temp real,
  july_mean_monthly_max_temp real,
  august_mean_monthly_max_temp real,
  september_mean_monthly_max_temp real,
  october_mean_monthly_max_temp real,
  november_mean_monthly_max_temp real,
  december_mean_monthly_max_temp real,
  january_mean_monthly_pp real,
  february_mean_monthly_pp real,
  march_mean_monthly_pp real,
  april_mean_monthly_pp real,
  may_mean_monthly_pp real,
  june_mean_monthly_pp real,
  july_mean_monthly_pp real,
  august_mean_monthly_pp real,
  september_mean_monthly_pp real,
  october_mean_monthly_pp real,
  november_mean_monthly_pp real,
  december_mean_monthly_pp real,
  CONSTRAINT clim_tbl_pk PRIMARY KEY (plot_id,year_clim)
);

ALTER TABLE rdb_quicc.climatic_data
  OWNER TO "QUICC";