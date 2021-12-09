--[[ Base Config ]]--

FACTION.name = "Prisoner"
FACTION.description = [[No need to put anything here..]]
FACTION.color = Color(200, 100, 20)

--[[ Helix Base Config ]]--

FACTION.models = {
	"models/willardnetworks/citizens/female_01.mdl",
	"models/willardnetworks/citizens/female_02.mdl",
	"models/willardnetworks/citizens/female_03.mdl",
	"models/willardnetworks/citizens/female_04.mdl",
	"models/willardnetworks/citizens/female_06.mdl",
	"models/willardnetworks/citizens/female_07.mdl",
	
	"models/willardnetworks/citizens/male01.mdl",
	"models/willardnetworks/citizens/male02.mdl",
	"models/willardnetworks/citizens/male03.mdl",
	"models/willardnetworks/citizens/male04.mdl",
	"models/willardnetworks/citizens/male05.mdl",
	"models/willardnetworks/citizens/male06.mdl",
	"models/willardnetworks/citizens/male07.mdl",
	"models/willardnetworks/citizens/male08.mdl",
	"models/willardnetworks/citizens/male09.mdl",
	"models/willardnetworks/citizens/male10.mdl",
}

FACTION.isGloballyRecognized = true
FACTION.isDefault = true

FACTION.payTime = 600
FACTION.pay = 0

--[[ Custom Config ]]--

FACTION.defaultClass = nil
FACTION.adminOnly = false
FACTION.donatorOnly = false
FACTION.noModelSelection = true
FACTION.requiredXP = nil
FACTION.command = nil
FACTION.modelWhitelist = "willardnetworks/citizens"

--[[ Do not change! ]]--

FACTION_PRISONER = FACTION.index