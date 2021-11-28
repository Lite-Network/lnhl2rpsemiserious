RECIPE.name = "Bandage"
RECIPE.description = "Craft some bandages with 2 pieces of cloth."
RECIPE.model = "models/willardnetworks/skills/bandaid.mdl"
RECIPE.category = "Medical Items"

RECIPE.base = "recipe_base"

RECIPE.requirements = {
	["cloth"] = 2,
}
RECIPE.results = {
	["bandage"] = 1
}

RECIPE.station = "ix_station_workbench"
RECIPE.craftStartSound = "physics/body/body_medium_impact_soft"..math.random(1,7)..".wav"
RECIPE.craftTime = 3
RECIPE.craftEndSound = "physics/body/body_medium_impact_soft"..math.random(1,7)..".wav"