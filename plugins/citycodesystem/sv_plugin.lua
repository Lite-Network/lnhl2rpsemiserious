local PLUGIN = PLUGIN

--[[---------------------------------------------------------------------------
	City Turmoil
---------------------------------------------------------------------------]]--

function PLUGIN:CityTurmoilStart()
	SetGlobalBool("ixCTStatus", true)

    PlayEventSound("ambient/levels/citadel/advisor_lift.wav")
    PlayTimedEventSound(5, "npc/overwatch/cityvoice/f_unrestprocedure1_spkr.wav")
    PlayTimedEventSound(6, "ambient/levels/citadel/citadel_5sirens3.wav")
    PlayTimedEventSound(7, "ambient/levels/citadel/advisor_leave.wav")
    PlayTimedEventSound(7, "ambient/levels/citadel/citadel_drone_loop2.wav")
    PlayTimedEventSound(7, "LiteNetwork/hl2rp/event/battle/battle_5.wav")
    PlayTimedEventSound(9, "ambient/levels/citadel/stalk_traindooropen.wav")
    PlayTimedEventSound(9, "ambient/levels/streetwar/city_riot2.wav")
    PlayTimedEventSound(12, "ambient/levels/citadel/citadel_5sirens3.wav")
    PlayTimedEventSound(19, "ambient/levels/streetwar/heli_distant1.wav")
    PlayTimedEventSound(25, "ambient/levels/streetwar/gunship_distant1.wav")
    PlayTimedEventSound(30, "ambient/levels/streetwar/gunship_distant2.wav")

    PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
    PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
    PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
    for _, v in pairs(player.GetAll()) do
        util.ScreenShake(v:GetPos(), 5, 5, 3, 500)
    end

	timer.Simple(4, function()
        PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
        PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
        PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
        for _, v in pairs(player.GetAll()) do
            util.ScreenShake(v:GetPos(), 5, 5, 3, 500)
        end
	end)

	timer.Simple(7, function()
        PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
        PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
        PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
        for _, v in pairs(player.GetAll()) do
            util.ScreenShake(v:GetPos(), 5, 5, 3, 500)
        end
	end)

	timer.Simple(7, function()
        timer.Create("ixCityTurmoilAmbience", 10, 0, function()
            local randomChance = math.random(1, 5)
            if ( randomChance == 2 ) then
                PlayTimedEventSound(math.random(0.0, 3.0), table.Random({
                    "npc/overwatch/cityvoice/f_anticitizenreport_spkr.wav",
                    "npc/overwatch/cityvoice/f_anticivil1_5_spkr.wav",
                    "npc/overwatch/cityvoice/f_anticivilevidence_3_spkr.wav",
                    "npc/overwatch/cityvoice/f_capitalmalcompliance_spkr.wav",
                    "npc/overwatch/cityvoice/f_sociolevel1_4_spkr.wav",
                    "npc/overwatch/cityvoice/f_unrestprocedure1_spkr.wav",
                }))
            end
            PlayEventSound({
                "LiteNetwork/hl2rp/event/battle/city_battle1.wav",
                "LiteNetwork/hl2rp/event/battle/city_battle2.wav",
                "LiteNetwork/hl2rp/event/battle/city_battle3.wav",
                "LiteNetwork/hl2rp/event/battle/city_battle4.wav",
                "LiteNetwork/hl2rp/event/battle/city_battle5.wav",
                "LiteNetwork/hl2rp/event/battle/city_battle6.wav",
                "LiteNetwork/hl2rp/event/battle/city_battle7.wav",
                "LiteNetwork/hl2rp/event/battle/city_battle8.wav",
                "LiteNetwork/hl2rp/event/battle/city_battle9.wav",
                "LiteNetwork/hl2rp/event/battle/city_battle10.wav",
                "LiteNetwork/hl2rp/event/battle/city_battle11.wav",
                "LiteNetwork/hl2rp/event/battle/city_battle12.wav",
                "LiteNetwork/hl2rp/event/battle/city_battle13.wav",
                "LiteNetwork/hl2rp/event/battle/city_battle14.wav",
                "LiteNetwork/hl2rp/event/battle/city_battle15.wav",
                "LiteNetwork/hl2rp/event/battle/city_battle16.wav",
                "LiteNetwork/hl2rp/event/battle/city_battle17.wav",
                "LiteNetwork/hl2rp/event/battle/city_battle18.wav",
                "LiteNetwork/hl2rp/event/battle/city_battle19.wav",
                "LiteNetwork/hl2rp/event/battle/distant_battle_dropship01.wav",
                "LiteNetwork/hl2rp/event/battle/distant_battle_dropship02.wav",
                "LiteNetwork/hl2rp/event/battle/distant_battle_dropship03.wav",
                "LiteNetwork/hl2rp/event/battle/distant_battle_gunfire01.wav",
                "LiteNetwork/hl2rp/event/battle/distant_battle_gunfire02.wav",
                "LiteNetwork/hl2rp/event/battle/distant_battle_gunfire03.wav",
                "LiteNetwork/hl2rp/event/battle/distant_battle_gunfire04.wav",
                "LiteNetwork/hl2rp/event/battle/distant_battle_gunfire05.wav",
                "LiteNetwork/hl2rp/event/battle/distant_battle_gunfire06.wav",
                "LiteNetwork/hl2rp/event/battle/distant_battle_gunfire07.wav",
                "LiteNetwork/hl2rp/event/battle/distant_battle_shotgun01.wav",
                "LiteNetwork/hl2rp/event/battle/distant_battle_soldier01.wav",
            })
        end)
    end)
