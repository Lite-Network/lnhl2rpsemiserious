RECIPE.name = "Crossbow Bolts"
RECIPE.description = "Craft some Crossbow Bolt's."
RECIPE.model = "models/Items/CrossbowRounds.mdl"
RECIPE.category = "Ammunition"

RECIPE.base = "recipe_base"

RECIPE.requirements = {
	["pipe"] = 4,
	["glue"] = 3,
	["refinedmetal"] = 2,
}
RECIPE.results = {
	["crossbowammo"] = 1,
}

RECIPE.station = "ix_station_workbench"
RECIPE.craftStartSound = "physics/metal/weapon_impact_hard2.wav"
RECIPE.craftTime = 6
RECIPE.craftEndSound = "physics/metal/weapon_impact_hard3.wav"