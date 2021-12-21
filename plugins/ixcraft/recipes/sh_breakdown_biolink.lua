RECIPE.name = "Destroyed Biolink"
RECIPE.description = "Breakdown a Destroyed Biolink."
RECIPE.model = "models/gibs/manhack_gib03.mdl"
RECIPE.category = "Breakdownable"

RECIPE.base = "recipe_base"

RECIPE.requirements = {
	["biolink"] = 1,
}
RECIPE.results = {
	["metalplate"] = 2,
}

RECIPE.station = "ix_station_workbench"
RECIPE.craftStartSound = "physics/metal/metal_box_impact_bullet1.wav"
RECIPE.craftTime = 5
RECIPE.craftEndSound = "physics/metal/metal_box_strain3.wav"