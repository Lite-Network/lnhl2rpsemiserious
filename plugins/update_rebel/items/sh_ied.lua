-- Item Statistics

ITEM.name = "IED"
ITEM.description = "A Bomb filled with explosives and a timer."
ITEM.category = "Weapons"

-- Item Configuration

ITEM.model = "models/weapons/w_c4_planted.mdl"
ITEM.skin = 0
ITEM.price = 3700

local function PlayBeep(time, ent)
	timer.Simple(time or 0, function()
		if ent:IsValid() then
			ent:EmitSound("weapons/c4/c4_click.wav", 90)
		end
	end)
end

ITEM.functions.PlaceVehicle = {
	name = "Place on Vehicle",
	OnCanRun = function(item)
		local ply = item.player
		local data = {}
			data.start = ply:GetShootPos()
			data.endpos = data.start + ply:GetAimVector() * 96
			data.filter = ply
		local ent = util.TraceLine(data).Entity

		if ( ent:IsValid() and ent:GetClass() == "gmod_sent_vehicle_fphysics_base" ) then
			return true
		else
			return false
		end
	end,
	OnRun = function(item)
		local ply = item.player
		local data = {}
			data.start = ply:GetShootPos()
			data.endpos = data.start + ply:GetAimVector() * 96
			data.filter = ply
		local ent = util.TraceLine(data).Entity

		if ( ent:IsValid() and ent:GetClass() == "gmod_sent_vehicle_fphysics_base" ) then
			local entityPosition = ent:GetPos()
			ent:EmitSound("weapons/c4/c4_disarm.wav", 90)
			PlayBeep(0.5, ent)
			PlayBeep(1.5, ent)
			PlayBeep(2.5, ent)
			PlayBeep(3, ent)
			PlayBeep(3.25, ent)
			PlayBeep(3.50, ent)
			PlayBeep(3.75, ent)
			timer.Simple(4, function()
				if ( IsValid(ent) ) then
					entityPosition = ent:GetPos()
					local explode = ents.Create("env_explosion")
					explode:SetPos(entityPosition)
					explode:SetOwner(ply)
					explode:Spawn()
					explode:SetKeyValue("iMagnitude", "375")
					explode:Fire("Explode", 0, 0)
					explode:EmitSound("weapons/c4/c4_explode1.wav", 120)
					explode:EmitSound("weapons/c4/c4_exp_deb1.wav", 100)
					explode:EmitSound("weapons/c4/c4_exp_deb2.wav", 100)
				end
			end)
		end

		return true
	end
}

ITEM.functions.Arm = {
	name = "Arm on yourself",
	OnRun = function(item)
		local ply = item.player
		
		ply:EmitSound("weapons/c4/c4_disarm.wav", 80)
		PlayBeep(0.5, ply)
		PlayBeep(1.5, ply)
		PlayBeep(2.5, ply)
		PlayBeep(3, ply)
		PlayBeep(3.25, ply)
		PlayBeep(3.50, ply)
		PlayBeep(3.75, ply)
		timer.Simple(4, function()
			if ( IsValid(ply) and ply:Alive() ) then
				local explode = ents.Create("env_explosion")
				explode:SetPos(ply:GetPos())
				explode:SetOwner(ply)
				explode:Spawn()
				explode:SetKeyValue("iMagnitude", "400")
				explode:Fire("Explode", 0, 0)
				explode:EmitSound("weapons/c4/c4_explode1.wav", 100)
				explode:EmitSound("weapons/c4/c4_exp_deb1.wav", 90)
				explode:EmitSound("weapons/c4/c4_exp_deb2.wav", 90)
			end
		end)

		return true
	end
}