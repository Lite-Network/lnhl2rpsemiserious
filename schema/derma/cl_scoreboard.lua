local PANEL = {}

function PANEL:Init()
	self:Dock(FILL)

	local players = player.GetAll()
    table.sort(players, function(k, v) return k:Team() > v:Team() end)

    for k, v in pairs(players) do
        if ( v:IsValid() ) then
            local playerBox = self:Add("ixMenuButton")
            playerBox:SetText("")
            playerBox:SetSize(self:GetWide(), 55)
            playerBox:Dock(TOP)
            playerBox:DockMargin(0, 0, 0, 5)
            playerBox.DoClick = function()
                local ply = v

                if (!IsValid(ply)) then
                    return
                end

                SetClipboardText(ply:IsBot() and ply:EntIndex() or ply:SteamID())
                ix.util.Notify("You copied " .. tostring(ply) .. " SteamID!")
            end
            playerBox.DoRightClick = function()
                local ply = v

                if (!IsValid(ply)) then
                    return
                end

                ply:ShowProfile()
                ix.util.Notify("You opened " .. tostring(ply) .. " Profile!")
            end
            playerBox.Paint = function(self)
                local teamColor = team.GetColor(v:Team()) or color_white
                draw.RoundedBox(0, 0, 0, playerBox:GetWide(), playerBox:GetTall(), ColorAlpha(teamColor, 100))

                draw.SimpleText(v:SteamName(), "LiteNetworkFont24-Light", 65, playerBox:GetTall() / 2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                draw.SimpleText(team.GetName(v:Team()), "LiteNetworkFont24-Light", playerBox:GetWide() / 2, playerBox:GetTall() / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

                draw.SimpleText(v:Nick(), "LiteNetworkFont24-Light", playerBox:GetWide() - 20, playerBox:GetTall() / 2, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
            end

            local playerIcon = playerBox:Add("ixSpawnIcon")
            playerIcon:SetSize(playerBox:GetTall(), playerBox:GetTall())
            playerIcon:Dock(LEFT)
            playerIcon:SetModel(v:GetModel(), v:GetSkin())

            for k2, v2 in pairs(v:GetBodyGroups()) do
                playerIcon.Entity:SetBodygroup(v2.id, v:GetBodygroup(v2.id))
            end
        end
    end
end


vgui.Register("ixScoreboard", PANEL, "DScrollPanel")

hook.Add("CreateMenuButtons", "ixScoreboard", function(tabs)
	tabs["scoreboard"] = function(container)
		container:Add("ixScoreboard")
	end
end)
