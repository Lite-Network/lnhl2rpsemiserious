ix.ranks.ota = {}
ix.ranks.ota[1] = {
	id = 1,
	name = "OWS",
	description = "Overwatch Soldier",
	xp = 1000,
	health = 0,
	armor = 0,
}

ix.ranks.ota[2] = {
	id = 2,
	name = "EOW",
	description = "Elite Overwatch Soldier",
	xp = 1200,
	health = 0,
	armor = 20,
}

ix.ranks.ota[3] = {
	id = 3,
	name = "LDR",
	description = "Leader",
	xp = nil,
	health = 20,
	armor = 40,
}

ix.divisions.ota = {}
ix.divisions.ota[1] = {
	id = 1,
	name = "ECHO",
	model = "models/litenetwork/ota.mdl",
	model_ldr = "models/litenetwork/ota.mdl",
	description = "Infantry Unit",
	norank = false,
	skin = 0,
	skin_ldr = 0,
	weapons = {},
	health = 100,
	armor = 100,
	max = 10,
	xp = 1000,
	class = CLASS_OTA_ECHO,
}
ix.divisions.ota[1].weapons[1] = {"ix_mp7"}
ix.divisions.ota[1].weapons[2] = {"ix_ar2"}
ix.divisions.ota[1].weapons[3] = {"ix_ar2", "weapon_frag"}

ix.divisions.ota[2] = {
	id = 2,
	name = "MACE",
	model = "models/litenetwork/ota.mdl",
	model_ldr = "models/litenetwork/ota.mdl",
	description = "Close Combat Unit",
	norank = false,
	skin = 1,
	skin_ldr = 1,
	weapons = {},
	health = 120,
	armor = 140,
	max = 10,
	xp = 1600,
	class = CLASS_OTA_MACE,
}
ix.divisions.ota[2].weapons[1] = {"ix_spas12"}
ix.divisions.ota[2].weapons[2] = {"ix_spas12"}
ix.divisions.ota[2].weapons[3] = {"ix_spas12", "weapon_frag"}

--[[ix.divisions.ota[3] = {
	id = 3,
	name = "NOVA",
	model = "models/litenetwork/ota.mdl",
	model_ldr = "models/litenetwork/ota.mdl",
	description = "Prison Management Unit",
	norank = false,
	skin = 0,
	skin_ldr = 1,
	weapons = {},
	health = 100,
	armor = 140,
	max = 10,
	xp = 1800,
	class = CLASS_OTA_NOVA,
}
ix.divisions.ota[3].weapons[1] = {"ix_mp7"}
ix.divisions.ota[3].weapons[2] = {"ix_ar2"}
ix.divisions.ota[3].weapons[3] = {"ix_spas12", "weapon_frag"}]]

ix.divisions.ota[4] = {
	id = 4,
	name = "XRAY",
	model = "models/litenetwork/ota.mdl",
	model_ldr = "models/litenetwork/ota.mdl",
	description = "Medical Unit",
	norank = false,
	skin = 0,
	skin_ldr = 1,
	weapons = {},
	health = 100,
	armor = 100,
	max = 10,
	xp = 2000,
	class = CLASS_OTA_XRAY,
}
ix.divisions.ota[4].weapons[1] = {"weapon_medkit", "ix_mp7"}
ix.divisions.ota[4].weapons[2] = {"weapon_medkit", "ix_mp7", "ix_usp"}
ix.divisions.ota[4].weapons[3] = {"weapon_medkit", "ix_ar2", "ix_usp", "weapon_frag"}

ix.divisions.ota[5] = {
	id = 5,
	name = "RANGER",
	model = "models/litenetwork/ota.mdl",
	model_ldr = "models/litenetwork/ota.mdl",
	description = "Long Range Combat Unit",
	norank = false,
	skin = 0,
	skin_ldr = 1,
	weapons = {},
	health = 100,
	armor = 120,
	max = 10,
	xp = 2300,
	class = CLASS_OTA_RANGER,
}
ix.divisions.ota[5].weapons[1] = {"ix_cmb_sniper", "ix_mp7"}
ix.divisions.ota[5].weapons[2] = {"ix_cmb_sniper", "ix_mp7"}
ix.divisions.ota[5].weapons[3] = {"ix_cmb_sniper", "ix_mp7", "weapon_frag"}

ix.divisions.ota[6] = {
	id = 6,
	name = "REAPER",
	model = "models/litenetwork/ota.mdl",
	description = "Special Operations unit",
	norank = true,
	skin = 0,
	weapons = {"ix_ar2", "ix_spas12", "weapon_frag"},
	health = 200,
	armor = 200,
	max = 1,
	xp = nil,
	class = CLASS_OTA_REAPER,
}

ix.divisions.ota[7] = {
	id = 7,
	name = "COMMANDER",
	model = "models/litenetwork/ota.mdl",
	description = "Commander of the Transhuman Forces",
	norank = true,
	skin = 0,
	weapons = {"ix_357", "ix_ar2", "ix_spas12", "weapon_frag"},
	health = 160,
	armor = 200,
	max = 1,
	xp = nil,
	class = CLASS_OTA_COMMANDER,
}