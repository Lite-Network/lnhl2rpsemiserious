ENT.Type = "anim"
ENT.PrintName = "Safebox"
ENT.Category = "IX:HL2RP"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.bNoPersist = true

if ( SERVER ) then
	function ENT:Initialize()
		self:SetModel("models/props_forest/footlocker01_closed.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)

		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(true)
			physObj:Wake()
		end
	end

	function ENT:SpawnFunction(ply, trace)
		local angles = ply:GetAngles()
	
		local entity = ents.Create("ix_safebox")
		entity:SetPos(trace.HitPos)
		entity:SetAngles(Angle(0, (entity:GetPos() - ply:GetPos()):Angle().y - 180, 0))
		entity:Spawn()
		entity:Activate()
	
		return entity
	end

	function ENT:Use(activator)
		if (CurTime() < (activator.ixNextOpen or 0)) then
			return
		end

		if ( activator:IsCombine() or activator:IsCA() ) then
			activator:Notify("You are a Combine, you cannot use safeboxes!")
			return
		end

		if (GetGlobalBool("ixCTStatus", false) == true) then
			activator:Notify("During a City Turmoil, you cannot open safeboxes!")
			return
		elseif (GetGlobalBool("ixJWStatus", false) == true) then
			activator:Notify("During a Judgement Waiver, you cannot open safeboxes!")
			return
		elseif (GetGlobalBool("ixAJStatus", false) == true) then
			activator:Notify("During a Autonomous Waiver, you cannot open safeboxes!")
			return
		elseif not ((activator.ixCombatPeriod or 0) < CurTime()) then
			activator:Notify("You cannot open your safebox due to you getting damaged before!")
			return
		end

		local openTime = ix.config.Get("safeboxOpenTime", 1)

		ix.safebox.Restore(activator, function()
			if (openTime > 0) then
				activator:SetAction("@storageSearching", openTime)
				activator:DoStaredAction(self, function()
					if (IsValid(activator) and activator:Alive()) then
						net.Start("ixSafeboxOpen")
						net.Send(activator)
					end
				end, openTime, function()
					if (IsValid(activator)) then
						activator:SetAction()
					end
				end)
			else
				net.Start("ixSafeboxOpen")
				net.Send(activator)
			end
		end)

		activator.ixNextOpen = CurTime() + 1
	end
end