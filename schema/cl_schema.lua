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

--[[---------------------------------------------------------------------------
	Clientside Net Nessages
---------------------------------------------------------------------------]]--

net.Receive("ixAddCombineDisplayMessage", function()
    if LocalPlayer():IsCombine() then
        ix.gui.AddCombineDisplayMessage(tostring(net.ReadString()) or "Invalid Input..", net.ReadColor() or color_white, tobool(net.ReadBool()) or false)
    end
end)

net.Receive("ixPlaySound", function(len, ply)
	surface.PlaySound(tostring(net.ReadString()))
end)

net.Receive("ixCreateVGUI", function(len, ply)
	vgui.Create(tostring(net.ReadString()))
end)

net.Receive("ixCustomSettings", function(len, ply)
	ix.option.Set("disableAnimations", false, true)
	ix.option.Set("cheapBlur", false, true)
	ix.option.Set("language", "english", true)
	ix.option.Set("observerTeleportBack", false, true)
	ix.option.Set("observerESP", false, true)

	ix.option.stored["minimalTooltips"].hidden = function() return true end
	ix.option.stored["alwaysShowBars"].hidden = function() return true end
	ix.option.stored["animationScale"].hidden = function() return true end
	ix.option.stored["24hourTime"].hidden = function() return true end
	ix.option.stored["openBags"].hidden = function() return true end
	ix.option.stored["disableAnimations"].hidden = function() return true end
	ix.option.stored["cheapBlur"].hidden = function() return true end
	ix.option.stored["language"].hidden = function() return true end
	ix.option.stored["observerTeleportBack"].hidden = function() return true end
	ix.option.stored["observerESP"].hidden = function() return true end
	ix.option.stored["altLower"].hidden = function() return true end
	ix.option.stored["showIntro"].hidden = function() return true end
	ix.option.stored["chatFontScale"].hidden = function() return true end
	ix.option.stored["chatOutline"].hidden = function() return true end
	ix.option.stored["chatNotices"].hidden = function() return true end
	ix.option.stored["chatTimestamps"].hidden = function() return true end
end)