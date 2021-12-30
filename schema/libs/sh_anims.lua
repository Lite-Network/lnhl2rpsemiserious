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

ix.anim.cremator = {
	normal = {
		[ACT_MP_STAND_IDLE] = {ACT_IDLE, ACT_IDLE},
		[ACT_MP_CROUCH_IDLE] = {ACT_IDLE, ACT_IDLE},
		[ACT_MP_RUN] = {ACT_WALK, ACT_WALK},
		[ACT_MP_CROUCHWALK] = {ACT_WALK, ACT_WALK},
		[ACT_MP_WALK] = {ACT_WALK, ACT_WALK},
		attack = ACT_RANGE_ATTACK1_LOW,
	},
	smg = { -- hold type for immolator
		[ACT_MP_STAND_IDLE] = {ACT_IDLE, ACT_IDLE},
		[ACT_MP_CROUCH_IDLE] = {ACT_IDLE, ACT_IDLE},
		[ACT_MP_RUN] = {ACT_WALK, ACT_WALK},
		[ACT_MP_CROUCHWALK] = {ACT_WALK, ACT_WALK},
		[ACT_MP_WALK] = {ACT_WALK, ACT_WALK},
		attack = ACT_RANGE_ATTACK1_LOW,
	},
	physgun = { 
		[ACT_MP_STAND_IDLE] = {ACT_IDLE, ACT_IDLE},
		[ACT_MP_CROUCH_IDLE] = {ACT_IDLE, ACT_IDLE},
		[ACT_MP_RUN] = {ACT_WALK, ACT_WALK},
		[ACT_MP_CROUCHWALK] = {ACT_WALK, ACT_WALK},
		[ACT_MP_WALK] = {ACT_WALK, ACT_WALK},
		attack = ACT_RANGE_ATTACK1_LOW,
	},
	pistol = {
		[ACT_MP_STAND_IDLE] = {ACT_IDLE, ACT_IDLE},
		[ACT_MP_CROUCH_IDLE] = {ACT_IDLE, ACT_IDLE},
		[ACT_MP_RUN] = {ACT_WALK, ACT_WALK},
		[ACT_MP_CROUCHWALK] = {ACT_WALK, ACT_WALK},
		[ACT_MP_WALK] = {ACT_WALK, ACT_WALK},
		attack = ACT_RANGE_ATTACK1_LOW,
	},
}

ix.anim.SetModelClass("models/cremator.mdl", "cremator")

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

ix.anim.SetModelClass("models/dpfilms/metropolice/arctic_police.mdl", "metrocop") -- Arctic Police
ix.anim.SetModelClass("models/dpfilms/metropolice/badass_police.mdl", "metrocop") -- Badass Police
ix.anim.SetModelClass("models/dpfilms/metropolice/biopolice.mdl", "metrocop") -- Bio Police 
ix.anim.SetModelClass("models/dpfilms/metropolice/blacop.mdl", "metrocop") -- Black Police
ix.anim.SetModelClass("models/dpfilms/metropolice/c08cop.mdl", "metrocop") -- City 08 Police
ix.anim.SetModelClass("models/dpfilms/metropolice/civil_medic.mdl", "metrocop") -- Civil Medic/HELIX
ix.anim.SetModelClass("models/dpfilms/metropolice/elite_police.mdl", "metrocop") -- Elite Police 
ix.anim.SetModelClass("models/dpfilms/metropolice/female_police.mdl", "metrocop") -- Female Police 
ix.anim.SetModelClass("models/dpfilms/metropolice/hd_barney.mdl", "metrocop") -- HD Barney 
ix.anim.SetModelClass("models/dpfilms/metropolice/hdpolice.mdl", "metrocop") -- HD Police 
ix.anim.SetModelClass("models/dpfilms/metropolice/hl2beta_police.mdl", "metrocop") -- HL2 Beta Police
ix.anim.SetModelClass("models/dpfilms/metropolice/hl2concept.mdl", "metrocop") -- HL2 Concept Police 
ix.anim.SetModelClass("models/dpfilms/metropolice/hunter_police.mdl", "metrocop") -- Hunter Police 
ix.anim.SetModelClass("models/dpfilms/metropolice/police_bt.mdl", "metrocop") -- Breen Troop Police 
ix.anim.SetModelClass("models/dpfilms/metropolice/police_fragger.mdl", "metrocop") -- Fragger Police 
ix.anim.SetModelClass("models/dpfilms/metropolice/policetrench.mdl", "metrocop") -- Trenchcoat Police 
ix.anim.SetModelClass("models/dpfilms/metropolice/resistance_police.mdl", "metrocop") -- Resistance/Rebel Police 
ix.anim.SetModelClass("models/dpfilms/metropolice/retrocop.mdl", "metrocop") -- Retro Police
ix.anim.SetModelClass("models/dpfilms/metropolice/rogue_police.mdl", "metrocop") -- Rogue Police
ix.anim.SetModelClass("models/dpfilms/metropolice/rtb_police.mdl", "metrocop") -- RTB Police 
ix.anim.SetModelClass("models/dpfilms/metropolice/steampunk_police.mdl", "metrocop") -- Steampunk Police 
ix.anim.SetModelClass("models/dpfilms/metropolice/tf2_metrocop.mdl", "metrocop") -- TF2 Police 
ix.anim.SetModelClass("models/dpfilms/metropolice/tribal_police.mdl", "metrocop") -- Tribal Police 
ix.anim.SetModelClass("models/dpfilms/metropolice/tron_police.mdl", "metrocop") -- Tron Police 
ix.anim.SetModelClass("models/dpfilms/metropolice/urban_police.mdl", "metrocop") -- Urban Police 
ix.anim.SetModelClass("models/dpfilms/metropolice/zombie_police.mdl", "metrocop") -- Zombie/Infected Police

