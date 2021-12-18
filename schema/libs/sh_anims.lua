--[[---------------------------------------------------------------------------
	Animations
---------------------------------------------------------------------------]]--

ix.anim.overwatch = {
	normal = {
		[ACT_MP_STAND_IDLE] = {"idle_unarmed", ACT_IDLE_ANGRY},
		[ACT_MP_CROUCH_IDLE] = {ACT_CROUCHIDLE, ACT_CROUCHIDLE},
		[ACT_MP_WALK] = {"walkunarmed_all", ACT_WALK_RIFLE},
		[ACT_MP_CROUCHWALK] = {ACT_WALK_CROUCH_RIFLE, ACT_WALK_CROUCH_RIFLE},
		[ACT_MP_RUN] = {ACT_RUN_AIM_RIFLE, ACT_RUN_AIM_RIFLE},
		[ACT_LAND] = {ACT_RESET, ACT_RESET}
	},
	pistol = {
		[ACT_MP_STAND_IDLE] = {"idle_unarmed", ACT_IDLE_ANGRY_SMG1},
		[ACT_MP_CROUCH_IDLE] = {ACT_CROUCHIDLE, ACT_CROUCHIDLE},
		[ACT_MP_WALK] = {"walkunarmed_all", ACT_WALK_RIFLE},
		[ACT_MP_CROUCHWALK] = {ACT_WALK_CROUCH_RIFLE, ACT_WALK_CROUCH_RIFLE},
		[ACT_MP_RUN] = {ACT_RUN_AIM_RIFLE, ACT_RUN_AIM_RIFLE},
		[ACT_LAND] = {ACT_RESET, ACT_RESET}
	},
	smg = {
		[ACT_MP_STAND_IDLE] = {ACT_IDLE_SMG1, ACT_IDLE_ANGRY_SMG1},
		[ACT_MP_CROUCH_IDLE] = {ACT_CROUCHIDLE, ACT_CROUCHIDLE},
		[ACT_MP_WALK] = {"WalkEasy_all", ACT_WALK_AIM_RIFLE},
		[ACT_MP_CROUCHWALK] = {ACT_WALK_CROUCH_RIFLE, ACT_WALK_CROUCH_RIFLE},
		[ACT_MP_RUN] = {ACT_RUN_RIFLE, ACT_RUN_AIM_RIFLE},
		[ACT_LAND] = {ACT_RESET, ACT_RESET}
	},
	shotgun = {
		[ACT_MP_STAND_IDLE] = {ACT_IDLE_SMG1, ACT_IDLE_ANGRY_SHOTGUN},
		[ACT_MP_CROUCH_IDLE] = {ACT_CROUCHIDLE, ACT_CROUCHIDLE},
		[ACT_MP_WALK] = {"WalkEasy_all", ACT_WALK_AIM_SHOTGUN},
		[ACT_MP_CROUCHWALK] = {ACT_WALK_CROUCH_RIFLE, ACT_WALK_CROUCH_RIFLE},
		[ACT_MP_RUN] = {ACT_RUN_RIFLE, ACT_RUN_AIM_SHOTGUN},
		[ACT_LAND] = {ACT_RESET, ACT_RESET}
	},
	grenade = {
		[ACT_MP_STAND_IDLE] = {"idle_unarmed", ACT_IDLE_ANGRY},
		[ACT_MP_CROUCH_IDLE] = {ACT_CROUCHIDLE, ACT_CROUCHIDLE},
		[ACT_MP_WALK] = {"walkunarmed_all", ACT_WALK_RIFLE},
		[ACT_MP_CROUCHWALK] = {ACT_WALK_CROUCH_RIFLE, ACT_WALK_CROUCH_RIFLE},
		[ACT_MP_RUN] = {ACT_RUN_AIM_RIFLE, ACT_RUN_AIM_RIFLE},
		[ACT_LAND] = {ACT_RESET, ACT_RESET}
	},
	melee = {
		[ACT_MP_STAND_IDLE] = {"idle_unarmed", ACT_IDLE_ANGRY},
		[ACT_MP_CROUCH_IDLE] = {ACT_CROUCHIDLE, ACT_CROUCHIDLE},
		[ACT_MP_WALK] = {"walkunarmed_all", ACT_WALK_RIFLE},
		[ACT_MP_CROUCHWALK] = {ACT_WALK_CROUCH_RIFLE, ACT_WALK_CROUCH_RIFLE},
		[ACT_MP_RUN] = {ACT_RUN_AIM_RIFLE, ACT_RUN_AIM_RIFLE},
		[ACT_LAND] = {ACT_RESET, ACT_RESET},
		attack = ACT_MELEE_ATTACK_SWING_GESTURE
	},
	glide = ACT_GLIDE
}

