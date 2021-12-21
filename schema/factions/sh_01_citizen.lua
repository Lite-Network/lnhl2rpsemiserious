--[[ Base Config ]]--

FACTION.name = "Citizen"
FACTION.description = [[Name: Citizen
Description: The lowest class of Universal Union society. They are forced to follow the Universal Union's dictatorship with absolute obedience, or face punishments and even execution. The Universal Union keeps citizens weak and malnourished, and it is all they can do to try and survive. However, some brave citizens dare to stand against the Combine...]]
FACTION.color = Color(20, 150, 20)

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

FACTION.voicelinesHuman = true
FACTION.defaultClass = nil
FACTION.adminOnly = false
FACTION.donatorOnly = false
FACTION.noModelSelection = true
FACTION.requiredXP = nil
FACTION.command = "ix_faction_become_citizen"
FACTION.modelWhitelist = "willardnetworks/citizens"

--[[ Do not change! ]]--

FACTION_CITIZEN = FACTION.index