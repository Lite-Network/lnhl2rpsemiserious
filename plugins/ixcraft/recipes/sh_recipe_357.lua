RECIPE.name = "357"
RECIPE.description = "Craft a 357."
RECIPE.model = "models/weapons/w_357.mdl"
RECIPE.category = "Weapons (Ranged)"

RECIPE.base = "recipe_base"

RECIPE.requirements = {
	["pipe"] = 2,
	["glue"] = 2,
	["gear"] = 1,
	["refinedmetal"] = 2,
}
RECIPE.results = {
	["357"] = 1
}

RECIPE.station = "ix_station_workbench"
RECIPE.craftStartSound = "physics/metal/weapon_impact_hard1.wav"
RECIPE.craftTime = 10
RECIPE.craftEndSound = "physics/metal/weapon_impact_hard3.wav"