ix.anim.SetModelClass("models/combine_super_soldier.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_super_a.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_super_s.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_super_sa.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_ground.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_ground_a.mdl", "overwatch")
ix.anim.SetModelClass("models/Combine_soldier.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_ground_sa.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_shotgun.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_shotgun_a.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_shotgun_sa.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_prison.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_prison_a.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_soldier_prisonguard.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_prison_sa.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_watch.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_watch_a.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_watch_s.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_watch_sa.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_advisor.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_advisor_a.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_advisor_s.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_advisor_sa.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_arctic.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_arctic_a.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_arctic_s.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_arctic_sa.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_coast.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_coast_a.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_coast_s.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_coast_sa.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_hazard.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_hazard_a.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_hazard_s.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_hazard_sa.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_hunter.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_hunter_a.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_hunter_s.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_hunter_sa.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_nebula.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_nebula_a.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_nebula_s.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_nebula_sa.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_murky.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_murky_a.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_murky_s.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_murky_sa.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_watch.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_watch_a.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_watch_s.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_watch_sa.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_taiga.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_taiga_a.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_taiga_s.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_taiga_sa.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_threser.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_threser_a.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_threser_s.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_threser_sa.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_alyx_s.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_alyx_sa.mdl", "overwatch")
ix.anim.SetModelClass("models/combine_heavy_a.mdl", "overwatch")

--[[ Hand Supports ]]--
player_manager.AddValidModel("CombineSoldierHands", "models/dpfilms/metropolice/arctic_police.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/dpfilms/metropolice/badass_police.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/dpfilms/metropolice/biopolice.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/dpfilms/metropolice/blacop.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/dpfilms/metropolice/c08cop.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/dpfilms/metropolice/civil_medic.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/dpfilms/metropolice/elite_police.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/dpfilms/metropolice/hdpolice.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/dpfilms/metropolice/hl2beta_police.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/dpfilms/metropolice/hl2beta_police.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/dpfilms/metropolice/hl2concept.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/dpfilms/metropolice/hunter_police.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/dpfilms/metropolice/phoenix_police.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/dpfilms/metropolice/police_bt.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/dpfilms/metropolice/police_fragger.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/dpfilms/metropolice/policetrench.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/dpfilms/metropolice/retrocop.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/dpfilms/metropolice/resistance_police.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/dpfilms/metropolice/rogue_police.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/dpfilms/metropolice/rtb_police.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/dpfilms/metropolice/steampunk_police.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/dpfilms/metropolice/tf2_metrocop.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/dpfilms/metropolice/tribal_police.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/dpfilms/metropolice/tron_police.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/dpfilms/metropolice/urban_police.mdl")

player_manager.AddValidModel("CombineSoldierHands", "models/combine_super_soldier.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_super_a.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_super_s.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_super_sa.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_ground.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_ground_a.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/Combine_soldier.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_ground_sa.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_shotgun.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_shotgun_a.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_shotgun_sa.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_prison.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_prison_a.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_soldier_prisonguard.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_prison_sa.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_watch.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_watch_a.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_watch_s.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_watch_sa.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_advisor.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_advisor_a.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_advisor_s.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_advisor_sa.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_arctic.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_arctic_a.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_arctic_s.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_arctic_sa.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_coast.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_coast_a.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_coast_s.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_coast_sa.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_hazard.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_hazard_a.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_hazard_s.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_hazard_sa.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_hunter.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_hunter_a.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_hunter_s.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_hunter_sa.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_murky.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_murky_a.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_murky_s.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_murky_sa.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_watch.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_watch_a.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_watch_s.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_watch_sa.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_taiga.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_taiga_a.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_taiga_s.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_taiga_sa.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_threser.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_threser_a.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_threser_s.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_threser_sa.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_alyx_s.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_alyx_sa.mdl")
player_manager.AddValidModel("CombineSoldierHands", "models/combine_heavy_a.mdl")

player_manager.AddValidHands("CombineSoldierHands", "models/weapons/c_arms_combine.mdl", 1, "0000000")

player_manager.AddValidModel("VortigauntHands", "models/vortigaunt.mdl")
player_manager.AddValidModel("VortigauntHands", "models/vortigaunt_slave.mdl")
player_manager.AddValidModel("VortigauntHands", "models/willardnetworks/vortigaunt.mdl")
player_manager.AddValidHands("VortigauntHands", "models/willardnetworks/c_arms_vortigaunt.mdl", 1, "0000000")