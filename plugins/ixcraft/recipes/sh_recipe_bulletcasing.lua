RECIPE.name = "Bullet Casing"
RECIPE.description = "Craft a bullet casing."
RECIPE.model = "models/items/ar2_grenade.mdl"
RECIPE.category = "Miscellaneous"

RECIPE.base = "recipe_base"

RECIPE.requirements = {
	["metalplate"] = 2,
}
RECIPE.results = {
	["bulletcasing"] = 1,
}

RECIPE.station = "ix_station_workbench"
RECIPE.craftStartSound = "physics/metal/metal_box_impact_bullet1.wav"
RECIPE.craftTime = 2
RECIPE.craftEndSound = "physics/metal/weapon_impact_hard3.wav"