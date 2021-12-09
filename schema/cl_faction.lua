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

            surface.SetDrawColor(ix.config.Get("color"))
            surface.DrawOutlinedRect(0, 0, w, h, 1)
        end

        factionButtonsPanel = container:Add("DPanel")
        factionButtonsPanel:Dock(LEFT)
        factionButtonsPanel:SetSize(container:GetWide() / 3, 0)
        factionButtonsPanel.Paint = function(self, w, h)
            surface.SetDrawColor(Color(30, 30, 30, 100))
            surface.DrawRect(0, 0, w, h)

            surface.SetDrawColor(ix.config.Get("color"))
            surface.DrawOutlinedRect(0, 0, w, h, 1)
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
                RunConsoleCommand(selectedFactionTable.command, factionModel:GetModel())
            end
        end

        factionModel = container:Add("ixModelPanel")
        factionModel:SetModel(LocalPlayer():GetModel(), 0)
        factionModel:Dock(LEFT)
        factionModel:SetWide(container:GetWide() / 3)
        factionModel:SetFOV(ScreenScale(19))

		local function PopulateModelSelection(modelSelectionTable, teamTable)
			if ( factionModelsPanel ) then factionModelsPanel:Remove() end

            factionModelsPanel = container:Add("DScrollPanel")
            factionModelsPanel:Dock(LEFT)
            factionModelsPanel:SetSize(container:GetWide() / 3, 0)
            factionModelsPanel.Paint = function(self, w, h)
                surface.SetDrawColor(Color(30, 30, 30, 100))
                surface.DrawRect(0, 0, w, h)

                surface.SetDrawColor(ix.config.Get("color"))
                surface.DrawOutlinedRect(0, 0, w, h, 1)
            end

            modelLayout = factionModelsPanel:Add("DIconLayout")
            modelLayout:Dock(FILL)
            modelLayout:DockMargin(1, 1, 1, 1)
            modelLayout:SetSpaceX(1)
            modelLayout:SetSpaceY(1)

			if ( modelSelectionTable == nil ) then return end

            for k, v in pairs(modelSelectionTable) do
                modelSelect = modelLayout:Add("ixSpawnIcon")
                modelSelect:SetModel(v)
                modelSelect:SetSize(ScreenScale(50) / 2, ScreenScale(50))
				modelSelect:InvalidateLayout(true)
				modelSelect.PaintOver = function(this, w, h)
					if (teamTable.model == k) then
						local color = ix.config.Get("color", color_white)

						surface.SetDrawColor(color.r, color.g, color.b, 200)

						for i = 1, 3 do
							local i2 = i * 2
							surface.DrawOutlinedRect(i, i, w - i2, h - i2)
						end
					end
				end
                modelSelect.DoClick = function()
                    factionModel:SetModel(v)
                
                    if ( teamTable.index == FACTION_CITIZEN ) or ( teamTable.index == FACTION_CWU ) then
                        factionModel.Entity:SetBodygroup(2, 1)
                        factionModel.Entity:SetBodygroup(3, 1)
                    end
                end
                
                if ( teamTable.index == FACTION_CITIZEN ) or ( teamTable.index == FACTION_CWU ) then
                    modelSelect.Entity:SetBodygroup(2, 1)
                    modelSelect.Entity:SetBodygroup(3, 1)
                end
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

        for k, v in SortedPairs(ix.faction.teams) do
            if not ( v.command == nil ) then
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
                    factionBecomeButton:SetTextColor(v.color or color_white)
                    factionDescription:SetText(v.description or "")

                    factionModel:SetModel(table.Random(v.models))
                    factionModel.Entity:SetSkin(0)

                    if not ( v.noModelSelection == true ) then
                        PopulateModelSelection(v.models, v)
                    else
                        if ( factionModelsPanel ) then factionModelsPanel:Remove() end
                    end
                end

                if not ( v.requiredXP == nil ) then
                    factionXPRequirement = factionButton:Add("ixLabel")
                    factionXPRequirement:Dock(RIGHT)
                    factionXPRequirement:DockMargin(0, 0, 20, 0)
                    factionXPRequirement:SetText("XP: "..tostring(v.requiredXP) or "")
                    factionXPRequirement:SetFont("LiteNetworkFont24")
                    factionXPRequirement:SetContentAlignment(6)
                    factionXPRequirement:SizeToContents()
    
                    if not (tonumber(LocalPlayer():GetXP()) < v.requiredXP) then
                        factionXPRequirement:SetTextColor(Color(20, 200, 20))
                    else
                        factionXPRequirement:SetTextColor(Color(200, 20, 20))
                    end
                end
            end
        end
    end
end