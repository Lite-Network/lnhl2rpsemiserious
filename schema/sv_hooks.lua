--[[---------------------------------------------------------------------------
	Serverside Hooks
---------------------------------------------------------------------------]]--

function Schema:OnReloaded()
	if ((ix.luaReloaded or 0) < CurTime()) then
		for k, v in pairs(player.GetAll()) do
			v:ChatNotify("Lua has been refreshed!")
			--v:PlaySound("vo/k_lab/ba_pushinit.wav")
		end

		ix.luaReloaded = CurTime() + 5
	end
end

function Schema:OnCharacterCreated(ply, char)
	char:SetData("ixKnownName", char:GetName())
	char:SetData("ixPreferedModel", char:GetModel())
end

function Schema:PlayerSwitchFlashlight(ply)
	return true
end

function Schema:PlayerFootstep(ply, pos, foot, sound, volume)
	if ( ply:Team() == FACTION_CCA ) then
		sound = "npc/metropolice/gear"..math.random(1,6)..".wav"
	elseif ( ply:Team() == FACTION_OTA ) then
		sound = "npc/combine_soldier/gear"..math.random(1,6)..".wav"
	elseif ( ply:IsRebel() ) then
		local rand = math.random( 1, 8 )
		if ( rand == 7 ) then
			rand = 8
		end
		sound = "npc/footsteps/hardboot_generic" .. rand .. ".wav"
	end

	if ply:KeyDown(IN_SPEED) then
		ply:EmitSound(sound, 80, math.random(90, 110), 1)
	else
		ply:EmitSound(sound, 70, math.random(90, 110), 0.2)
	end

	return true
end

-- Temporary Code to Fix Backdoors
local blacklistedEntities = {
	["grenade_helicopter"] = true,
	["npc_grenade_frag"] = true,
	["npc_handgrenade"] = true,
	["obj_vj_grenade"] = true,
	["grenade_ar2"] = true,
	["npc_helicopter"] = true,
	["npc_combinegunship"] = true,
	["npc_combinedropship"] = true,
	[ "gmod_wire_explosive" ] = true,
	[ "gmod_wire_detonator" ] = true
}

function Schema:OnEntityCreated(ent)
    timer.Simple(0, function()
        if ent:IsValid() then
			ent:DrawShadow(false)
            if blacklistedEntities[ent:GetClass()] then
                MsgAll("REMOVED "..ent:GetClass().."\n")
                if ent:GetOwner():IsPlayer() then
                    MsgAll(ent:GetOwner():Nick().."\n")
                else
                    MsgAll("Entity had no owner!\n")
                end
                ent:Remove()
            end

			if ( ent:GetClass():find( "wire" ) ) then
				local client = ent:GetOwner()

				local bCanUse = IsValid( client ) and ( client:IsDonator() or client:IsAdmin() )

				if ( !bCanUse ) then
					ent:Remove()
				end
			end
        end
    end)
end

function Schema:simfphysUse(ent, ply)
	if ent:GetModel():find("combine_apc") then
		if not (ply:IsCombine()) then
			if ((ent.APCUseCoolDown or 0) < CurTime()) then
				ply:ChatNotify("You can not enter the Combine APC due to it being biolocked!")
				ent:EmitSound("buttons/combine_button_locked.wav", 80)
				ent:EmitSound("ambient/alarms/apc_alarm_loop1.wav", 90)

				timer.Simple(15, function()
					if ( IsValid(ent) ) then
						ent:EmitSound("ambient/alarms/klaxon1.wav", 90, 80)
						ent:StopSound("ambient/alarms/apc_alarm_loop1.wav")
					end
				end)

				Schema:AddCombineDisplayMessage("attempted biolock bypass detected!", Color(255, 0, 0), true, "npc/roller/mine/rmine_blip3.wav")
				Schema:AddWaypoint(ent:GetPos(), "Attempted Biolock bypass detected!", Color(255, 0, 0), 120)

				ent.APCUseCoolDown = CurTime() + 15
			end

			return "no"
		else
			ply:ChatNotify("You bypassed the biolock on the Combine APC.")
			ent:EmitSound("buttons/combine_button1.wav", 80)
			Schema:AddCombineDisplayMessage("unit "..ply:Nick().." entered armored personnel carrier..", team.GetColor(ply:Team()), true)
		end
	end
