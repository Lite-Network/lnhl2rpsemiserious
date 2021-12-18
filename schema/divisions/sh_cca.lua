ix.ranks.cca = {}
ix.ranks.cca[1] = {
	id = 1,
	name = "RCT",
	description = "Recruit",
	xp = 35,
	health = 0,
	armor = 0,
	-- Bodygroups
	bg_cape = 0,
	bg_head = 1,
	bg_armor = 0,
	bg_belt = 0,
	bg_pants = 0,
	bg_bag = 0,
	bg_satchel = 0,
}

ix.ranks.cca[2] = {
	id = 2,
	name = "i5",
	description = "Ground Unit 5",
	xp = 50,
	health = 0,
	armor = 0,
	-- Bodygroups
	bg_cape = 0,
	bg_head = 1,
	bg_armor = 0,
	bg_belt = 0,
	bg_pants = 0,
	bg_bag = 0,
	bg_satchel = 0,
}

ix.ranks.cca[3] = {
	id = 3,
	name = "i4",
	description = "Ground Unit 4",
	xp = 100,
	health = 0,
	armor = 0,
	-- Bodygroups
	bg_cape = 0,
	bg_head = 1,
	bg_armor = 0,
	bg_belt = 0,
	bg_pants = 0,
	bg_bag = 0,
	bg_satchel = 0,
}

ix.ranks.cca[4] = {
	id = 4,
	name = "i3",
	description = "Ground Unit 3",
	xp = 200,
	health = 0,
	armor = 5,
	-- Bodygroups
	bg_cape = 0,
	bg_head = 1,
	bg_armor = 0,
	bg_belt = 0,
	bg_pants = 0,
	bg_bag = 0,
	bg_satchel = 0,
}

ix.ranks.cca[5] = {
	id = 5,
	name = "i2",
	description = "Ground Unit 2",
	xp = 400,
	health = 0,
	armor = 10,
	-- Bodygroups
	bg_cape = 0,
	bg_head = 1,
	bg_armor = 0,
	bg_belt = 0,
	bg_pants = 1,
	bg_bag = 0,
	bg_satchel = 0,
}

ix.ranks.cca[6] = {
	id = 6,
	name = "i1",
	description = "Ground Unit 1",
	xp = 800,
	health = 0,
	armor = 20,
	-- Bodygroups
	bg_cape = 0,
	bg_head = 1,
	bg_armor = 0,
	bg_belt = 0,
	bg_pants = 1,
	bg_bag = 1,
	bg_satchel = 0,
}

ix.ranks.cca[7] = {
	id = 7,
	name = "OfC",
	description = "Officer",
	xp = nil,
	health = 0,
	armor = 40,
	-- Bodygroups
	bg_cape = 0,
	bg_head = 1,
	bg_armor = 1,
	bg_belt = 0,
	bg_pants = 0,
	bg_bag = 2,
	bg_satchel = 0,
}

ix.ranks.cca[8] = {
	id = 8,
	name = "DvL",
	description = "Division Leader",
	xp = nil,
	health = 0,
	armor = 60,
	-- Bodygroups
	bg_cape = 0,
	bg_head = 3,
	bg_armor = 2,
	bg_belt = 0,
	bg_pants = 1,
	bg_bag = 2,
	bg_satchel = 0,
}

ix.ranks.cca[9] = {
	id = 9,
	name = "DcO",
	description = "District Control Officer",
	xp = nil,
	health = 0,
	armor = 80,
	-- Bodygroups
	bg_cape = 0,
	bg_body = 10,
	bg_head = 3,
	bg_armor = 1,
	bg_belt = 1,
	bg_pants = 1,
	bg_bag = 0,
	bg_satchel = 1,
}

ix.divisions.cca = {}
ix.divisions.cca[1] = {
    id = 1,
    name = "UNION",
    description = "Patrol Unit",
    norank = false,
    skin = 0,
    weapons = {},
    health = 100,
    armor = 0,
    max = 10,
    xp = 35,
    class = CLASS_CP_UNION,
    -- Bodygroups
    bg_body = 2,
}
ix.divisions.cca[1].weapons[1] = {"ix_stunstick"}
ix.divisions.cca[1].weapons[2] = {"ix_stunstick"}
ix.divisions.cca[1].weapons[3] = {"ix_stunstick", "ix_usp"}
ix.divisions.cca[1].weapons[4] = {"ix_stunstick", "ix_usp"}
ix.divisions.cca[1].weapons[5] = {"ix_stunstick", "ix_usp"}
ix.divisions.cca[1].weapons[6] = {"ix_stunstick", "ix_usp", "ix_mp7"}
ix.divisions.cca[1].weapons[7] = {"ix_stunstick", "ix_usp", "ix_mp7"}
ix.divisions.cca[1].weapons[8] = {"ix_stunstick", "ix_usp", "ix_spas12"}
ix.divisions.cca[1].weapons[9] = {"ix_stunstick", "ix_357", "ix_spas12"}

