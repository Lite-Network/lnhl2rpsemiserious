ENT.Base 			= "base_ai"
ENT.Type 			= "anim"
ENT.PrintName		= "Arresting Terminal"
ENT.Author			= "Riggs Mackay"
ENT.Purpose			= "Arrest them baddies :)"
ENT.Instructions	= "Press E"
ENT.Category 		= "IX:HL2RP"

ENT.AutomaticFrameAdvance = true
ENT.Spawnable = true
ENT.AdminOnly = true

ix.combineterminal = {}
ix.combineterminal.charges = {
	{name = "10-103m, disturbance by mentally unfit", severity = 5, sound = "npc/overwatch/radiovoice/disturbancemental10-103m.wav"},
	{name = "27, attempted crime", severity = 2, sound = "npc/overwatch/radiovoice/attemptedcrime27.wav"},
	{name = "51, non-sanctioned arson", severity = 5, sound = "npc/overwatch/radiovoice/nonsanctionedarson51.wav"},
	{name = "51B, threat to property", severity = 3, sound = "npc/overwatch/radiovoice/threattoproperty51b.wav"},
	{name = "63, criminal trespass", severity = 5, sound = "npc/overwatch/radiovoice/criminaltrespass63.wav"},
	{name = "69, possession of (contraband) resources", severity = 3, sound = "npc/overwatch/radiovoice/posession69.wav"},
	{name = "95, illegal carrying (weaponry)", severity = 6, sound = "npc/overwatch/radiovoice/illegalcarrying95.wav"},
	{name = "99, reckless operation", severity = 2, sound = "npc/overwatch/radiovoice/recklessoperation99.wav"},
	{name = "148, resisting arrest", severity = 4, sound = "npc/overwatch/radiovoice/resistingpacification148.wav"},
	{name = "243, assault on protection team", severity = 14, sound = "npc/overwatch/radiovoice/assault243.wav"},
	{name = "404, riot", severity = 4, sound = "npc/overwatch/radiovoice/riot404.wav"},
	{name = "507, public non-compliance", severity = 2, sound = "npc/overwatch/radiovoice/publicnoncompliance507.wav"},
	{name = "603, unlawful entry", severity = 4, sound = "npc/overwatch/radiovoice/unlawfulentry603.wav"},
	{name = "Disassociation from the civic populous", severity = 7, sound = "npc/overwatch/radiovoice/disassociationfromcivic.wav"},
	{name = "Promoting communal unrest", severity = 7, sound = "npc/overwatch/radiovoice/promotingcommunalunrest.wav"}
}