end

function Schema:PlayerDisconnected(ply)
	Schema:SetTeam(ply, ix.faction.teams["01_citizen"])
end

function Schema:ShowSpare2(ply)
	ply:ConCommand("ix_togglethirdperson")
end

local walkPenalty = 0
local runPenalty = 0
function Schema:Move(ply, mv)
	walkPenalty = 0
	runPenalty = 0

	if ply:IsCombine() then
		runBoost = 20
	else
		runBoost = 0
	end

	ply:SetDuckSpeed(0.4)
	ply:SetUnDuckSpeed(0.4)
	ply:SetSlowWalkSpeed(70)
	ply:SetCrouchedWalkSpeed(0.7)

	if (ply:KeyDown(IN_FORWARD) and ply:KeyDown(IN_MOVELEFT)) then
		ply:SetWalkSpeed(80 - walkPenalty)
		ply:SetRunSpeed(165 + runBoost - runPenalty)
	elseif (ply:KeyDown(IN_FORWARD) and ply:KeyDown(IN_MOVERIGHT)) then
		ply:SetWalkSpeed(80 - walkPenalty)
		ply:SetRunSpeed(165 + runBoost - runPenalty)
	elseif (ply:KeyDown(IN_FORWARD) and not (ply:KeyDown(IN_MOVELEFT) or ply:KeyDown(IN_MOVERIGHT))) then
		ply:SetWalkSpeed(90 - walkPenalty)
		ply:SetRunSpeed(180 + runBoost - runPenalty)
	elseif (ply:KeyDown(IN_MOVELEFT) or ply:KeyDown(IN_MOVERIGHT)) then
		ply:SetWalkSpeed(85 - walkPenalty)
		ply:SetRunSpeed(170 + runBoost - runPenalty)
	elseif ply:KeyDown(IN_BACK) then
		ply:SetWalkSpeed(60 - walkPenalty)
		ply:SetRunSpeed(130 + runBoost - runPenalty)
	end
end

local allowedPlayersContainers = {
	["STEAM_0:1:65213148"] = true,
	["STEAM_0:0:206764368"] = true,
}
function Schema:CanPlayerSpawnContainer(ply)
	if allowedPlayersContainers[ply:SteamID()] then
		MsgAll(ply:Nick(), " allowed to spawn container!")
		return true
	else
		return false
	end
end

function Schema:PlayerUse(ply, entity)
	if (!ply:IsRestricted() and entity:IsPlayer() and entity:IsRestricted() and !entity:GetNetVar("untying")) then
		entity:SetAction("You are being untied by "..ply:Nick(), 3)
		entity:SetNetVar("untying", true)

		ply:SetAction("You are untying "..entity:Nick(), 3)

		ply:DoStaredAction(entity, function()
			ply.ixDraggedTarget = nil
			entity.ixDraggedBy = nil
			entity:SetRestricted(false)
			entity:SetNetVar("untying")
			entity:Freeze(false)
		end, 3, function()
			if (IsValid(entity)) then
				entity:SetNetVar("untying")
				entity:SetAction()
			end

			if (IsValid(ply)) then
				ply:SetAction()
			end
		end)
	end
end

local cwuCombineDoors = {
	[4368] = true,
	[4367] = true,
	[4366] = true,
	[4365] = true,
}
function Schema:PlayerUseDoor(ply, door)
	print(door:MapCreationID())
	if (ply:IsCombine() or ply:IsCA() or ply:IsDispatch()) then
		if (!door:HasSpawnFlags(256) and !door:HasSpawnFlags(1024)) then
			door:Fire("open")
		end
	elseif ((ply:IsCWU() or ply:IsCombine()) and cwuCombineDoors[door:MapCreationID()]) then
		if (!door:HasSpawnFlags(256) and !door:HasSpawnFlags(1024)) then
			door:Fire("open")
		end
	end
end

function Schema:PlayerSpray(ply)
	return true
end

