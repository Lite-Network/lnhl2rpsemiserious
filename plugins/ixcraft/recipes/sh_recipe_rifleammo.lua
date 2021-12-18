RECIPE.name = "Rifle Ammo"
RECIPE.description = "Craft some rifle ammo."
RECIPE.model = "models/willardnetworks/skills/explosive_material.mdl"
RECIPE.category = "Ammunition"

RECIPE.base = "recipe_base"

RECIPE.requirements = {
	["bulletcasing"] = 4,
	["gunpowder"] = 3,
}
RECIPE.results = {
	["rifleammo"] = 1
}

RECIPE.station = "ix_station_workbench"
RECIPE.craftStartSound = "physics/metal/weapon_impact_hard2.wav"
RECIPE.craftTime = 5
RECIPE.craftEndSound = "physics/metal/weapon_impact_hard3.wav"