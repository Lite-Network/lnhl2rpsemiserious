RECIPE.name = "357 Ammo"
RECIPE.description = "Craft some 357 Revolver Bullets."
RECIPE.model = "models/Items/357ammo.mdl"
RECIPE.category = "Ammunition"

RECIPE.base = "recipe_base"

RECIPE.requirements = {
	["bulletcasing"] = 2,
	["gunpowder"] = 2,
}
RECIPE.results = {
	["357ammo"] = 1
}

RECIPE.station = "ix_station_workbench"
RECIPE.craftStartSound = "physics/metal/weapon_impact_hard2.wav"
RECIPE.craftTime = 6
RECIPE.craftEndSound = "physics/metal/weapon_impact_hard3.wav"