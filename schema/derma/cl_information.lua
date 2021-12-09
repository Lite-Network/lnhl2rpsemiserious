local PANEL = {}

function PANEL:Init()
	self:Dock(FILL)
    
    poop = self:Add("ixLabel")
    poop:SetText("poopers")
    poop:SetColor(color_white)
end

vgui.Register("ixCharacterInfo", PANEL, "DScrollPanel")

hook.Add("CreateMenuButtons", "ixCharInfo", function(tabs)
	tabs["you"] = nil
end)

hook.Remove("CreateMenuButtons", "ixCharInfo")