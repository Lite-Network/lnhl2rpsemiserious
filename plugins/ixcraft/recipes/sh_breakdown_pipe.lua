RECIPE.name = "Metal Pipe"
RECIPE.description = "Breakdown a Metal Pipe."
RECIPE.model = "models/props_lab/pipesystem03a.mdl"
RECIPE.category = "Breakdownable"

RECIPE.base = "recipe_base"

RECIPE.requirements = {
	["pipe"] = 1,
}
RECIPE.results = {
	["metalplate"] = 1,
}

RECIPE.station = "ix_station_workbench"
RECIPE.craftStartSound = "physics/metal/metal_box_impact_bullet1.wav"
RECIPE.craftTime = 5
RECIPE.craftEndSound = "physics/metal/metal_box_strain3.wav"