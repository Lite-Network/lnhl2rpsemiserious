local PLUGIN = PLUGIN

PLUGIN.name = "Lite Network Achievement System"
PLUGIN.author = "Riggs Mackay"
PLUGIN.description = "Allows players to get achievements by doing random things."

--[[---------------------------------------------------------------------------
	Achievement Core Plugin
---------------------------------------------------------------------------]]--

ix.achievements = {
    {"ix.achiment.RiggsKill", "I am the Founder now!", "Kill Riggs Mackay"}, -- 1
    {"ix.achiment.BecomeCCA", "Pick up that can!", "Become CCA for the First Time"}, -- 2
    {"ix.achiment.BecomeOTA", "Transhumanization Complete.", "Become OTA for the First Time"}, -- 3
    {"ix.achiment.CCACommanderKill", "Down with the Universal Union!", "kill the CCA Commander"}, -- 4
    {"ix.achiment.OTACommanderKill", "Command & Control.", "Kill the OTA Commander"}, -- 5
    {"ix.achiment.BlizzardKill", "Beware the Blue Door", "Kill Blizzard Boi"}, -- 6
    {"ix.achiment.TayKill", "Remember, no femchar...", "Kill Tay"}, -- 7
    --{"ix.achiment.", "", ""}, -- 8
    --{"ix.achiment.", "", ""}, -- 9
    --{"ix.achiment.", "", ""}, -- 10
    --{"ix.achiment.", "", ""}, -- 11
    --{"ix.achiment.", "", ""}, -- 12
    --{"ix.achiment.", "", ""}, -- 13
    --{"ix.achiment.", "", ""}, -- 14
    --{"ix.achiment.", "", ""}, -- 15
}

if ( SERVER ) then
    for k, v in pairs(ix.achievements) do
        util.AddNetworkString(tostring(ix.achievements[k][1])..".Give")
        util.AddNetworkString(tostring(ix.achievements[k][1])..".Take")
    end

    util.AddNetworkString("ixAchievementEarn")
    function PLUGIN:GiveAchievement(ply, achievement, achievementTitle)
        if not ( ply:GetPData(achievement) ) then
            ply:SetPData(achievement, true)
            net.Start(achievement..".Give") net.Send(ply)

            if ( achievementTitle ) then
                local playerSteamName = ply:SteamName()
                for k, v in pairs(player.GetAll()) do
                    v:PlaySound("garrysmod/save_load"..math.random(1,4)..".wav")
                    net.Start("ixAchievementEarn")
                        net.WriteTable({title = achievementTitle, name = playerSteamName})
                    net.Send(v)
                end
            end
        end
    end

    function PLUGIN:TakeAchievement(ply, achievement)
        ply:SetPData(achievement, false)
        net.Start(achievement..".Take") net.Send(ply)
    end

    function PLUGIN:PlayerInitialSpawn(ply)
        for k, v in pairs(ix.achievements) do
            if ( ply:GetPData(tostring(ix.achievements[k][1]), false) == true ) then
                net.Start(tostring(ix.achievements[k][1])..".Give") net.Send(ply)
            else
                net.Start(tostring(ix.achievements[k][1])..".Take") net.Send(ply)
            end
        end
    end
else
    for k, v in pairs(ix.achievements) do
        net.Receive(tostring(ix.achievements[k][1])..".Give", function()
            LocalPlayer():SetNWBool(tostring(tostring(ix.achievements[k][1])), true)
        end)

        net.Receive(tostring(ix.achievements[k][1])..".Take", function()
            LocalPlayer():SetNWBool(tostring(ix.achievements[k][1]), false)
        end)
    end

    net.Receive("ixAchievementEarn", function()
        local achievementTable = net.ReadTable()

        chat.AddText(Material("icon16/medal_gold_add.png"), ix.config.Get("color"), "(Lite Network Achievements) ", Color(180, 180, 150), achievementTable.name.." has earned the ["..achievementTable.title.."] achievement!")
    end)
end

--[[---------------------------------------------------------------------------
	Achievement Hooks
---------------------------------------------------------------------------]]--

if ( SERVER ) then
    function PLUGIN:PlayerDeath(ply, inflictor, attacker)
        if ( attacker:IsPlayer() ) then
            if ( ply:SteamID() == "STEAM_0:1:1395956" ) then
                PLUGIN:GiveAchievement(attacker, ix.achievements[1][1], ix.achievements[1][2])
            elseif ( ply:IsCombine() and ply:Nick():find("CCA:C17-COMMANDER") ) then
                PLUGIN:GiveAchievement(attacker, ix.achievements[4][1], ix.achievements[4][2])
            elseif ( ply:IsCombine() and ply:Nick():find("OTA:C17-COMMANDER") ) then
                PLUGIN:GiveAchievement(attacker, ix.achievements[5][1], ix.achievements[5][2])
            elseif ( ply:SteamID() == "STEAM_0:0:206764368" ) then
                PLUGIN:GiveAchievement(attacker, ix.achievements[6][1], ix.achievements[6][2])
            elseif ( ply:SteamID() == "STEAM_0:1:65213148" ) then
                PLUGIN:GiveAchievement(attacker, ix.achievements[7][1], ix.achievements[7][2])
            end
        end
    end

    function PLUGIN:PlayerLoadout(ply)
        if ( ply:Team() == FACTION_CCA ) then
            PLUGIN:GiveAchievement(ply, ix.achievements[2][1], ix.achievements[2][2])
        elseif ( ply:Team() == FACTION_OTA ) then
            PLUGIN:GiveAchievement(ply, ix.achievements[3][1], ix.achievements[3][2])
        end
    end
end