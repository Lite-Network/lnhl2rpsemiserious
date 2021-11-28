-- Item Statistics

ITEM.name = "Health Vial"
ITEM.description = "A small vial with green liquid."
ITEM.category = "Medical Items"

-- Item Configuration

ITEM.model = "models/healthvial.mdl"
ITEM.skin = 0

-- Item Inventory Size Configuration

ITEM.width = 1
ITEM.height = 1

-- Item Custom Configuration

ITEM.HealAmount = 30
ITEM.Volume = 70
ITEM.price = 40

-- Item Functions

ITEM.functions.Apply = {
	name = "Heal yourself",
	icon = "icon16/heart.png",
	OnRun = function(itemTable)
		local ply = itemTable.player
		ply:Freeze(true)
		ply:SetAction("Applying "..itemTable.name.."...", 3, function()
			ply:SetHealth(math.min(ply:Health() + itemTable.HealAmount, ply:GetMaxHealth()))
			ply:EmitSound("items/smallmedkit1.wav", itemTable.Volume)

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
				ply:SetAction("Applying "..itemTable.name.."...", 3, function()
					ply:SetHealth(math.min(ply:Health() + itemTable.HealAmount, ply:GetMaxHealth()))
					ply:EmitSound("items/smallmedkit1.wav", itemTable.Volume)
					target:EmitSound("items/smallmedkit1.wav", itemTable.Volume)
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