QUICC-SQL
=========
**Update:** April, 24th 

Work-in-progress...

### TODO on Relational database

#### General

- Add climatic table CREATE statement on general rdb_quicc script
- Fix role vissst01 to QUICC in dbm file
- Move Sequences statement upper in pgmodeler script 
- Change climatic_data.id_plot to general id from rdb_quicc.plot_info

#### Plot_info table

- Generate ID in plot_id reference table (**Done**)

#### Location table

- Cleanup permanente and temporary sample plot coordinates (**Done**)
- Filters used: Coordinates taken on the last measurement and not empty 
- **Check** validity of `RIGHT JOIN`

#### Plot_info table

- Function #1 Convert class of plot size (Need further investigations)
- Function #2 Convert radius to area (**Done**)

#### Tree_info table

Next

#### Tree table

Next
