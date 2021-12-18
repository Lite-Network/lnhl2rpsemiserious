local PLUGIN = PLUGIN

PLUGIN.name = "Jury Division Update"
PLUGIN.author = "Riggs Mackay"
PLUGIN.description = "Adds Features and improvements to the Jury Division in Lite Network."

ix.util.Include("sv_plugin.lua")

if ( CLIENT ) then
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
    
    net.Receive("ixInspectBodyFinish", function(len, ply)
        local usedWeapon = net.ReadString()
        local attacker = net.ReadString()
        local message = "You have inspected the body, therefor you revealed the following..\n"
        
        Derma_Message(message, "Body Inspection Complete!", "Close")
    end)
end