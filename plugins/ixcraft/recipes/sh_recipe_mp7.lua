RECIPE.name = "MP7"
RECIPE.description = "Craft a submachine gun."
RECIPE.model = "models/weapons/w_smg1.mdl"
RECIPE.category = "Weapons (Firearms)"

RECIPE.base = "recipe_base"

RECIPE.requirements = {
	["pipe"] = 2,
	["glue"] = 1,
	["gear"] = 1,
	["plastic"] = 2,
	["refinedmetal"] = 3,
}
RECIPE.results = {
	["mp7"] = 1,
}

RECIPE.station = "ix_station_workbench"
RECIPE.craftStartSound = "physics/metal/weapon_impact_hard1.wav"
RECIPE.craftTime = 10
RECIPE.craftEndSound = "physics/metal/weapon_impact_hard3.wav"