local animationTime = 1

DEFINE_BASECLASS("ixSubpanelParent")
local PANEL = {}

AccessorFunc(PANEL, "bCharacterOverview", "CharacterOverview", FORCE_BOOL)

function PANEL:Init()
	if (IsValid(ix.gui.menu)) then
		ix.gui.menu:Remove()
	end

	ix.gui.menu = self

	self.bCharacterOverview = false
	self.bOverviewOut = false
	self.overviewFraction = 0

	self.noAnchor = CurTime() + 0.4
	self.anchorMode = true

	self.currentAlpha = 0
	self.currentBlur = 0

	self:SetSize(ScrW(), ScrH())
	self:SetPos(0, 0)

	self.buttons = self:Add("Panel")
	self.buttons:SetSize(ScrW(), ScreenScale(50 / 3))
	self.buttons:Dock(TOP)
	self.buttons:SetPaintedManually(true)
	self.buttons.Paint = function(self, width, height)
		surface.SetDrawColor(0, 0, 0, 130)
		surface.DrawRect(0, 0, width, height)
	end

	local close = self.buttons:Add("ixMenuButton")
	close.SetText = function(self, text, noTranslation)
		DButton.SetText(self, noTranslation and text or L(text))
	end
	close:SetText("X")
	close:SetFont("LiteNetworkFont24-Light")
	close:SetTextColor(ix.config.Get("color"))
	close:SetContentAlignment(5)
	close:Dock(RIGHT)
	close:SetBackgroundColor(ix.config.Get("color"))
	close.DoClick = function()
		self:Remove()
	end

	local characters = self.buttons:Add("ixMenuButton")
	characters.SetText = function(self, text, noTranslation)
		surface.SetFont("LiteNetworkFont24-Light")
		local text = "<"
		DButton.SetText(self, text)

		local w, h = surface.GetTextSize(text)
		self:SetSize(w + 64, h + 32)	
	end
	characters:SetText("<")
	characters:SetFont("LiteNetworkFont24-Light")
	characters:SetTextColor(ix.config.Get("color"))
	characters:SetContentAlignment(5)
	characters:Dock(LEFT)
	characters:SetBackgroundColor(ix.config.Get("color"))
	characters.DoClick = function()
		self:Remove()
		vgui.Create("ixCharMenu")
	end

	self.tabs = self.buttons:Add("Panel")
	self.tabs.buttons = {}
	self.tabs:Dock(FILL)
	self:PopulateTabs()

	self:MakePopup()
	self:OnOpened()
end

function PANEL:OnOpened()
	self:SetAlpha(0)

	self:CreateAnimation(animationTime, {
		target = {currentAlpha = 255},
		easing = "outQuint",

		Think = function(animation, panel)
			panel:SetAlpha(panel.currentAlpha)
		end
	})
end

function PANEL:GetActiveTab()
	return (self:GetActiveSubpanel() or {}).subpanelName
end

function PANEL:TransitionSubpanel(id)
	local lastSubpanel = self:GetActiveSubpanel()

	-- don't transition to the same panel
	if (IsValid(lastSubpanel) and lastSubpanel.subpanelID == id) then
		return
	end

	local subpanel = self:GetSubpanel(id)

	if (IsValid(subpanel)) then
		if (!subpanel.bPopulated) then
			local info = subpanel.info
			subpanel.Paint = nil

			if (istable(info) and info.Create) then
				info:Create(subpanel)
			elseif (isfunction(info)) then
				info(subpanel)
			end

			hook.Run("MenuSubpanelCreated", subpanel.subpanelName, subpanel)
			subpanel.bPopulated = true
		end

		-- only play whoosh sound only when the menu was already open
		if (IsValid(lastSubpanel)) then
			LocalPlayer():EmitSound("Helix.Whoosh")
		end

		self:SetActiveSubpanel(id)
	end

	subpanel = self:GetActiveSubpanel()

	local info = subpanel.info
	local bHideBackground = istable(info) and (info.bHideBackground != nil and info.bHideBackground or false) or false

	if (bHideBackground) then
		self:HideBackground()
	else
		self:ShowBackground()
	end

	-- call hooks if we've changed subpanel
	if (IsValid(lastSubpanel) and istable(lastSubpanel.info) and lastSubpanel.info.OnDeselected) then
		lastSubpanel.info:OnDeselected(lastSubpanel)
	end

	if (IsValid(subpanel) and istable(subpanel.info) and subpanel.info.OnSelected) then
		subpanel.info:OnSelected(subpanel)
	end

	ix.gui.lastMenuTab = id
