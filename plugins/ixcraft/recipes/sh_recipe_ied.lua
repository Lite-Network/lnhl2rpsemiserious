RECIPE.name = "IED"
RECIPE.description = "Craft a explosive IED."
RECIPE.model = "models/weapons/w_c4_planted.mdl"
RECIPE.category = "Miscellaneous"

RECIPE.base = "recipe_base"

RECIPE.requirements = {
	["plastic"] = 16,
	["glue"] = 6,
	["electronics"] = 6,
	["gunpowder"] = 45,
}
RECIPE.results = {
	["ied"] = 1,
}

RECIPE.station = "ix_station_workbench"
RECIPE.craftStartSound = "physics/metal/metal_box_impact_bullet1.wav"
RECIPE.craftTime = 40
RECIPE.craftEndSound = "physics/metal/metal_box_strain3.wav"