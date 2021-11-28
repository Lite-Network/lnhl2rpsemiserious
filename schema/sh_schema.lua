--[[---------------------------------------------------------------------------
	Helix Base Information
---------------------------------------------------------------------------]]--

Schema.name = "Lite Network: Half-Life 2 Semi Serious Roleplay"
Schema.author = "Riggs Mackay"
Schema.description = "A base schema for development."

--[[---------------------------------------------------------------------------
	Helix Base File Include
---------------------------------------------------------------------------]]--

ix.util.Include("cl_schema.lua")
ix.util.Include("sv_schema.lua")

ix.util.Include("cl_hooks.lua")
ix.util.Include("sh_hooks.lua")
ix.util.Include("sv_hooks.lua")

ix.util.Include("cl_faction.lua")
ix.util.Include("cl_fonts.lua")
ix.util.Include("cl_hud.lua")
ix.util.Include("sh_chat.lua")
ix.util.Include("sh_commands.lua")
ix.util.Include("sh_settings.lua")

ix.ranks = ix.ranks or {}
ix.divisions = ix.divisions or {}

ix.util.IncludeDir("divisions")
ix.util.IncludeDir("meta")

--[[---------------------------------------------------------------------------
	Helix Base Items Expnansion
---------------------------------------------------------------------------]]--

ix.moreItemsTable = {
	["wood"] = {
		["name"] = "Piece of Wood",
		["description"] = "A piece of wood.",
		["model"] = "models/items/item_item_crate_chunk02.mdl",
		["width"] = 1,
		["height"] = 1,
		["price"] = 25,
	},
	["plastic"] = {
		["name"] = "Chunk of Plastic",
		["description"] = "A small chunk of scrap plastic.",
		["model"] = "models/props_c17/canisterchunk01a.mdl",
		["width"] = 1,
		["height"] = 1,
		["price"] = 45,
	},
	["metalplate"] = {
		["name"] = "Metal Plate",
		["description"] = "A metal plate.",
		["model"] = "models/gibs/metal_gib4.mdl",
		["width"] = 1,
		["height"] = 1,
		["price"] = 7,
	},
	["refinedmetal"] = {
		["name"] = "Refined Metal Plate",
		["description"] = "A refined metal plate.",
		["model"] = "models/gibs/scanner_gib02.mdl",
		["width"] = 1,
		["height"] = 1,
		["price"] = 12,
	},
	["cloth"] = {
		["name"] = "Piece of Cloth",
		["description"] = "A piece of cloth.",
		["model"] = "models/willardnetworks/skills/cloth.mdl",
		["width"] = 1,
		["height"] = 1,
		["price"] = 25,
	},
	["pipe"] = {
		["name"] = "Metal Pipe",
		["description"] = "A metal pipe.",
		["model"] = "models/props_lab/pipesystem03a.mdl",
		["width"] = 1,
		["height"] = 1,
		["price"] = 24,
	},
	["gunpowder"] = {
		["name"] = "Jar of Gunpowder",
		["description"] = "A jar of gunpowder, mostly used for ammo and explosives.",
		["model"] = "models/props_lab/jar01b.mdl",
		["width"] = 1,
		["height"] = 1,
		["price"] = 58,
	},
	["glue"] = {
		["name"] = "Glue",
		["description"] = "A tube with sticky liquid..",
		["model"] = "models/items/battery.mdl",
		["width"] = 1,
		["height"] = 1,
		["price"] = 25,
	},
	["gear"] = {
		["name"] = "Metal Gear",
		["description"] = "A small metal gear.",
		["model"] = "models/props_wasteland/gear02.mdl",
		["width"] = 1,
		["height"] = 1,
		["price"] = 34,
	},
	["bulletcasing"] = {
		["name"] = "Bullet Casing",
		["description"] = "A metal casing for bullets.",
		["model"] = "models/items/ar2_grenade.mdl",
		["width"] = 1,
		["height"] = 1,
		["price"] = 90,
	},
	["electronics"] = {
		["name"] = "Electronics",
		["description"] = "Some electronic parts.",
		["model"] = "models/props/cs_office/projector_p6.mdl",
		["width"] = 1,
		["height"] = 1,
		["price"] = 35,
	},
	["gnome"] = {
		["name"] = "Gnome",
		["description"] = "Fear this creature, you must.",
		["model"] = "models/props_junk/gnome.mdl",
		["width"] = 1,
		["height"] = 2,
		["price"] = 200,
	},
	["goldgnome"] = {
		["name"] = "Gold Gnome",
		["description"] = "HOLY SHIT! GOLD GNOOOOMMEEE!!!!",
		["model"] = "models/litenetwork/goldengnome.mdl",
		["width"] = 1,
		["height"] = 2,
		["price"] = 2000000000, -- 2.000.000.000 tokens worth
	},
	["damagedotavest"] = {
		["name"] = "Damaged Overwatch Vest",
		["description"] = "A Damaged Overwatch Soldier Vest, can be salvaged to a resistance vest.",
		["model"] = "models/nemez/combine_soldiers/combine_soldier_prop_vest.mdl",
		["width"] = 2,
		["height"] = 2,
		["price"] = 200,
	},
}

for k, v in pairs(ix.moreItemsTable) do
	local ITEM = ix.item.Register(k, nil, false, nil, true)
	ITEM.name = v.name or "An Undefined Name, please configue items.lua in the plugins folder."
	ITEM.description = v.description or "An Undefined Description, please configue items.lua in the plugins folder."
	ITEM.model = v.model or "models/hunter/plates/plate025x025.mdl"
	ITEM.width = v.width or 1
	ITEM.height = v.height or 1
	ITEM.price = v.price or 10
	ITEM.category = "Extended Items"
	ITEM.noBusiness = true
	ITEM.bDropOnDeath = true

	ITEM.base = nil

	function ITEM:GetDescription()
		return self.description
	end
end

--[[---------------------------------------------------------------------------
	Shared Functions
---------------------------------------------------------------------------]]--

function Schema:ZeroNumber(number, length)
	local amount = math.max(0, length - string.len(number))
	return string.rep("0", amount)..tostring(number)
end