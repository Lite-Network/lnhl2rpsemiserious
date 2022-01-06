AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_combine/combine_intwallunit.mdl")
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

	local entity = ents.Create("ix_atm")
	entity:SetPos(trace.HitPos)
	entity:SetAngles(Angle(0, (entity:GetPos() - ply:GetPos()):Angle().y - 180, 0))
	entity:Spawn()
	entity:Activate()

	return entity
end

util.AddNetworkString("ixATM_OpenMenu")
function ENT:Use(activator, caller)
	if IsValid(activator) and activator:IsPlayer() then
		if (activator.ATMInteractCooldown or 0) > CurTime() then return end
		self:EmitSound("ambient/levels/citadel/pod_open1.wav", 50)

		net.Start("ixATM_OpenMenu")
			net.WriteString(tostring(activator:GetCharacter():GetData("ix.ATM.Money", "0")))
		net.Send(activator)

		activator.ATMInteractCooldown = CurTime() + 5
	end
end

util.AddNetworkString("ixATM_Deposit")
net.Receive("ixATM_Deposit", function(_, ply)
	if IsValid(ply) and ply:IsPlayer() then
		if ply:GetCharacter() then
			local _number = net.ReadUInt(32)
			if tostring(_number):find("+") or tostring(_number):find("-") then return end
			for k, v in pairs(ents.FindInSphere(ply:GetPos(), 250)) do
				if v:GetClass() == "ix_atm" then
					if tonumber(_number) > tonumber(ply:GetCharacter():GetMoney()) then return end
					ix.ATM:DepositMoney(ply, _number)
					ix.util.Notify("You have deposited ".._number.." tokens into your bank account", ply)
				end
			end
		end
	end
end)

util.AddNetworkString("ixATM_Withdraw")
net.Receive("ixATM_Withdraw", function(_, ply)
	if IsValid(ply) and ply:IsPlayer() then
		if ply:GetCharacter() then
			local _number = net.ReadUInt(32)
			if tostring(_number):find("+") or tostring(_number):find("-") then return end
			for k, v in pairs(ents.FindInSphere(ply:GetPos(), 250)) do
				if v:GetClass() == "ix_atm" then
					if tonumber(_number) > tonumber(ix.ATM:GetMoney(ply)) then return end
					ix.ATM:WithdrawMoney(ply, _number)
					ix.util.Notify("You have withdrawn ".._number.." tokens from your bank account", ply)
				end
			end
		end
	end
end)