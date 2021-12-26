AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_combine/combine_interface001.mdl")
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

	local entity = ents.Create("ix_arrest_terminal")
	entity:SetPos(trace.HitPos)
	entity:SetAngles(Angle(0, (entity:GetPos() - ply:GetPos()):Angle().y - 180, 0))
	entity:Spawn()
	entity:Activate()

	return entity
end

function ENT:Think()
	if (self.nextTerminalCheck or 0) < CurTime() then
		self:StopSound("ambient/machines/combine_terminal_loop1.wav")
		self:EmitSound("ambient/machines/combine_terminal_loop1.wav", 50)

		self.nextTerminalCheck = CurTime() + 10
	end
end

function ENT:OnRemove()
	self:StopSound("ambient/machines/combine_terminal_loop1.wav")
end

function ENT:Use(ply)
	if (self.useCooldown or 0) < CurTime() then
		if (!ply:GetCharacter()) or (!ply:IsCombine()) then
			ply:Notify("You need to be a Combine to use the Combine Terminal!")
			return
		end
		if (!ply:NearPlayer(96)) then
			ply:Notify("There is no target near the Combine Terminal that is tied!")
			return
		end

		self:EmitSound("ambient/machines/combine_terminal_idle"..math.random(1,2)..".wav", 60)
		ply:OpenVGUI("LiteNetworkTerminal")

		self.useCooldown = CurTime() + 3
	end
end

util.AddNetworkString("ixCombineTerminalCharge")
net.Receive("ixCombineTerminalCharge", function(len, ply)
	if not (ply:GetCharacter() and ply:IsCombine()) then
		ply:Notify("You need to be a Combine to use the Combine Terminal!")
		return
	end
	if not (ply.ixDraggedTarget:IsValid() and ply.ixDraggedTarget:IsPlayer() and ply.ixDraggedTarget:GetCharacter()) then
		ply:Notify("You arent dragging someone.")
		return
	end
	local target = ply.ixDraggedTarget
	local chargesTable = net.ReadTable()
	local chargesMessage = "Attention, you have been charged with.. "
	local chargesMessageTable = {}
	local chargesSounds = {}
	local chargesTimeOriginal = net.ReadUInt(4)
	local chargesTime = net.ReadUInt(12)

	table.insert(chargesSounds, "npc/overwatch/radiovoice/attentionyouhavebeenchargedwith.wav")
	for k, v in pairs(chargesTable) do
		table.insert(chargesMessageTable, ix.combineterminal.charges[v].name)
		table.insert(chargesSounds, ix.combineterminal.charges[v].sound)
	end
	table.insert(chargesSounds, "npc/overwatch/radiovoice/youarejudgedguilty.wav")

	local chargesMessageTableString = table.ToString(chargesMessageTable)
	chargesMessageTableString = string.Replace(chargesMessageTableString, '{"', "")
	chargesMessageTableString = string.Replace(chargesMessageTableString, '",}', "")
	chargesMessageTableString = string.Replace(chargesMessageTableString, '","', "; ")

	chargesMessage = chargesMessage..chargesMessageTableString.." you are judged guilty by civil protection team."

	ix.chat.Send(ply, "dispatchperson", chargesMessage, false)
	ix.util.EmitQueuedSounds(ply, chargesSounds)
	ix.util.EmitQueuedSounds(target, chargesSounds)
	
	local targetCharacter = target:GetCharacter()
	ply:ChatNotify("Target: "..target:Nick())
	ply:ChatNotify("Sentenced Time: "..chargesTime)
	
	ply.ixDraggedTarget = nil
	target.ixDraggedBy = nil
	Schema:SetTeam(target, ix.faction.teams["07_prisoner"], nil, nil, nil, true, true)
	target:ChatNotify("You have been sentenced for "..chargesTime.." seconds!")
	target:StripWeapons()

	target.ixJailState = true

	timer.Simple(chargesTime - 5, function()
		target:ChatNotify("Your Sentence will be taken away in 5 seconds.")
	end)

	timer.Simple(chargesTime, function()
		target.ixJailState = nil

		Schema:SetTeam(target, ix.faction.teams["01_citizen"], nil, nil, nil, true, true)
		hook.Run("PlayerLoadout", target)
	end)
end)