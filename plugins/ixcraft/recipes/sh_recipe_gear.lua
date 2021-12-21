RECIPE.name = "Gear"
RECIPE.description = "Craft a metal gear."
RECIPE.model = "models/props_wasteland/gear02.mdl"
RECIPE.category = "Miscellaneous"

RECIPE.base = "recipe_base"

RECIPE.requirements = {
	["metalplate"] = 4,
	["glue"] = 1,
}
RECIPE.results = {
	["gear"] = 1,
}

RECIPE.station = "ix_station_workbench"
RECIPE.craftStartSound = "physics/metal/metal_box_impact_bullet1.wav"
RECIPE.craftTime = 4
RECIPE.craftEndSound = "physics/metal/metal_box_strain3.wav"