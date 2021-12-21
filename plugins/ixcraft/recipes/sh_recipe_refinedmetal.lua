RECIPE.name = "Refined Metal"
RECIPE.description = "Craft refined metal."
RECIPE.model = "models/gibs/scanner_gib02.mdl"
RECIPE.category = "Miscellaneous"

RECIPE.base = "recipe_base"

RECIPE.requirements = {
	["metalplate"] = 2,
	["glue"] = 1,
}
RECIPE.results = {
	["refinedmetal"] = 1,
}

RECIPE.station = "ix_station_workbench"
RECIPE.craftStartSound = "physics/metal/metal_box_impact_bullet1.wav"
RECIPE.craftTime = 6
RECIPE.craftEndSound = "physics/metal/metal_box_strain3.wav"