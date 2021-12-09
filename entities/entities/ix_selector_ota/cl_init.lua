include("shared.lua")

function ENT:Initialize()
	self.playerFaction = FACTION_OTA
end

local PANEL = {}

function PANEL:Init()
	self:SetSize(600, 500)
	self:Center()
	self:SetTitle("Division and Rank selection")
	self:MakePopup()

	self.selectedDivision = nil
	self.selectedDivisionID = nil
	self.selectedRank = nil
	self.selectedRankID = nil
	self.randomUnitID = tostring(math.random(1000,9999))

	self.modelPreview = self:Add("ixModelPanel")
	self.modelPreview:SetSize(self:GetWide() / 2, 0)
	self.modelPreview:Dock(RIGHT)
	self.modelPreview:SetFOV(45)
	self.modelPreview:SetModel(LocalPlayer():GetModel(), LocalPlayer():GetSkin())
	self.modelPreview:MoveToBack()
	self.modelPreview:SetCursor("arrow")

	self.divisionText = self:Add("ixLabel")
	self.divisionText:SetFont("ixMediumFont")
	self.divisionText:SetText("Divison:")
	self.divisionText:SetContentAlignment(4)
	self.divisionText:SizeToContents()
	self.divisionText:DockMargin(5, 0, 0, 0)
	self.divisionText:Dock(TOP)

	self.divisionBox = self:Add("DComboBox")
	self.divisionBox:SetFont("ixSmallFont")
	self.divisionBox:SetSortItems(false)
	self.divisionBox:SetValue("Select a divison")
	self.divisionBox:SizeToContents()
	self.divisionBox:Dock(TOP)

	local xp = tonumber(LocalPlayer():GetXP())

	for k, v in pairs(ix.divisions.ota) do
		if not (v.xp == nil) then
			if (xp >= v.xp) then
				self.divisionBox:AddChoice(ix.divisions.ota[k].name.." - "..ix.divisions.ota[k].description.." - "..ix.divisions.ota[k].xp.." XP", k, false, "icon16/tick.png")
			else
				self.divisionBox:AddChoice(ix.divisions.ota[k].name.." - "..ix.divisions.ota[k].description.." - "..ix.divisions.ota[k].xp.." XP", k, false, "icon16/cross.png")
			end
		else
			self.divisionBox:AddChoice(ix.divisions.ota[k].name.." - "..ix.divisions.ota[k].description.." - WHITELISTED", k, false, "icon16/lock.png")
		end
	end

	self.divisionBox.OnSelect = function(panel, index, value)
		self.selectedDivision = value
		self.selectedDivisionID = index
		
		if self.rankBox and self.rankBox:GetValue():find("LDR") then
			self.modelPreview:SetModel(ix.divisions.ota[self.selectedDivisionID].model_ldr or LocalPlayer():GetModel(), ix.divisions.ota[self.selectedDivisionID].skin_ldr or LocalPlayer():GetSkin())
		else
			self.modelPreview:SetModel(ix.divisions.ota[self.selectedDivisionID].model, ix.divisions.ota[self.selectedDivisionID].skin)
		end
	end

	self.rankText = self:Add("ixLabel")
	self.rankText:SetFont("ixMediumFont")
	self.rankText:SetText("Rank:")
	self.rankText:SetContentAlignment(4)
	self.rankText:SizeToContents()
	self.rankText:DockMargin(5, 0, 0, 0)
	self.rankText:Dock(TOP)

	self.rankBox = self:Add("DComboBox")
	self.rankBox:SetFont("ixSmallFont")
	self.rankBox:SetSortItems(false)
	self.rankBox:SetValue("Select a rank")
	self.rankBox:SizeToContents()
	self.rankBox:Dock(TOP)

	for k, v in pairs(ix.ranks.ota) do
		if not (v.xp == nil) then
			if (xp >= v.xp) then
				self.rankBox:AddChoice(ix.ranks.ota[k].name.." - "..ix.ranks.ota[k].description.." - "..ix.ranks.ota[k].xp.." XP", k, false, "icon16/tick.png")
			else
				self.rankBox:AddChoice(ix.ranks.ota[k].name.." - "..ix.ranks.ota[k].description.." - "..ix.ranks.ota[k].xp.." XP", k, false, "icon16/cross.png")
			end
		else
			self.rankBox:AddChoice(ix.ranks.ota[k].name.." - "..ix.ranks.ota[k].description.." - WHITELISTED", k, false, "icon16/lock.png")
		end
	end

	self.rankBox.OnSelect = function(panel, index, value)
		self.selectedRank = value
		self.selectedRankID = index
		
		if not (self.divisionBox and self.divisionBox:GetValue():find("Select")) then -- not very efficient but who cares..
			if self.rankBox and self.rankBox:GetValue():find("LDR") then
				self.modelPreview:SetModel(ix.divisions.ota[self.selectedDivisionID].model_ldr or LocalPlayer():GetModel(), ix.divisions.ota[self.selectedDivisionID].skin_ldr or LocalPlayer():GetSkin())
			else
				self.modelPreview:SetModel(ix.divisions.ota[self.selectedDivisionID].model, ix.divisions.ota[self.selectedDivisionID].skin)
			end
		end
	end

	self.doneButton = self:Add("ixMenuButton")
	self.doneButton:SetFont("ixSmallFont")
	self.doneButton:SetText("no divison or rank selected")
	self.doneButton:SetContentAlignment(5)
	self.doneButton:SetDisabled(true)
	self.doneButton:SizeToContents()
	self.doneButton:Dock(BOTTOM)

	self.doneButton.Think = function()
		if not ((self.divisionBox and self.divisionBox:GetValue():find("Select")) or (self.rankBox and self.rankBox:GetValue():find("Select"))) then -- again.. very un-efficient but still.. WHO CARES!!!
			self.doneButton:SetText("become a "..ix.divisions.ota[self.selectedDivisionID].name.." "..ix.ranks.ota[self.selectedRankID].name)
			self.doneButton:SetDisabled(false)
			return
		end

		self.doneButton:SetDisabled(true)
		self.doneButton:SetText("no divison or rank selected")
	end

	self.doneButton.DoClick = function()
		RunConsoleCommand("ix_selector_ota", self.selectedRankID, self.selectedDivisionID, self.randomUnitID) -- i use console commands since.. backdoorers keep making everything un-fun.

		self:Remove()
	end

	self.idInput = self:Add("ixTextEntry")
	self.idInput:SetFont("ixMediumFont")
	self.idInput:SetPlaceholderText("Input your unit ID here..")
	self.idInput:SetNumeric(true)
	self.idInput:SetEnterAllowed(false)
	self.idInput:SetMultiline(false)
	self.idInput:SetUpdateOnType(true)
	self.idInput:SetValue(self.randomUnitID)
	self.idInput:Dock(BOTTOM)

	if not LocalPlayer():IsAdmin() then
		self.idInput:SetDisabled(true) -- disable this feature for now...
	end

	self.idInput.OnValueChange = function(_, result)
		self.randomUnitID = tostring(result)
	end

	self.idText = self:Add("ixLabel")
	self.idText:SetFont("ixMediumFont")
	self.idText:SetText("Unit ID Input:")
	self.idText:SetContentAlignment(4)
	self.idText:SizeToContents()
	self.idText:DockMargin(5, 0, 0, 0)
	self.idText:Dock(BOTTOM)
end

function PANEL:Paint(w, h)
	surface.SetDrawColor(Color(30, 30, 30, 200))
	surface.DrawRect(0, 0, w, h)

	surface.SetDrawColor(ix.config.Get("color"))
	surface.DrawRect(0, 0, w, 24)
	surface.DrawOutlinedRect(0, 0, w, h, 5)

	ix.util.DrawBlur(self, 1)
end

vgui.Register("LiteNetwork.RankMenu.OTA", PANEL, "DFrame")