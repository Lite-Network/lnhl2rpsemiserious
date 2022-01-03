--[[---------------------------------------------------------------------------
	Serverside Functions
---------------------------------------------------------------------------]]--

ix.whitelists = ix.whitelists or {}
ix.whitelists.CCA = ix.whitelists.CCA or {}
ix.whitelists.OTA = ix.whitelists.OTA or {}

ix.whitelists.CCA.NoRanks = {
	["VNG"] = {
		"STEAM_0:0:102502702", -- universal
		"STEAM_0:0:138626507", -- John Smith
	},
}
ix.whitelists.CCA.Ranks = {
	["UNION-OfC"] = {
		"STEAM_0:0:89116555", -- sprite cran
		"STEAM_0:0:203818007", -- kingdarkness
		"STEAM_0:0:196637456", -- German
		"STEAM_0:1:157305669", -- haja
		"STEAM_0:0:244971374", -- GMAN0289
		"STEAM_0:0:455356942", -- tsukii
		"STEAM_0:0:57781706", -- Dr.Anon
		"STEAM_0:0:57794116", -- Mike
		"STEAM_0:0:95908775", -- Roshe
	}, 
	["UNION-DvL"] = {
		"STEAM_0:1:117769029", -- bonk
		"STEAM_0:0:10223064", -- xavier
	},
	["UNION-DcO"] = "STEAM_0:0:138626507", -- John Smith

	["HELIX-OfC"] = {
		"STEAM_0:0:174143741", -- lee west
		"STEAM_0:0:428839009", -- Yoboy
		"STEAM_0:1:40787669", -- Apollo
	},
	["HELIX-DvL"] = {},
	["HELIX-DcO"] = "",

	["GRID-OfC"] = {
		"STEAM_0:1:157305669", -- haja
		"STEAM_0:1:580525463", -- Creek
		"STEAM_0:0:226903802", --Fawful
		"STEAM_0:1:88481744", -- Winkie
	},
	["GRID-DvL"] = {
		"STEAM_0:0:448077906", -- prototwat
	},
	["GRID-DcO"] = "",

	["JURY-OfC"] = {
		"STEAM_0:0:229400758", -- tea
		"STEAM_0:0:25401034", -- Tsunami
		"STEAM_0:0:104447930", -- Maraluna
	},
	["JURY-DvL"] = {
		"STEAM_0:0:203267540", -- Overwatch
	},
	["JURY-DcO"] = "",
}
ix.whitelists.OTA.NoRanks = {
	["REAPER"] = {
		"STEAM_0:0:203818007", -- kingdarkness
		"STEAM_0:0:448077906", -- prototwat
		"STEAM_0:0:89116555", -- sprite cran
		"STEAM_0:0:138626507", -- john smith
		"STEAM_0:0:10223064", -- xavier
		"STEAM_0:0:199691641", -- Revectane
		"STEAM_0:0:54754855", -- Diablo
		"STEAM_0:1:112093491", -- engi
		"STEAM_0:0:455356942", -- tsukii
		"STEAM_1:1:104896936", -- phil leotardo
		"STEAM_0:1:76725981", -- m3 r88
		"STEAM_0:1:599186470", -- punished glunch
		"STEAM_0:0:64132801", -- ovxy
		"STEAM_0:1:104370902", -- archer
		"STEAM_1:0:203749017 ", -- detective pat
	},
}
ix.whitelists.OTA.Ranks = {
	["LDR"] = {
		"STEAM_0:1:104896936", -- Phil Leotardo
		"STEAM_0:0:229400758", -- tea
		"STEAM_0:0:155006109", -- ProvingMedusa
		"STEAM_0:0:89116555", -- sprite cran
		"STEAM_0:0:20320092", -- adamski
		"STEAM_0:0:580428602", -- morph
		"STEAM_0:1:91589611", -- breadgaming
		"STEAM_0:0:554357457", -- nocturne
		"STEAM_0:0:226903802", -- fawful
		"STEAM_0:1:213488223", -- lastcrusader
		"STEAM_0:1:75454172", -- vault
		"STEAM_0:0:455356942", -- tsukii
	},
}

