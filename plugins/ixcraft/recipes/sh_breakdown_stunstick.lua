RECIPE.name = "Stunstick"
RECIPE.description = "Breakdown a Stunstick."
RECIPE.model = "models/weapons/w_stunbaton.mdl"
RECIPE.category = "Breakdownable"

RECIPE.base = "recipe_base"

RECIPE.requirements = {
	["stunstick"] = 1,
}
RECIPE.results = {
	["pipe"] = 1,
	["metalplate"] = 1,
	["refinedmetal"] = 1,
}

RECIPE.station = "ix_station_workbench"
RECIPE.craftStartSound = "physics/metal/metal_box_impact_bullet1.wav"
RECIPE.craftTime = 4
RECIPE.craftEndSound = "physics/metal/metal_box_strain3.wav"