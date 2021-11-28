-- Item Statistics

ITEM.name = "Combine Ration"
ITEM.description = "A shrink-wrapped packet containing some food and money."

-- Item Configuration

ITEM.model = "models/weapons/w_package.mdl"
ITEM.skin = 0

ITEM.illegal = false
ITEM.items = {"noodles", "orange", "coffee"}
ITEM.money = 500
ITEM.noBusiness = true

-- Item Price Configuration

ITEM.price = 200

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(1.96, 5.95, 199.77),
	ang = Angle(86.31, 276.88, 0),
	fov = 6.82
}

ITEM.functions.Open = {
	icon = "icon16/box.png",
	OnRun = function(itemTable)
		local ply = itemTable.player
		local character = ply:GetCharacter()

		for k, v in ipairs(itemTable.items) do
			if (!character:GetInventory():Add(v)) then
				ix.item.Spawn(v, ply)
			end
		end

		character:GiveMoney(itemTable.money)
		ply:EmitSound("physics/plastic/plastic_barrel_break"..math.random(1,2)..".wav", 80)
	end
}