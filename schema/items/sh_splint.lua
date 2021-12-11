-- Item Statistics

ITEM.name = "Splint"
ITEM.description = "A long wooden rod. Can be used to heal broken bones."
ITEM.category = "Medical Items"

-- Item Configuration

ITEM.model = "models/props_junk/wood_crate001a_chunk05.mdl"
ITEM.skin = 0
ITEM.price = 10

-- Item Inventory Size Configuration

ITEM.width = 1
ITEM.height = 1

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(36.11, 32.74, 193.97),
	ang = Angle(104.11, 42.2, 0),
	fov = 8.99
}

ITEM.functions.Apply = {
	icon = "icon16/box.png",
	OnRun = function(itemTable)
		local ply = itemTable.player
		local char = ply:GetCharacter()

		if ( SERVER ) then
			if char:GetData("brokenLegs", false) == true then
				ply:Freeze(true)
				ply:SetAction("Applying splint...", 5, function()
					char:SetData("brokenLegs", false)
					ply:Notify("Your broken legs have healed.")
					ply:Freeze(false)
					return true
				end)
			else
				ply:Notify("Your legs are not broken!")
				return false
			end
		end
	end
}