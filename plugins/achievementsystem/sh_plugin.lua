local PLUGIN = PLUGIN

PLUGIN.name = "Lite Network Achievemnt System"
PLUGIN.author = "Riggs Mackay"
PLUGIN.description = "Allows players to get achievements by doing random things."

--[[---------------------------------------------------------------------------
	Achievement Core Plugin
---------------------------------------------------------------------------]]--

PLUGIN.achievements = {
    {"ix.Achievement.RiggsKill", "I am the Founder now!"}, -- 1
    {"ix.Achievement.BecomeCCA", "Pick up that can!"}, -- 2
    {"ix.Achievement.BecomeOTA", "Transhumanization Complete."}, -- 3
    {"ix.Achievement.CCACommanderKill", "Down with the Universal Union!"}, -- 4
    {"ix.Achievement.OTACommanderKill", "Command & Control."}, -- 5
}

if ( SERVER ) then
    util.AddNetworkString("ixAchievementEarn")
    function PLUGIN:GiveAchievement(ply, achievement, achievementTitle)
        if not ( ply:GetPData(achievement) ) then
            ply:SetPData(achievement, true)

            if ( achievementTitle ) then
                local playerSteamName = ply:SteamName()
                for k, v in pairs(player.GetAll()) do
                    net.Start("ixAchievementEarn")
                        net.WriteTable({title = achievementTitle, name = playerSteamName})
                    net.Send(v)
                end
            end
        else
            print("Already Achievement Got!")
        end
    end

    function PLUGIN:TakeAchievement(ply, achievement)
        ply:SetPData(achievement, false)
    end
end

if ( CLIENT ) then
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
                PLUGIN:GiveAchievement(attacker, PLUGIN.achievements[1][1], PLUGIN.achievements[1][2])
            elseif ( ply:IsCombine() and ply:Nick():find("CCA:C17-COMMANDER") ) then
                PLUGIN:GiveAchievement(attacker, PLUGIN.achievements[4][1], PLUGIN.achievements[4][2])
            elseif ( ply:IsCombine() and ply:Nick():find("OTA:C17-COMMANDER") ) then
                PLUGIN:GiveAchievement(attacker, PLUGIN.achievements[5][1], PLUGIN.achievements[5][2])
            end
        end
    end

    function PLUGIN:PlayerLoadout(ply)
        if ( ply:Team() == FACTION_CCA ) then
            PLUGIN:GiveAchievement(ply, PLUGIN.achievements[2][1], PLUGIN.achievements[2][2])
        elseif ( ply:Team() == FACTION_OTA ) then
            PLUGIN:GiveAchievement(ply, PLUGIN.achievements[3][1], PLUGIN.achievements[3][2])
        end
    end
end