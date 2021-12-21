RECIPE.name = "Crowbar"
RECIPE.description = "Craft a crowbar."
RECIPE.model = "models/weapons/w_crowbar.mdl"
RECIPE.category = "Weapons (Melee)"

RECIPE.base = "recipe_base"

RECIPE.requirements = {
	["metalplate"] = 1,
	["refinedmetal"] = 2,
	["glue"] = 1,
}
RECIPE.results = {
	["crowbar"] = 1,
}

RECIPE.station = "ix_station_workbench"
RECIPE.craftStartSound = "physics/metal/metal_box_impact_bullet1.wav"
RECIPE.craftTime = 6
RECIPE.craftEndSound = "physics/metal/metal_box_strain3.wav"