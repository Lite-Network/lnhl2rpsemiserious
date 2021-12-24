--[[ Base Config ]]--

FACTION.name = "Cremator"
FACTION.description = [[No need to put anything here.. atm!]]
FACTION.color = Color(15, 100, 15)

--[[ Helix Base Config ]]--

FACTION.models = {
	"models/player/kleiner.mdl",
}

FACTION.isGloballyRecognized = true
FACTION.isDefault = true

FACTION.payTime = 600
FACTION.pay = 0

--[[ Custom Config ]]--

FACTION.voicelinesHuman = false
FACTION.defaultClass = nil
FACTION.adminOnly = false
FACTION.donatorOnly = true
FACTION.noModelSelection = true
FACTION.requiredXP = 5000
FACTION.command = nil
FACTION.modelWhitelist = "player/kleiner"

--[[ Do not change! ]]--

FACTION_CREMATOR = FACTION.index