ix.anim.playerzombie = {
	normal = {
		[ACT_MP_STAND_IDLE] = {ACT_HL2MP_IDLE_ZOMBIE, ACT_HL2MP_IDLE_ZOMBIE},
		[ACT_MP_CROUCH_IDLE] = {ACT_HL2MP_IDLE_CROUCH_ZOMBIE, ACT_HL2MP_IDLE_CROUCH_ZOMBIE},
		[ACT_MP_WALK] = {ACT_HL2MP_WALK_ZOMBIE_01, ACT_HL2MP_WALK_ZOMBIE_01},
		[ACT_MP_CROUCHWALK] = {ACT_HL2MP_WALK_CROUCH_ZOMBIE_01, ACT_HL2MP_WALK_CROUCH_ZOMBIE_01},
		[ACT_MP_RUN] = {ACT_HL2MP_RUN_ZOMBIE, ACT_HL2MP_RUN_ZOMBIE},
		[ACT_LAND] = {ACT_RESET, ACT_RESET},
		attack = ACT_GMOD_GESTURE_RANGE_ZOMBIE,
	},
}

ix.anim.SetModelClass("models/litenetwork/ota/echo.mdl", "overwatch")
ix.anim.SetModelClass("models/litenetwork/ota/mace.mdl", "overwatch")
ix.anim.SetModelClass("models/litenetwork/ota/ranger.mdl", "overwatch")
ix.anim.SetModelClass("models/litenetwork/ota/xray.mdl", "overwatch")
ix.anim.SetModelClass("models/litenetwork/ota/reaper.mdl", "overwatch")
ix.anim.SetModelClass("models/litenetwork/ota/ldr.mdl", "overwatch")
ix.anim.SetModelClass("models/litenetwork/ota/nova.mdl", "overwatch")
ix.anim.SetModelClass("models/nemez/combine_soldiers/combine_soldier_beta_h.mdl", "overwatch")
ix.anim.SetModelClass("models/nemez/combine_soldiers/combine_soldier_border_patrol_h.mdl", "overwatch")
ix.anim.SetModelClass("models/nemez/combine_soldiers/combine_soldier_coordinator_h.mdl", "overwatch")
ix.anim.SetModelClass("models/nemez/combine_soldiers/combine_soldier_elite_h.mdl", "overwatch")
ix.anim.SetModelClass("models/nemez/combine_soldiers/combine_soldier_elite_wpu_h.mdl", "overwatch")
ix.anim.SetModelClass("models/nemez/combine_soldiers/combine_soldier_h.mdl", "overwatch")
ix.anim.SetModelClass("models/nemez/combine_soldiers/combine_soldier_nova_h.mdl", "overwatch")
ix.anim.SetModelClass("models/nemez/combine_soldiers/combine_soldier_recon_h.mdl", "overwatch")
ix.anim.SetModelClass("models/nemez/combine_soldiers/combine_soldier_urban_h.mdl", "overwatch")
ix.anim.SetModelClass("models/nemez/combine_soldiers/combine_soldier_urban_shotgunner_h.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_darkelite1_soldier.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_darkelite_soldier.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_overwatch_soldier.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_soldier2000.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_soldiergrunt.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_soldieros.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_soldierproto.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_soldierproto_drt.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_soldiersnow.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_super_soldierproto.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_super_soldierprotodirt.mdl", "overwatch")
ix.anim.SetModelClass("models/willardnetworks/combine/charger.mdl", "overwatch")
ix.anim.SetModelClass("models/willardnetworks/combine/ordinal.mdl", "overwatch")
ix.anim.SetModelClass("models/willardnetworks/combine/soldier.mdl", "overwatch")
ix.anim.SetModelClass("models/willardnetworks/combine/suppressor.mdl", "overwatch")
ix.anim.SetModelClass("models/wn7new/metropolice/male_01.mdl", "metrocop")
ix.anim.SetModelClass("models/wn7new/metropolice/male_02.mdl", "metrocop")
ix.anim.SetModelClass("models/wn7new/metropolice/male_03.mdl", "metrocop")
ix.anim.SetModelClass("models/wn7new/metropolice/male_04.mdl", "metrocop")
ix.anim.SetModelClass("models/wn7new/metropolice/male_05.mdl", "metrocop")
ix.anim.SetModelClass("models/wn7new/metropolice/male_06.mdl", "metrocop")
ix.anim.SetModelClass("models/wn7new/metropolice/male_07.mdl", "metrocop")
ix.anim.SetModelClass("models/wn7new/metropolice/male_08.mdl", "metrocop")
ix.anim.SetModelClass("models/wn7new/metropolice/male_09.mdl", "metrocop")
ix.anim.SetModelClass("models/wn7new/metropolice/male_10.mdl", "metrocop")
ix.anim.SetModelClass("models/ma/hla/metropolice.mdl", "metrocop")
ix.anim.SetModelClass("models/vortigaunt.mdl", "vortigaunt")
ix.anim.SetModelClass("models/vortigaunt_slave.mdl", "vortigaunt")
ix.anim.SetModelClass("models/willardnetworks/vortigaunt.mdl", "vortigaunt")
ix.anim.SetModelClass("models/player/zombie_classic.mdl", "playerzombie")
ix.anim.SetModelClass("models/player/zombie_soldier.mdl", "playerzombie")

