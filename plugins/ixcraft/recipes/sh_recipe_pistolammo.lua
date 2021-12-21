RECIPE.name = "Pistol Ammo"
RECIPE.description = "Craft some pistol ammo."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Ammunition"

RECIPE.base = "recipe_base"

RECIPE.requirements = {
	["bulletcasing"] = 2,
	["gunpowder"] = 1,
}
RECIPE.results = {
	["pistolammo"] = 1,
}

RECIPE.station = "ix_station_workbench"
RECIPE.craftStartSound = "physics/metal/weapon_impact_hard2.wav"
RECIPE.craftTime = 3
RECIPE.craftEndSound = "physics/metal/weapon_impact_hard3.wav"