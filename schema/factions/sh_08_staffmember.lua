--[[ Base Config ]]--

FACTION.name = "Staff Member"
FACTION.description = [[No need to put anything here..]]
FACTION.color = Color(20, 200, 200)

--[[ Helix Base Config ]]--

FACTION.models = {
	"models/player/kleiner.mdl",
}

FACTION.isGloballyRecognized = true
FACTION.isDefault = true

FACTION.payTime = 600
FACTION.pay = 0

--[[ Custom Config ]]--

FACTION.voicelinesHuman = true
FACTION.defaultClass = nil
FACTION.adminOnly = true
FACTION.donatorOnly = false
FACTION.noModelSelection = true
FACTION.requiredXP = nil
FACTION.command = nil
FACTION.modelWhitelist = "player/kleiner"

--[[ Do not change! ]]--

FACTION_STAFF = FACTION.index