--[[---------------------------------------------------------------------------
	Clientside Functions
---------------------------------------------------------------------------]]--

function Schema:AddCombineDisplayMessage(text, color, sound, soundFile)
    if LocalPlayer():IsCombine() then
        ix.gui.AddCombineDisplayMessage(tostring(text) or "Invalid Input..", color or color_white, tobool(sound) or false)
    end
end

function notification.AddLegacy(text, _, __)
    LocalPlayer():Notify(tostring(text))
end

-- from scotnay / max
function LerpColor(time, col, ColorTo)
	for i, v in pairs(col) do
		col[i] = Lerp(time, v, ColorTo[i])
	end
	return col
end

local LiteNetworkLogo = ix.util.GetMaterial("litenetwork/logo_white.png")
local LiteNetworkLogoText = ix.util.GetMaterial("litenetwork/logotext_white.png")
function ix.gui.GlowingLogo(x, y, w, h, text)
    if not LogoColor then LogoColor = Color(200, 75, 25) end

    local r, g, b, a = LogoColor:Unpack()

    if math.Round(b, 0) == 255 then
        glowchange = true
    elseif math.Round(r, 0) == 200 then
        glowchange = false
    end

    if glowchange then
        LogoColor = LerpColor(0.0075, LogoColor, Color(200, 75, 25))
    else
        LogoColor = LerpColor(0.0075, LogoColor, Color(68, 187, 255))
    end

    if (text == true) then
	    surface.SetMaterial(LiteNetworkLogoText)
    else
	    surface.SetMaterial(LiteNetworkLogo)
    end
	surface.SetDrawColor(LogoColor or Color(255, 255, 255))
	surface.DrawTexturedRect(x, y, w, h)
end

function Schema:PopulateHelpMenu(categories)
	categories["achievements"] = function(container)
		for k, v in pairs(ix.achievements) do
			if ( LocalPlayer():GetNWBool(tostring(ix.achievements[k][1]), false) == true ) then
				achievementPanel = container:Add("DPanel")
				achievementPanel:Dock(TOP)
				achievementPanel:DockMargin(5, 5, 5, 5)
				achievementPanel:SetSize(0, 85)
				achievementPanel.Paint = function(self, w, h)
					surface.SetDrawColor(Color(30, 30, 30, 100))
					surface.DrawRect(0, 0, w, h)
		
					surface.SetDrawColor(ix.config.Get("color"))
					surface.DrawOutlinedRect(0, 0, w, h, 1)

					draw.DrawText(ix.achievements[k][2], "LiteNetworkFont32", achievementPanel:GetWide() / 2, 5, ix.config.Get("color"), TEXT_ALIGN_CENTER)
					draw.DrawText(ix.achievements[k][3], "LiteNetworkFont32", achievementPanel:GetWide() / 2, 45, color_white, TEXT_ALIGN_CENTER)
				end
			end
		end
	end
end

timer.Create("FixShadows", 10, 0, function()
	for _, ply in ipairs( player.GetAll() ) do
		ply:DrawShadow(false)
	end

	for _, v in ipairs( ents.FindByClass("prop_door_rotating") ) do
		if IsValid(v) and v:IsDoor() then
			v:DrawShadow(false)
		end
	end
end)

hook.Remove("HUDPaint", "simfphys_HUD") -- no thx

