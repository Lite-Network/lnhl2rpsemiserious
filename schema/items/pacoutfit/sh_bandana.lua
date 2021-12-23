-- Item Statistics

ITEM.name = "Bandana"
ITEM.description = "A Bandana made out of cloth, it can be used to hide your identity."
ITEM.category = "Clothing"

-- Item Configuration

ITEM.model = "models/willardnetworks/clothingitems/head_facewrap.mdl"
ITEM.skin = 0

-- Item Inventory Size Configuration

ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-37.84, 10.98, 115.07),
	ang = Angle(70.85, 344.05, 0),
	fov = 4.33
}

-- Item Custom Configuration

if ( SERVER ) then
	util.AddNetworkString("ixBandanaEquip")
	util.AddNetworkString("ixBandanaUnEquip")
	function ITEM:OnEquipped()
		if (self.player) then
			local ply = self.player
			net.Start("ixBandanaEquip") net.Send(ply)
			ply.ixBandanaEquipped = true
			ply:EmitSound("npc/combine_soldier/zipline_clothing"..math.random(1,2)..".wav", 60)
			ply:SetBodygroup(9, 1)
			ply:SetAction("Equipping Bandana..", 2, function()
				ply:EmitSound("npc/combine_soldier/zipline_clothing"..math.random(1,2)..".wav", 60)
				ply:SetBodygroup(9, 1)
			end)
		end
	end

	function ITEM:OnUnequipped()
		if (self.player) then
			local ply = self.player
			net.Start("ixBandanaUnEquip") net.Send(ply)
			ply.ixBandanaEquipped = nil
			ply:EmitSound("npc/combine_soldier/zipline_clothing"..math.random(1,2)..".wav", 60)
			ply:SetBodygroup(9, 0)
			ply:SetAction("Unequipping your Bandana..", 2, function()
				ply:EmitSound("npc/combine_soldier/zipline_clothing"..math.random(1,2)..".wav", 60)
				ply:SetBodygroup(9, 0)
			end)
		end
	end
else
	net.Receive("ixBandanaEquip", function()
		LocalPlayer().ixBandanaEquipped = true
	end)

	net.Receive("ixBandanaUnEquip", function()
		LocalPlayer().ixBandanaEquipped = nil
	end)
end