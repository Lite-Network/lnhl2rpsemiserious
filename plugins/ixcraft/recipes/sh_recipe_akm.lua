RECIPE.name = "AKM"
RECIPE.description = "Craft an AKM."
RECIPE.model = "models/weapons/w_rif_ak47.mdl"
RECIPE.category = "Weapons (Ranged)"

RECIPE.base = "recipe_base"

RECIPE.requirements = {
	["pipe"] = 3,
	["glue"] = 2,
	["gear"] = 2,
	["plastic"] = 3,
	["refinedmetal"] = 3,
}
RECIPE.results = {
	["akm"] = 1
}

RECIPE.station = "ix_station_workbench"
RECIPE.craftStartSound = "physics/metal/weapon_impact_hard1.wav"
RECIPE.craftTime = 10
RECIPE.craftEndSound = "physics/metal/weapon_impact_hard3.wav"