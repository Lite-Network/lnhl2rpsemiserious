
ITEM.name = "Combine Lock"
ITEM.description = "A metal apparatus applied to doors."
ITEM.model = Model("models/props_combine/combine_lock01.mdl")
ITEM.width = 1
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(-0.5, 50, 2),
	ang = Angle(0, 270, 0),
	fov = 25.29
}
ITEM.noBusiness = true

ITEM.functions.Place = {
	OnRun = function(itemTable)
		local ply = itemTable.player
		local data = {}
			data.start = ply:GetShootPos()
			data.endpos = data.start + ply:GetAimVector() * 96
			data.filter = ply

		local lock = scripted_ents.Get("ix_combinelock"):SpawnFunction(ply, util.TraceLine(data))

		if (IsValid(lock)) then
			ply:EmitSound("physics/metal/weapon_impact_soft2.wav", 75, 80)
		else
			return false
		end
	end
}
