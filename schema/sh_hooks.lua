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

		if (toolname:find("wire")) and not (ply:IsDonator() or ply:IsAdmin()) and not (toolname:find("wire_textscreen")) then
			ply:Notify("Wiremod is restricted to Donators only!")
			MsgAll(tostring(ply), " ", tostring(ply:SteamID()), " tried to use the ", toolname, " tool.\n")
			return false
		end

		MsgAll(tostring(ply), " ", tostring(ply:SteamID()), " used the ", toolname, " tool.\n")
	end
end

function Schema:CanProperty(ply, property, ent)
	if (property == "persist") then
		if ( SERVER ) then
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
		if not ( ply:IsRebel() or ply:IsCombine() ) then
			if ( SERVER ) then
				ply:ChatNotify("Don't try to minge.")
			end
			return false
		else
			return true
		end
	end
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

function Schema:EntityTakeDamage(target, dmginfo)
	if target:IsPlayer() and (dmginfo:GetDamageType() == DMG_CRUSH) then
		dmginfo:ScaleDamage(0)
	end

	if ( target:IsPlayer() ) then
		if ( dmginfo:GetAttacker():GetClass() == "npc_headcrab" or dmginfo:GetAttacker():GetClass() == "npc_headcrab_fast" ) then
			dmginfo:ScaleDamage(math.random(3.00,5.00))
		end
	end
end

function Schema:CanPlayerUseBusiness(ply, uniqueID)
	local itemTable = ix.item.list[uniqueID]

	if (itemTable) then
		if (ply.ixCWUClass == 2) and (itemTable.category == "Consumeables") then
			ply.noBusinessAllow = true
			return true
		elseif (ply.ixCWUClass == 3) and (itemTable.category == "Medical Items") then
			ply.noBusinessAllow = true
			return true
		else
			ply.noBusinessAllow = false
			return false
		end
	end
end

function Schema:SetupMove(ply, mv, cmd)
	if not (ply:IsRestricted()) then return end

	mv:SetMaxClientSpeed(mv:GetMaxClientSpeed() * 0.6)
	
	if not IsValid(ply.ixDraggedBy) then return end
	
	local kidnapper = ply.ixDraggedBy
	if not ( kidnapper:IsPlayer() ) then return end
	
	local TargetPoint = (kidnapper:IsPlayer() and kidnapper:GetShootPos()) or kidnapper:GetPos()
	local MoveDir = (TargetPoint - ply:GetPos()):GetNormal()
	local ShootPos = ply:GetShootPos() + (Vector(0, 0, (ply:Crouching() and 0)))
	local Distance = 64
	
	local distFromTarget = ShootPos:Distance( TargetPoint )
	if (distFromTarget) <= (Distance + 5) then return end
	if ply:InVehicle() then
		if ( SERVER ) and (distFromTarget > (Distance * 3)) then
			ply:ExitVehicle()
		end
		
		return
	end
	
	local TargetPos = TargetPoint - (MoveDir * Distance)
	
	local xDif = math.abs(ShootPos[1] - TargetPos[1])
	local yDif = math.abs(ShootPos[2] - TargetPos[2])
	local zDif = math.abs(ShootPos[3] - TargetPos[3])
	
	local speedMult = 3 + ( (xDif + yDif) * 0.5) ^ 1.01
	local vertMult = math.max((math.Max(300 - (xDif + yDif), -10) * 0.08) ^ 1.01 + (zDif / 2), 0)
	
	if kidnapper:GetGroundEntity() == ply then
		vertMult = - vertMult
	end
	
	local TargetVel = (TargetPos - ShootPos):GetNormal() * 10
	TargetVel[1] = TargetVel[1] * speedMult
	TargetVel[2] = TargetVel[2] * speedMult
	TargetVel[3] = TargetVel[3] * vertMult
	local dir = mv:GetVelocity()
	
	local clamp = 50
	local vclamp = 20
	local accel = 200
	local vaccel = 30 * (vertMult / 50)
	
	dir[1] = (dir[1] > TargetVel[1] - clamp or dir[1] < TargetVel[1] + clamp) and math.Approach(dir[1], TargetVel[1], accel) or dir[1]
	dir[2] = (dir[2] > TargetVel[2] - clamp or dir[2] < TargetVel[2] + clamp) and math.Approach(dir[2], TargetVel[2], accel) or dir[2]
	
	if ShootPos[3] < TargetPos[3] then
		dir[3] = (dir[3] > TargetVel[3] - vclamp or dir[3] < TargetVel[3] + vclamp) and math.Approach(dir[3], TargetVel[3], vaccel) or dir[3]
	end
	
	mv:SetVelocity( dir )

	local target = ply.ixDraggedTarget
	if IsValid(target) and ( ply == target.ixDraggedBy ) then
		target:SetAngles(ply:GetAngles())
	end
end