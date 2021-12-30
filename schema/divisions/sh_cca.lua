ix.ranks.cca = {}
ix.ranks.cca[1] = {
	id = 1,
	name = "RCT",
	description = "Recruit",
	xp = 50,
	health = 0,
	armor = 0,
}

ix.ranks.cca[2] = {
	id = 2,
	name = "i5",
	description = "Ground Unit 5",
	xp = 100,
	health = 0,
	armor = 0,
}

ix.ranks.cca[3] = {
	id = 3,
	name = "i4",
	description = "Ground Unit 4",
	xp = 240,
	health = 0,
	armor = 0,
}

ix.ranks.cca[4] = {
	id = 4,
	name = "i3",
	description = "Ground Unit 3",
	xp = 400,
	health = 0,
	armor = 5,
}

ix.ranks.cca[5] = {
	id = 5,
	name = "i2",
	description = "Ground Unit 2",
	xp = 650,
	health = 0,
	armor = 10,
}

ix.ranks.cca[6] = {
	id = 6,
	name = "i1",
	description = "Ground Unit 1",
	xp = 1000,
	health = 0,
	armor = 20,
}

ix.ranks.cca[7] = {
	id = 7,
	name = "OfC",
	description = "Officer",
	model = "models/dpfilms/metropolice/hl2concept.mdl",
	sheet = "models/dpfilms/metropolice/elite/metrocop_sheet",
	xp = nil,
	health = 0,
	armor = 40,
}

ix.ranks.cca[8] = {
	id = 8,
	name = "DvL",
	description = "Division Leader",
	model = "models/dpfilms/metropolice/hl2concept.mdl",
	sheet = "models/dpfilms/metropolice/elite/metrocop_sheet",
	gasmask = "models/dpfilms/metropolice/elite/gasmask",
	lens = "models/dpfilms/metropolice/rogue/gasmask_lens",
	xp = nil,
	health = 0,
	armor = 60,
}

ix.ranks.cca[9] = {
	id = 9,
	name = "DcO",
	description = "District Control Officer",
	model = "models/dpfilms/metropolice/elite_police.mdl",
	sheet = "models/dpfilms/metropolice/elite/metrocop_sheet",
	xp = nil,
	health = 0,
	armor = 80,
}

ix.divisions.cca = {}
ix.divisions.cca[1] = {
    id = 1,
    name = "UNION",
    description = "Patrol Unit",
	model = "models/dpfilms/metropolice/hdpolice.mdl",
    norank = false,
    skin = 0,
    weapons = {},
    health = 100,
    armor = 0,
    max = 10,
    xp = 35,
    class = CLASS_CCA_UNION,
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
	model = "models/dpfilms/metropolice/civil_medic.mdl",
	norank = false,
	skin = 0,
	weapons = {},
	health = 100,
	armor = 0,
	max = 10,
	xp = 200,
	class = CLASS_CCA_HELIX,
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
	model = "models/dpfilms/metropolice/c08cop.mdl",
	gasmask = "models/dpfilms/metropolice/hd_police/gasmask",
	norank = false,
	skin = 0,
	weapons = {},
	health = 100,
	armor = 0,
	max = 10,
	xp = 600,
	class = CLASS_CCA_GRID,
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
	model = "models/dpfilms/metropolice/policetrench.mdl",
	sheet = "models/dpfilms/metropolice/retrocop/metrocop_sheet",
	norank = false,
	skin = 0,
	weapons = {},
	health = 100,
	armor = 0,
	max = 10,
	xp = 1000,
	class = CLASS_CCA_JURY,
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
    name = "VNG",
    description = "Special Operation Unit",
	model = "models/dpfilms/metropolice/urban_police.mdl",
    norank = true,
    skin = 1,
    weapons = {"ix_mp7", "ix_spas12"},
    health = 100,
    armor = 80,
    max = 1,
    xp = nil,
    class = CLASS_CCA_VANGUARD,
}

ix.divisions.cca[6] = {
	id = 6,
	name = "CmD",
	description = "Overall Civil Protection Commander",
	model = "models/dpfilms/metropolice/police_bt.mdl",
	sheet = "models/dpfilms/metropolice/metrold/metrocop_sheet",
	norank = true,
	skin = 0,
	weapons = {"ix_stunstick", "ix_mp7", "ix_357"},
	health = 100,
	armor = 80,
	max = 1,
	xp = nil,
	class = CLASS_CCA_COMMANDER,
}