-- Item Statistics

ITEM.name = "EMP Tool"
ITEM.description = "An EMP Tool, which can be used against combine technology!"
ITEM.category = "Tools"

-- Item Configuration

ITEM.model = "models/transmissions_element120/charger_attachment.mdl"
ITEM.skin = 0

-- Item Inventory Size Configuration

ITEM.width = 1
ITEM.height = 1

-- Item Custom Configuration

ITEM.price = 160

-- Item Functions

ITEM.functions.OverloadDoor = {
	name = "Overload Door",
	icon = "icon16/shield_add.png",
	OnRun = function(itemTable)
		local ply = itemTable.player
		local data = {}
			data.start = ply:GetShootPos()
			data.endpos = data.start + ply:GetAimVector() * 96
			data.filter = ply
		local target = util.TraceLine(data).Entity

		if IsValid(target) and target:IsDoor() then
			local randomChance = math.random(1,10)
			if not (target:HasSpawnFlags(256) and target:HasSpawnFlags(1024)) then
				ply:Freeze(true)
				ply:SetAction("Overloarding...", 3, function()
					ply:Freeze(false)
					if (randomChance > 5) then
						target:Fire("open")
						ply:EmitSound("buttons/combine_button1.wav")
						ply:Notify("You have successfully overloaded the door.")
					else
						ply:EmitSound("ambient/energy/zap1.wav")
						ply:Notify("The EMP attempt failed.")
					end
				end)
			end
		else
			ply:Notify("You need to look at a overloadable door to use the EMP!")
		end

		return false
	end
}