local civilianTeam = {
	[FACTION_CITIZEN] = true,
	[FACTION_CWU] = true,
	[FACTION_PRISONER] = true,
}
function Schema:PlayerLoadout(ply)
	local char = ply:GetCharacter()

	ply:SetCanZoom(true)
    ply:ConCommand("gmod_mcore_test 1")

	if ( civilianTeam[ply:Team()] and char ) then
		ply:SetBodygroup(2, 1)
		ply:SetBodygroup(3, 1)
	elseif ( ply:Team() == FACTION_VORTIGAUNT ) then
		ply:SetBodygroup(7, 1)
		ply:SetBodygroup(8, 1)
		ply:SetBodygroup(9, 1)
	end

	ply:SetNetVar("restricted")
	ply.ixRebelState = nil

	if ( ply.ixJailState and ( ply:Team() == FACTION_CITIZEN or ply:Team() == FACTION_CWU ) ) then
		ply.ixDraggedBy = nil
		Schema:SetTeam(ply, ix.faction.teams["07_prisoner"])
		ply:StripWeapons()
	end
end

function Schema:PlayerLoadedCharacter(ply, char, oldChar)
	Schema:SetTeam(ply, ix.faction.teams["01_citizen"], nil, false)
	hook.Run("PlayerSpawn", ply)
end

function Schema:CanPlayerUseBusiness(ply, uniqueID)
	return false
	--[[if (ply:IsCWU()) then
		local itemTable = ix.item.list[uniqueID]

		if (itemTable) then
			if (ply.ixCWUClass == 2) and (itemTable.category == "Consumeables") then
				ply.ixbusinessAllow = true
				return true
			elseif (ply.ixCWUClass == 3) and (itemTable.category == "Medical Items") then
				ply.ixbusinessAllow = true
				return true
			else
				ply.ixbusinessAllow = false
				return false
			end
		end
	else
		ply.ixbusinessAllow = false
		return false
	end]]
end

local dropAbleWeapons = {
	["ix_357"] = "357",
	["ix_ar2"] = "ar2",
	["ix_mp7"] = "mp7",
	["ix_spas12"] = "spas12",
	["ix_usp"] = "usp",
	["ix_m16"] = "m16",
	["ix_m14"] = "m14",
	["ix_stunstick"] = "stunstick",
	["ix_crowbar"] = "crowbar",
	["ix_axe"] = "axe",
	["weapon_grenade"] = "grenade",
	["weapon_crossbow"] = "crossbow",
	["weapon_rpg"] = "rpg",
}

