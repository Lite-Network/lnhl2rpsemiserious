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

-- probably the worst terminal ever... i dont care tho
util.AddNetworkString("ixCombineTerminalCharge")
net.Receive("ixCombineTerminalCharge", function( len, ply )
	if (!ply:GetCharacter()) or (!ply:IsCombine()) then
		ply:Notify("You need to be a Combine to use the Combine Terminal!")
		return
	end
	if (!ply:NearPlayer(96)) then
		ply:Notify("There is no target near the Combine Terminal that is tied!")
		return
	end
	local charges = net.ReadTable()
	local charges_msg = "Attention, you have been charged with.. "
	local charges_msg_table = {}
	local charges_sounds = {}
	local charges_time_original = net.ReadUInt(4)
	local charges_time = net.ReadUInt(12)

	table.insert(charges_sounds, "npc/overwatch/radiovoice/attentionyouhavebeenchargedwith.wav")
	for k, v in pairs(charges) do
		table.insert(charges_msg_table, ix.combineterminal.charges[v].name)
		table.insert(charges_sounds, ix.combineterminal.charges[v].sound)
	end
	table.insert(charges_sounds, "npc/overwatch/radiovoice/youarejudgedguilty.wav")

	local msgtablestring = table.ToString(charges_msg_table)
	msgtablestring = string.Replace(msgtablestring, '{"', "")
	msgtablestring = string.Replace(msgtablestring, '",}', "")
	msgtablestring = string.Replace(msgtablestring, '","', "; ")

	charges_msg = charges_msg..msgtablestring.." you are judged guilty by civil protection team."

	ix.chat.Send(ply, "dispatchperson", charges_msg, false)
	ix.util.EmitQueuedSounds(ply, charges_sounds)

	for k, v in ipairs(ents.FindInSphere(ply:GetPos(), radius or 96)) do
		timer.Simple(math.Clamp(charges_time_original, 3, 7), function()
			if v:IsPlayer() and v:Alive() and v:IsValid() then
				if v:IsRestricted() then
					ply:ChatNotify("targets: "..v:Nick())
					ply:ChatNotify("sentenced time: "..charges_time)
					v.inJail = false
					v:ConCommand("ix_become_citizen")
					v:SetRestricted(false)
					v:SetPos(table.Random(ix.combineterminal.jailpos))
					v:StripWeapons()
					v:StripAmmo()
					v:GetCharacter():SetData("brokenLegs", false)
					v:ChatNotify("You have been sentenced to jail for "..charges_time.." seconds!")
					v.inJail = true
					timer.Simple(charges_time, function()
						v.inJail = false
						v:Spawn()
						v.inJail = false
					end)
				end
			end
		end)
	end
end)
