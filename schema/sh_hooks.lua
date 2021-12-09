--[[---------------------------------------------------------------------------
	Shared Hooks
---------------------------------------------------------------------------]]--

function Schema:CanTool(ply, trace, toolname, tool, button)
	if ply and toolname then
		if (toolname == "creator") and not (ply:IsAdmin()) then
			ply:Notify("Nice try.")
			MsgAll(tostring(ply), " ", tostring(ply:SteamID()), " tried to use the ", toolname, " tool.\n")
			return false
		end

		if (toolname == "advdupe2") and not (ply:IsDonator() or ply:IsAdmin()) then
			ply:Notify("Advanced Duplicator is restricted to Donators only!")
			MsgAll(tostring(ply), " ", tostring(ply:SteamID()), " tried to use the ", toolname, " tool.\n")
			return false
		end

		if (toolname == "rb655_easy_bodygroup") and not (ply:IsDonator() or ply:IsAdmin()) then
			ply:Notify("Easy Bodygroup Tool is restricted to Donators only!")
			MsgAll(tostring(ply), " ", tostring(ply:SteamID()), " tried to use the ", toolname, " tool.\n")
			return false
		end

		if (toolname:find("wire")) and not (ply:IsDonator() or ply:IsAdmin()) then
			ply:Notify("Wiremod is restricted to Donators only!")
			MsgAll(tostring(ply), " ", tostring(ply:SteamID()), " tried to use the ", toolname, " tool.\n")
			return false
		end

		MsgAll(tostring(ply), " ", tostring(ply:SteamID()), " used the ", toolname, " tool.\n")
	end
end

function Schema:OnPlayerHitGround(ply)
    local vel = ply:GetVelocity()
    ply:SetVelocity( Vector( - ( vel.x * 0.1 ), - ( vel.y * 0.1 ), 0) )
end

function Schema:CanProperty(ply, property, ent)
	if (property == "persist") then
		if (SERVER) then
			ply:Notify("Persist Feature is disabled, please use perma all tool instead!")
		end
		return false
	end
end

function Schema:PrePACEditorOpen(ply)
	if not (ply:IsAdmin() or ply:IsDonator()) then
		ply:ChatNotify("PAC3 is restricted to certain users only!")
		return false
	end
end

function Schema:CanPlayerThrowPunch(ply)
	if ply:IsWepRaised() then
		if not ply:IsRebel() then
			if (SERVER) then
				ply:ChatNotify("Don't try to minge.")
			end
			return false
		else
			return true
		end
	end
end

function Schema:Initialize()
    timer.Simple(60, function()
		RunConsoleCommand("sv_skyname", "painted")
		for k, v in pairs(ents.FindByClass("light_environment")) do
			v:Fire("TurnOff")
		end
	end)
end

function Schema:CanPlayerJoinClass()
	return false
end

function Schema:CanDrive()
	return false
end

function Schema:GetMaxPlayerCharacter(ply)
	if not ply:IsSuperAdmin() then
		return 1
	else
		return 2
	end
end

function Schema:OnCharacterCreated(ply, char)
	char:SetData("ixKnownName", char:GetName())

	return true
end