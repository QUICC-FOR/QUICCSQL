QUICC-SQL
=========
**Update:** April, 29th 

Work-in-progress...

### TODO on Relational database

#### General

- Add climatic table CREATE statement on general rdb_quicc script (**Done**)
- Fix role vissst01 to QUICC in dbm file (**Done**)
- Move Sequences statement upper in pgmodeler script (**MANUAL**) 
- Change climatic_data.id_plot to general id from rdb_quicc.plot_info

#### Plot_info table

- Generate ID in plot_id reference table (**Done**)
- Table closed and working for: `FIA`, `QC`, `ON`, `NB`

#### Location table

- Cleanup coordinates on permanent and temporary sample plots  (**Done**)
- Filters (**Done**): 
 * Coordinates taken on the last measurement
 * Field is not empty
 * Only consider maximum longitude 
- **Check** validity of `RIGHT JOIN` (**Done**)

#### Plot_info table

- Function #1 Convert class of plot size (Need further investigations)
- Function #2 Convert radius to area (**Done**)

#### Tree_info table

Next

#### Tree table

Next

### Order to run the scripts in Table folder:

1. plot_info_tbl.sql
2. climate_tbl.sql and localisation_tbl.sql
3. plot_tbl.sql
