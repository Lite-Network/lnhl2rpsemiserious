ENT.Base 			= "base_gmodentity"
ENT.Type 			= "anim"
ENT.PrintName		= "Combine Terminal"
ENT.Author			= "Riggs Mackay"
ENT.Purpose			= "This can be used by Combine Civil Authority and Overwatch."
ENT.Instructions	= "Press E"
ENT.Category 		= "IX:HL2RP"

ENT.AutomaticFrameAdvance = true
ENT.Spawnable = true
ENT.AdminOnly = true

if (CLIENT) then
	function ENT:OnPopulateEntityInfo(container)
	   local EntityName = container:AddRow("EntityName")
	   EntityName:SetImportant()
	   EntityName:SetText(self.PrintName)
	   EntityName:SizeToContents()

	   local EntityDescription = container:AddRow("EntityDescription")
	   EntityDescription:SetText(self.Purpose)
	   EntityDescription:SizeToContents()
    end
end

ix.combineterminal = {}
ix.combineterminal.jailpos = {}
-- rp_nc_district47
--[[
ix.combineterminal.jailpos = {
	Vector(-2021.311279, -863.897400, 450.031250),
	Vector(-2019.012695, -992.957031, 450.031250),
	Vector(-2017.819092, -1114.533203, 450.031250),
	Vector(-2008.576660, -1174.652710, 450.031250),
	Vector(-1827.213745, -1113.493896, 450.031250),
	Vector(-1825.476074, -989.429016, 450.031250),
	Vector(-1822.867676, -804.923767, 450.031250),
}]]
-- rp_city17_litenetwork
ix.combineterminal.jailpos = {
	Vector(7106.879395, 3331.183838, -205.968750),
	Vector(6966.728516, 3328.695801, -205.968750),
	Vector(6819.024902, 3326.074219, -205.968750),
}
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