--[[ Base Config ]]--

FACTION.name = "Combine Civil Authority"
FACTION.description = [[Name: Combine Civil Authority
Description: The Combine Civil Authority are the Universal Union's human police force. They are responsible for the enforcement of the UU's laws, and controlling the population. The Combine Civil Authority consists of multiple divisions, each with a specific role. Many join the Combine Civil Authority in hopes of getting better rations, or simply for the power it brings over their fellow citizens.]]
FACTION.color = Color(80, 125, 230)

--[[ Helix Base Config ]]--

FACTION.models = {
	"models/litenetwork/cca.mdl",
}

FACTION.isGloballyRecognized = true
FACTION.isDefault = true

FACTION.payTime = 600
FACTION.pay = 0

--[[ Custom Config ]]--

FACTION.voicelinesHuman = false
FACTION.defaultClass = nil
FACTION.adminOnly = false
FACTION.donatorOnly = false
FACTION.noModelSelection = true
FACTION.requiredXP = 50
FACTION.command = "ix_faction_become_cca"
FACTION.modelWhitelist = "litenetwork/cca"

--[[ Plugin Configs ]]--

FACTION.canSeeWaypoints = true
FACTION.canAddWaypoints = true
FACTION.canRemoveWaypoints = true
FACTION.canUpdateWaypoints = true

--[[ Do not change! ]]--

FACTION_CCA = FACTION.index