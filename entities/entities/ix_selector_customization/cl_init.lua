include("shared.lua")

net.Receive("ixSelector.Customizer.NotAllowed", function()
	Derma_Message("You need to become a Civilian in order to use this vendor!", "Civilian Customizer", "X")
end)

local PANEL = {}

function PANEL:Init()
	self:SetSize(600, 500)
	self:Center()
	self:SetTitle("Civilian Customizer")
	self:MakePopup()

	self.selectedJob = nil
	self.selectedJobID = nil

	self.modelPreview = self:Add("ixModelPanel")
	self.modelPreview:SetSize(self:GetWide() / 2, 0)
	self.modelPreview:Dock(RIGHT)
	self.modelPreview:SetFOV(45)
	self.modelPreview:SetModel(LocalPlayer():GetModel(), LocalPlayer():GetSkin())
	self.modelPreview:MoveToBack()
	self.modelPreview:SetCursor("arrow")

	self.jobsText = self:Add("ixLabel")
	self.jobsText:SetFont("ixMediumFont")
	self.jobsText:SetText("Jobs:")
	self.jobsText:SetContentAlignment(4)
	self.jobsText:SizeToContents()
	self.jobsText:DockMargin(5, 0, 0, 0)
	self.jobsText:Dock(TOP)

	self.jobsBox = self:Add("DComboBox")
	self.jobsBox:SetFont("ixSmallFont")
	self.jobsBox:SetSortItems(false)
	self.jobsBox:SetValue("Select a job")
	self.jobsBox:SizeToContents()
	self.jobsBox:Dock(TOP)

	local xp = tonumber(LocalPlayer():GetXP())

	for k, v in pairs(ix.divisions.cwu) do
		if (xp >= v.xp) then
			self.jobsBox:AddChoice(ix.divisions.cwu[k].name.." - "..ix.divisions.cwu[k].xp.." XP", k, false, "icon16/tick.png")
		else
			self.jobsBox:AddChoice(ix.divisions.cwu[k].name.." - "..ix.divisions.cwu[k].xp.." XP", k, false, "icon16/cross.png")
		end
	end

	self.jobsBox.OnSelect = function(panel, index, value)
		self.selectedJob = value
		self.selectedJobID = index
	end

	self.jobDescription = self:Add("RichText")
	self.jobDescription:Dock(FILL)
	self.jobDescription:DockMargin(5, 5, 5, 5)
	self.jobDescription:SetVerticalScrollbarEnabled(false)
	self.jobDescription:SetText("")
	self.jobDescription.Think = function()
		self.jobDescription:SetFontInternal("LiteNetworkFont24")
		if not ((self.jobsBox and self.jobsBox:GetValue():find("Select"))) then -- again.. very un-efficient but still.. WHO CARES!!!
			self.jobDescription:SetText(ix.divisions.cwu[self.selectedJobID].description)
			return
		end

		self.jobDescription:SetText([[]])
	end

	self.doneButton = self:Add("ixMenuButton")
	self.doneButton:SetFont("ixSmallFont")
	self.doneButton:SetText("no job selected")
	self.doneButton:SetContentAlignment(5)
	self.doneButton:SetDisabled(true)
	self.doneButton:SizeToContents()
	self.doneButton:Dock(BOTTOM)

	self.doneButton.Think = function()
		if not ((self.jobsBox and self.jobsBox:GetValue():find("Select"))) then -- again.. very un-efficient but still.. WHO CARES!!!
			self.doneButton:SetText("become a "..ix.divisions.cwu[self.selectedJobID].name)
			self.doneButton:SetDisabled(false)
			return
		end

		self.doneButton:SetDisabled(true)
		self.doneButton:SetText("no job selected")
	end

	self.doneButton.DoClick = function()
		RunConsoleCommand("ix_selector_cwu", self.selectedJobID) -- i use console commands since.. backdoorers keep making everything un-fun.

		self:Remove()
	end
end

function PANEL:Paint(w, h)
	surface.SetDrawColor(Color(30, 30, 30, 200))
	surface.DrawRect(0, 0, w, h)

	surface.SetDrawColor(ix.config.Get("color"))
	surface.DrawRect(0, 0, w, 24)
	surface.DrawOutlinedRect(0, 0, w, h, 5)

	ix.util.DrawBlur(self, 1)
end

vgui.Register("LiteNetwork.Menu.Customizer", PANEL, "DFrame")