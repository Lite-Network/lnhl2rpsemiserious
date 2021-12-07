local PANEL = {}

function PANEL:Init()
    self:SetTitle("Lite Network Event System Menu")
    self:SetSize(ScrW() / 1.2, ScrH() / 1.2)
    self:Center()
end

vgui.Register("ixEventMenu", PANEL, "DFrame")