function Schema:SearchPlayer(ply, target)
	if (!target:GetCharacter() or !target:GetCharacter():GetInventory()) then
		return false
	end

	local name = hook.Run("GetDisplayedName", target) or target:Name()
	local inventory = target:GetCharacter():GetInventory()

	ix.storage.Open(ply, inventory, {
		entity = target,
		name = name
	})

	return true
end

local rebelNPCs = {
	["npc_citizen"] = true,
	["npc_vortigaunt"] = true,
}

local combineNPCs = {
	["npc_cscanner"] = true,
	["npc_stalker"] = true,
	["npc_clawscanner"] = true,
	["npc_turret_floor"] = true,
	["npc_combine_camera"] = true,
	["npc_metropolice"] = true,
	["npc_combine_s"] = true,
	["npc_manhack"] = true,
	["npc_rollermine"] = true,
	["npc_strider"] = true,
	["npc_hunter"] = true,
	["npc_stalker"] = true,
}
function Schema:UpdateRelationShip(ent)
	for k, v in pairs(player.GetAll()) do
		if ( v:IsCombine() or v:IsCA() ) then
			if ( combineNPCs[ent:GetClass()] ) then
				ent:AddEntityRelationship(v, D_LI, 99)
			elseif ( rebelNPCs[ent:GetClass()] ) then
				ent:AddEntityRelationship(v, D_HT, 99)
			end
		else
			if ( combineNPCs[ent:GetClass()] ) then
				ent:AddEntityRelationship(v, D_HT, 99)
			elseif ( rebelNPCs[ent:GetClass()] ) then
				ent:AddEntityRelationship(v, D_LI, 99)
			end
		end
	end
end

function Schema:GiveWeapons(ply, weapons)
	for i, weapon in ipairs(weapons) do
		ply:Give(weapon)
	end
end

function Schema:SetTeam(ply, factionTable, preferedModel, dontReSpawn, dontWipeInventory, bypassTime, bypassXP)
	local char = ply:GetCharacter()

	if not ( factionTable ) then
		return
	end

	if not ( char ) then
		return
	end

	if ((factionTable.adminOnly == true) and not (ply:IsAdmin())) then
		ply:Notify(factionTable.name.." is for Admin only!")
		return
	end

	if ((factionTable.donatorOnly == true) and not (ply:IsDonator() or ply:IsAdmin())) then
		ply:Notify(factionTable.name.." is for Donators only!")
		return
	end

	if not ( bypassXP ) then
		if not ( factionTable.requiredXP == nil ) then
			if (tonumber(ply:GetXP()) < factionTable.requiredXP) then
				ply:Notify("You need "..factionTable.requiredXP.." XP to become a "..factionTable.name.."!")
				return
			end
		end
	end

	if not ( bypassTime ) then
		local waittime = 180

		if ( ply:IsSuperAdmin() ) then
			waittime = 2
		elseif ( ply:IsAdmin() ) then
			waittime = 10
		end

		if (ply.jobCooldown or 0) > RealTime() then
			ply:Notify("You need to wait another "..math.Round(ply.jobCooldown - RealTime()).." seconds, to switch jobs again!")
			return
		end

		ply.jobCooldown = RealTime() + waittime or 300
	end
	
	char:SetFaction(factionTable.index)

	if not ( dontReSpawn ) then
		ply:Spawn()
	end

	char:GiveFlags("pet")

	if ( ply:IsDonator() or ply:IsAdmin() ) then
		char:GiveFlags("rc")
	end

	if ( ply:IsAdmin() ) then
		char:GiveFlags("Cn")
	end

	ply:StripWeapons()
	ply:ResetBodygroups()
	ply.ixRebelState = nil

	if ( factionTable.index == FACTION_CITIZEN or factionTable.index == FACTION_CWU or factionTable.index == FACTION_PRISONER ) then
		if not (char) then
			return
		end

		char:SetName(char:GetData("ixKnownName", "John Doe"))
		char:SetModel(char:GetData("ixPreferedModel") or table.Random(factionTable.models) or "models/error.mdl")
	else
		if ( factionTable.index == FACTION_CA ) then
			char:SetName(char:GetData("ixKnownName", "John Doe"))
		end
		char:SetModel(preferedModel or table.Random(factionTable.models))
	end

	ply:SetupHands()

	if not ( dontWipeInventory ) then
		for k, v in pairs(char:GetInventory():GetItems()) do
			v:Remove()
		end
	end

	ply:ScreenFade(SCREENFADE.IN, color_black, 1, 1)
	
	for i = 0, 30 do
		ply:SetSubMaterial(i, "")
	end

	timer.Simple(0.5, function()
		if ply:IsValid() then
			hook.Run("PlayerLoadout", ply)

			ply:SelectWeapon("ix_hands")

			if ( factionTable.playerLoadout ) then
				factionTable.playerLoadout(ply)
			else
				ply:SetHealth(100)
				ply:SetMaxHealth(100)
				ply:SetArmor(0)
				ply:SetMaxArmor(0)

				ply:SetViewOffset(Vector(0, 0, 66))
				ply:SetJumpPower(160)
			end
		end
	end)
