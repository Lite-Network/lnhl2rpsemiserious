function Schema:CreateMenuButtons(tabs)
	tabs["factions"] = function(container)
        local selectedFaction = false
        local selectedFactionName = nil
        local selectedFactionTable = {}

        factionDescriptionPanel = container:Add("DPanel")
        factionDescriptionPanel:Dock(BOTTOM)
        factionDescriptionPanel:SetSize(0, container:GetTall() / 3)
        factionDescriptionPanel.Paint = function(self, w, h)
            surface.SetDrawColor(Color(30, 30, 30, 100))
            surface.DrawRect(0, 0, w, h)
        end

        factionButtonsPanel = container:Add("DPanel")
        factionButtonsPanel:Dock(LEFT)
        factionButtonsPanel:SetSize(container:GetWide() / 3, 0)
        factionButtonsPanel.Paint = function(self, w, h)
            surface.SetDrawColor(Color(30, 30, 30, 100))
            surface.DrawRect(0, 0, w, h)
        end

        factionBecomeButton = factionButtonsPanel:Add("ixMenuButton")
        factionBecomeButton:Dock(BOTTOM)
        factionBecomeButton:SetSize(0, 50)
        factionBecomeButton:SetText("Select a Faction first!")
        factionBecomeButton:SetFont("LiteNetworkFont24")
        factionBecomeButton:SetTextColor(color_white)
        factionBecomeButton.DoClick = function()
            if (selectedFaction == false) then
                ix.util.Notify("Select a Faction first!")
            else
                RunConsoleCommand(selectedFactionTable.command)
            end
        end

		factionDescription = factionDescriptionPanel:Add("RichText")
		factionDescription:Dock(FILL)
		factionDescription:DockMargin(5, 5, 5, 5)
		factionDescription:SetVerticalScrollbarEnabled(false)
		factionDescription:SetText("")
		function factionDescription:PerformLayout()
			factionDescription:SetFontInternal("LiteNetworkFont32")
		end

        for k, v in pairs(ix.faction.teams) do
            factionButton = factionButtonsPanel:Add("ixMenuButton")
            factionButton:Dock(TOP)
            factionButton:SetSize(0, 50)
            factionButton:SetText(v.name)
            factionButton:SetFont("LiteNetworkFont32")
            factionButton:SetTextColor(v.color)
            factionButton.DoClick = function()
                selectedFactionTable = v
                selectedFaction = true
                factionBecomeButton:SetText("Become "..v.name)
                factionDescription:SetText(v.description or "")
            end
        end
    end
end