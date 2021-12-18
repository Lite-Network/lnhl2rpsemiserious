include("shared.lua")

function ENT:Draw()
	self:DrawModel()

	local pos = self:GetPos()
	local ang = self:GetAngles()

	pos = pos + (ang:Up() * 48)
	pos = pos + (ang:Forward() * -2.36)
	pos = pos + (ang:Right() * 9.8)

	ang:RotateAroundAxis(self:GetAngles():Up(), 90)
	ang:RotateAroundAxis(self:GetAngles():Right(), -42)

	cam.Start3D2D(pos, ang, 0.07)
		surface.SetDrawColor(Color(30, 30, 30))
		surface.DrawRect(0, 0, 225, 115)

		surface.SetDrawColor(ix.config.Get("color"))
		surface.DrawOutlinedRect(0, 0, 225, 115, 5)

		draw.DrawText("TERMINAL: "..self:EntIndex(), "ixMenuButtonFontSmall", 8, 4, Color(65, 105, 200), TEXT_ALIGN_LEFT)
		draw.DrawText("CITY INDEX: 17", "ixMenuButtonFontSmall", 8, 32, Color(65, 105, 200), TEXT_ALIGN_LEFT)
		draw.DrawText("PLEASE CONFIRM IDENTITY", "ixSmallFont", 8, 90, color_white, TEXT_ALIGN_LEFT)
	cam.End3D2D()
end

local PANEL = {}
function PANEL:Init()
	local panel = self

	self:SetTitle("Arresting Terminal")
	self:SetSize(ScrW() / 2, ScrH() / 2)
	self:Center()
	self:SetVisible(true)
	self:MakePopup()

	self.scrollpanel = self:Add("DScrollPanel")
	self.scrollpanel:Dock(FILL)

	self.setting = {}

	for k, v in SortedPairs(ix.combineterminal.charges) do
		self:AddCharge(k, v)
	end

	self.sentencebutton = self:Add("ixMenuButton")
	self.sentencebutton:Dock(BOTTOM)
	self.sentencebutton:SizeToContents()
	self.sentencebutton:SetText("arrest (Charges: 0 | Cycles: 0)")

	self.sentencebutton.DoClick = function()
		local chargecount = 0
		local charges = {}
		local chargestimeoriginal = 0
		local chargestime = 0

		for k, v in pairs(panel.setting) do
			table.insert(charges, k)
			-- probably the worst way but fuck you :)
			chargestimeoriginal = chargestimeoriginal + ix.combineterminal.charges[k].severity
			chargestime = ix.combineterminal.charges[k].severity * 60
			chargecount = chargecount + 1
		end

		if (chargecount > 0) and (chargecount < 5) then
			net.Start("ixCombineTerminalCharge")
				net.WriteTable(charges)
				net.WriteUInt(chargestimeoriginal, 4)
				net.WriteUInt(chargestime, 12)
			net.SendToServer()
		else
			if (chargecount > 4) then
				LocalPlayer():Notify("You cannot select too many charges!")
			elseif (chargecount == 0) then
				LocalPlayer():Notify("You must atleast select one resonable charge!")
			end
		end
	end
end

function PANEL:AddCharge(chargeid, data)
	local panel = self

	local chargesetting = self.scrollpanel:Add("ixSettingsRowBool")
	chargesetting:SetText(data.name)
	chargesetting:SizeToContents()
	chargesetting:Dock(TOP)
	chargesetting:DockMargin(4, 4, 1, 1)
	chargesetting.chargeID = chargeid

	function chargesetting:OnValueChanged(value)
		if value then
			panel.setting[self.chargeID] = value
		else
			panel.setting[self.chargeID] = nil
		end

		self.value = value

		local chargecount = 0
		local timecount = 0

		for k, v in pairs(panel.setting) do
			timecount = timecount + ix.combineterminal.charges[k].severity
			chargecount = chargecount + 1
		end

		panel.sentencebutton:SetText("arrest (Charges: "..chargecount.." | Cycles: "..math.Clamp(timecount, 0, (900 / 60))..")")
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
vgui.Register("LiteNetworkTerminal", PANEL, "DFrame")