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

function ENT:AcceptInput(Name, Activator, ply)
	if (Name == "Use" and ply:IsPlayer()) then
		if (ply:IsCitizen() or ply:IsVortigaunt()) then
			self:EmitSound("doors/door_metal_thin_open1.wav")

			ply:Freeze(true)
			ply:SetAction("Changing Outfit..", math.random(2,5), function()
				ply:Freeze(false)
				if ( ply:IsCitizen() ) then
					if ( ply:IsRebel() ) then
						ply:SetBodygroup(1, 0)
						ply:SetBodygroup(2, 1)
						ply:SetBodygroup(3, 1)
						ply:SetBodygroup(4, 0)
						ply:EmitSound("doors/door_metal_thin_close2.wav")
						ply.ixRebelState = nil
				
						ply:Notify("You have changed to your Citizen Outfit.")
					else
						ply:SetBodygroup(1, table.Random({2, 3, 6}))
						ply:SetBodygroup(2, math.random(8,9))
						ply:SetBodygroup(3, math.random(6,8))
						ply:SetBodygroup(4, 6)
						ply:EmitSound("doors/door_metal_thin_close2.wav")
						ply.ixRebelState = true
				
						ply:Notify("You have changed to a Rebel Outfit.")
					end
				elseif ( ply:IsVortigaunt() ) then
					if not ( ply:GetCharacter():GetClass() == CLASS_VORT_SHACKLED ) then
						ply:SetBodygroup(7, 1)
						ply:SetBodygroup(8, 1)
						ply:SetBodygroup(9, 1)
						ply:StripWeapon("ix_vort_beam")
						ply:EmitSound("doors/door_metal_thin_close2.wav")
						ply:SelectWeapon("ix_hands")
						ply:SetupHands()
						char:SetClass(CLASS_VORT_SHACKLED)
				
						ply:Notify("You are now shackled.")
					else
						ply:SetBodygroup(7, 0)
						ply:SetBodygroup(8, 0)
						ply:SetBodygroup(9, 0)
						ply:Give("ix_vort_beam")
						ply:EmitSound("doors/door_metal_thin_close2.wav")
						ply:SelectWeapon("ix_hands")
						ply:SetupHands()
						char:SetClass(CLASS_VORT_FREED)
				
						ply:Notify("You are now freed from your shackles.")
					end
				end
			end)
		else
			ply:Notify("Your Team cannot use this Locker!")
		end
	end
end