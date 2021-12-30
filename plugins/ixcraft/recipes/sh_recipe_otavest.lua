RECIPE.name = "Overwatch Soldier Vest"
RECIPE.description = "Craft a Overwatch Vest."
RECIPE.model = "models/Items/item_item_crate.mdl"
RECIPE.category = "Armor Items"

RECIPE.base = "recipe_base"

RECIPE.requirements = {
	["damagedotavest"] = 1,
	["cloth"] = 5,
	["glue"] = 1,
	["refinedmetal"] = 2,
	["plastic"] = 2,
}
RECIPE.results = {
	["otavest"] = 1,
}

RECIPE.station = "ix_station_workbench"
RECIPE.craftStartSound = "physics/body/body_medium_impact_soft"..math.random(1,7)..".wav"
RECIPE.craftTime = 30
RECIPE.craftEndSound = "physics/body/body_medium_impact_soft"..math.random(1,7)..".wav"