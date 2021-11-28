-- Item Statistics

ITEM.name = "IED"
ITEM.description = "A Bomb filled with explosives and a timer."
ITEM.category = "Weapons"

-- Item Configuration

ITEM.model = "models/weapons/w_c4_planted.mdl"
ITEM.skin = 0
ITEM.price = 3700

ITEM.functions.FiveSelf = {
	name = "Arm (5 Seconds)",
	OnRun = function(item)
		local ply = item.player
		ply:EmitSound("weapons/c4/c4_plant.wav", 80)
		ply:EmitSound("weapons/c4/c4_disarm.wav", 100)
		timer.Simple(1.0, function() if ply:IsValid() then ply:EmitSound("weapons/c4/c4_click.wav") end end)
		timer.Simple(2.0, function() if ply:IsValid() then ply:EmitSound("weapons/c4/c4_click.wav") end end)
		timer.Simple(3.0, function() if ply:IsValid() then ply:EmitSound("weapons/c4/c4_click.wav") end end)
		timer.Simple(3.5, function() if ply:IsValid() then ply:EmitSound("weapons/c4/c4_click.wav") end end)
		timer.Simple(4.0, function() if ply:IsValid() then ply:EmitSound("weapons/c4/c4_click.wav") end end)
		timer.Simple(4.2, function() if ply:IsValid() then ply:EmitSound("weapons/c4/c4_click.wav") end end)
		timer.Simple(4.5, function() if ply:IsValid() then ply:EmitSound("weapons/c4/c4_click.wav") end end)
		timer.Simple(4.7, function() if ply:IsValid() then ply:EmitSound("weapons/c4/c4_click.wav") end end)
		timer.Simple(4.9, function() if ply:IsValid() then ply:EmitSound("weapons/c4/c4_click.wav") end end)
		timer.Simple(5.0, function()
			local explode = ents.Create("env_explosion")
			explode:SetPos(ply:GetPos())
			explode:SetOwner(ply)
			explode:Spawn()
			explode:SetKeyValue("iMagnitude", "200")
			explode:Fire("Explode", 0, 0)
			explode:EmitSound("weapons/c4/c4_explode1.wav")
		end)
		return true
	end
}

ITEM.functions.Five = {
	name = "Place (5 Seconds)",
	OnRun = function(item)
		local ply = item.player
		ply:EmitSound("weapons/c4/c4_plant.wav", 80)
		ply:EmitSound("weapons/c4/c4_disarm.wav", 100)
		local ent = ents.Create("prop_physics")
		ent:SetModel("models/weapons/w_c4_planted.mdl")
		ent:SetPos(ply:EyePos() + (ply:GetAimVector() * 40))
		ent:SetAngles(ply:EyeAngles() + Angle(0,0,0))
		ent:Spawn()
		timer.Simple(1.0, function() ent:EmitSound("weapons/c4/c4_click.wav") end)
		timer.Simple(2.0, function() ent:EmitSound("weapons/c4/c4_click.wav") end)
		timer.Simple(3.0, function() ent:EmitSound("weapons/c4/c4_click.wav") end)
		timer.Simple(3.5, function() ent:EmitSound("weapons/c4/c4_click.wav") end)
		timer.Simple(4.0, function() ent:EmitSound("weapons/c4/c4_click.wav") end)
		timer.Simple(4.2, function() ent:EmitSound("weapons/c4/c4_click.wav") end)
		timer.Simple(4.5, function() ent:EmitSound("weapons/c4/c4_click.wav") end)
		timer.Simple(4.7, function() ent:EmitSound("weapons/c4/c4_click.wav") end)
		timer.Simple(4.9, function() ent:EmitSound("weapons/c4/c4_click.wav") end)
		timer.Simple(5.0, function()
			local explode = ents.Create("env_explosion")
			explode:SetPos(ent:GetPos())
			explode:SetOwner(ply)
			explode:Spawn()
			explode:SetKeyValue("iMagnitude", "200")
			explode:Fire("Explode", 0, 0)
			explode:EmitSound("weapons/c4/c4_explode1.wav")
			ent:Remove()
		end)
		return true
	end
}