--[[---------------------------------------------------------------------------
	Voicelines Library
---------------------------------------------------------------------------]]--

Schema.voices = {}
Schema.voices.stored = {}
Schema.voices.classes = {}

function Schema.voices.Add(class, key, text, sound, global)
	class = string.lower(class)
	key = string.lower(key)

	Schema.voices.stored[class] = Schema.voices.stored[class] or {}
	Schema.voices.stored[class][key] = {
		text = text,
		sound = sound,
		global = global
	}
end

function Schema.voices.Get(class, key)
	class = string.lower(class)
	key = string.lower(key)

	if (Schema.voices.stored[class]) then
		return Schema.voices.stored[class][key]
	end
end

function Schema.voices.AddClass(class, condition)
	class = string.lower(class)

	Schema.voices.classes[class] = {
		condition = condition
	}
end

function Schema.voices.GetClass(ply)
	local classes = {}

	for k, v in pairs(Schema.voices.classes) do
		if (v.condition(ply)) then
			classes[#classes + 1] = k
		end
	end

	return classes
end

if (CLIENT) then
	local voiceTypes = {
		"vortigaunt",
		"citizenmale",
		"citizenfemale",
		"universalunion",
		"universalunionez2",
		"dispatchradio",
		"dispatch",
	}
	for k, v in pairs(voiceTypes) do
		concommand.Add("ix_printvcs_"..v, function(ply, cmd, args)
			for k2, v2 in SortedPairs(Schema.voices.stored[v]) do
				print(k2:upper())
			end
		end)
	end
end

Schema.voices.AddClass("UniversalUnion", function(ply)
	return ply:IsCombine()
end)

Schema.voices.AddClass("UniversalUnionEZ2", function(ply)
	return ply:IsCombine() and ply:IsSuperAdmin() -- fuck you lol :)
end)

Schema.voices.AddClass("Dispatch", function(ply)
	return ply:IsDispatch() or ply:IsCombineCommand() or ply:IsAdmin()
end)

Schema.voices.AddClass("DispatchRadio", function(ply)
	return ply:IsDispatch() or ply:IsCombineCommand() or ply:IsAdmin()
end)

Schema.voices.AddClass("Vortigaunt", function(ply)
	return ply:IsVortigaunt()
end)

Schema.voices.AddClass("CitizenMale", function(ply)
	local factionTable = ix.faction.Get(ply:Team())
	if ( ( ply:IsCitizen() or ply:IsCWU() ) and not ply:IsFemale() ) and ( ply:IsDonator() or ply:IsAdmin() ) then
		return true
	end
end)

Schema.voices.AddClass("CitizenFemale", function(ply)
	local factionTable = ix.faction.Get(ply:Team())
	if ( ( ply:IsCitizen() or ply:IsCWU() ) and ply:IsFemale() ) and ( ply:IsDonator() or ply:IsAdmin() ) then
		return true
	end
end)