end

function PLUGIN:CityTurmoilStop()
	SetGlobalBool("ixCTStatus", false)
    timer.Remove("ixCityTurmoilAmbience")
    StopEventSound("ambient/levels/citadel/citadel_drone_loop2.wav")
    StopEventSound("LiteNetwork/hl2rp/event/battle/battle_5.wav")
end

--[[---------------------------------------------------------------------------
	Judgement Waiver
---------------------------------------------------------------------------]]--

function PLUGIN:JudgementWaiverStart()
	SetGlobalBool("ixJWStatus", true)

	PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
    PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
    PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
    PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
    PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
    PlayEventSound("ambient/atmosphere/hole_hit"..math.random(1,5)..".wav")
    PlayEventSound("ambient/atmosphere/terrain_rumble1.wav")

    for _, v in pairs(player.GetAll()) do
        util.ScreenShake(v:GetPos(), 5, 5, 4, 5000)
    end

	for _, v in pairs(ents.FindByName("citadel")) do
		v:Fire("SetAnimation", "open")
	end

	PlayEventSound("npc/overwatch/cityvoice/f_protectionresponse_5_spkr.wav")
	PlayEventSound("ambient/alarms/manhack_alert_pass1.wav")
	PlayEventSound("doors/door_metal_large_chamber_close1.wav")
	PlayEventSound("doors/door_metal_large_chamber_close1.wav")

	timer.Simple(1, function()
		PlayEventSound("ambient/alarms/city_siren_loop2.wav")
		PlayEventSound("doors/door_metal_large_chamber_close1.wav")
		PlayEventSound("doors/door_metal_large_chamber_close1.wav")
	end)

	timer.Simple(2, function()
        PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
        PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
        PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
        PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
        PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
        PlayEventSound("ambient/atmosphere/hole_hit"..math.random(1,5)..".wav")
        for _, v in pairs(player.GetAll()) do
            util.ScreenShake(v:GetPos(), 5, 5, 3, 5000)
        end

		PlayEventSound("ambient/machines/wall_move1.wav")
	end)

	timer.Simple(5, function()
        PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
		PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
		PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
		PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
		PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
		PlayEventSound("ambient/atmosphere/hole_hit"..math.random(1,5)..".wav")
		PlayEventSound("ambient/atmosphere/terrain_rumble1.wav")

		for _, v in pairs(player.GetAll()) do
			util.ScreenShake(v:GetPos(), 5, 5, 5, 5000)
		end

		PlayEventSound("ambient/machines/wall_crash1.wav")
		PlayEventSound("ambient/levels/streetwar/marching_distant2.wav")
		PlayEventSound("ambient/levels/citadel/drone1lp.wav")
		PlayEventSound("LiteNetwork/hl2rp/event/battle/battle_1.wav")
	end)

	timer.Simple(9, function()
        PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
        PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
        PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
        PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
        PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
        PlayEventSound("ambient/atmosphere/hole_hit"..math.random(1,5)..".wav")
        for _, v in pairs(player.GetAll()) do
            util.ScreenShake(v:GetPos(), 5, 5, 3, 5000)
        end

		PlayEventSound("ambient/materials/metal_big_impact_scrape1.wav")
	end)

	timer.Simple(10, function()
		for k, v in pairs(player.GetAll()) do v:StopSound("ambient/alarms/city_siren_loop2.wav") end
		PlayEventSound("ambient/levels/streetwar/marching_distant2.wav")
		PlayEventSound("LiteNetwork/hl2rp/event/battle/city_chant1.wav")
		PlayEventSound("ambient/alarms/citadel_alert_loop2.wav")
		timer.Create("ixJudgementWaiverAmbience", 5, 0, function()
			PlayEventSound({
				"LiteNetwork/hl2rp/event/battle/city_battle1.wav",
				"LiteNetwork/hl2rp/event/battle/city_battle2.wav",
				"LiteNetwork/hl2rp/event/battle/city_battle3.wav",
				"LiteNetwork/hl2rp/event/battle/city_battle4.wav",
				"LiteNetwork/hl2rp/event/battle/city_battle5.wav",
				"LiteNetwork/hl2rp/event/battle/city_battle6.wav",
				"LiteNetwork/hl2rp/event/battle/city_battle7.wav",
				"LiteNetwork/hl2rp/event/battle/city_battle8.wav",
				"LiteNetwork/hl2rp/event/battle/city_battle9.wav",
				"LiteNetwork/hl2rp/event/battle/city_battle10.wav",
				"LiteNetwork/hl2rp/event/battle/city_battle11.wav",
				"LiteNetwork/hl2rp/event/battle/city_battle12.wav",
				"LiteNetwork/hl2rp/event/battle/city_battle13.wav",
				"LiteNetwork/hl2rp/event/battle/city_battle14.wav",
				"LiteNetwork/hl2rp/event/battle/city_battle15.wav",
				"LiteNetwork/hl2rp/event/battle/city_battle16.wav",
				"LiteNetwork/hl2rp/event/battle/city_battle17.wav",
				"LiteNetwork/hl2rp/event/battle/city_battle18.wav",
				"LiteNetwork/hl2rp/event/battle/city_battle19.wav",
				"LiteNetwork/hl2rp/event/battle/distant_battle_dropship01.wav",
				"LiteNetwork/hl2rp/event/battle/distant_battle_dropship02.wav",
				"LiteNetwork/hl2rp/event/battle/distant_battle_dropship03.wav",
				"LiteNetwork/hl2rp/event/battle/distant_battle_gunfire01.wav",
				"LiteNetwork/hl2rp/event/battle/distant_battle_gunfire02.wav",
				"LiteNetwork/hl2rp/event/battle/distant_battle_gunfire03.wav",
				"LiteNetwork/hl2rp/event/battle/distant_battle_gunfire04.wav",
				"LiteNetwork/hl2rp/event/battle/distant_battle_gunfire05.wav",
				"LiteNetwork/hl2rp/event/battle/distant_battle_gunfire06.wav",
				"LiteNetwork/hl2rp/event/battle/distant_battle_gunfire07.wav",
				"LiteNetwork/hl2rp/event/battle/distant_battle_shotgun01.wav",
				"LiteNetwork/hl2rp/event/battle/distant_battle_soldier01.wav",
				"LiteNetwork/hl2rp/event/battle/strider_1.wav",
				"LiteNetwork/hl2rp/event/battle/strider_2.wav",
				"LiteNetwork/hl2rp/event/battle/strider_3.wav",
				"LiteNetwork/hl2rp/event/overhead/helicopter01.ogg",
				"LiteNetwork/hl2rp/event/overhead/helicopter02.ogg",
				"LiteNetwork/hl2rp/event/overhead/helicopter03.ogg",
				"LiteNetwork/hl2rp/event/overhead/helicopter04.ogg",
				"LiteNetwork/hl2rp/event/overhead/helicopter05.ogg",
				"LiteNetwork/hl2rp/event/overhead/helicopter06.ogg",
				"LiteNetwork/hl2rp/event/overhead/helicopter07.ogg",
				"LiteNetwork/hl2rp/event/overhead/helicopter08.ogg",
				"LiteNetwork/hl2rp/event/overhead/jet01.mp3",
				"LiteNetwork/hl2rp/event/overhead/jet02.mp3",
				"LiteNetwork/hl2rp/event/overhead/jet03.mp3",
				"LiteNetwork/hl2rp/event/overhead/jet04.mp3",
				"LiteNetwork/hl2rp/event/scary/idle_moan_wet_01.ogg",
				"LiteNetwork/hl2rp/event/scary/idle_moan_wet_02.ogg",
				"LiteNetwork/hl2rp/event/scary/idle_moan_wet_03.ogg",
				"LiteNetwork/hl2rp/event/scary/idle_moan_wet_04.ogg",
				"LiteNetwork/hl2rp/event/scary/idle_moan_wet_05.ogg",
				"LiteNetwork/hl2rp/event/scary/idle_moan_wet_06.ogg",
				"LiteNetwork/hl2rp/event/scary/idle_moan_wet_07.ogg",
				"LiteNetwork/hl2rp/event/scary/idle_moan_wet_08.ogg",
				"LiteNetwork/hl2rp/event/scary/idle_moan_wet_09.ogg",
				"LiteNetwork/hl2rp/event/scary/idle_moan_wet_10.ogg",
				"LiteNetwork/hl2rp/event/scary/idle_moan_wet_11.ogg",
				"LiteNetwork/hl2rp/event/scary/idle_moan_wet_12.ogg",
				"LiteNetwork/hl2rp/event/scary/idle_moan_wet_13.ogg",
				"LiteNetwork/hl2rp/event/scary/idle_moan_wet_14.ogg",
			})
		end)

		timer.Create("ixJudgementWaiverAlarm", 45, 0, function()
			PlayEventSound("ambient/alarms/citadel_alert_loop2.wav")

            PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
            PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
            PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
            PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
            PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
            PlayEventSound("ambient/atmosphere/hole_hit"..math.random(1,5)..".wav")
            for _, v in pairs(player.GetAll()) do
                util.ScreenShake(v:GetPos(), 5, 5, 3, 5000)
            end
		end)

		timer.Create("ixJudgementWaiverReminder", 300, 0, function()
			PlayEventSound("npc/overwatch/cityvoice/f_protectionresponse_5_spkr.wav")
		end)
	end)

	timer.Simple(14, function()
		PlayEventSound("ambient/levels/streetwar/marching_distant2.wav")
	end)
