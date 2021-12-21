RECIPE.name = "EMP"
RECIPE.description = "Craft a emp which can open combine doors."
RECIPE.model = "models/transmissions_element120/charger_attachment.mdl"
RECIPE.category = "Miscellaneous"

RECIPE.base = "recipe_base"

RECIPE.requirements = {
	["electronics"] = 2,
	["gear"] = 1,
	["refinedmetal"] = 2,
	["metalplate"] = 4,
	["glue"] = 2,
}
RECIPE.results = {
	["emp"] = 1,
}

RECIPE.station = "ix_station_workbench"
RECIPE.craftStartSound = "physics/glass/glass_impact_hard3.wav"
RECIPE.craftTime = 5
RECIPE.craftEndSound = "physics/cardboard/cardboard_box_impact_bullet3.wav"