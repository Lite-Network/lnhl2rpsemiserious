local PANEL = {}

function PANEL:Init()
	self:Dock(FILL)

	self.clients = { }
end

// Used so that the scoreboard can be refreshed and formatted in the event of
// a player leaving.
function PANEL:PopulateScoreboard()
	for i, v in pairs( self.clients ) do
		if ( ispanel( v ) and IsValid( v ) ) then
			v:Remove()
		end
	end

	// Clear the client panel cache.
	self.clients = { }

	local players = player.GetAll()
    table.sort(players, function(k, v) return k:Team() > v:Team() end)

	for k, v in pairs(players) do
		local playerBox = self:Add("DPanel")
		self.clients[ k ] = playerBox
		playerBox.player = v
		playerBox:SetSize(self:GetWide(), 70)
		playerBox:Dock(TOP)
		playerBox:DockMargin(0, 0, 0, 5)
		playerBox.Paint = function(this)
			if (!IsValid( this.player ) ) then
				return
			end

			local teamColor = team.GetColor(this.player:Team()) or color_white
			draw.RoundedBox(5, 0, 0, playerBox:GetWide(), playerBox:GetTall(), ColorAlpha(teamColor, 100))

			draw.SimpleText(v:SteamName(), "LiteNetworkFont32", 80, playerBox:GetTall() / 2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			draw.SimpleText(team.GetName(v:Team()), "LiteNetworkFont32", playerBox:GetWide() / 2, playerBox:GetTall() / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

			if ( LocalPlayer():IsAdmin() ) then
				draw.SimpleText(v:Nick(), "LiteNetworkFont32", playerBox:GetWide() - 80, playerBox:GetTall() / 2, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
			end
		end

		playerBox.Think = function( this )
			if ( !IsValid( this.player ) ) then
				// Reformat if the player is invalid (left or bugged).
				self:PopulateScoreboard()
			end
		end

		local playerIcon = playerBox:Add("ixSpawnIcon")
		playerIcon.player = v
		playerIcon:SetSize(playerBox:GetTall() - 10, playerBox:GetTall() - 10)
		playerIcon:Dock(LEFT)
		playerIcon:DockMargin(5, 5, 5, 5)
		playerIcon:SetModel(v:GetModel(), v:GetSkin())
		playerIcon.DoRightClick = function()
			local ply = self.player

			if (!IsValid(ply)) then
				return
			end

			local menu = DermaMenu()

			menu:AddOption(L("viewProfile"), function()
				ply:ShowProfile()
			end)

			menu:AddOption(L("copySteamID"), function()
				SetClipboardText(ply:IsBot() and ply:EntIndex() or ply:SteamID())
			end)

			hook.Run("PopulateScoreboardPlayerMenu", ply, menu)
			menu:Open()
		end

		for k2, v2 in pairs(v:GetBodyGroups()) do
			playerIcon.Entity:SetBodygroup(v2.id, v:GetBodygroup(v2.id))
		end
	end
end


vgui.Register("ixScoreboard", PANEL, "DScrollPanel")

hook.Add("CreateMenuButtons", "ixScoreboard", function(tabs)
	tabs["scoreboard"] = function(container)
		container:Add("ixScoreboard")
	end
end)