end

function PLUGIN:JudgementWaiverStopSilent()
	for _, v in pairs(ents.FindByName("citadel")) do
		v:Fire("SetAnimation", "idle")
	end

	for _, v in ipairs(player.GetAll()) do
		v:StopSound("ambient/levels/citadel/drone1lp.wav")
		v:StopSound("LiteNetwork/hl2rp/event/battle/battle_1.wav")
	end

	SetGlobalBool("ixJWStatus", false)
	timer.Destroy("ixJudgementWaiverAlarm")
	timer.Destroy("ixJudgementWaiverAmbience")
	timer.Destroy("ixJudgementWaiverReminder")
end

function PLUGIN:JudgementWaiverStop()
	SetGlobalBool("ixJWStatus", false)

    PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
    PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
    PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
    PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
    PlayEventSound("ambient/atmosphere/hole_hit"..math.random(1,5)..".wav")

    for _, ply in pairs(player.GetAll()) do
        util.ScreenShake( ply:GetPos(), 5, 5, 2, 5000 )
    end

	timer.Destroy("ixJudgementWaiverAlarm")
	timer.Destroy("ixJudgementWaiverReminder")

	timer.Simple(2, function()
        PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
        PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
        PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
        PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
        PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
        PlayEventSound("ambient/atmosphere/hole_hit"..math.random(1,5)..".wav")
        for _, v in pairs(player.GetAll()) do
            util.ScreenShake(v:GetPos(), 5, 5, 3, 5000)
        end
	end)

	timer.Simple(10, function()
        PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
        PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
        PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
        PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
        PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
        PlayEventSound("ambient/atmosphere/hole_hit"..math.random(1,5)..".wav")
        for _, v in pairs(player.GetAll()) do
            util.ScreenShake(v:GetPos(), 5, 5, 3, 5000)
        end

		timer.Destroy("ixJudgementWaiverAmbience")
		for _, v in ipairs(player.GetAll()) do
			v:StopSound("ambient/levels/citadel/drone1lp.wav")
			v:StopSound("LiteNetwork/hl2rp/event/battle/battle_1.wav")
		end
	end)

	for _, v in pairs(ents.FindByName("citadel")) do
		v:Fire("SetAnimation", "idle")
	end
	PlayEventSound("ambient/materials/metal_big_impact_scrape1.wav")
	PlayEventSound("ambient/alarms/scanner_alert_pass1.wav")
	PlayEventSound("doors/door_metal_large_chamber_close1.wav")
	PlayEventSound("doors/door_metal_large_chamber_close1.wav")
	PlayTimedEventSound(0.5, "doors/door_metal_large_chamber_close1.wav")
	PlayTimedEventSound(0.5, "doors/door_metal_large_chamber_close1.wav")
	PlayTimedEventSound(0.5, "doors/door_metal_large_chamber_close1.wav")
	PlayTimedEventSound(1, "doors/door_metal_large_chamber_close1.wav")
	PlayTimedEventSound(1, "doors/door_metal_large_chamber_close1.wav")
	PlayTimedEventSound(1, "doors/door_metal_large_chamber_close1.wav")
	PlayTimedEventSound(2, "ambient/machines/wall_move1.wav")
	PlayTimedEventSound(4, "ambient/machines/wall_move2.wav")
	PlayTimedEventSound(4, "ambient/levels/streetwar/marching_distant2.wav")
	PlayTimedEventSound(10, "ambient/machines/wall_crash1.wav")
	PlayTimedEventSound(10, "ambient/levels/streetwar/marching_distant2.wav")
	PlayTimedEventSound(10, "LiteNetwork/hl2rp/event/battle/city_chant1.wav")
	PlayTimedEventSound(15, "npc/overwatch/cityvoice/f_innactionisconspiracy_spkr.wav")
	PlayTimedEventSound(15, "ambient/levels/streetwar/marching_distant1.wav")
