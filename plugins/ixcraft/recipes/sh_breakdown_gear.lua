RECIPE.name = "Gear"
RECIPE.description = "Breakdown a Metal Gear."
RECIPE.model = "models/props_wasteland/gear02.mdl"
RECIPE.category = "Breakdownable"

RECIPE.base = "recipe_base"

RECIPE.requirements = {
	["gear"] = 1,
}
RECIPE.results = {
	["metalplate"] = 3,
}

RECIPE.station = "ix_station_workbench"
RECIPE.craftStartSound = "physics/metal/metal_box_impact_bullet1.wav"
RECIPE.craftTime = 5
RECIPE.craftEndSound = "physics/metal/metal_box_strain3.wav"