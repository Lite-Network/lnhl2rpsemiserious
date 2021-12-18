util.AddNetworkString("ixEventMessage")

function PlayEventSound(sound)
	for k, v in pairs(player.GetAll()) do
		if istable(sound) then
			v:PlaySound(table.Random(sound))
		else
			v:PlaySound(sound)
		end
	end
end

function PlayTimedEventSound(time, sound)
	timer.Simple(time, function() PlayEventSound(tostring(sound)) end)
end

function StopEventSound(sound)
	for k, v in pairs(player.GetAll()) do
		v:StopSound(sound)
	end
end

function StopTimedEventSound(time, sound)
	timer.Simple(time, function()
		for k, v in pairs(player.GetAll()) do
			v:StopSound(sound)
		end
	end)
end

concommand.Add("ix_event_cinematicbars_all", function(ply, cmd, args)
	if ( args[1] ) and ( ply:IsSuperAdmin() ) then
		for k, v in pairs(player.GetAll()) do
			net.Start("ixEventMessage")
				net.WriteString(args[1])
			net.Send(v)
		end
	end
end)

concommand.Add("ix_event_cinematicbars_target", function(ply, cmd, args)
	if ( args[1] and args[2] ) and ( ply:IsSuperAdmin() ) then
		local target = ix.util.FindPlayer(args[1])
		net.Start("ixEventMessage")
			net.WriteString(args[2])
		net.Send(target)
	end
end)