end

--[[---------------------------------------------------------------------------
	Autonomous Judgement
---------------------------------------------------------------------------]]--

function PLUGIN:AutonomousJudgementStart()
	for k, v in pairs(player.GetAll()) do
		net.Start("ixEventMessage")
			net.WriteString("Autonomous Judgement.. Prepare yourselves..")
		net.Send(v)
	end

	PlayEventSound("npc/overwatch/cityvoice/f_protectionresponse_4_spkr.wav")
	PlayEventSound("LiteNetwork/hl2rp/music/trailer.ogg")
	PlayTimedEventSound(1, "ambient/levels/citadel/citadel_5sirens3.wav")
	PlayTimedEventSound(3, "ambient/levels/citadel/strange_talk"..math.random(1,11)..".wav")
	PlayTimedEventSound(6, "ambient/levels/citadel/strange_talk"..math.random(1,11)..".wav")
	PlayTimedEventSound(10, "ambient/levels/citadel/portal_open1_adpcm.wav")
	PlayTimedEventSound(12, "LiteNetwork/hl2rp/cityvoice/void.mp3")
	PlayTimedEventSound(12, "ambient/levels/citadel/core_partialcontain_loop1.wav")
	PlayTimedEventSound(12, "ambient/levels/citadel/citadel_drone_loop1.wav")
	PlayTimedEventSound(30, "npc/overwatch/cityvoice/f_protectionresponse_4_spkr.wav")

	timer.Simple(12, function()
		SetGlobalBool("ixAJStatus", true)
		local portalStormClouds = ents.Create("prop_dynamic")
		portalStormClouds:SetPos(Vector(-14115.766602, -13259.793945, 13184.562500))
		portalStormClouds:SetModel("models/props_combine/combine_citadelcloud001c.mdl")
		portalStormClouds:SetModelScale(0.75)
		portalStormClouds:Spawn()

		local portalStorm = ents.Create("prop_dynamic")
		portalStorm:SetPos(Vector(-14115.766602, -13259.793945, -13454.562500))
		portalStorm:SetModel("models/props_combine/combine_citadelcloudcenter.mdl")
		portalStorm:SetModelScale(0.75)
		portalStorm:Spawn()

        PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
		PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
		PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
		PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
		PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
		PlayEventSound("ambient/atmosphere/hole_hit"..math.random(1,5)..".wav")
		PlayEventSound("ambient/atmosphere/terrain_rumble1.wav")

		for _, v in pairs(player.GetAll()) do
			util.ScreenShake(v:GetPos(), 5, 5, 5, 5000)
		end

		PlayEventSound("ambient/levels/labs/teleport_weird_voices"..math.random(1,2)..".wav")
		PlayEventSound("ambient/levels/labs/teleport_postblast_thunder1.wav")

		for _, v in pairs(player.GetAll()) do
			v:ScreenFade(SCREENFADE.IN, color_white, 5, 0)
		end

		timer.Create("ixAJAmbiencePortal", 7, 0, function()
            PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
            PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
            PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
            PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
            PlayEventSound("ambient/atmosphere/hole_hit"..math.random(1,5)..".wav")

            for _, ply in pairs(player.GetAll()) do
                util.ScreenShake( ply:GetPos(), 5, 5, 2, 5000 )
            end

			PlayEventSound({
				"ambient/levels/city/citadel_cloudhit1.wav",
				"ambient/levels/city/citadel_cloudhit2.wav",
				"ambient/levels/city/citadel_cloudhit3.wav",
				"ambient/levels/city/citadel_cloudhit4.wav",
				"ambient/levels/city/citadel_cloudhit5.wav",
			})
		end)
		timer.Create("ixAJAmbience", 3, 0, function()
			PlayEventSound({
				"LiteNetwork/hl2rp/event/battle/city_battle1.wav",
				"LiteNetwork/hl2rp/event/battle/city_battle2.wav",
				"LiteNetwork/hl2rp/event/battle/city_battle3.wav",
				"LiteNetwork/hl2rp/event/battle/city_battle4.wav",
				"LiteNetwork/hl2rp/event/battle/city_battle5.wav",
				"LiteNetwork/hl2rp/event/battle/city_battle6.wav",
				"LiteNetwork/hl2rp/event/battle/city_battle7.wav",
				"LiteNetwork/hl2rp/event/battle/city_battle8.wav",
				"LiteNetwork/hl2rp/event/battle/city_battle9.wav",
				"LiteNetwork/hl2rp/event/battle/city_battle10.wav",
				"LiteNetwork/hl2rp/event/battle/city_battle11.wav",
				"LiteNetwork/hl2rp/event/battle/city_battle12.wav",
				"LiteNetwork/hl2rp/event/battle/city_battle13.wav",
				"LiteNetwork/hl2rp/event/battle/city_battle14.wav",
				"LiteNetwork/hl2rp/event/battle/city_battle15.wav",
				"LiteNetwork/hl2rp/event/battle/city_battle16.wav",
				"LiteNetwork/hl2rp/event/battle/city_battle17.wav",
				"LiteNetwork/hl2rp/event/battle/city_battle18.wav",
				"LiteNetwork/hl2rp/event/battle/city_battle19.wav",
				"LiteNetwork/hl2rp/event/battle/distant_battle_dropship01.wav",
				"LiteNetwork/hl2rp/event/battle/distant_battle_dropship02.wav",
				"LiteNetwork/hl2rp/event/battle/distant_battle_dropship03.wav",
				"LiteNetwork/hl2rp/event/battle/distant_battle_gunfire01.wav",
				"LiteNetwork/hl2rp/event/battle/distant_battle_gunfire02.wav",
				"LiteNetwork/hl2rp/event/battle/distant_battle_gunfire03.wav",
				"LiteNetwork/hl2rp/event/battle/distant_battle_gunfire04.wav",
				"LiteNetwork/hl2rp/event/battle/distant_battle_gunfire05.wav",
				"LiteNetwork/hl2rp/event/battle/distant_battle_gunfire06.wav",
				"LiteNetwork/hl2rp/event/battle/distant_battle_gunfire07.wav",
				"LiteNetwork/hl2rp/event/battle/distant_battle_shotgun01.wav",
				"LiteNetwork/hl2rp/event/battle/distant_battle_soldier01.wav",
				"LiteNetwork/hl2rp/event/battle/strider_1.wav",
				"LiteNetwork/hl2rp/event/battle/strider_2.wav",
				"LiteNetwork/hl2rp/event/battle/strider_3.wav",
				"LiteNetwork/hl2rp/event/overhead/helicopter01.ogg",
				"LiteNetwork/hl2rp/event/overhead/helicopter02.ogg",
				"LiteNetwork/hl2rp/event/overhead/helicopter03.ogg",
				"LiteNetwork/hl2rp/event/overhead/helicopter04.ogg",
				"LiteNetwork/hl2rp/event/overhead/helicopter05.ogg",
				"LiteNetwork/hl2rp/event/overhead/helicopter06.ogg",
				"LiteNetwork/hl2rp/event/overhead/helicopter07.ogg",
				"LiteNetwork/hl2rp/event/overhead/helicopter08.ogg",
				"LiteNetwork/hl2rp/event/overhead/jet01.mp3",
				"LiteNetwork/hl2rp/event/overhead/jet02.mp3",
				"LiteNetwork/hl2rp/event/overhead/jet03.mp3",
				"LiteNetwork/hl2rp/event/overhead/jet04.mp3",
				"LiteNetwork/hl2rp/event/scary/idle_moan_wet_01.ogg",
				"LiteNetwork/hl2rp/event/scary/idle_moan_wet_02.ogg",
				"LiteNetwork/hl2rp/event/scary/idle_moan_wet_03.ogg",
				"LiteNetwork/hl2rp/event/scary/idle_moan_wet_04.ogg",
				"LiteNetwork/hl2rp/event/scary/idle_moan_wet_05.ogg",
				"LiteNetwork/hl2rp/event/scary/idle_moan_wet_06.ogg",
				"LiteNetwork/hl2rp/event/scary/idle_moan_wet_07.ogg",
				"LiteNetwork/hl2rp/event/scary/idle_moan_wet_08.ogg",
				"LiteNetwork/hl2rp/event/scary/idle_moan_wet_09.ogg",
				"LiteNetwork/hl2rp/event/scary/idle_moan_wet_10.ogg",
				"LiteNetwork/hl2rp/event/scary/idle_moan_wet_11.ogg",
				"LiteNetwork/hl2rp/event/scary/idle_moan_wet_12.ogg",
				"LiteNetwork/hl2rp/event/scary/idle_moan_wet_13.ogg",
				"LiteNetwork/hl2rp/event/scary/idle_moan_wet_14.ogg",
			})
		end)
	end)

	timer.Create("ixAJFlasher", 20, 0, function()
		PlayEventSound("ambient/levels/citadel/portal_beam_shoot"..math.random(1,6)..".wav")
		PlayEventSound("ambient/levels/citadel/strange_talk"..math.random(1,11)..".wav")
		PlayEventSound("ambient/levels/citadel/strange_talk"..math.random(1,11)..".wav")

        PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
		PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
		PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
		PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
		PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
		PlayEventSound("ambient/atmosphere/hole_hit"..math.random(1,5)..".wav")
		PlayEventSound("ambient/atmosphere/terrain_rumble1.wav")

		for _, v in pairs(player.GetAll()) do
			util.ScreenShake(v:GetPos(), 5, 5, 5, 5000)
		end

		PlayEventSound("ambient/levels/labs/teleport_weird_voices"..math.random(1,2)..".wav")
		PlayEventSound("ambient/levels/labs/teleport_postblast_thunder1.wav")

		for _, v in pairs(player.GetAll()) do
			v:ScreenFade(SCREENFADE.IN, color_white, 5, 0)
		end
	end)
