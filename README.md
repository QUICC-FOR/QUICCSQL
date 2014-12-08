QUICC-SQL
=========

Work-in-progress...

## TODO on RDB tables

### General

- [ ] Move `SEQUENCES` statement upper in pgmodeler script (**MANUAL**)
- [ ] Add DOMTAR on functions

### Plot table

- [ ] Compute plot_size by plot for `QC`
- [ ] Remove `DEFAULT nextval('plot_info_plot_id_seq'::regclass)` on plot_id_plot_info **(MANUAL)**
- [ ] Add bolean field: is_planted ?
- [ ] Need create functions on `has_superplot`, `plot_size`, `sapling_plot_size`, `seedling_plot_size`, `is_planted`
- [ ] Table working for: `FIA`, `QC`, `ON`, `NB`,`DOMTAR`

### Ref species table

- [ ] Some code from NB are missing (**Need to be checked**)

## Filters:

### New-Brunswick

* Remove all plots with no year of measurement (`NB`)

### All DBs

 * Coordinates taken on the last measurement
 * Field `coord_geom` is not empty
 * Only consider maximum geometry_point (*Need further investigations*)


## TODO on makefile

- Add exception in temp_sch trigger: climatic_tbl need to be untouched.

## Getting started

    git clone https://github.com/TheoreticalEcosystemEcology/QUICC-SQL.git
    cd QUICC-SQL/
    make all
