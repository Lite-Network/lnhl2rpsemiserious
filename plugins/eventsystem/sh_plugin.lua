local PLUGIN = PLUGIN

PLUGIN.name = "Lite Network Event System"
PLUGIN.author = "Riggs Mackay"
PLUGIN.description = "Allows Gamemasters to make events more faster + better."

if ( CLIENT ) then
    net.Receive("ixEventMessage", function(_, ply)
        ix.CinematicTitle = net.ReadString()
        ix.CinematicIntro = true
    end)
end

ix.util.Include("sv_plugin.lua")

ix.command.Add("CinematicBarsTarget", {
	description = "Shows Cinematic Bars on a certain player.",
	superAdminOnly = true,
	arguments = {ix.type.player, ix.type.string},
	OnRun = function(_, ply, target, stringMessage)
		if not (ply:IsSuperAdmin()) then
			ply:Notify("You need to be a super admin in order to use this command.")
			return false
		end
		
        --ply:ConCommand([[ix_event_cinematicbars_target "]] .. tostring(target) .. [[" "]] .. stringMessage .. [["]])
		net.Start("ixEventMessage")
			net.WriteString(stringMessage)
		net.Send(target)
	end
})

ix.command.Add("CinematicBarsAll", {
	description = "Shows Cinematic Bars on every player.",
	superAdminOnly = true,
	arguments = ix.type.string,
	OnRun = function(_, ply, stringMessage)
		if not (ply:IsSuperAdmin()) then
			ply:Notify("You need to be a super admin in order to use this command.")
			return false
		end

        ply:ConCommand([[ix_event_cinematicbars_all "]] .. stringMessage .. [["]])
	end
})