ix.divisions.cca[2] = {
	id = 2,
	name = "HELIX",
	description = "Medical Unit",
	norank = false,
	skin = 0,
	weapons = {},
	health = 100,
	armor = 0,
	max = 10,
	xp = 200,
	class = CLASS_CP_HELIX,
	-- Bodygroups
	bg_body = 4,
}
ix.divisions.cca[2].weapons[1] = {"ix_medkit", "ix_stunstick"}
ix.divisions.cca[2].weapons[2] = {"ix_medkit", "ix_stunstick"}
ix.divisions.cca[2].weapons[3] = {"ix_medkit", "ix_stunstick", "ix_usp"}
ix.divisions.cca[2].weapons[4] = {"ix_medkit", "ix_stunstick", "ix_usp"}
ix.divisions.cca[2].weapons[5] = {"ix_medkit", "ix_stunstick", "ix_usp"}
ix.divisions.cca[2].weapons[6] = {"ix_medkit", "ix_stunstick", "ix_usp"}
ix.divisions.cca[2].weapons[7] = {"ix_medkit", "ix_stunstick", "ix_usp", "ix_mp7"}
ix.divisions.cca[2].weapons[8] = {"ix_medkit", "ix_stunstick", "ix_usp", "ix_mp7"}
ix.divisions.cca[2].weapons[9] = {"ix_medkit", "ix_stunstick", "ix_357", "ix_spas12"}

ix.divisions.cca[3] = {
	id = 3,
	name = "GRID",
	description = "Technician Unit",
	norank = false,
	skin = 0,
	weapons = {},
	health = 100,
	armor = 0,
	max = 10,
	xp = 600,
	class = CLASS_CP_GRID,
	-- Bodygroups
	bg_body = 6,
}
ix.divisions.cca[3].weapons[1] = {"ix_stunstick"}
ix.divisions.cca[3].weapons[2] = {"ix_stunstick"}
ix.divisions.cca[3].weapons[3] = {"ix_stunstick", "ix_usp"}
ix.divisions.cca[3].weapons[4] = {"ix_stunstick", "ix_usp"}
ix.divisions.cca[3].weapons[5] = {"ix_stunstick", "ix_usp"}
ix.divisions.cca[3].weapons[6] = {"ix_stunstick", "ix_usp"}
ix.divisions.cca[3].weapons[7] = {"ix_stunstick", "ix_usp", "ix_mp7"}
ix.divisions.cca[3].weapons[8] = {"ix_stunstick", "ix_usp", "ix_mp7"}
ix.divisions.cca[3].weapons[9] = {"ix_stunstick", "ix_357", "ix_spas12"}

ix.divisions.cca[4] = {
	id = 4,
	name = "JURY",
	description = "Investigation Unit",
	norank = false,
	skin = 0,
	weapons = {},
	health = 100,
	armor = 0,
	max = 10,
	xp = 1000,
	class = CLASS_CP_JURY,
	-- Bodygroups
	bg_body = 8,
}
ix.divisions.cca[4].weapons[1] = {"ix_stunstick"}
ix.divisions.cca[4].weapons[2] = {"ix_stunstick"}
ix.divisions.cca[4].weapons[3] = {"ix_stunstick", "ix_usp"}
ix.divisions.cca[4].weapons[4] = {"ix_stunstick", "ix_usp"}
ix.divisions.cca[4].weapons[5] = {"ix_stunstick", "ix_usp"}
ix.divisions.cca[4].weapons[6] = {"ix_stunstick", "ix_usp"}
ix.divisions.cca[4].weapons[7] = {"ix_stunstick", "ix_usp", "ix_mp7"}
ix.divisions.cca[4].weapons[8] = {"ix_stunstick", "ix_usp", "ix_mp7"}
ix.divisions.cca[4].weapons[9] = {"ix_stunstick", "ix_357", "ix_spas12"}

ix.divisions.cca[5] = {
    id = 5,
    name = "VANGUARD",
    description = "Special Operation Unit",
    norank = true,
    skin = 1,
    weapons = {"ix_mp7", "ix_spas12"},
    health = 100,
    armor = 80,
    max = 1,
    xp = nil,
    class = CLASS_CP_VANGUARD,
    model = "models/ma/hla/metropolice.mdl",
	-- Bodygroups
	bg_cape = 1,
    bg_body = 1,
    bg_head = 1,
    bg_armor = 0,
    bg_belt = 0,
    bg_pants = 0,
    bg_bag = 0,
    bg_satchel = 0,
}

ix.divisions.cca[6] = {
	id = 6,
	name = "COMMANDER",
	description = "Overall Civil Protection Commander",
	norank = true,
	skin = 0,
	weapons = {"ix_stunstick", "ix_mp7", "ix_357"},
	health = 100,
	armor = 80,
	max = 1,
	xp = nil,
	class = CLASS_CP_COMMANDER,
	-- Bodygroups
	bg_cape = 0,
    bg_body = 10,
    bg_head = 3,
    bg_armor = 0,
    bg_belt = 0,
    bg_pants = 0,
    bg_bag = 1,
    bg_satchel = 0,
}