--[[ Base Config ]]--

FACTION.name = "Cremator"
FACTION.description = [[The Cremator is some kind of janitor, breathing heavily at almost all times resulting in a rather dark ambience around, alerting anyone in a radius of its presence, it was mainly to be seen disposing of dead bodies through the use of it's Immolator a large plasma thrower capable of spraying a green beam, which would disintegrate organic matter upon contact.]]
FACTION.color = Color(15, 100, 15)

--[[ Helix Base Config ]]--

FACTION.models = {
	"models/cremator.mdl",
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
FACTION.requiredXP = 5000
FACTION.command = "ix_faction_become_cremator"
FACTION.modelWhitelist = "models/cremator.mdl"

FACTION.playerLoadout = function(ply)
	ply:SetHealth(200)
	ply:SetMaxHealth(200)

	ply:SetArmor(200)
	ply:SetMaxArmor(200)

	ply:SetViewOffset(Vector(0, 0, 90))
	ply:SetJumpPower(0)

	ply:EmitSound("litenetwork/hl2rp/cremator/breath.wav", 30)
	ply:StripWeapons()
	ply:Give("ix_immolator")
end

--[[ Do not change! ]]--

FACTION_CREMATOR = FACTION.index