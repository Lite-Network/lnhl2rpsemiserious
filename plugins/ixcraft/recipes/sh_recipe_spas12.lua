RECIPE.name = "SPAS-12"
RECIPE.description = "Craft a spas-12 shotgun."
RECIPE.model = "models/weapons/w_shotgun.mdl"
RECIPE.category = "Weapons (Firearms)"

RECIPE.base = "recipe_base"

RECIPE.requirements = {
	["pipe"] = 4,
	["glue"] = 2,
	["gear"] = 2,
	["plastic"] = 2,
	["refinedmetal"] = 3,
}
RECIPE.results = {
	["spas12"] = 1,
}

RECIPE.station = "ix_station_workbench"
RECIPE.craftStartSound = "physics/metal/weapon_impact_hard1.wav"
RECIPE.craftTime = 16
RECIPE.craftEndSound = "physics/metal/weapon_impact_hard3.wav"