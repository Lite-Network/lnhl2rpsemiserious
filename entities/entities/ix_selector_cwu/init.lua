AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/willardnetworks/citizens/male04.mdl")
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

util.AddNetworkString("ixSelector.CWU.NotAllowed")
util.AddNetworkString("ixSelector.CWU.SetClass")
function ENT:AcceptInput(Name, Activator, Caller)
	if ( Name == "Use" ) and Caller:IsPlayer() then
		self:SetEyeTarget(Caller:EyePos())
		if ( Caller:Team() == FACTION_CWU ) then
			self:EmitSound("vo/npc/male01/hi0"..math.random(1,2)..".wav")
			Caller:OpenVGUI("LiteNetwork.RankMenu.CWU")
		else
			net.Start("ixSelector.CWU.NotAllowed")
			net.Send(Caller)
			self:EmitSound("vo/trainyard/male01/cit_pedestrian0"..math.random(1,5)..".wav")
			Caller:Notify("You are not part of the Civil Worker's Union!")
		end
	end
end

concommand.Add("ix_selector_cwu", function(ply, cmd, args)
	if not (args[1]) then return end
	if not ply:NearEntity("ix_selector_cwu") then ply:Notify("You need to be near the Civil Worker's Union quartermaster in order to use this!") return end
	if not (ply:Team() == FACTION_CWU) then ply:Notify("You need to become a Civil Worker's Union to run this command.") return end
	if not ((ply.cwuSelectionCoolDown or 0) > CurTime()) then
		local char = ply:GetCharacter()

		if (!char) then
			return
		end

		local JobID = tonumber(args[1])
		local JobInfo = ix.divisions.cwu[JobID]

		if not (JobInfo.xp == nil) then
			if not (tonumber(ply:GetXP()) >= JobInfo.xp) then
				ply:Notify("You do not have the correct amount of XP to become that Job!")
				return false
			end
		end

		ply:Notify("You are now a "..JobInfo.name.."!")
		if ( JobInfo.class ) and ( char ) then
			char:SetClass(JobInfo.class)
		end

		if ( JobInfo.model ) then
			ply:SetModel(JobInfo.model)
		else
			if not ( ply:GetModel():find("willardnetworks/citizens") ) then
				ply:SetModel(table.Random(ix.faction.Get(ply:Team()).models))
			end
		end
		
		ply:ResetBodygroups()

		if ( JobInfo.loadout ) then
			JobInfo.loadout( ply )
		end

		ply:SetupHands()

		ply.ixCWUClass = JobInfo.id

		net.Start("ixSelector.CWU.SetClass")
			net.WriteUInt(ply.ixCWUClass or 0, 3)
		net.Send(ply)

		ply.cwuSelectionCoolDown = CurTime() + 10
	else
		ply:Notify("You need to wait before you can your Job again.")
	end
end)