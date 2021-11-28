ix.ranks.ota = {}
ix.ranks.ota[1] = {
	id = 1,
	name = "OWS",
	description = "Overwatch Soldier",
	xp = 600,
	health = 0,
	armor = 0,
}

ix.ranks.ota[2] = {
	id = 2,
	name = "EOW",
	description = "Elite Overwatch Soldier",
	xp = 1000,
	health = 10,
	armor = 20,
}

ix.ranks.ota[3] = {
	id = 3,
	name = "LDR",
	description = "Leader",
	xp = 2200,
	health = 20,
	armor = 40,
}

ix.divisions.ota = {}
ix.divisions.ota[1] = {
	id = 1,
	name = "ECHO",
	model = "models/litenetwork/ota/echo.mdl",
	model_ldr = "models/litenetwork/ota/ldr.mdl",
	description = "Infantry Unit",
	norank = false,
	skin = 0,
	skin_ldr = 0,
	weapons = {},
	health = 120,
	armor = 100,
	max = 10,
	xp = 600,
	class = CLASS_OTA_ECHO,
}
ix.divisions.ota[1].weapons[1] = {"ix_mp7"}
ix.divisions.ota[1].weapons[2] = {"ix_ar2"}
ix.divisions.ota[1].weapons[3] = {"ix_ar2", "ix_usp"}

ix.divisions.ota[2] = {
	id = 2,
	name = "MACE",
	model = "models/litenetwork/ota/mace.mdl",
	model_ldr = "models/litenetwork/ota/mace.mdl",
	description = "Close Combat Unit",
	norank = false,
	skin = 1,
	skin_ldr = 1,
	weapons = {},
	health = 120,
	armor = 140,
	max = 10,
	xp = 800,
	class = CLASS_OTA_MACE,
}
ix.divisions.ota[2].weapons[1] = {"ix_spas12"}
ix.divisions.ota[2].weapons[2] = {"ix_spas12"}
ix.divisions.ota[2].weapons[3] = {"ix_spas12", "ix_usp"}

ix.divisions.ota[3] = {
	id = 3,
	name = "XRAY",
	model = "models/litenetwork/ota/xray.mdl",
	model_ldr = "models/litenetwork/ota/xray.mdl",
	description = "Medical Unit",
	norank = false,
	skin = 0,
	skin_ldr = 1,
	weapons = {},
	health = 100,
	armor = 100,
	max = 10,
	xp = 1000,
	class = CLASS_OTA_XRAY,
}
ix.divisions.ota[3].weapons[1] = {"weapon_medkit", "ix_mp7"}
ix.divisions.ota[3].weapons[2] = {"weapon_medkit", "ix_mp7", "ix_usp"}
ix.divisions.ota[3].weapons[3] = {"weapon_medkit", "ix_ar2", "ix_usp"}

ix.divisions.ota[4] = {
	id = 4,
	name = "RANGER",
	model = "models/litenetwork/ota/ranger.mdl",
	model_ldr = "models/litenetwork/ota/ranger.mdl",
	description = "Long Range Combat Unit",
	norank = false,
	skin = 0,
	skin_ldr = 1,
	weapons = {},
	health = 120,
	armor = 100,
	max = 10,
	xp = 1200,
	class = CLASS_OTA_RANGER,
}
ix.divisions.ota[4].weapons[1] = {"ix_cmb_sniper", "ix_usp"}
ix.divisions.ota[4].weapons[2] = {"ix_cmb_sniper", "ix_usp"}
ix.divisions.ota[4].weapons[3] = {"ix_cmb_sniper", "ix_mp7"}

ix.divisions.ota[5] = {
	id = 5,
	name = "REAPER",
	model = "models/litenetwork/ota/reaper.mdl",
	description = "Operational Unit",
	norank = true,
	skin = 0,
	weapons = {"ix_357", "ix_ar2", "ix_spas12"},
	health = 200,
	armor = 200,
	max = 1,
	xp = nil,
	class = CLASS_OTA_REAPER,
}

ix.divisions.ota[6] = {
	id = 6,
	name = "COMMANDER",
	model = "models/willardnetworks/combine/ordinal.mdl",
	description = "Overall Transhuman Commander",
	norank = true,
	skin = 0,
	weapons = {"ix_357", "ix_ar2", "ix_spas12"},
	health = 140,
	armor = 200,
	max = 1,
	xp = nil,
	class = CLASS_OTA_COMMANDER,
}