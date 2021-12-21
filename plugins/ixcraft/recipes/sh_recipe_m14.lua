RECIPE.name = "M14"
RECIPE.description = "Craft a hunting rifle."
RECIPE.model = "models/weapons/w_tfa_mni14b.mdl"
RECIPE.category = "Weapons (Firearms)"

RECIPE.base = "recipe_base"

RECIPE.requirements = {
	["pipe"] = 6,
	["glue"] = 6,
	["gear"] = 3,
	["refinedmetal"] = 3,
	["wood"] = 10,
}
RECIPE.results = {
	["m14"] = 1,
}

RECIPE.station = "ix_station_workbench"
RECIPE.craftStartSound = "physics/metal/weapon_impact_hard1.wav"
RECIPE.craftTime = 14
RECIPE.craftEndSound = "physics/metal/weapon_impact_hard3.wav"