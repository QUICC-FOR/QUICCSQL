QUICC-SQL
=========
**Update:** March, 12th

Work-in-progress...

### TODO on RDB tables

#### General

- Add climatic table `CREATE` statement on general rdb_quicc script (**Done**)
- Fix role vissst01 to QUICC in dbm file (**Done**)
- Move `SEQUENCES` statement upper in pgmodeler script (**MANUAL**) 
- Check MV fields type correspond to final rdb table 

#### Plot_info table

- Generate ID in plot_id reference table (**Done**)
- Table clean, closed and working for: `FIA`, `QC`, `ON`, `NB`

#### Location table

- Cleanup coordinates on permanent and temporary sample plots  (**Done**)
- **Check** validity of `RIGHT JOIN` (**Done**)
- Table clean, closed and working for: `FIA`, `QC`, `ON`, `NB`

##### **Filters** (**Done**)
 * Coordinates taken on the last measurement
 * Field `coord_geom` is not empty
 * Only consider maximum geometry_point (*Need further investigations*)

#### Plot table 

- Add Year of measurements (**Done**)
- Compute plot_size by plot for `QC`
- Remove `DEFAULT nextval('plot_info_plot_id_seq'::regclass)` on plot_id_plot_info **(MANUAL)**
- Need create functions on `has_superplot`, `plot_size`, `sapling_plot_size`, `seedling_plot_size`
- Table working for: `FIA`, `QC`, `ON`, `NB`

##### **Filters** (**Done**)
 * Remove all plots with no year of measurement (`NB`)

#### Climatic data table 

- Filter original climatic data table using the localisation table (**Done**)
- Change climatic_data.id_plot to general id from rdb_quicc.plot_info (**Done**)
- Remove all year not necessary (**Done**)
- Create Pkey on plot_id and year (**Done**)
- Remove lat, long, elevation (**Done**)
- Problem needing to be assess: Some TP and PP in QC schema have the same ID.
- Table clean, closed and working for: `FIA`, `QC`, `ON`, `NB`

#### Tree info table 

- Next step

#### Tree table 

- Next step

### TODO on conversion functions

#### Plot table

- Function #1 Convert class of plot size (*Need further investigations*)
- Function #2 Convert radius to area 

### Order to run the scripts :

1. pgmodeler_script_rdb.sql
2. plot_info_tbl.sql
3. climate_tbl.sql and localisation_tbl.sql
4. plot_tbl.sql
5. script bash on `Post_trait_NRCan.sh`