end

for k, v in pairs(ix.faction.teams) do
	if not ( v.command == nil ) then
		concommand.Add(v.command, function(ply, cmd, args)
			if (args[1] == nil) then
				Schema:SetTeam(ply, v, nil)
			else
				if tostring(args[1]):find(v.modelWhitelist) then
					Schema:SetTeam(ply, v, args[1] or nil)
				else
					ply:Notify("You specified a invalid model!")
				end
			end
		end)
	end
end

util.AddNetworkString("ixAddCombineDisplayMessage")
function Schema:AddCombineDisplayMessage(text, color, sound)
    for k, v in pairs(player.GetAll()) do
        if v:IsCombine() then
			net.Start("ixAddCombineDisplayMessage")
				net.WriteString(tostring(text) or "Invalid Input..")
				net.WriteColor(color or color_white)
				net.WriteBool(tobool(sound) or false)
			net.Send(v)
        end
    end
end

--[[---------------------------------------------------------------------------
	Serverside Net Messages
---------------------------------------------------------------------------]]--

local uploads = WireLib.RegisterPlayerTable()
local upload_ents = WireLib.RegisterPlayerTable()
net.Receive("wire_expression2_upload", function(len, ply)
	local toent = Entity(net.ReadUInt(16))
	local numpackets = net.ReadUInt(16)

	if (not IsValid(toent) or toent:GetClass() ~= "gmod_wire_expression2") then
		if uploads[ply] then -- this is to prevent notification spam due to the net library automatically limiting its own transfer rate so that the messages arrive late
			uploads[ply] = nil
			upload_ents[ply] = nil
			WireLib.AddNotify(ply, "Invalid Expression chip specified. Upload aborted.", NOTIFY_ERROR, 7, NOTIFYSOUND_DRIP3)
		end
		return
	end

	if not ( ply:IsDonator() or ply:IsAdmin() ) then
		WireLib.AddNotify(ply, "You are not allowed to upload to the target Expression chip. Upload aborted.", NOTIFY_ERROR, 7, NOTIFYSOUND_DRIP3)
		return
	end

	if upload_ents[ply] ~= toent then -- a new upload was started, abort previous
		uploads[ply] = nil
	end

	upload_ents[ply] = toent

	if not uploads[ply] then uploads[ply] = {} end
	uploads[ply][#uploads[ply]+1] = net.ReadData(net.ReadUInt(32))
	if numpackets <= #uploads[ply] then
		local datastr = E2Lib.decode(table.concat(uploads[ply]))
		uploads[ply] = nil
		local ok, ret = pcall(WireLib.von.deserialize, datastr)

		if not ok then
			WireLib.AddNotify(ply, "Expression 2 upload failed! Error message:\n" .. ret, NOTIFY_ERROR, 7, NOTIFYSOUND_DRIP3)
			print("Expression 2 upload failed! Error message:\n" .. ret)
			return
		end

		local code = ret[1]

		local includes = {}
		for k, v in pairs(ret[2]) do
			includes[k] = v
		end

		local filepath = ret[3]

		if ply ~= toent.player and toent.player:GetInfoNum("wire_expression2_friendwrite", 0) ~= 1 then
			code = "@disabled for security reasons. Remove this line (Ctrl+Shift+L) and left-click the chip to enable. 'wire_expression2_friendwrite 1' disables security.\n" .. code
		end

		toent:Setup(code, includes, nil, nil, filepath)
	end
end)
