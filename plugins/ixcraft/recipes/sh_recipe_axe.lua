RECIPE.name = "Axe"
RECIPE.description = "Craft a Axe."
RECIPE.model = "models/weapons/hl2meleepack/w_axe.mdl"
RECIPE.category = "Weapons (Melee)"

RECIPE.base = "recipe_base"

RECIPE.requirements = {
	["metalplate"] = 3,
	["wood"] = 2,
	["glue"] = 1,
}
RECIPE.results = {
	["axe"] = 1,
}

RECIPE.station = "ix_station_workbench"
RECIPE.craftStartSound = "physics/metal/metal_box_impact_bullet1.wav"
RECIPE.craftTime = 10
RECIPE.craftEndSound = "physics/metal/metal_box_strain3.wav"