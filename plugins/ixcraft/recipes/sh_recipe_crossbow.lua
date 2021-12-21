RECIPE.name = "Crossbow"
RECIPE.description = "Craft a Crossbow."
RECIPE.model = "models/weapons/w_crossbow.mdl"
RECIPE.category = "Weapons (Firearms)"

RECIPE.base = "recipe_base"

RECIPE.requirements = {
	["pipe"] = 4,
	["metalplate"] = 5,
	["glue"] = 3,
	["gear"] = 3,
	["refinedmetal"] = 4,
}
RECIPE.results = {
	["crossbow"] = 1,
}

RECIPE.station = "ix_station_workbench"
RECIPE.craftStartSound = "physics/metal/weapon_impact_hard1.wav"
RECIPE.craftTime = 13
RECIPE.craftEndSound = "physics/metal/weapon_impact_hard3.wav"