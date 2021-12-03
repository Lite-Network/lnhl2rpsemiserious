ITEM.name = "Bandage"
ITEM.model = "models/willardnetworks/skills/bandaid.mdl"
ITEM.description = "A Cloth, can be used to cover wounds to stop bleeding."
ITEM.category = "Medical Items"
ITEM.price = 20
ITEM.HealAmount = 10
ITEM.Volume = 70

ITEM.functions.Apply = {
	name = "Heal yourself",
	icon = "icon16/heart.png",
	OnCanRun = function(itemTable)
		local ply = itemTable.player

		if ( ply:IsValid() and ply:Health() < ply:GetMaxHealth() ) then
			return true
		else
			return false
		end
	end,
	OnRun = function(itemTable)
		local ply = itemTable.player
		ply:Freeze(true)
		ply:SetAction("Applying "..itemTable.name.."...", 2, function()
			ply:SetHealth(math.min(ply:Health() + itemTable.HealAmount, ply:GetMaxHealth()))
			ply:EmitSound("physics/body/body_medium_impact_soft"..math.random(1,7)..".wav", itemTable.Volume)

			ply:Notify("You applied a "..itemTable.name.." on yourself and you have gained health.")
			ply:Freeze(false)
			return true
		end)
	end
}

ITEM.functions.ApplyTarget = {
	name = "Heal target",
	icon = "icon16/heart_add.png",
	OnCanRun = function(itemTable)
		local ply = itemTable.player
		local data = {}
			data.start = ply:GetShootPos()
			data.endpos = data.start + ply:GetAimVector() * 96
			data.filter = ply
		local target = util.TraceLine(data).Entity

		if ( target:IsValid() and target:IsPlayer() and ( target:Health() < target:GetMaxHealth() ) ) then
			return true
		else
			return false
		end
	end,
    OnCanRun = function(itemTable)
		local ply = itemTable.player
		local data = {}
			data.start = ply:GetShootPos()
			data.endpos = data.start + ply:GetAimVector() * 96
			data.filter = ply
		local target = util.TraceLine(data).Entity

		if IsValid(target) and target:IsPlayer() then
			return false
		end
    end,
	OnRun = function(itemTable)
		local ply = itemTable.player
		local data = {}
			data.start = ply:GetShootPos()
			data.endpos = data.start + ply:GetAimVector() * 96
			data.filter = ply
		local target = util.TraceLine(data).Entity

		if IsValid(target) and target:IsPlayer() then
			if target:GetCharacter() then
				ply:Freeze(true)
				target:Freeze(true)
				ply:SetAction("Applying "..itemTable.name.."...", 2, function()
					ply:SetHealth(math.min(ply:Health() + itemTable.HealAmount, ply:GetMaxHealth()))
					ply:EmitSound("physics/body/body_medium_impact_soft"..math.random(1,7)..".wav", itemTable.Volume)
					target:EmitSound("physics/body/body_medium_impact_soft"..math.random(1,7)..".wav", itemTable.Volume)
					target:SetHealth(math.min(target:Health() + itemTable.HealAmount, target:GetMaxHealth()))

					ply:Notify("You applied a "..itemTable.name.." on yourself and you have gained health.")
					target:Notify(ply:Nick().." applied a "..itemTable.name.." on you and you have gained health.")
					ply:Freeze(false)
					target:Freeze(false)
					return true
				end)
				return true
			end
		end

		return false
	end
}