--[[ Base Config ]]--

FACTION.name = "Civil Worker's Union"
FACTION.description = [[Name: Civil Worker's Union
Description: A citizen who has been recruited or signed up to work for the UU. Civil Worker's Union receive many benefits, with access to better food and medical supplies. Most Civil Worker's Union operate business in the city, selling resources to other citizens in return for tokens, and some may be hired by the City Administrator to work for him. Most Civil Worker's Union believe that the goal of the Combine is good and do their best to support it.]]
FACTION.color = Color(170, 200, 190)

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
FACTION.requiredXP = 30
FACTION.command = "ix_faction_become_cwu"
FACTION.modelWhitelist = "willardnetworks/citizens"

--[[ Do not change! ]]--

FACTION_CWU = FACTION.index