--[[ Hand Supports ]]--
player_manager.AddValidModel("CombineSoldierHands", "models/litenetwork/ota/echo.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/litenetwork/ota/mace.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/litenetwork/ota/ranger.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/litenetwork/ota/xray.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/litenetwork/ota/reaper.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/litenetwork/ota/ldr.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/litenetwork/ota/nova.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/nemez/combine_soldiers/combine_soldier_beta_h.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/nemez/combine_soldiers/combine_soldier_border_patrol_h.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/nemez/combine_soldiers/combine_soldier_coordinator_h.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/nemez/combine_soldiers/combine_soldier_elite_h.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/nemez/combine_soldiers/combine_soldier_elite_wpu_h.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/nemez/combine_soldiers/combine_soldier_h.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/nemez/combine_soldiers/combine_soldier_nova_h.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/nemez/combine_soldiers/combine_soldier_recon_h.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/nemez/combine_soldiers/combine_soldier_urban_h.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/nemez/combine_soldiers/combine_soldier_urban_shotgunner_h.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_darkelite1_soldier.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_darkelite_soldier.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_overwatch_soldier.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_soldier2000.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_soldiergrunt.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_soldieros.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_soldierproto.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_soldierproto_drt.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_soldiersnow.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_super_soldierproto.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_super_soldierprotodirt.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/wn7new/metropolice/female_01.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/wn7new/metropolice/female_02.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/wn7new/metropolice/female_03.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/wn7new/metropolice/female_04.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/wn7new/metropolice/female_06.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/wn7new/metropolice/female_07.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/wn7new/metropolice/male_01.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/wn7new/metropolice/male_02.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/wn7new/metropolice/male_03.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/wn7new/metropolice/male_04.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/wn7new/metropolice/male_05.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/wn7new/metropolice/male_06.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/wn7new/metropolice/male_07.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/wn7new/metropolice/male_08.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/wn7new/metropolice/male_09.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/wn7new/metropolice/male_10.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/ma/hla/metropolice.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/willardnetworks/combine/suppressor.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/willardnetworks/combine/soldier.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/willardnetworks/combine/ordinal.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/willardnetworks/combine/charger.mdl")
player_manager.AddValidHands("CombineSoldierHands", "models/weapons/c_arms_combine.mdl", 1, "0000000")

player_manager.AddValidModel("VortigauntHands", "models/vortigaunt.mdl")
player_manager.AddValidModel("VortigauntHands", "models/vortigaunt_slave.mdl")
player_manager.AddValidModel("VortigauntHands", "models/willardnetworks/vortigaunt.mdl")
player_manager.AddValidHands("VortigauntHands", "models/willardnetworks/c_arms_vortigaunt.mdl", 1, "0000000")