--[[---------------------------------------------------------------------------
	Serverside Functions
---------------------------------------------------------------------------]]--

ix.whitelists = ix.whitelists or {}
ix.whitelists.CCA = ix.whitelists.CCA or {}
ix.whitelists.OTA = ix.whitelists.OTA or {}

ix.whitelists.CCA.NoRanks = {
	["VANGUARD"] = "STEAM_0:0:102502702",
}
ix.whitelists.CCA.Ranks = {
	["UNION-OfC"] = {
		"STEAM_0:0:89116555", -- sprite cran
		"STEAM_0:0:203818007", -- kingdarkness
	}, 
	["UNION-DvL"] = "STEAM_0:1:117769029", -- bonk
	["UNION-DcO"] = "",

	["HELIX-OfC"] = "STEAM_0:0:174143741", -- lee west
	["HELIX-DvL"] = "STEAM_0:1:506629560", -- cor
	["HELIX-DcO"] = "",

	["GRID-OfC"] = "",
	["GRID-DvL"] = "",
	["GRID-DcO"] = "",

	["JURY-OfC"] = "",
	["JURY-DvL"] = "",
	["JURY-DcO"] = "",
}
ix.whitelists.OTA.NoRanks = {
	["REAPER"] = {
		"STEAM_0:1:1395956", -- Riggs Mackay
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
	["LDR"] = "",
}

function Schema:SetTeam(ply, factionTable, preferedModel)
	local char = ply:GetCharacter()

	if not (factionTable) then
		return
	end

	if not (char) then
		return
	end
	
	ply:Spawn()
	char:SetFaction(factionTable.index)
	ply:StripWeapons()
	ply:ResetBodygroups()
	char:SetModel(preferedModel or table.Random(factionTable.models))
	ply:SetModel(preferedModel or table.Random(factionTable.models))

	ply:SetupHands()

	for k, v in pairs(char:GetInventory():GetItems()) do
		v:Remove()
	end

	PrintTable(factionTable)

	hook.Run("PlayerLoadout", ply)
	ply:ScreenFade(SCREENFADE.IN, color_black, 1, 1)

	timer.Simple(0.5, function() ply:SelectWeapon("ix_hands") end)
end

for k, v in pairs(ix.faction.teams) do
	concommand.Add("ix_faction_become_"..v.uniqueID, function(ply, cmd, args)
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

util.AddNetworkString("ixPlayerFootstep")
net.Receive("ixPlayerFootstep", function(len, ply)
	if ply:KeyDown(IN_SPEED) then
		ply:EmitSound(net.ReadString(), 80, math.random(90, 110), 1)
	else
		ply:EmitSound(net.ReadString(), 70, math.random(90, 110), 0.5)
	end
end)