end

function PANEL:SetCharacterOverview(bValue, length)
	bValue = tobool(bValue)
	length = length or animationTime

	if (bValue) then
		if (!IsValid(self.projectedTexture)) then
			self.projectedTexture = ProjectedTexture()
		end

		local faction = ix.faction.indices[LocalPlayer():Team()]
		local color = faction and faction.color or color_white

		self.projectedTexture:SetEnableShadows(false)
		self.projectedTexture:SetNearZ(12)
		self.projectedTexture:SetFarZ(64)
		self.projectedTexture:SetFOV(90)
		self.projectedTexture:SetColor(color)
		self.projectedTexture:SetTexture("effects/flashlight/soft")

		self:CreateAnimation(length, {
			index = 3,
			target = {overviewFraction = 1},
			easing = "outQuint",
			bIgnoreConfig = true
		})

		self.bOverviewOut = false
		self.bCharacterOverview = true
	else
		self:CreateAnimation(length, {
			index = 3,
			target = {overviewFraction = 0},
			easing = "outQuint",
			bIgnoreConfig = true,

			OnComplete = function(animation, panel)
				panel.bCharacterOverview = false

				if (IsValid(panel.projectedTexture)) then
					panel.projectedTexture:Remove()
				end
			end
		})

		self.bOverviewOut = true
	end
end

function PANEL:GetOverviewInfo(origin, angles, fov)
	local originAngles = Angle(0, angles.yaw, angles.roll)
	local target = LocalPlayer():GetObserverTarget()
	local fraction = self.overviewFraction
	local bDrawPlayer = ((fraction > 0.2) or (!self.bOverviewOut and (fraction > 0.2))) and !IsValid(target)
	local forward = originAngles:Forward() * 58 - originAngles:Right() * 36
	forward.z = 0

	local newOrigin

	if (IsValid(target)) then
		newOrigin = target:GetPos() + forward
	else
		newOrigin = origin - LocalPlayer():OBBCenter() * 0.6 + forward
	end

	local newAngles = originAngles + Angle(0, 180, 0)
	newAngles.pitch = 5
	newAngles.roll = 0

	return LerpVector(fraction, origin, newOrigin), LerpAngle(fraction, angles, newAngles), Lerp(fraction, fov, 90), bDrawPlayer
end

function PANEL:HideBackground()
	self:CreateAnimation(animationTime, {
		index = 2,
		target = {currentBlur = 0},
		easing = "outQuint"
	})
end

function PANEL:ShowBackground()
	self:CreateAnimation(animationTime, {
		index = 2,
		target = {currentBlur = 1},
		easing = "outQuint"
	})
end

