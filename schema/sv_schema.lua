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
	}, 
	["UNION-DvL"] = {
		"STEAM_0:1:117769029", -- bonk
		"STEAM_0:0:10223064", -- xavier
	},
	["UNION-DcO"] = "",

	["HELIX-OfC"] = {
		"STEAM_0:0:174143741", -- lee west
		"STEAM_0:0:428839009", -- Yoboyboss76
	},
	["HELIX-DvL"] = "STEAM_0:1:506629560", -- cor
	["HELIX-DcO"] = "",

	["GRID-OfC"] = "",
	["GRID-DvL"] = {
		"STEAM_0:1:104896936", -- Phil Leotardo
		"STEAM_0:0:448077906", -- prototwat
	},
	["GRID-DcO"] = "",

	["JURY-OfC"] = "",
	["JURY-DvL"] = "STEAM_0:0:203267540", -- Overwatch
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
	},
}
ix.whitelists.OTA.Ranks = {
	["LDR"] = {
		"STEAM_0:1:104896936", -- cor
		"STEAM_0:1:506629560", -- Phil Leotardo
		"STEAM_0:0:10223064", -- xavier
	},
}

function Schema:GiveWeapons(ply, weapons)
	for i, weapon in ipairs(weapons) do
		ply:Give(weapon)
	end
end

function Schema:SetTeam(ply, factionTable, dontReSpawn)
	local char = ply:GetCharacter()

	if not (factionTable) then
		return
	end

	if not (char) then
		return
	end
	
	char:SetFaction(factionTable.index)

	if not ( dontReSpawn ) then
		ply:Spawn()
	end

	ply:StripWeapons()
	ply:ResetBodygroups()

	if not ( factionTable.index == FACTION_CITIZEN or factionTable.index == FACTION_CWU ) then
		char:SetModel(table.Random(factionTable.models))
		ply:SetModel(table.Random(factionTable.models))
	else
		char:SetName(char:GetData("ixKnownName", "John Doe"))
		char:SetModel(char:GetData("ixPreferedModel", nil) or table.Random(ix.faction.teams[FACTION_CITIZEN].models) or "models/error.mdl")
		ply:SetModel(char:GetData("ixPreferedModel", nil) or table.Random(ix.faction.teams[FACTION_CITIZEN].models) or "models/error.mdl")
	end

	ply:SetupHands()

	for k, v in pairs(char:GetInventory():GetItems()) do
		v:Remove()
	end

	hook.Run("PlayerLoadout", ply)
	ply:ScreenFade(SCREENFADE.IN, color_black, 1, 1)

	timer.Simple(0.5, function()
		if ply:IsValid() then
			ply:SelectWeapon("ix_hands")
		end
	end)
end

for k, v in pairs(ix.faction.teams) do
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

function Schema:PlayEventSound(sound)
	for k, v in pairs(player.GetAll()) do
		if istable(sound) then
			v:PlaySound(table.Random(sound))
		else
			v:PlaySound(sound)
		end
	end
end

function Schema:PlayTimedEventSound(time, sound)
	timer.Simple(time, function() Schema:PlayEventSound(tostring(sound)) end)
end

function Schema:AddCombineDisplayMessage(text, color, sound)
    for k, v in ipairs(player.GetAll()) do
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