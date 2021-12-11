AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_wasteland/controlroom_storagecloset001a.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:EnableMotion(false)
	end
end

function ENT:SpawnFunction(ply, trace)
	local angles = ply:GetAngles()

	local entity = ents.Create("ix_rebel_locker")
	entity:SetPos(trace.HitPos)
	entity:SetAngles(Angle(0, (entity:GetPos() - ply:GetPos()):Angle().y - 180, 0))
	entity:Spawn()
	entity:Activate()

	return entity
end

function ENT:OnTakeDamage()
	return false
end

function ENT:AcceptInput(Name, Activator, Caller)
	if (Name == "Use" and Caller:IsPlayer()) then
		if (Caller:IsCitizen() or Caller:IsVort()) then
			self:EmitSound("doors/door_metal_thin_open1.wav")
			Caller:OpenVGUI("LiteNetworkRebelOutfitLocker")
		else
			Caller:Notify("Your Team cannot use this Locker!")
		end
	end
end

util.AddNetworkString("LiteNetworkRebelLockerChange.Citizen")
util.AddNetworkString("LiteNetworkRebelLockerChange.Rebel")
util.AddNetworkString("LiteNetworkRebelLockerChange.RebelMedic")
util.AddNetworkString("LiteNetworkRebelLockerChange.VortigauntShackled")
util.AddNetworkString("LiteNetworkRebelLockerChange.VortigauntFreed")

net.Receive("LiteNetworkRebelLockerChange.Citizen", function( len, ply )
	local char = ply:GetCharacter()
	if (char and ply:IsCitizen()) then
		if (!ply:NearEntity("ix_rebel_locker", 128)) then
			ply:Notify("You have to be near the Rebel Outift Locker.")
			return false
		end

		ply:SetBodygroup(1, 0)
		ply:SetBodygroup(2, 1)
		ply:SetBodygroup(3, 1)
		ply:SetBodygroup(4, 0)
		ply:EmitSound("doors/door_metal_thin_close2.wav")
		ply.ixRebelState = nil

		ply:Notify("You have changed to your Citizen Outfit.")
	else
		ply:Notify("Your team cannot run this command!")
	end
end)

net.Receive("LiteNetworkRebelLockerChange.Rebel", function( len, ply )
	local char = ply:GetCharacter()
	if (char and ply:IsCitizen()) then
		if (!ply:NearEntity("ix_rebel_locker", 128)) then
			ply:Notify("You have to be near the Rebel Outift Locker.")
			return false
		end

		ply:SetBodygroup(1, table.Random({2, 3, 6}))
		ply:SetBodygroup(2, math.random(11,12))
		ply:SetBodygroup(3, math.random(6,8))
		ply:SetBodygroup(4, 6)
		ply:EmitSound("doors/door_metal_thin_close2.wav")
		ply.ixRebelState = true

		ply:Notify("You have changed to a Rebel Outfit.")
	else
		ply:Notify("Your team cannot run this command!")
	end
end)

net.Receive("LiteNetworkRebelLockerChange.RebelMedic", function( len, ply )
	local char = ply:GetCharacter()
	if (char and ply:IsCitizen()) then
		if (!ply:NearEntity("ix_rebel_locker", 128)) then
			ply:Notify("You have to be near the Rebel Outift Locker.")
			return false
		end

		ply:SetBodygroup(1, table.Random({6, 7, 8}))
		ply:SetBodygroup(2, 13)
		ply:SetBodygroup(3, math.random(6,8))
		ply:SetBodygroup(4, 6)
		ply:EmitSound("doors/door_metal_thin_close2.wav")
		ply.ixRebelState = true

		ply:Notify("You have changed to a Rebel Medic Outfit.")
	else
		ply:Notify("Your team cannot run this command!")
	end
end)

net.Receive("LiteNetworkRebelLockerChange.VortigauntShackled", function( len, ply )
	local char = ply:GetCharacter()
	if (char and ply:IsVort()) then
		if (!ply:NearEntity("ix_rebel_locker", 128)) then
			ply:Notify("You have to be near the Rebel Outift Locker.")
			return false
		end

		ply:SetBodygroup(7, 1)
		ply:SetBodygroup(8, 1)
		ply:SetBodygroup(9, 1)
		ply:StripWeapon("ix_vort_beam")
		ply:EmitSound("doors/door_metal_thin_close2.wav")
		char:SetClass(CLASS_VORT_SHACKLED)

		ply:Notify("You are now shackled.")
		ply:SelectWeapon("ix_hands")
		ply:SetupHands()
	else
		ply:Notify("Your team cannot run this command!")
	end
end)

net.Receive("LiteNetworkRebelLockerChange.VortigauntFreed", function( len, ply )
	local char = ply:GetCharacter()
	if (char and ply:IsVort()) then
		if (!ply:NearEntity("ix_rebel_locker", 128)) then
			ply:Notify("You have to be near the Rebel Outift Locker.")
			return false
		end

		ply:SetBodygroup(7, 0)
		ply:SetBodygroup(8, 0)
		ply:SetBodygroup(9, 0)
		ply:Give("ix_vort_beam")
		ply:EmitSound("doors/door_metal_thin_close2.wav")
		char:SetClass(CLASS_VORT_FREED)

		ply:Notify("You are now freed from your shackles.")
		ply:SelectWeapon("ix_hands")
		ply:SetupHands()
	else
		ply:Notify("Your team cannot run this command!")
	end
end)