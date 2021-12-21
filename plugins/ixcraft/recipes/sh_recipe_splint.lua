RECIPE.name = "Splint"
RECIPE.description = "Craft a long wooden rod."
RECIPE.model = "models/props_junk/wood_crate001a_chunk05.mdl"
RECIPE.category = "Medical Items"

RECIPE.base = "recipe_base"

RECIPE.requirements = {
	["wood"] = 2,
}
RECIPE.results = {
	["splint"] = 1,
}

RECIPE.station = "ix_station_workbench"
RECIPE.craftStartSound = "physics/wood/wood_box_break1.wav"
RECIPE.craftTime = 3
RECIPE.craftEndSound = "physics/wood/wood_box_impact_hard2.wav"