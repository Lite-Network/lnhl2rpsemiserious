--[[---------------------------------------------------------------------------
	Serverside Functions
---------------------------------------------------------------------------]]--

ix.whitelists = ix.whitelists or {}
ix.whitelists.CCA = ix.whitelists.CCA or {}
ix.whitelists.OTA = ix.whitelists.OTA or {}

ix.whitelists.CCA.NoRanks = {
	["VANGUARD"] = {
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
	}, 
	["UNION-DvL"] = {
		"STEAM_0:1:117769029", -- bonk
		"STEAM_0:1:506629560", -- cor
		"STEAM_0:0:10223064", -- xavier
	},
	["UNION-DcO"] = "",

	["HELIX-OfC"] = {
		"STEAM_0:0:174143741", -- lee west
	},
	["HELIX-DvL"] = {},
	["HELIX-DcO"] = "",

	["GRID-OfC"] = {
		"STEAM_0:1:157305669", -- haja
		"STEAM_0:1:580525463", -- Creek
		"STEAM_0:0:226903802", --Fawful
	},
	["GRID-DvL"] = {
		"STEAM_0:0:448077906", -- prototwat
	},
	["GRID-DcO"] = "",

	["JURY-OfC"] = {
		"STEAM_0:0:229400758", -- tea
		"STEAM_0:0:25401034", -- Tsunami
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
		"STEAM_0:1:506629560", -- cor
		"STEAM_1:1:15510316", -- gilinar
		"STEAM_0:0:138626507", -- john smith
		"STEAM_0:0:10223064", -- xavier
		"STEAM_0:0:199691641", -- Revectane
		"STEAM_0:0:54754855", -- Diablo
		"STEAM_0:1:112093491", -- engi
	},
}
ix.whitelists.OTA.Ranks = {
	["LDR"] = {
		"STEAM_0:1:104896936", -- Phil Leotardo
		"STEAM_0:1:506629560", -- cor
		"STEAM_0:0:229400758", -- tea
		"STEAM_0:0:155006109", -- ProvingMedusa
		"STEAM_0:0:89116555", -- sprite cran
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

function Schema:GiveWeapons(ply, weapons)
	for i, weapon in ipairs(weapons) do
		ply:Give(weapon)
	end
end

function Schema:SetTeam(ply, factionTable, preferedModel, dontReSpawn, dontWipeInventory)
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

	if not ( factionTable.requiredXP == nil ) then
		if (tonumber(ply:GetXP()) < factionTable.requiredXP) then
			ply:Notify("You need "..factionTable.requiredXP.." XP to become a "..factionTable.name.."!")
			return
		end
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
		char:SetModel(preferedModel or table.Random(factionTable.models))
	end

	ply:SetupHands()

	if not ( dontWipeInventory ) then
		for k, v in pairs(char:GetInventory():GetItems()) do
			v:Remove()
		end
	end

	ply:ScreenFade(SCREENFADE.IN, color_black, 1, 1)

	timer.Simple(0.5, function()
		if ply:IsValid() then
			hook.Run("PlayerLoadout", ply)

			ply:SelectWeapon("ix_hands")

			ply:SetHealth(100)
			ply:SetMaxHealth(100)
			ply:SetArmor(0)
			ply:SetMaxArmor(0)
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

function Schema:AddCombineDisplayMessage(text, color, sound)
    for k, v in pairs(player.GetAll()) do
        if v:IsCombine() then
			net.Start("ixAddCombineDisplayMessage")
				net.WriteString(tostring(text) or "Invalid Input..")
				net.WriteColor(color or color_white)
				net.WriteBool(tobool(sound) or false)
			net.Send(self)
        end
    end
end

--[[---------------------------------------------------------------------------
	Serverside Net Messages
---------------------------------------------------------------------------]]--