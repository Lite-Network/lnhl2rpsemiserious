
-- Item Statistics

ITEM.name = "Overwatch Soldier Vest"
ITEM.description = "An Overwatch Transhuman Arm Vest salvaged to be used as a common Vest for the Resistnace."
ITEM.category = "Armor Items"

-- Item Configuration

ITEM.model = "models/nemez/combine_soldiers/combine_soldier_prop_vest.mdl"
ITEM.skin = 0

-- Item Inventory Size Configuration

ITEM.width = 2
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(913.61, 766.68, 605.49),
	ang = Angle(24.9, 219.97, 0),
	fov = 1.67
}

-- Item Custom Configuration

ITEM.price = 400
ITEM.maxArmor = 75

ITEM.pacData = {
	[1] = {
		["children"] = {
			[1] = {
				["children"] = {
				},
				["self"] = {
					["Skin"] = 0,
					["Invert"] = false,
					["EyeTargetName"] = "",
					["NoLighting"] = false,
					["OwnerName"] = "self",
					["AimPartName"] = "",
					["BlendMode"] = "",
					["AimPartUID"] = "",
					["Materials"] = "",
					["Name"] = "",
					["LevelOfDetail"] = 0,
					["NoTextureFiltering"] = false,
					["PositionOffset"] = Vector(0, 0, 0),
					["IsDisturbing"] = false,
					["Translucent"] = false,
					["DrawOrder"] = 0,
					["Alpha"] = 1,
					["Material"] = "",
					["ModelModifiers"] = "Pelvis cover=0;",
					["Bone"] = "head",
					["UniqueID"] = "4174685339",
					["EyeTargetUID"] = "",
					["BoneMerge"] = true,
					["NoCulling"] = false,
					["Position"] = Vector(0, 0, 0),
					["AngleOffset"] = Angle(0, 0, 0),
					["Color"] = Vector(1, 1, 1),
					["Hide"] = false,
					["Angles"] = Angle(0, 0, 0),
					["Scale"] = Vector(1, 1, 1),
					["EyeAngles"] = false,
					["EditorExpand"] = true,
					["Size"] = 1,
					["ClassName"] = "model2",
					["IgnoreZ"] = false,
					["Brightness"] = 1,
					["Model"] = "models/nemez/combine_soldiers/combine_soldier_prop_vest.mdl",
					["ForceObjUrl"] = false,
				},
			},
		},
		["self"] = {
			["DrawOrder"] = 0,
			["UniqueID"] = "3470073635",
			["AimPartUID"] = "",
			["Hide"] = false,
			["Duplicate"] = false,
			["ClassName"] = "group",
			["OwnerName"] = "self",
			["IsDisturbing"] = false,
			["Name"] = "my outfit",
			["EditorExpand"] = true,
		},
	},
}

-- totally not kind of stolen neb code ;) - ok bonk
if (CLIENT) then
	function ITEM:pacAdjust(pacData, ply)
		if ply then
			local info = pacData[1]["children"][1]["self"]

			if ply:IsFemale() then
				info["Size"] = 0.75
			end

			return pacData
		end
	end

	function ITEM:PopulateTooltip(tooltip)
		local panel = tooltip:AddRowAfter("name", "armor")
		panel:SetBackgroundColor(derma.GetColor("Warning", tooltip))
		panel:SetText("Armor: " .. (self:GetData("equip") and LocalPlayer():Armor() or self:GetData("armor", self.maxArmor)))
		panel:SizeToContents()
	end
end

if ( SERVER ) then
	function ITEM:OnEquipped()
		if (self.player) then
			local ply = self.player
			ply:EmitSound("npc/combine_soldier/zipline_clothing"..math.random(1,2)..".wav")
			ply:SetArmor(self:GetData("armor", self.maxArmor))
			ply:SetAction("Equipping Vest..", 4, function()
				if (self:GetData("armor", 75) >= 10) then
					ply:EmitSound("npc/combine_soldier/zipline_clothing"..math.random(1,2)..".wav")
					ply:SetArmor(self:GetData("armor", self.maxArmor))
				else
					self:Remove()
					ply:ChatNotify("Your repaired Overwatch Soldier Vest has broken down due to it being low on armor.")
					ply:EmitSound("npc/combine_soldier/gear"..math.random(1,6)..".wav")
					ix.item.Spawn("damagedotavest", ply:GetPos() + Vector(0, 0, 30))
				end
			end)
		end
	end

	function ITEM:OnUnequipped()
		if (self.player) then
			local ply = self.player
			self:SetData("armor", math.Clamp(ply:Armor(), 0, self.maxArmor))
			ply:EmitSound("npc/combine_soldier/zipline_clothing"..math.random(1,2)..".wav")
			ply:SetArmor(0)
			ply:SetAction("Unequipping your Vest..", 4, function()
				if (self:GetData("armor", 75) >= 10) then
					ply:EmitSound("npc/combine_soldier/zipline_clothing"..math.random(1,2)..".wav")
					ply:SetArmor(0)
				else
					self:Remove()
					ply:ChatNotify("Your repaired Overwatch Soldier Vest has broken down due to it being low on armor.")
					ply:EmitSound("npc/combine_soldier/gear"..math.random(1,6)..".wav")
					ix.item.Spawn("damagedotavest", ply:GetPos() + Vector(0, 0, 30))
				end
			end)
		end
	end
end

function ITEM:Repair(amount)
	self:SetData("armor", math.Clamp(self:GetData("armor") + amount, 0, self.maxArmor))
end

function ITEM:OnLoadout()
	if (self:GetData("equip")) then
		self.player:SetArmor(self:GetData("armor", self.maxArmor))
	end
end

function ITEM:OnSave()
	if (self:GetData("equip")) then
		self:SetData("armor", math.Clamp(self.player:Armor(), 0, self.maxArmor))
	end
end