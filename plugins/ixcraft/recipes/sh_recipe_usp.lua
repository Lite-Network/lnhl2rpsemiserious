RECIPE.name = "USP Match"
RECIPE.description = "Craft a 9mm sidearm pistol."
RECIPE.model = "models/weapons/w_pistol.mdl"
RECIPE.category = "Weapons (Ranged)"

RECIPE.base = "recipe_base"

RECIPE.requirements = {
	["pipe"] = 1,
	["glue"] = 2,
	["gear"] = 1,
	["plastic"] = 3,
	["metalplate"] = 2,
}
RECIPE.results = {
	["usp"] = 1
}

RECIPE.station = "ix_station_workbench"
RECIPE.craftStartSound = "physics/plastic/plastic_barrel_break1.wav"
RECIPE.craftTime = 7
RECIPE.craftEndSound = "physics/plastic/plastic_box_break2.wav"