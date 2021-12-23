AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/willardnetworks/citizens/male05.mdl")
	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()
	self:SetSolid(SOLID_BBOX)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()

	self:SetSkin(2)

	self:SetBodygroup(1, 9)
	self:SetBodygroup(2, 34)
	self:SetBodygroup(3, 9)
	self:SetBodygroup(4, 2)
	self:SetBodygroup(5, 1)
	self:SetBodygroup(6, 0)
	self:SetBodygroup(7, 0)
	self:SetBodygroup(8, 1)
	self:SetBodygroup(9, 0)
	self:SetBodygroup(10, 7)
end

function ENT:OnTakeDamage()
	return false
end 

util.AddNetworkString("ixSelector.Customizer.NotAllowed")
function ENT:AcceptInput(Name, Activator, Caller)
	if ( Name == "Use" ) and Caller:IsPlayer() then
		self:SetEyeTarget(Caller:EyePos())
		if ( Caller:IsCitizen() ) then
			self:EmitSound("vo/npc/male01/hi0"..math.random(1,2)..".wav")
			Caller:OpenVGUI("LiteNetwork.Menu.Customizer")
		else
			net.Start("ixSelector.Customizer.NotAllowed")
			net.Send(Caller)
			self:EmitSound("vo/trainyard/male01/cit_pedestrian0"..math.random(1,5)..".wav")
			Caller:Notify("You need to be a Civilian!")
		end
	end
end

concommand.Add("ix_selector_customize", function(ply, cmd, args)
	if not (args[1]) then return end
	if not ply:NearEntity("ix_selector_customization") then ply:Notify("You need to be near the Civilian Customizer in order to use this!") return end
	if not (ply:IsCitizen()) then ply:Notify("You need to become a Civilian to run this command.") return end
	if not ((ply.customizationSelectionCoolDown or 0) > CurTime()) then
		local char = ply:GetCharacter()

		if (!char) then
			return
		end

		ply:SetupHands()

		ply.customizationSelectionCoolDown = CurTime() + 10
	else
		ply:Notify("You need to wait before you can your Customization again.")
	end
end)