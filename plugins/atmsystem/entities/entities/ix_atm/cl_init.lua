include("shared.lua")

surface.CreateFont("ix_ATM_Font_18", {
	font = "Roboto",
	size = 18,
	weight = 64,
	antialias = true
})

surface.CreateFont("ix_ATM_Font_25", {
	font = "Roboto Bold",
	size = 25,
	weight = 64,
	antialias = true
})

surface.CreateFont("ix_ATM_Font_20", {
	font = "Roboto Bold",
	size = 20,
	weight = 64,
	antialias = true,
	bold = true
})

function ENT:Draw()
	self:DrawModel()
	local position, angles = self:GetPos(), self:GetAngles()
	local Glow = Material("sprites/glow04_noz")

	angles:RotateAroundAxis(angles:Forward(), 90)
	angles:RotateAroundAxis(angles:Right(), 270)

	cam.Start3D(EyePos(), EyeAngles())
		render.SetMaterial(Glow)
		render.DrawSprite(self:GetPos() + self:GetForward() * 4 + self:GetRight() * 8.2 + self:GetUp() * 11, 10, 10, Color(0, 150, 255, math.abs(math.cos(RealTime() * 1.8) * 255)))
		render.DrawSprite(self:GetPos() + self:GetForward() * 4 + self:GetRight() * 8.2 + self:GetUp() * 5.6, 10, 10, Color(0, 150, 255, math.abs(math.cos(RealTime() * 1.9) * 255)))
		render.DrawSprite(self:GetPos() + self:GetForward() * 4 + self:GetRight() * 8.2 + self:GetUp() * -0.7, 10, 10, Color(0, 150, 255, math.abs(math.cos(RealTime() * 2) * 255)))
		render.DrawSprite(self:GetPos() + self:GetForward() * 4 + self:GetRight() * 8.2 + self:GetUp() * -6.4, 10, 10, Color(0, 150, 255, math.abs(math.cos(RealTime() * 2.1) * 255)))
	cam.End3D()
	
	cam.Start3D2D(position + self:GetForward()*3.65 + self:GetRight()*8.5 + self:GetUp()*3, angles, 0.1)
		draw.SimpleText("ATM Machine", "ix_ATM_Font_25", 120, -94, Color(255, 255, 255, math.abs(math.cos(RealTime() * 0.5) * 255)), 1, 0)
		draw.SimpleText("Press ''USE'' to begin.", "ix_ATM_Font_25", 120, -64, Color(255, 255, 255, math.abs(math.cos(RealTime() * 0.5) * 255)), 1, 0)
	cam.End3D2D()
end

net.Receive("ixATM_OpenMenu", function(_)
	if !IsValid(ATM_MENU) then
		local ATM_MENU = vgui.Create("DFrame")
		ATM_MENU:SetTitle("ATM Machine")
		ATM_MENU:SetSize(300, 150)
		ATM_MENU:Center()
		ATM_MENU:MakePopup()
		ATM_MENU:SetSizable(false)
		ATM_MENU:SetDraggable(false)
		ATM_MENU:ShowCloseButton(true)
		ATM_MENU.Paint = function(self, w, h)
			surface.SetDrawColor(Color(30, 30, 30, 200))
			surface.DrawRect(0, 0, w, h)
		
			surface.SetDrawColor(ix.config.Get("color"))
			surface.DrawRect(0, 0, w, 24)
			surface.DrawOutlinedRect(0, 0, w, h, 5)
		
			ix.util.DrawBlur(self, 1)
		end

		local ATM_INFO = vgui.Create("ixLabel", ATM_MENU)
		ATM_INFO:Dock(TOP)
		ATM_INFO:SetFont("ix_ATM_Font_18")
		ATM_INFO:SetTextColor(color_white)
		ATM_INFO:SetText("Your Balance: "..net.ReadString())
		ATM_INFO:SizeToContents()

		local ATM_ENTRY = vgui.Create("DTextEntry", ATM_MENU)
		ATM_ENTRY:Dock(TOP)
		ATM_ENTRY:SetSize(0, 20)
		ATM_ENTRY:SetFont("ix_ATM_Font_20")
		ATM_ENTRY:SetNumeric(true)

		local ATM_DEPOSIT = vgui.Create("ixMenuButton", ATM_MENU)
		ATM_DEPOSIT:Dock(BOTTOM)
		ATM_DEPOSIT:SetColor(color_white)
		ATM_DEPOSIT:SetFont("ix_ATM_Font_18")
		ATM_DEPOSIT:SetText("Deposit")
		ATM_DEPOSIT.DoClick = function()
			local _number = ATM_ENTRY:GetValue()
			if _number == "" then return end

			if not _number then return end

			if _number:find("+") or _number:find("-") then return end

			net.Start("ixATM_Deposit")
				net.WriteUInt(math.floor(_number), 32)
			net.SendToServer()

			ATM_MENU:Remove()
		end

		local ATM_WITHDRAW = vgui.Create("ixMenuButton", ATM_MENU)
		ATM_WITHDRAW:Dock(BOTTOM)
		ATM_WITHDRAW:SetColor(color_white)
		ATM_WITHDRAW:SetFont("ix_ATM_Font_18")
		ATM_WITHDRAW:SetText("Withdraw")
		ATM_WITHDRAW.DoClick = function()
			local _number = ATM_ENTRY:GetValue()
			if _number == "" then return end

			if not _number then return end

			if _number:find("+") or _number:find("-") then return end

			net.Start("ixATM_Withdraw")
				net.WriteUInt(math.floor(_number), 32)
			net.SendToServer()

			ATM_MENU:Remove()
		end
	end
end)