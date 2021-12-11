--[[---------------------------------------------------------------------------
	Helix Base Config
---------------------------------------------------------------------------]]--

ALWAYS_RAISED["swep_construction_kit"] = true
ALWAYS_RAISED["ix_zombie_claws"] = true

ix.config.SetDefault("communityText", "Website")
ix.config.SetDefault("communityURL", "http://lite-network.de")
ix.config.SetDefault("color", Color(200, 75, 25) or color_white)
ix.config.SetDefault("font", "Segoe Ui Light")
ix.config.SetDefault("genericFont", "Segoe Ui")
ix.config.SetDefault("music", "LiteNetwork/hl2rp/music/teaser.ogg")
ix.config.SetDefault("scoreboardRecognition", true)

ix.config.Add("cityCode", 0, "The Current City Code of the City.", nil, {
	data = {
		min = 0,
		max = 4
	},
	category = "Miscellaneous",
})

ix.currency.symbol = "T"
ix.currency.singular = "token"
ix.currency.plural = "tokens"
ix.currency.model = "models/props/cs_assault/Money.mdl"

ix.vendingItems = {
	{"REGULAR", "water", 15},
	{"SPARKLING", "water_sparkling", 25},
	{"SPECIAL", "water_special", 35}
}

--[[---------------------------------------------------------------------------
	Helix Base Settings
---------------------------------------------------------------------------]]--

ix.option.Add("hudScreenEffect", ix.type.bool, true)
ix.option.Add("hudDrawBox", ix.type.bool, true)
ix.option.Add("hudDrawPlayerInformation", ix.type.bool, true)

ix.option.Add("showLocalAssets", ix.type.bool, true, {
	phrase = "Show Local Assets",
	description = "Should the local assets on your Combine Hud show?",
	category = "Appearance",
})