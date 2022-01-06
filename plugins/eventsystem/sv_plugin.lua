util.AddNetworkString("ixEventMessage")

function PlayEventSound(sound, pitch)
	for k, v in pairs(player.GetAll()) do
		if istable(sound) then
			v:PlaySound(tostring(table.Random(sound)), tonumber(pitch) or 100)
		else
			v:PlaySound(tostring(sound), tonumber(pitch) or 100)
		end
	end
end

function PlayTimedEventSound(time, sound, pitch)
	timer.Simple(time, function()
		PlayEventSound(tostring(sound), tonumber(pitch) or 100)
	end)
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

function EmitShake()
    for k, v in pairs(player.GetAll()) do
        util.ScreenShake(v:GetPos(), 5, 5, 5, 5000)
    end
end

function EmitTimedShake(time)
	timer.Simple(time, function()
		for k, v in pairs(player.GetAll()) do
			util.ScreenShake(v:GetPos(), 5, 5, 5, 5000)
		end
	end)
end

function EmitSlightShake()
    for k, v in pairs(player.GetAll()) do
        util.ScreenShake(v:GetPos(), math.random(1, 3), 5, math.random(1, 3), 5000)
    end
end

function EmitTimedSlightShake(time)
	timer.Simple(time, function()
		for k, v in pairs(player.GetAll()) do
			util.ScreenShake(v:GetPos(), math.random(1, 3), 5, math.random(1, 3), 5000)
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

concommand.Add("ix_event_c17_start", function(ply, cmd, args)
	if ( ply:IsSuperAdmin() ) then
		
	end
end)