function Schema:DoPlayerDeath(ply, inflicter, attacker)
	ply.deathPos = ply:GetPos()
	ply.deathAngles = ply:GetAngles()
	ply.ixCWUClass = 0

	if ply:IsRestricted() then
		ply:Freeze(false)
	end

	if ply:IsBot() then
		return false
	end

	local char = ply:GetCharacter()

	if (!char) then return end

	if ( ply:Team() == FACTION_OTA ) then
		local randomChance = math.random(1,5)

		if (randomChance == math.random(1,5)) then
			ix.item.Spawn("damagedotavest", ply:GetPos() + Vector(0, 0, 70))
		end
	end

	local held = ply:GetActiveWeapon()

	if ( IsValid( held ) ) then
		local wep = dropAbleWeapons[ held:GetClass() ]

		if ( wep ) then
			ix.item.Spawn( wep, ply:GetPos() + Vector( 0, 0, 70 ), nil, ply:GetAngles() )
		end
	else
		local weapons = { }

		for i, v in ipairs( ply:GetWeapons() ) do
			local class = v:GetClass()

			if ( dropAbleWeapons[ class ] ) then
				weapons[ #weapons + 1 ] = dropAbleWeapons[ class ]
			end
		end

		if ( #weapons > 0 ) then
			local randWeapon = table.Random( weapons )

			ix.item.Spawn( wep, ply:GetPos() + Vector( 0, 0, 70 ), nil, ply:GetAngles() )
		end
	end

	if (char:GetMoney() == 0) then return end

	local droppedTokens = ents.Create("ix_money")
	droppedTokens:SetModel(ix.currency.model)
	droppedTokens:SetPos(ply:GetPos())
	droppedTokens:SetAngles(ply:GetAngles())
	droppedTokens:SetAmount(char:GetMoney())
	droppedTokens:Spawn()

	char:SetMoney(0)
end

function Schema:PlayerDeath(ply, inflictor, attacker)
	if ( attacker:IsNPC() and ( attacker:GetClass() == "npc_headcrab" or attacker:GetClass() == "npc_headcrab_fast" ) ) then
		local headCrab = ents.Create("npc_zombie")
		if ( attacker:GetClass() == "npc_headcrab_fast" ) then
			headCrab = ents.Create("npc_fastzombie")
		end
		headCrab:SetPos(ply:GetPos())
		headCrab:Spawn()
		attacker:Remove()
		ply:Notify("A Headcrab has latched on to your body and is now taking control of it!")
	else
		local corpse = ents.Create("prop_ragdoll")
		corpse:SetPos(ply:GetPos())
		corpse:SetAngles(ply:GetAngles())
		corpse:SetVelocity(ply:GetVelocity())
		corpse:SetModel(ply:GetModel())
		corpse:Spawn()

		timer.Simple(300, function()
			if ( IsValid(corpse) ) then
				corpse:Remove()
			end
		end)
	end

	timer.Simple(0, function() Schema:SetTeam(ply, ix.faction.teams["01_citizen"], nil, true) end)
end

local allowedPlayersContainers = {
	[ "STEAM_0:1:65213148" ] = true,
	[ "STEAM_0:0:206764368" ] = true,
}
function Schema:CanPlayerSpawnContainer(ply)
	if allowedPlayersContainers[ ply:SteamID() ] then
		print(ply:Nick(), " allowed to spawn container!")
		return true
	else
		return false
	end
end

function Schema:ShouldSpawnClientRagdoll()
	return false
end

function Schema:ShouldRemoveRagdollOnDeath()
	return false
end

function Schema:EntityTakeDamage(target, dmg)
	if ( target:IsPlayer() ) then
		if ( dmg:GetAttacker():GetClass() == "npc_headcrab" or dmg:GetAttacker():GetClass() == "npc_headcrab_fast" ) then
			dmg:ScaleDamage(math.random(3.00,5.00))
		end
	end
end

function Schema:PlayerHurt(ply, attacker, health, damage)
	if (health <= 0) then
		return
	end

	if (ply:IsCombine() and (ply.traumaCooldown or 0) < CurTime()) then
		local text = "External"

		if (damage > 20) then
			text = "Severe"
		end

		Schema:AddCombineDisplayMessage("WARNING! UNIT "..ply:Nick().." RECEIVED "..text.." trauma...", Color(255, 0, 0, 255), text)

		if (health < 25) then
			ply:AddCombineDisplayMessage("WARNING! VITAL SIGNS DROPPING, SEEK IMMEDIATE MEDICAL ATTENTION", Color(255, 0, 0, 255))
		end

		ply.traumaCooldown = CurTime() + 5
	end

	ply:ScreenFade(SCREENFADE.IN, Color(255, 0, 0, damage * 10), math.Clamp(damage * math.random(0.05, 0.10), 1, 4), 0)
end

-- Prop Cost
function Schema:PlayerSpawnProp(ply)
	local char = ply:GetCharacter()
	local amount = char:GetMoney()

	if ply:IsAdmin() or ( ply:IsCombine() and ply:Nick():find("GRID") ) then
		ply:ChatNotify("You did not pay any tokens to spawn this prop.")
		return true
	elseif (ply:IsDonator() or ply:IsCombine()) then
		if char:HasMoney(2) then
			char:TakeMoney(2)
			ply:ChatNotify("You spent 2 tokens to spawn this prop.")
			return true
		else
			ply:ChatNotify("You need 2 tokens to spawn a prop!")
			return false
		end
	else
		if char:HasMoney(5) then
			char:TakeMoney(5)
			ply:ChatNotify("You spent 5 tokens to spawn this prop.")
			return true
		else
			ply:ChatNotify("You need 5 tokens to spawn a prop!")
			return false
		end
	end
end

function Schema:OnPlayerHitGround(ply, inWater, onFloater, speed)
	if not ( inWater or ( ply.ixIntroBool == true ) ) and ply:IsValid() then
		local punch = speed * 0.01

		if ( punch * 2 >= 7 ) then
			ply:EmitSound("npc/combine_soldier/zipline_hitground"..math.random(1,2)..".wav", 60)
			ply:EmitSound("LiteNetwork/hl2rp/land0"..math.random(1,4)..".ogg", 50, math.random(90, 110), math.random(0.3, 0.4))
		else
			ply:EmitSound("LiteNetwork/hl2rp/land0"..math.random(1,4)..".ogg", 50, math.random(90, 110), math.random(0.3, 0.4))
		end

		if (punch * 2 >= 12) and not (ply:Team() == FACTION_OTA or ply:IsDispatch()) then
			ply:TakeDamage(math.random(10, 20))
			ply:EmitSound("player/pl_fallpain1.wav", 80)
			ply:ChatNotify("You broke your legs!")
			ply:GetCharacter():SetData("ixbrokenLegs", true)

			if ply:IsCombine() then
				Schema:AddCombineDisplayMessage("WARNING! UNIT "..string.upper(ply:Nick()).." RECEIVED LEG FRACTURE...", Color(200, 50, 0, 255))
			end
		end
	end
end

-- Pain Sound
local painSounds = {
	[FACTION_CCA] = {sound = function() return "npc/metropolice/pain"..math.random(1,4)..".wav" end},
	[FACTION_OTA] = {sound = function() return "npc/combine_soldier/pain"..math.random(1,3)..".wav" end},
	[FACTION_VORTIGAUNT] = {sound = function() return table.Random({
		"vo/npc/vortigaunt/vortigese02.wav",
		"vo/npc/vortigaunt/vortigese03.wav",
		"vo/npc/vortigaunt/vortigese04.wav",
		"vo/npc/vortigaunt/vortigese07.wav",
	}) end},
}
function Schema:GetPlayerPainSound(ply)
	if ( painSounds[ply:Team()] and painSounds[ply:Team()].sound ) then
		return painSounds[ply:Team()].sound()
	end
end

-- Death Sound
local deathSounds = {
	[FACTION_CCA] = {sound = function() return "npc/metropolice/die"..math.random(1,4)..".wav" end, globalCombine = true},
	[FACTION_OTA] = {sound = function() return "npc/combine_soldier/die"..math.random(1,3)..".wav" end, globalCombine = true},
	[FACTION_VORTIGAUNT] = {sound = function() return table.Random({
		"vo/npc/vortigaunt/vortigese02.wav",
		"vo/npc/vortigaunt/vortigese03.wav",
		"vo/npc/vortigaunt/vortigese04.wav",
		"vo/npc/vortigaunt/vortigese07.wav",
	}) end},
}
function Schema:GetPlayerDeathSound(ply)
	if ( deathSounds[ply:Team()] and deathSounds[ply:Team()].sound ) then
		local deathSound = deathSounds[ply:Team()].sound()

		for k, v in ipairs(player.GetAll()) do
			if (v:IsCombine() and ply:IsCombine()) and ( deathSounds[ply:Team()].globalCombine == true ) then
				v:EmitSound(deathSound, 80)
			end
		end

		return deathSound
	end
end

function Schema:PlayerMessageSend(speaker, chatType, text, anonymous, receivers, rawText)
	if (chatType == "ic" or chatType == "w" or chatType == "y" or chatType == "commandradio" or chatType == "radio" or chatType == "dispatch" or chatType == "dispatchradio") then
		local class = self.voices.GetClass(speaker)

		for k, v in ipairs(class) do
			local info = self.voices.Get(v, rawText)

			if v:find("citizen") and not (speaker:IsDonator() or speaker:IsAdmin()) then
				return text
			end

			if (info) then
				local volume = 80

				if (chatType == "w") then
					volume = 60
				elseif (chatType == "y") then
					volume = 150
				end

				if (info.sound) then
					if (info.global) and (chatType == "dispatch") then
						netstream.Start(nil, "PlaySound", info.sound)
					else
						local sounds = {info.sound}

						if ((chatType == "commandradio") or (chatType == "radio") or (chatType == "dispatchradio")) then
							for k2, v2 in pairs(player.GetAll()) do
								if v2:IsCombine() then
									ix.util.EmitQueuedSounds(v, sounds, nil, nil, 40)
								end
							end
						else
							ix.util.EmitQueuedSounds(speaker, sounds, nil, nil, volume)
						end
					end
				end

				if (speaker:IsCombine()) then
					if ((chatType == "commandradio") or (chatType == "radio") or (chatType == "dispatchradio")) then
						return info.text
					else
						return "<:: "..info.text.." ::>"
					end
				else
					return info.text
				end
			end
		end

		if (speaker:IsCombine()) then
			if ((chatType == "commandradio") or (chatType == "radio") or (chatType == "dispatchradio")) then
				return text
			else
				return "<:: "..text.." ::>"
			end
		end
	end
end
