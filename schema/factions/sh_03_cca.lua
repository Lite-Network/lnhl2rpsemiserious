--[[ Base Config ]]--

FACTION.name = "Combine Civil Authority"
FACTION.description = [[Name: Combine Civil Authority
Description: The Combine Civil Authority are the Universal Union's human police force. They are responsible for the enforcement of the UU's laws, and controlling the population. The Combine Civil Authority consists of multiple divisions, each with a specific role. Many join the Combine Civil Authority in hopes of getting better rations, or simply for the power it brings over their fellow citizens.]]
FACTION.color = Color(80, 125, 230)

--[[ Helix Base Config ]]--

FACTION.models = {
	--[["models/wn7new/metropolice/female_01.mdl",
	"models/wn7new/metropolice/female_02.mdl",
	"models/wn7new/metropolice/female_03.mdl",
	"models/wn7new/metropolice/female_04.mdl",
	"models/wn7new/metropolice/female_06.mdl",
	"models/wn7new/metropolice/female_07.mdl",]]
	
	"models/wn7new/metropolice/male_01.mdl",
	"models/wn7new/metropolice/male_02.mdl",
	"models/wn7new/metropolice/male_03.mdl",
	"models/wn7new/metropolice/male_04.mdl",
	"models/wn7new/metropolice/male_05.mdl",
	"models/wn7new/metropolice/male_06.mdl",
	"models/wn7new/metropolice/male_07.mdl",
	"models/wn7new/metropolice/male_08.mdl",
	"models/wn7new/metropolice/male_09.mdl",
	"models/wn7new/metropolice/male_10.mdl",
}

FACTION.isGloballyRecognized = true
FACTION.isDefault = true

FACTION.payTime = 600
FACTION.pay = 0

--[[ Custom Config ]]--

FACTION.defaultClass = nil
FACTION.adminOnly = false
FACTION.donatorOnly = false
FACTION.requiredXP = 50
FACTION.command = "ix_faction_become_cca"
FACTION.modelWhitelist = "wn7new/metropolice"

--[[ Do not change! ]]--

FACTION_CCA = FACTION.index