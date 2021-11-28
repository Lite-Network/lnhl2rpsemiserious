--[[---------------------------------------------------------------------------
	Serverside Hooks
---------------------------------------------------------------------------]]--

function Schema:OnReloaded()
	if ((ix.luaReloaded or 0) < CurTime()) then
		for k, v in pairs(player.GetAll()) do
			v:ChatNotify("Lua has been refreshed!")
			v:PlaySound("vo/k_lab/ba_pushinit.wav")
		end

		ix.luaReloaded = CurTime() + 5
	end
end

function Schema:PlayerFootstep(ply, pos, foot, sound, volume)
	net.Start("ixPlayerFootstep")
		net.WriteString(sound)
	net.Send(ply)
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
}

function Schema:Tick()
	for k, v in pairs(ents.GetAll()) do
		if blacklistedEntities[v:GetClass()] then
			MsgAll("REMOVED "..blacklistedEntities[v:GetClass()].."\n")
			if v:GetOwner():IsPlayer() then
				MsgAll(v:GetOwner():Nick().."\n")
			else
				MsgAll("Entity had no owner!\n")
			end
			v:Remove()
		end
	end

	for k, v in pairs(ents.FindByClass("wire_*")) do
		if v:GetOwner():IsPlayer() and not (v:GetOwner():IsDonator() or v:GetOwner():IsAdmin()) then
			MsgAll("REMOVED ", tostring(ent), " FROM ", tostring(v:GetOwner()))
			v:Remove()
		end
	end
end

function Schema:simfphysUse(ent, ply)
	if ent:GetModel():find("combine_apc") then
		if not (ply:IsCombine()) then
			if ((ent.APCUseCoolDown or 0) < CurTime()) then
				ply:ChatNotify("You can not enter the Combine APC due to it being biolocked!")
				ent:EmitSound("buttons/combine_button_locked.wav", 80)
				ent:EmitSound("ambient/alarms/apc_alarm_loop1.wav", 90)
				timer.Simple(15, function() ent:EmitSound("ambient/alarms/klaxon1.wav", 90, 80) ent:StopSound("ambient/alarms/apc_alarm_loop1.wav") end)
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
	ply:SetWalkSpeed(90 - walkPenalty)
	ply:SetRunSpeed(180 - runPenalty)
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

function Schema:PlayerUseDoor(ply, door)
	if (ply:IsCombine() or ply:IsCA() or ply:IsDispatch()) then
		if (!door:HasSpawnFlags(256) and !door:HasSpawnFlags(1024)) then
			door:Fire("open")
		end
	end
end

function Schema:PlayerSpray(ply)
	return true
end

function Schema:PlayerLoadout(ply)
	local char = ply:GetCharacter()

	if not (char) then
		return
	end

	ply:SetCanZoom(true)
    ply:ConCommand("gmod_mcore_test 1")
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

	if ply:IsBot() then
		return false
	end

	local char = ply:GetCharacter()

	if (!char) then return end

	if (ply:Team() == FACTION_OTA) then
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

	ply:ScreenFade(SCREENFADE.IN, Color(200, 0, 0, damage * 10), math.Clamp(damage * math.random(0.05, 0.10), 1, 4), 0)
end

-- Prop Cost
function Schema:PlayerSpawnProp(ply)
	local char = ply:GetCharacter()
	local amount = char:GetMoney()
	
	if ply:IsAdmin() or ply:Nick():find("GRID") then
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