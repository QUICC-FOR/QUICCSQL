QUICC-SQL
=========
**Update:** March, 12th

Work-in-progress...

## TODO on RDB tables

### General

- Add climatic table `CREATE` statement on general rdb_quicc script (**Done**)
- Fix role vissst01 to QUICC in dbm file (**Done**)
- Move `SEQUENCES` statement upper in pgmodeler script (**MANUAL**) 
- Check MV fields type correspond to final rdb table 

### Plot_info table

- Generate ID in plot_id reference table (**Done**)
- Table clean, closed and working for: `FIA`, `QC`, `ON`, `NB`

### Location table

- Cleanup coordinates on permanent and temporary sample plots  (**Done**)
- **Check** validity of `RIGHT JOIN` (**Done**)
- Table clean, closed and working for: `FIA`, `QC`, `ON`, `NB`

#### **Filters** (**Done**)
 * Coordinates taken on the last measurement
 * Field `coord_geom` is not empty
 * Only consider maximum geometry_point (*Need further investigations*)

### Plot table 

- Add Year of measurements (**Done**)
- Compute plot_size by plot for `QC`
- Remove `DEFAULT nextval('plot_info_plot_id_seq'::regclass)` on plot_id_plot_info **(MANUAL)**
- Need create functions on `has_superplot`, `plot_size`, `sapling_plot_size`, `seedling_plot_size`
- Table working for: `FIA`, `QC`, `ON`, `NB`

#### **Filters** (**Done**)
 * Remove all plots with no year of measurement (`NB`)

### Climatic data table 

- Filter original climatic data table using the localisation table (**Done**)
- Change climatic_data.id_plot to general id from rdb_quicc.plot_info (**Done**)
- Remove all year not necessary (**Done**)
- Create Pkey on plot_id and year (**Done**)
- Remove lat, long, elevation (**Done**)
- Problem needing to be assess: Some TP and PP in QC schema have the same ID.
- Table clean, closed and working for: `FIA`, `QC`, `ON`, `NB`

### Tree info table 

- Next step

### Tree table 

- Next step

## TODO on conversion functions

### Plot table

- Function #1 Convert class of plot size (*Need further investigations*)
- Function #2 Convert radius to area 

## Getting started

    git clone https://github.com/TheoreticalEcosystemEcology/QUICC-SQL.git
    cd QUICC-SQL/ 
    make all

# Test

- [ ] Ants
	- [ ] Ant Sprites
		- [x] Base
			- [x] Queen
			- [x] Worker
			- [x] Soldier
			- [x] Breeder
		- [ ] Walk-cycle
	- [ ] Health
		- [ ] Decreases over time
		- [ ] Priority to fulfil becomes more urgent
		- [ ] Death results if not met within x amount of frames
	- [ ] Movement
		- [ ] A* path-finding
		- [ ] Click/Tap to move ant
		- [ ] Double Click/Tap to act on environment
	- [ ] AI / Behaviours
		- [ ] Ants preform tasks based on duty assignment (controlled via % sliders)
			- [ ] Forage
			- [ ] Nurse
				- [ ] Move eggs around
			- [ ] Dig
				- [ ] New Queen can dig-in, otherwise must dig-out
		- [ ] Attack
		- [ ] Queen produces eggs
			- [ ] set rate for egg production 
			- [ ]  higher rate = more sugar
			- [ ] ants take the eggs to the nurseries
			- [ ] nurse ants take care of the eggs
		- [ ] Eggs/Larvae
			- [ ] Produced at regular interval by queen
			- [ ] Can't sit on top of one another
			- [ ] If the queens laying area gets to crowded, she can't lay
			- [ ] Nurses move the eggs
	- [ ] Allow body exchange
	- [ ] Pheromone trails
		- [ ] Types
			- [ ] Food
			- [ ] Attack
			- [ ] Defend
		- [ ] Washed away by rain
		- [ ] Fade over time
- [ ] Interface
	- [ ] Environment (primary interface)
		- [ ] Scrolling
		- [ ] Surface
		- [ ] Underground
			- [ ] All dirt with tunnels
	- [ ] UI Menus
		- [ ] Behaviours
		- [ ] Ant Type
- [ ] Events
	- [ ] Randomly create food on the map
	- [ ] Create enemy colony and AI
	- [ ] Lawn Mower
	- [ ] Rain
		-Pre-warning: Gets darker, lightening flash, thunder just before downpour
- [ ] Enemies
	- [ ] *Red Colony*
	- [ ] Ant lion
	- [ ] Spider
		- [ ] You can actually exchange bodies with the Spider
- [ ] Prey
	- [ ] Caterpillar
		- [ ] Moves in straight line
		
## Other Ideas

- [ ] More complex AI
- [ ] New Enemies/Events/Natural Disasters
	- [ ] Magnifying glass attack
	- [ ] Birds
	- [ ] Wind
- [ ] Blessing events
	- [ ] Food Drop
- [ ] Require larger nest for larger colony
- [ ] More realistic hive structure
	- [ ] Nursery
	- [ ] Food storage
	- [ ] Tunnels
	- [ ] Queen's' Chamber
- [ ] Outside
	- [ ] Bridges
	- [ ] Leaves
	- [ ] Human Items
	- [ ] Roads
	- [ ] Sand
	- [ ] Water bodies
- [ ] New Ant Roles
	- [ ] Janitors
- [ ] New Resources
	- [ ] Aphid Farm
		- [ ] Move to sweeter parts of plant
		- [ ] Move aphids under leaves when rain is coming
- [ ] Other Prey
	- [ ] Slugs
	- [ ] Moths
	- [ ] Worms
	- [ ] Crabs
	- [ ] Cricket
- [ ] Earn higher hatch speed
	- [ ] requires more food
	- [ ] requires more nursing behaviour
	- [ ] requires more space
