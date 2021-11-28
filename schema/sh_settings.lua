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

ix.currency.symbol = "T"
ix.currency.singular = "token"
ix.currency.plural = "tokens"
ix.currency.model = "models/props/cs_assault/Money.mdl"

--[[---------------------------------------------------------------------------
	Helix Base Settings
---------------------------------------------------------------------------]]--

ix.option.Add("hudScreenEffect", ix.type.bool, true)
ix.option.Add("hudDrawBox", ix.type.bool, true)
ix.option.Add("hudDrawPlayerInformation", ix.type.bool, true)