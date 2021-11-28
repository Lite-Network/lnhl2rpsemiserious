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

net.Receive("ixInspectBodyFinish", function()
    Derma_Message("test!", "helix", "Close")
end)