function Schema:PopulateHelpMenu(tabs)
	tabs["voices"] = function(container)
		local classes = {}

		for k, v in pairs(Schema.voices.classes) do
			if (v.condition(LocalPlayer())) then
				classes[#classes + 1] = k
			end
		end

		if (#classes < 1) then
			local info = container:Add("DLabel")
			info:SetFont("ixSmallFont")
			info:SetText("You do not have access to any voice lines!")
			info:SetContentAlignment(5)
			info:SetTextColor(color_white)
			info:SetExpensiveShadow(1, color_black)
			info:Dock(TOP)
			info:DockMargin(0, 0, 0, 8)
			info:SizeToContents()
			info:SetTall(info:GetTall() + 16)

			info.Paint = function(_, width, height)
				surface.SetDrawColor(ColorAlpha(derma.GetColor("Error", info), 160))
				surface.DrawRect(0, 0, width, height)
			end

			return
		end

		table.sort(classes, function(a, b)
			return a < b
		end)

		local searchEntry = container:Add("ixIconTextEntry")
		searchEntry:Dock(TOP)
		searchEntry:SetEnterAllowed(false)

		local function ListVoices(filter)
			for _, class in ipairs(classes) do
				local category = container:Add("Panel")
				category:Dock(TOP)
				category:DockMargin(0, 0, 0, 8)
				category:DockPadding(8, 8, 8, 8)
				category.Paint = function(_, width, height)
					surface.SetDrawColor(Color(0, 0, 0, 66))
					surface.DrawRect(0, 0, width, height)
				end
				category.removeOnFilter = true

				local categoryLabel = category:Add("DLabel")
				categoryLabel:SetFont("ixMediumLightFont")
				categoryLabel:SetText(class:upper())
				categoryLabel:Dock(FILL)
				categoryLabel:SetTextColor(color_white)
				categoryLabel:SetExpensiveShadow(1, color_black)
				categoryLabel:SizeToContents()
				categoryLabel.removeOnFilter = true
				category:SizeToChildren(true, true)

				if self.voices and self.voices.stored and self.voices.stored[class] then
					for command, info in SortedPairs(self.voices.stored[class]) do
						if filter == nil or (command:lower():find(filter:lower()) or info.text:lower():find(filter:lower())) then
							local title = container:Add("ixMenuButton")
							title:SetFont("LiteNetworkFont16-Light")
							title:SetText(command:upper())
							title:Dock(TOP)
							title:SetTextColor(ix.config.Get("color"))
							title:SetSize(container:GetWide(), 18)
							title.DoClick = function()
								ix.util.Notify("You have copied: "..tostring(command:upper()))
								SetClipboardText(tostring(command:upper()))
							end
							title.removeOnFilter = true

							local description = container:Add("DLabel")
							description:SetFont("ixSmallFont")
							description:SetText(info.text)
							description:Dock(TOP)
							description:SetTextColor(color_white)
							description:SetExpensiveShadow(1, color_black)
							description:SetWrap(true)
							description:SetAutoStretchVertical(true)
							description:SizeToContents()
							description:DockMargin(0, 0, 0, 8)
							description.removeOnFilter = true
						end
					end
				end
			end
		end

		searchEntry.OnChange = function(entry)
			local function deepRemove(panel)
				for k, v in pairs(panel:GetChildren()) do
					if v.removeOnFilter == true then
						v:Remove()
					else
						if v:HasChildren() then deepRemove(v) end
					end
				end
			end

			deepRemove(container)
			ListVoices(searchEntry:GetValue())
		end

		ListVoices()
	end
end

--[[---------------------------------------------------------------------------
	Clientside Net Nessages
---------------------------------------------------------------------------]]--

net.Receive("ixAddCombineDisplayMessage", function()
    if LocalPlayer():IsCombine() then
        ix.gui.AddCombineDisplayMessage(tostring(net.ReadString()) or "Invalid Input..", net.ReadColor() or color_white, tobool(net.ReadBool()) or false)
    end
end)

net.Receive("ixPlaySound", function(len, ply)
	--surface.PlaySound(tostring(net.ReadString()))
	LocalPlayer():EmitSound(tostring(net.ReadString()), tonumber(net.ReadUInt(7)) or 100)
end)

net.Receive("ixCreateVGUI", function(len, ply)
	vgui.Create(tostring(net.ReadString()))
end)

net.Receive("ixCustomSettings", function(len, ply)
	ix.option.Set("language", "english", true)
	ix.option.Set("observerTeleportBack", false, true)
	ix.option.Set("observerESP", false, true)

	ix.option.stored["minimalTooltips"].hidden = function() return true end
	ix.option.stored["alwaysShowBars"].hidden = function() return true end
	ix.option.stored["animationScale"].hidden = function() return true end
	ix.option.stored["openBags"].hidden = function() return true end
	ix.option.stored["language"].hidden = function() return true end
	ix.option.stored["observerTeleportBack"].hidden = function() return true end
	ix.option.stored["observerESP"].hidden = function() return true end
	--ix.option.stored["altLower"].hidden = function() return true end
	ix.option.stored["showIntro"].hidden = function() return true end
	ix.option.stored["chatFontScale"].hidden = function() return true end
	ix.option.stored["chatOutline"].hidden = function() return true end

	RunConsoleCommand("pac_enable", "1")
	RunConsoleCommand("pac_draw_distance", "-1")
end)