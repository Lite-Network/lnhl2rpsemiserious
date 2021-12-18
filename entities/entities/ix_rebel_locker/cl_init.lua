include("shared.lua")

local PANEL = {}
function PANEL:Init()
	self:SetTitle("Rebel Outfit Locker")
	self:SetSize(ScrW() / 2, ScrH() / 2)
	self:Center()
	self:SetVisible(true)
	self:MakePopup()

	self.iconpanel = self:Add("DPanel")
	self.iconpanel:Dock(FILL)
	self.iconpanel.Paint = function() end

	self.buttonpanel = self:Add("DPanel")
	self.buttonpanel:SetSize(0, 40)
	self.buttonpanel:Dock(BOTTOM)
	self.buttonpanel.Paint = function() end

	if LocalPlayer():IsCitizen() then
		self.citizenmodelicon = self.iconpanel:Add("ixModelPanel")
		self.citizenmodelicon:SetSize(self:GetWide() / 3, 0)
		self.citizenmodelicon:SetModel(LocalPlayer():GetModel())
		self.citizenmodelicon:Dock(LEFT)
		self.citizenmodelicon:SetFOV(ScreenScale(14))
		self.citizenmodelicon.Entity:SetBodygroup(1, 0)
		self.citizenmodelicon.Entity:SetBodygroup(2, 1)
		self.citizenmodelicon.Entity:SetBodygroup(3, 1)
		self.citizenmodelicon.Entity:SetBodygroup(4, 0)

		function self.citizenmodelicon:LayoutEntity()
			local entity = self.Entity

			entity:SetAngles(Angle(0, 45, 0))
			entity:SetIK(false)

			if (self.copyLocalSequence) then
				entity:SetSequence(LocalPlayer():GetSequence())
				entity:SetPoseParameter("move_yaw", 360 * LocalPlayer():GetPoseParameter("move_yaw") - 180)
			end

			self:RunAnimation()
		end

		self.citizenmodelbutton = self.buttonpanel:Add("ixMenuButton")
		self.citizenmodelbutton:SetSize(self:GetWide() / 3, 40)
		self.citizenmodelbutton:SetText("Change to Citizen Outfit")
		self.citizenmodelbutton:SetTextColor(color_white)
		self.citizenmodelbutton:SetFont("ixSmallFont")
		self.citizenmodelbutton:SetContentAlignment(5)
		self.citizenmodelbutton:Dock(LEFT)
		self.citizenmodelbutton.DoClick = function()
			self:Close()

			net.Start("LiteNetworkRebelLockerChange.Citizen")
			net.SendToServer()
		end

		self.rebelmodelicon = self.iconpanel:Add("ixModelPanel")
		self.rebelmodelicon:SetSize(self:GetWide() / 3, 0)
		self.rebelmodelicon:SetModel(LocalPlayer():GetModel())
		self.rebelmodelicon:Dock(LEFT)
		self.rebelmodelicon:SetFOV(ScreenScale(14))
		self.rebelmodelicon.Entity:SetBodygroup(1, table.Random({2, 3, 6}))
		self.rebelmodelicon.Entity:SetBodygroup(2, math.random(8,9))
		self.rebelmodelicon.Entity:SetBodygroup(3, math.random(6,8))
		self.rebelmodelicon.Entity:SetBodygroup(4, 6)

		function self.rebelmodelicon:LayoutEntity()
			local entity = self.Entity

			entity:SetAngles(Angle(0, 45, 0))
			entity:SetIK(false)

			if (self.copyLocalSequence) then
				entity:SetSequence(LocalPlayer():GetSequence())
				entity:SetPoseParameter("move_yaw", 360 * LocalPlayer():GetPoseParameter("move_yaw") - 180)
			end

			self:RunAnimation()
		end

		self.rebelmodelbutton = self.buttonpanel:Add("ixMenuButton")
		self.rebelmodelbutton:SetSize(self:GetWide() / 3, 40)
		self.rebelmodelbutton:SetText("Change to Rebel Outfit")
		self.rebelmodelbutton:SetTextColor(color_white)
		self.rebelmodelbutton:SetFont("ixSmallFont")
		self.rebelmodelbutton:SetContentAlignment(5)
		self.rebelmodelbutton:Dock(LEFT)
		self.rebelmodelbutton.DoClick = function()
			self:Close()

			net.Start("LiteNetworkRebelLockerChange.Rebel")
			net.SendToServer()
		end

		self.rebelmedicmodelicon = self.iconpanel:Add("ixModelPanel")
		self.rebelmedicmodelicon:SetSize(self:GetWide() / 3, 0)
		self.rebelmedicmodelicon:SetModel(LocalPlayer():GetModel())
		self.rebelmedicmodelicon:Dock(LEFT)
		self.rebelmedicmodelicon:SetFOV(ScreenScale(14))
		self.rebelmedicmodelicon.Entity:SetBodygroup(1, table.Random({6, 7, 8}))
		self.rebelmedicmodelicon.Entity:SetBodygroup(2, 10)
		self.rebelmedicmodelicon.Entity:SetBodygroup(3, math.random(6,8))
		self.rebelmedicmodelicon.Entity:SetBodygroup(4, 6)

		function self.rebelmedicmodelicon:LayoutEntity()
			local entity = self.Entity

			entity:SetAngles(Angle(0, 45, 0))
			entity:SetIK(false)

			if (self.copyLocalSequence) then
				entity:SetSequence(LocalPlayer():GetSequence())
				entity:SetPoseParameter("move_yaw", 360 * LocalPlayer():GetPoseParameter("move_yaw") - 180)
			end

			self:RunAnimation()
		end

		self.rebelmedicmodelbutton = self.buttonpanel:Add("ixMenuButton")
		self.rebelmedicmodelbutton:SetSize(self:GetWide() / 3, 40)
		self.rebelmedicmodelbutton:SetText("Change to Rebel Medic Outfit")
		self.rebelmedicmodelbutton:SetTextColor(color_white)
		self.rebelmedicmodelbutton:SetFont("ixSmallFont")
		self.rebelmedicmodelbutton:SetContentAlignment(5)
		self.rebelmedicmodelbutton:Dock(LEFT)
		self.rebelmedicmodelbutton.DoClick = function()
			self:Close()

			net.Start("LiteNetworkRebelLockerChange.RebelMedic")
			net.SendToServer()
		end
	elseif LocalPlayer():IsVortigaunt() then
		self.vortshackledbutton = self.buttonpanel:Add("ixMenuButton")
		self.vortshackledbutton:SetSize(self:GetWide() / 2, 40)
		self.vortshackledbutton:SetText("Become a Shackled Vortigaunt")
		self.vortshackledbutton:SetTextColor(color_white)
		self.vortshackledbutton:SetFont("ixMediumFont")
		self.vortshackledbutton:SetContentAlignment(5)
		self.vortshackledbutton:Dock(LEFT)
		self.vortshackledbutton.DoClick = function()
			self:Close()

			net.Start("LiteNetworkRebelLockerChange.VortigauntShackled")
			net.SendToServer()
		end

		self.vortshackledicon = self.iconpanel:Add("ixModelPanel")
		self.vortshackledicon:SetSize(self:GetWide() / 2, 0)
		self.vortshackledicon:SetModel(LocalPlayer():GetModel())
		self.vortshackledicon:Dock(LEFT)
		self.vortshackledicon:SetFOV(ScreenScale(20))
		self.vortshackledicon.Entity:SetBodygroup(7, 1)
		self.vortshackledicon.Entity:SetBodygroup(8, 1)
		self.vortshackledicon.Entity:SetBodygroup(9, 1)

		function self.vortshackledicon:LayoutEntity()
			local entity = self.Entity

			entity:SetAngles(Angle(0, 45, 0))
			entity:SetIK(false)

			if (self.copyLocalSequence) then
				entity:SetSequence(LocalPlayer():GetSequence())
				entity:SetPoseParameter("move_yaw", 360 * LocalPlayer():GetPoseParameter("move_yaw") - 180)
			end

			self:RunAnimation()
		end

		self.vortfreedbutton = self.buttonpanel:Add("ixMenuButton")
		self.vortfreedbutton:SetSize(self:GetWide() / 2, 40)
		self.vortfreedbutton:SetText("Become a Freed Vortigaunt")
		self.vortfreedbutton:SetTextColor(color_white)
		self.vortfreedbutton:SetFont("ixMediumFont")
		self.vortfreedbutton:SetContentAlignment(5)
		self.vortfreedbutton:Dock(LEFT)
		self.vortfreedbutton.DoClick = function()
			self:Close()

			net.Start("LiteNetworkRebelLockerChange.VortigauntFreed")
			net.SendToServer()
		end

		self.vortfreedicon = self.iconpanel:Add("ixModelPanel")
		self.vortfreedicon:SetSize(self:GetWide() / 2, 0)
		self.vortfreedicon:SetModel(LocalPlayer():GetModel())
		self.vortfreedicon:Dock(LEFT)
		self.vortfreedicon:SetFOV(ScreenScale(20))
		self.vortfreedicon.Entity:SetBodygroup(7, 0)
		self.vortfreedicon.Entity:SetBodygroup(8, 0)
		self.vortfreedicon.Entity:SetBodygroup(9, 0)

		function self.vortfreedicon:LayoutEntity()
			local entity = self.Entity

			entity:SetAngles(Angle(0, 45, 0))
			entity:SetIK(false)

			if (self.copyLocalSequence) then
				entity:SetSequence(LocalPlayer():GetSequence())
				entity:SetPoseParameter("move_yaw", 360 * LocalPlayer():GetPoseParameter("move_yaw") - 180)
			end

			self:RunAnimation()
		end
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
vgui.Register("LiteNetworkRebelOutfitLocker", PANEL, "DFrame")
