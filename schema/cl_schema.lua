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
    if not LogoColor then LogoColor = ix.config.Get("color") end

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

ix.weaponDescription = {
	["ix_mp7"] = "The corpse contains 4.65mm rounds.",
	["ix_357"] = "The corpse contains .357 rounds.",
	["ix_m14"] = "The corpse contains 7.62mm rounds.",
	["ix_m16"] = "The corpse contains 7.62mm rounds.",
	["ix_spas12"] = "The corpse has been ripped apart by buckshot rounds.",
	["ix_ar2"] = "The corpse has been pentrated by a high energy round which has left burn marks.",
	["ix_cmb_sniper"] = "The corpse has been pentrated by a high energy round which has left burn marks, probably from faar way.",
	["ix_crowbar"] = "The corpse has been slashed with big wounds.",
	["ix_axe"] = "The corpse has been hacked and slashed.",
	["ix_zombie_claws"] = "The corpse has been slashed with sharp wounds.",
	["ix_stunstick"] = "The corpse has several burn wounds commonly created by contact with a charged stun baton.",
	["ix_usp"] = "The corpse contains 9mm rounds.",
	["ix_vort_beam"] = "The corpse has sustained electrical and plasma burns by an extremely powerful force."
}

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

net.Receive("ixInspectBodyFinish", function(len, ply)
    local usedWeapon = net.ReadString()
    local attacker = net.ReadString()
    local message = "You have inspected the body, therefor you revealed the following..\n"
    
    Derma_Message(message, "Body Inspection Complete!", "Close")
end)