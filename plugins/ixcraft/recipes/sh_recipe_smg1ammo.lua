RECIPE.name = "MP7 Ammo"
RECIPE.description = "Craft some submachine ammo."
RECIPE.model = "models/Items/BoxMRounds.mdl"
RECIPE.category = "Ammunition"

RECIPE.base = "recipe_base"

RECIPE.requirements = {
	["bulletcasing"] = 3,
	["gunpowder"] = 2,
}
RECIPE.results = {
	["smg1ammo"] = 1,
}

RECIPE.station = "ix_station_workbench"
RECIPE.craftStartSound = "physics/metal/weapon_impact_hard2.wav"
RECIPE.craftTime = 5
RECIPE.craftEndSound = "physics/metal/weapon_impact_hard3.wav"