RECIPE.name = "Shotgun Shells"
RECIPE.description = "Craft some buckshot shells."
RECIPE.model = "models/Items/BoxBuckshot.mdl"
RECIPE.category = "Ammunition"

RECIPE.base = "recipe_base"

RECIPE.requirements = {
	["bulletcasing"] = 2,
	["gunpowder"] = 4,
}
RECIPE.results = {
	["shotgunammo"] = 1,
}

RECIPE.station = "ix_station_workbench"
RECIPE.craftStartSound = "physics/metal/weapon_impact_hard2.wav"
RECIPE.craftTime = 7
RECIPE.craftEndSound = "physics/metal/weapon_impact_hard3.wav"