function PANEL:PopulateTabs()
	local default
	local tabs = {}

	hook.Run("CreateMenuButtons", tabs)

	for name, info in SortedPairs(tabs) do
		local bTable = istable(info)
		local buttonColor = ix.config.Get("color")
		local bDefault = (bTable and info.bDefault) or false

		-- setup subpanels without populating them so we can retain the order
		local subpanel = self:AddSubpanel(name, true)
		local id = subpanel.subpanelID
		subpanel.info = info
		subpanel:SetPaintedManually(true)
		subpanel:SetTitle(nil)
		subpanel:SetSize(ScrW() - self:GetPadding() * 2, ScrH() - self:GetPadding() * 2)

		-- self is called while the subpanel has not been populated
		subpanel.Paint = function(panel, width, height)
			derma.SkinFunc("PaintPlaceholderPanel", panel, width, height)
		end

		local button = self.tabs:Add("ixMenuSelectionButton")
		button.SetText = function(self, text, noTranslation)
			surface.SetFont("LiteNetworkFont24-Light")
			local text = noTranslation and text:upper() or L(text):upper()
			DButton.SetText(self, text)

			local w, h = surface.GetTextSize(text)
			self:SetSize(w + 64, h + 32)
		end
		button:SetText(L(name))
		button:SetTextColor(ix.config.Get("color"))
		button:SetContentAlignment(5)
		button:Dock(LEFT)
		button:SetButtonList(self.tabs.buttons)
		button:SetBackgroundColor(ix.config.Get("color"))
		button:SetFont("LiteNetworkFont24-Light")
		button.id = id
		button.OnSelected = function()
			self:TransitionSubpanel(id)
		end
		function button:PaintBackground(width, height)
			surface.SetDrawColor(ColorAlpha(self.backgroundColor, self.currentBackgroundAlpha))
			surface.DrawRect(0, 0, width, height)
		end

		if (bTable and info.PopulateTabButton) then
			info:PopulateTabButton(button)
		end

		if (bDefault) then
			default = button
		end
	end

	if (ix.gui.lastMenuTab) then
		for i = 1, #self.tabs.buttons do
			local button = self.tabs.buttons[i]

			if (button.id == ix.gui.lastMenuTab) then
				default = button
				break
			end
		end
	end

	if (!IsValid(default) and #self.tabs.buttons > 0) then
		default = self.tabs.buttons[1]
	end

	if (IsValid(default)) then
		default:SetSelected(true)
		self:SetActiveSubpanel(default.id, 0)
	end

	self.buttons:MoveToFront()
end

function PANEL:OnKeyCodePressed(key)
	self.noAnchor = CurTime() + 0.5

	if (key == KEY_TAB) then
		self:Remove()
	end
end

function PANEL:Think()
	if (IsValid(self.projectedTexture)) then
		local forward = LocalPlayer():GetForward()
		forward.z = 0

		local right = LocalPlayer():GetRight()
		right.z = 0

		self.projectedTexture:SetBrightness(self.overviewFraction * 4)
		self.projectedTexture:SetPos(LocalPlayer():GetPos() + right * 16 - forward * 8 + Vector(0, 0, 6))
		self.projectedTexture:SetAngles(forward:Angle() + Angle(-45, 60, 0))
		self.projectedTexture:Update()
	end

	if (self.bClosing) then
		return
	end

	local bTabDown = input.IsKeyDown(KEY_TAB)

	if (bTabDown and (self.noAnchor or CurTime() + 0.4) < CurTime() and self.anchorMode) then
		self.anchorMode = false
	end

	if ((!self.anchorMode and !bTabDown) or gui.IsGameUIVisible()) then
		self:Remove()
	end
end

local gradient = surface.GetTextureID("vgui/gradient-d")
function PANEL:Paint(width, height)
	surface.SetDrawColor(ColorAlpha(ix.config.Get("color"), 10))
	surface.DrawRect(0, 0, width, height)

	surface.SetDrawColor(Color(0, 0, 0, 200))
	surface.DrawRect(0, 0, width, height)

	ix.util.DrawBlur(self)

	self:PaintSubpanels(width, height)
	self.buttons:PaintManual()

	if (IsValid(ix.gui.inv1) and ix.gui.inv1.childPanels) then
		for i = 1, #ix.gui.inv1.childPanels do
			local panel = ix.gui.inv1.childPanels[i]

			if (IsValid(panel)) then
				panel:PaintManual()
			end
		end
	end
end

function PANEL:Remove()
	self.bClosing = true
	self:SetMouseInputEnabled(false)
	self:SetKeyboardInputEnabled(false)
	self:SetCharacterOverview(false, animationTime * 0.5)

	-- remove input from opened child panels since they grab focus
	if (IsValid(ix.gui.inv1) and ix.gui.inv1.childPanels) then
		for i = 1, #ix.gui.inv1.childPanels do
			local panel = ix.gui.inv1.childPanels[i]

			if (IsValid(panel)) then
				panel:SetMouseInputEnabled(false)
				panel:SetKeyboardInputEnabled(false)
			end
		end
	end

	CloseDermaMenus()
	gui.EnableScreenClicker(false)

	self:CreateAnimation(animationTime * 0.5, {
		index = 2,
		target = {currentBlur = 0},
		easing = "outQuint"
	})

	self:CreateAnimation(animationTime * 0.5, {
		target = {currentAlpha = 0},
		easing = "outQuint",

		-- we don't animate the blur because blurring doesn't draw things
		-- with amount < 1 very well, resulting in jarring transition
		Think = function(animation, panel)
			panel:SetAlpha(panel.currentAlpha)
		end,

		OnComplete = function(animation, panel)
			if (IsValid(panel.projectedTexture)) then
				panel.projectedTexture:Remove()
			end

			BaseClass.Remove(panel)
		end
	})
end

vgui.Register("ixMenu", PANEL, "ixSubpanelParent")

if (IsValid(ix.gui.menu)) then
	ix.gui.menu:Remove()
end

ix.gui.lastMenuTab = nil

hook.Add("CreateMenuButtons", "ixSettings", function(tabs)
	tabs["settings"] = {
		PopulateTabButton = function(info, button)
			local menu = ix.gui.menu

			if (!IsValid(menu)) then
				return
			end

			DEFINE_BASECLASS("ixMenuButton")
			button:Dock(FILL)
			button:SetContentAlignment(6)
			button:SetZPos(9999)
		end,

		Create = function(info, container)
			container:SetTitle(L("settings"))

			local panel = container:Add("ixSettings")
			panel:SetSearchEnabled(true)

			for category, options in SortedPairs(ix.option.GetAllByCategories(true)) do
				category = L(category)
				panel:AddCategory(category)

				-- sort options by language phrase rather than the key
				table.sort(options, function(a, b)
					return L(a.phrase) < L(b.phrase)
				end)

				for _, data in pairs(options) do
					local key = data.key
					local row = panel:AddRow(data.type, category)
					local value = ix.util.SanitizeType(data.type, ix.option.Get(key))

					row:SetText(L(data.phrase))
					row:Populate(key, data)

					-- type-specific properties
					if (data.type == ix.type.number) then
						row:SetMin(data.min or 0)
						row:SetMax(data.max or 10)
						row:SetDecimals(data.decimals or 0)
					end

					row:SetValue(value, true)
					row:SetShowReset(value != data.default, key, data.default)
					row.OnValueChanged = function()
						local newValue = row:GetValue()

						row:SetShowReset(newValue != data.default, key, data.default)
						ix.option.Set(key, newValue)
					end

					row.OnResetClicked = function()
						row:SetShowReset(false)
						row:SetValue(data.default, true)

						ix.option.Set(key, data.default)
					end

					row:GetLabel():SetHelixTooltip(function(tooltip)
						local title = tooltip:AddRow("name")
						title:SetImportant()
						title:SetText(key)
						title:SizeToContents()
						title:SetMaxWidth(math.max(title:GetMaxWidth(), ScrW() * 0.5))

						local description = tooltip:AddRow("description")
						description:SetText(L(data.description))
						description:SizeToContents()
					end)
				end
			end

			panel:SizeToContents()
			container.panel = panel
		end,

		OnSelected = function(info, container)
			container.panel.searchEntry:RequestFocus()
		end
	}
end)