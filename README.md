QUICC-SQL
=========
**Update:** September, 15th

Work-in-progress...

## TODO on RDB tables

### General

- [x] Add climatic table `CREATE` statement on general rdb_quicc script (**Done**)
- [x] Fix role vissst01 to QUICC in dbm file (**Done**)
- [ ] Move `SEQUENCES` statement upper in pgmodeler script (**MANUAL**) 
- [ ] Check MV fields type correspond to final rdb table 

### Plot_info table

- [x] Generate ID in plot_id reference table (**Done**)
- [x] Table clean, closed and working for: `FIA`, `QC`, `ON`, `NB`,`DOMTAR`

### Location table

- [x] Cleanup coordinates on permanent and temporary sample plots  (**Done**)
- [x] **Check** validity of `RIGHT JOIN` (**Done**)
- [x] Add elevation from temp_quicc.elev_tbl
- [ ] Investigate why some plots don't have an elevation
- [x] Table working for: `FIA`, `QC`, `ON`, `NB`,`DOMTAR`

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
- [ ] Table working for: `FIA`, `QC`, `ON`, `NB`,`DOMTAR`

#### **Filters** (**Done**)
 * Remove all plots with no year of measurement (`NB`)

### Climatic data table 

- [x] Filter original climatic data table using the localisation table (**Done**)
- [x] Change climatic_data.id_plot to general id from rdb_quicc.plot_info (**Done**)
- [x] Remove all year not necessary (**Done**)
- [x] Create Pkey on plot_id and year (**Done**)
- [x] Remove lat, long, elevation (**Done**)
- [x] Problem needing to be assess: Some TP and PP in QC schema have the same ID (**Fixed**).
- [x] Fix other prob: some plots have 15 and else 20 years of climatic data
- [ ] Send a new climatic data request to Dan in order to get `DOMTAR`
- [x] Table working for: `FIA`, `QC`, `ON`, `NB`

### Tree info table 

- [x] tree_id as char(3) for each tree
- [ ] Switch tree_id as numeric/integer ?
- [x] Table working for: `QC`, `ON`, `NB`

### Ref species table 

- [x] Write R script in order to use `Taxize` package
- [x] Clean scientific name and TSN
- [x] Retrieve fr_com_name and en_com_name using ITIS API
- [ ] Some code from NB are missing (**Need to be checked**)
- [x] Merge all reference table together (**Done**)

#### **Code removed** 

##### Unknown code

|id    |fr_com_name           |**qc_code**  |**new_code**  |
|:-----|:---------------------|:--------|:---------|
|1966  |Résineux inconnu      |RES      |UNK       |
|1967  |Feuillu inconnu       |FEU      |UNK       |
|1968  |Gadellier des chiens  |RIC      |UNK       |
|1969  |Gadellier hérissé     |RIH      |UNK       |
|1970  |Genre inconnu         |INC      |UNK       |

##### Duplicated code

|     tsn|en_com_name                           |  us_code|  new_code|
|-------:|:-------------------------------------|--------:|---------:|
|   18036|Honduras pine                         |      144|       111|
|   18048|Eastern red cedar ;southern redcedar  |       67|        68|
|   19042|netleaf hackberry                     |      463|       461|
|   19457|Ozark chinkapin                       |      423|       422|
|   21536|Basswood ;Carolina basswood           |      953|       952|
|   21536|Basswood ;American basswood           |      951|       952|
|   22445|Cottonwood ;eastern cottonwood        |      742|       745|
|   22453|Balsam poplar ;black cottonwood       |      747|       741|
|   23825|Surinam bulletwood                    |     7663|      7662|
|   24764|Black cherry ;black cherry            |      762|      8349|
|   27204|lathberry                             |     7068|      7067|
|   27248|bayrumtree                            |     8178|      8177|
|   28013|Ilex urbaniana                        |     7466|      7465|
|   28696|western soapberry                     |      919|      8529|
|   28708|Puerto Rico ceboruquillo              |     8794|      8793|
|   28718|Texas buckeye                         |      334|       331|
|   30199|Plumeria obtusa                       |     8269|      8268|
|   35101|Oahu wild coffee                      |     8382|      8377|
|  181830|corkbark fir                          |       18|        19|
|  183353|Arizona pinyon pine                   |      143|       133|
|  502440|tiger's claw                          |     7016|      7015|


### Tree table 

- [ ] Merge queries with UNION ALL
- [ ] Validate ID_tree
- [ ] Table working for: `QC`, `ON`, `NB`, `FIA`

## Conversion functions

- conv_rad_to_surface(): Haven't check unit of the plot radius. **Warning**

## Tips for querying the FIA database:


- **SURVEY.ANN_INVENTORY = "Y"** - selects only those surveys done using the modern, standardized methodology

- **PLOT.PLOT_STATUS_CD = 1**: Sampled - at least one accessible forest land condition present

- **PLOT.KINDCD > 0 AND < 4**: Standard National Design plots - basically NOT 0 (Periodic inventory plot - pre 1990s, non standardized) AND NOT 4 (Modeled periodic inventory plot - conducted only in Northeat and North central regions)

- **PLOT.DESIGNCD  = 1 or 220 or 240 or 311 - 314 or 328 or 502-505** - all basically sampled the same way (see Appendix B of Phase 2 documentation for explanations)

- **PLOT.QA_STATUS = 1**: Standard production plot

- **PLOT.MANUAL >= 1**: limits data to those collected using the standardized methodology described in the National FIA Field Guide

- **PLOT.SAMP_METHOD_CD = 1**: Field visited (as opposed to 2 = remote sensed)
PLOT.INVR < 9999 (INVYR is set to 9999 to distinguish those Western Phase 3 plots that are “off subpanel”. This is due to differences in measurement intervals between Phase 3 (measurement interval=5 years) and Phase 2 (measurement interval=10 years) plots. Only users interested in performing certain Phase 3 data analyses should access plots with this anomalous value in INVYR.)

- **COND.TRTCD1, TRTCD2, and TRTCD3 = 00**: No observable treatment (i.e., no cutting, girdling, herbicides, etc.), but most records are actually NULL in these fields

- **COND.STDORGCD** - Stand origin code - 0 = Natural stand (vs. 1 = clear evidence of artificial regeneration)

- **TREE.STATUSCD = 1** - live trees 

- **PLOT.STATECD, UNITCD, COUNTYCD, and PLOT** should be used in concert to uniquely identify a plot, but the documentation confusingly states that "Along with STATECD, INVYR, UNITCD, COUNTYCD and/or some other combinations of variables, PLOT may be used to uniquely identify a plot."

**Source**: [http://ecologicaldata.org/wiki/forest-inventory-and-analysis-database](http://ecologicaldata.org/wiki/forest-inventory-and-analysis-database)

## TODO on makefile

- Add exception in temp_sch trigger: climatic_tbl need to be untouched.

## Getting started

    git clone https://github.com/TheoreticalEcosystemEcology/QUICC-SQL.git
    cd QUICC-SQL/ 
    make all
