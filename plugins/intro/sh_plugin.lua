local PLUGIN = PLUGIN

PLUGIN.name = "Lite Network Intro"
PLUGIN.author = "Riggs Mackay"
PLUGIN.description = "A Intro that loads after creating your character."

ix.util.Include("sv_plugin.lua")

if ( CLIENT ) then
    net.Receive("ixStartIntro", function(len, ply)
        
    end)
end