end

function PLUGIN:AutonomousJudgementStop()
	timer.Remove("ixAJFlasher")
	timer.Remove("ixAJAmbiencePortal")
	timer.Remove("ixAJAmbience")

	PlayEventSound("ambient/levels/citadel/citadel_flyer1.wav")
	PlayTimedEventSound(3, "ambient/levels/citadel/citadel_5sirens.wav")
	PlayTimedEventSound(4, "ambient/levels/citadel/stalk_traindooropen.wav")
	PlayTimedEventSound(6, "ambient/levels/citadel/portal_beam_shoot"..math.random(1,6)..".wav")
	PlayTimedEventSound(8, "ambient/levels/citadel/portal_beam_shoot"..math.random(1,6)..".wav")
	PlayTimedEventSound(9, "ambient/levels/labs/teleport_mechanism_windup5.wav")

	timer.Simple(17, function()
		PlayEventSound("ambient/levels/citadel/portal_beam_shoot"..math.random(1,6)..".wav")
		PlayEventSound("ambient/levels/citadel/portal_beam_shoot"..math.random(1,6)..".wav")
		PlayTimedEventSound(1, "ambient/levels/labs/teleport_winddown1.wav")
		
        PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
		PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
		PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
		PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
		PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
		PlayEventSound("ambient/atmosphere/hole_hit"..math.random(1,5)..".wav")
		PlayEventSound("ambient/atmosphere/terrain_rumble1.wav")

		for _, v in pairs(player.GetAll()) do
			util.ScreenShake(v:GetPos(), 5, 5, 5, 5000)
		end

        PlayEventSound("ambient/levels/labs/teleport_weird_voices"..math.random(1,2)..".wav")
		PlayEventSound("ambient/levels/labs/teleport_postblast_thunder1.wav")

		for _, v in pairs(player.GetAll()) do
			v:ScreenFade(SCREENFADE.IN, color_white, 5, 0)
		end

		SetGlobalBool("ixAJStatus", false)
		
		for _, v in ipairs(player.GetAll()) do
			v:StopSound("ambient/levels/citadel/core_partialcontain_loop1.wav")
			v:StopSound("ambient/levels/citadel/citadel_drone_loop1.wav")
		end

		for _, v in pairs(ents.FindByClass("prop_dynamic")) do
			if (v:GetModel() == "models/props_combine/combine_citadelcloudcenter.mdl") or (v:GetModel() == "models/props_combine/combine_citadelcloud001c.mdl") then
				SafeRemoveEntity(v)
			end
		end
	end)

	timer.Simple(6, function()
        PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
		PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
		PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
		PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
		PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
		PlayEventSound("ambient/atmosphere/hole_hit"..math.random(1,5)..".wav")
		PlayEventSound("ambient/atmosphere/terrain_rumble1.wav")

		for _, v in pairs(player.GetAll()) do
			util.ScreenShake(v:GetPos(), 5, 5, 5, 5000)
		end

        PlayEventSound("ambient/levels/labs/teleport_weird_voices"..math.random(1,2)..".wav")
		PlayEventSound("ambient/levels/labs/teleport_postblast_thunder1.wav")

		for _, v in pairs(player.GetAll()) do
			v:ScreenFade(SCREENFADE.IN, color_white, 5, 0)
		end
	end)

	timer.Simple(8, function()
        PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
		PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
		PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
		PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
		PlayEventSound("ambient/levels/streetwar/building_rubble"..math.random(1,5)..".wav")
		PlayEventSound("ambient/atmosphere/hole_hit"..math.random(1,5)..".wav")
		PlayEventSound("ambient/atmosphere/terrain_rumble1.wav")

		for _, v in pairs(player.GetAll()) do
			util.ScreenShake(v:GetPos(), 5, 5, 5, 5000)
		end

        PlayEventSound("ambient/levels/labs/teleport_weird_voices"..math.random(1,2)..".wav")
		PlayEventSound("ambient/levels/labs/teleport_postblast_thunder1.wav")

		for _, v in pairs(player.GetAll()) do
			v:ScreenFade(SCREENFADE.IN, color_white, 5, 0)
		end
	end)
end