QUICC-SQL
=========
**Update:** March, 20th

Work-in-progress...

## TODO on RDB tables

### General

- [x] Add climatic table `CREATE` statement on general rdb_quicc script (**Done**)
- [x] Fix role vissst01 to QUICC in dbm file (**Done**)
- [ ] Move `SEQUENCES` statement upper in pgmodeler script (**MANUAL**) 
- [ ] Check MV fields type correspond to final rdb table 

### Plot_info table

- [x] Generate ID in plot_id reference table (**Done**)
- [x] Table clean, closed and working for: `FIA`, `QC`, `ON`, `NB`

### Location table

- [x] Cleanup coordinates on permanent and temporary sample plots  (**Done**)
- [x] **Check** validity of `RIGHT JOIN` (**Done**)
- [x] Add elevation from temp_quicc.elev_tbl
- [ ] Investigate why some plots don't have an elevation
- [x] Table working for: `FIA`, `QC`, `ON`, `NB`

#### **Filters** (**Done**)
 * Coordinates taken on the last measurement
 * Field `coord_geom` is not empty
 * Only consider maximum geometry_point (*Need further investigations*)

### Plot table 

- [x] Add Year of measurements (**Done**)
- [ ] Compute plot_size by plot for `QC`
- [ ] Remove `DEFAULT nextval('plot_info_plot_id_seq'::regclass)` on plot_id_plot_info **(MANUAL)**
- [ ] Add bolean field: is_planted ?
- [ ] Need create functions on `has_superplot`, `plot_size`, `sapling_plot_size`, `seedling_plot_size`, `is_planted`
- [ ] Table working for: `FIA`, `QC`, `ON`, `NB`

#### **Filters** (**Done**)
 * Remove all plots with no year of measurement (`NB`)

### Climatic data table 

- [x] Filter original climatic data table using the localisation table (**Done**)
- [x] Change climatic_data.id_plot to general id from rdb_quicc.plot_info (**Done**)
- [x] Remove all year not necessary (**Done**)
- [x] Create Pkey on plot_id and year (**Done**)
- [x] Remove lat, long, elevation (**Done**)
- [x] Problem needing to be assess: Some TP and PP in QC schema have the same ID (**Fixed**).
- [ ] Fix other prob: some plots have 15 and else 20 years of climatic data
- [ ] Table working for: `FIA`, `QC`, `ON`, `NB`

### Tree info table 

- [x] tree_id as char(3) for each tree
- [ ] Switch tree_id as numeric/integer ?
- [x] Table working for: `QC`, `ON`, `NB`

### Ref species table 

- [x] Write R script in order to use `Taxize` package
- [x] Clean scientific name and TSN
- [ ] Merge all reference table together (**Almost done**)

### Tree table 

- [ ] Merge queries with UNION ALL
- [ ] Validate ID_tree
- [ ] Table working for: `QC`, `ON`, `NB`, `FIA`

## TODO on conversion functions

### Plot table

- Function #1 Convert class of plot size (*Need further investigations*)
- Function #2 Convert radius to area 

## Getting started

    git clone https://github.com/TheoreticalEcosystemEcology/QUICC-SQL.git
    cd QUICC-SQL/ 
    make all
