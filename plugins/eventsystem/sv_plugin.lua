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