util.AddNetworkString("ixSafeboxOpen")

function PLUGIN:PlayerLoadedCharacter(ply)
	ix.safebox.Restore(ply)
end

function PLUGIN:PlayerHurt(ply, attacker)
	if ((ply.ixCombatPeriodCooldown or 0) < CurTime()) then
		if ( attacker:IsPlayer() and attacker:IsCombine() ) then
			ply.ixCombatPeriod = CurTime() + 180
		end
		ply.ixCombatPeriodCooldown = CurTime() + 60
	end
end

function ix.safebox.Restore(ply, callback)
	local character = ply:GetCharacter()

	if (!character) then
		return
	end

	local index = character:GetData("safeboxID")
	local characterID = character:GetID()

	if (index) then
		local inventory = ix.inventory.Get(index)

		if (inventory) then
			inventory:Sync(ply)
			inventory:AddReceiver(ply)

			if (callback) then
				callback()
			end
		else
			local invType = ix.item.inventoryTypes["safebox"]
			ix.inventory.Restore(index, invType.w, invType.h, function(inv)
				inv:SetOwner(characterID)
			end)
		end
	else
		ix.inventory.New(characterID, "safebox", function(inv)
			character:SetData("safeboxID", inv:GetID())
		end)
	end
end