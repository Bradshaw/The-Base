# The Base

Concept for a base-building game.

## Refs:
+ Rymdkapsel
+ Dwarf Fortress



## Mission-based:

+ Build a planetary cannon, fire it
+ Warp in X units and keep them healthy for Y days, then warp them home
+ Defend a given objective
+ Explore an area, retrieve the doodad




## Design:

+ World is a grid
+ Resources are on grid and can be mined
+ Resources need to be ferried to where they're useful
+ Resources are semi-limited
	+ Biomass grows faster when the biomass amount is high
	+ Zether is limited
	+ Mineral grows in an EVE capacitor-style curve
+ Zether is used to power equipment
+ Mineral is used to build equipment
+ Biomass is used to feed units



## Buildings:

+ Hyperspace exit point
	+ When activated, warps in a new unit
	+ One exit point is offered on game start
	+ High mineral cost
	+ High zether activation
+ Extractor
	+ Runs when manned
	+ Generates minerals
	+ Low mineral cost
	+ Must be placed on a mineral deposit
+ Farm
	+ Runs continuously
	+ Generates biomass
	+ Low mineral cost
+ Biomass conversion unit
	+ Runs when manned
	+ Converts biomass to food
	+ Medium mineral cost
+ Zether pump
	+ Runs when manned
	+ Generates zether
	+ Medium mineral cost
+ Storage
	+ When built, select a resource by placing one unit of resource
	+ Can store given resource
	+ Medium mineral cost
+ Weapons factory
	+ Converts minerals to weapons
	+ One activation = one weapon
	+ Weapons cost (1weap+1zeth or Xmin+Xzeth)
	+ When weapons are empty, they can be reloaded at the factory
	+ High mineral cost
+ Point defense
	+ Fires at enemies on sight (tower defense)
	+ Stores an amount of zether
	+ Consumes zether on shoot
	+ Cannot fire when empty
	+ High mineral cost