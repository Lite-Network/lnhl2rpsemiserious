AddCSLuaFile()

ENT.Base 			= "base_gmodentity"
ENT.Type 			= "anim"
ENT.PrintName		= "Ration Machine"
ENT.Author			= "Riggs Mackay"
ENT.Purpose			= "A Machine which dispenses rations, each ration you have to wait to gain another."
ENT.Instructions	= "Press E"
ENT.Category 		= "IX:HL2RP"

ENT.AutomaticFrameAdvance = true
ENT.Spawnable = true
ENT.AdminOnly = true

if (CLIENT) then
	function ENT:OnPopulateEntityInfo(container)
	   local EntityName = container:AddRow("EntityName")
	   EntityName:SetImportant()
	   EntityName:SetText(self.PrintName)
	   EntityName:SizeToContents()

	   local EntityDescription = container:AddRow("EntityDescription")
	   EntityDescription:SetText(self.Purpose)
	   EntityDescription:SizeToContents()
    end
end

function ENT:SetupDataTables()
	self:NetworkVar("Float", 0, "RationTime")
	self:NetworkVar("Float", 1, "FlashTime")
	self:NetworkVar("Bool", 0, "Locked")
end

function ENT:IsLocked()
	return self:GetLocked()
end

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/props_junk/watermelon01.mdl")
	
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:SetSolid(SOLID_VPHYSICS)
	
		self.dispenser = ents.Create("prop_dynamic")
		self.dispenser:DrawShadow(false)
		self.dispenser:SetAngles(self:GetAngles())
		self.dispenser:SetParent(self)
		self.dispenser:SetModel("models/props_combine/combine_dispenser.mdl")
		self.dispenser:SetPos(self:GetPos())
		self.dispenser:Spawn()
	
		self:DeleteOnRemove(self.dispenser)
	
		local minimum = Vector(-8, -8, -8)
		local maximum = Vector(8, 8, 64)
	
		self:SetCollisionBounds(minimum, maximum)
		self:SetCollisionGroup(COLLISION_GROUP_WORLD)
		self:PhysicsInitBox(minimum, maximum)
		self:DrawShadow(false)
	end
	
	function ENT:UpdateTransmitState()
		return TRANSMIT_ALWAYS
	end
	
	function ENT:Toggle()
		if (self:IsLocked()) then
			self:Unlock()
		else
			self:Lock()
		end
	end
	
	function ENT:Lock()
		self:SetLocked(true)
		self:EmitRandomSound()
	end
	
	function ENT:Unlock()
		self:SetLocked(false)
		self:EmitRandomSound()
	end
	
	function ENT:SetFlashDuration(duration)
		self:EmitSound("buttons/combine_button_locked.wav", 80)
		self:SetFlashTime(CurTime() + duration)
	end
	
	function ENT:CreateDummyRation()
		local forward = self:GetForward() * 15
		local right = self:GetRight() * 0
		local up = self:GetUp() * -8
	
		local entity = ents.Create("prop_physics")
	
		entity:SetAngles(self:GetAngles())
		entity:SetModel("models/weapons/w_package.mdl")
		entity:SetPos(self:GetPos() + forward + right + up)
		entity:Spawn()
	
		return entity
	end
	
	function ENT:ActivateRation(activator, duration, force)
		local char = activator:GetCharacter()
		local curTime = CurTime()
	
		if (!duration) then duration = 6 end
	
		if (force or !self.nextActivateRation or curTime >= self.nextActivateRation) then
			self.nextActivateRation = curTime + duration + 2
			self:SetRationTime(curTime + duration)
	
			timer.Create("ration_" .. self:EntIndex(), duration, 1, function()
				if (!IsValid(self)) then return end
	
				local dispenser = self.dispenser
				local entity = self:CreateDummyRation()
	
				if (!IsValid(entity)) then return end
	
				entity:EmitSound("ambient/machines/combine_terminal_idle4.wav")
	
				entity:SetNotSolid(true)
				entity:SetParent(dispenser)
	
				timer.Simple(0, function()
					if !(IsValid(self) and IsValid(entity)) then return end
	
					entity:Fire("SetParentAttachment", "package_attachment", 0)
	
					timer.Simple(0, function()
						if !(IsValid(self) and IsValid(entity)) then return end
	
						dispenser:Fire("SetAnimation", "dispense_package", 0)
	
						timer.Simple(1.75, function()
							if !(IsValid(self) and IsValid(entity)) then return end
	
							local position = entity:GetPos()
							local angles = entity:GetAngles()
	
							entity:CallOnRemove("CreateRation", function()
								if (IsValid(activator)) then
									ix.item.Spawn("ration", position, nil, angles)
								end
							end)
	
							entity:SetNoDraw(true)
							entity:Remove()
						end)
					end)
				end)
			end)
		end
	end
	
	function ENT:EmitRandomSound()
		local randomSounds = {
			"buttons/combine_button1.wav",
			"buttons/combine_button2.wav",
			"buttons/combine_button3.wav",
			"buttons/combine_button5.wav",
			"buttons/combine_button7.wav"
		}
	
		self:EmitSound(randomSounds[ math.random(1, #randomSounds) ])
	end
	
	function ENT:PhysicsUpdate(physicsObject)
		if (!self:IsPlayerHolding() and !self:IsConstrained()) then
			physicsObject:SetVelocity(Vector(0, 0, 0))
			physicsObject:Sleep()
		end
	end
	
	function ENT:Use(activator, caller)
		local char = activator:GetCharacter()
		if (activator:IsPlayer() and activator:GetEyeTraceNoCursor().Entity == self) then
			local curTime = CurTime()
			local unixTime = os.time()
	
			if (!self.nextUse or curTime >= self.nextUse) then
				if (!self:IsLocked() and unixTime >= char:GetData("NextRation", 0)) then
					if (!self.nextActivateRation or curTime >= self.nextActivateRation) then
						self:ActivateRation(activator)

						char:SetData("NextRation", unixTime + 3600)
					end
				else
					self:SetFlashDuration(3)
				end
	
				self.nextUse = curTime + 3
			end
		end
	end
	
	function ENT:CanTool(player, trace, tool)
		return false
	end
else
	local glowMaterial = Material("sprites/glow04_noz")

	function ENT:Draw()
		local _, _, _, a = self:GetColor()
		local rationTime = self:GetRationTime()
		local flashTime = self:GetFlashTime()
		local position = self:GetPos()
		local angles = self:GetAngles()
		local forward = self:GetForward() * 10
		local curTime = CurTime()
		local right = self:GetRight()
		local up = self:GetUp() * 22
	
		if (rationTime > curTime) then
			local glowColor = Color(0, 0, 255, a)
			local timeLeft = rationTime - curTime
	
			if (!self.nextFlash or curTime >= self.nextFlash or (self.flashUntil and self.flashUntil > curTime)) then
				cam.Start3D()
					render.SetMaterial(glowMaterial)
					render.DrawSprite(position + self:GetForward() * 10 + self:GetRight() * -1.5 + self:GetUp() * 22, 20, 20, glowColor)
				cam.End3D()
	
				if (!self.flashUntil or curTime >= self.flashUntil) then
					self.nextFlash = curTime + (timeLeft / 4)
					self.flashUntil = curTime + (FrameTime() * 4)
					self:EmitSound("buttons/blip1.wav", 80)
				end
			end
		else
			local glowColor = Color(0, 255, 0, a)
	
			if (self:IsLocked()) then
				glowColor = Color(255, 150, 0, a)
			end
	
			if (flashTime and flashTime >= curTime) then
				glowColor = Color(255, 0, 0, a)
			end
	
			cam.Start3D()
				render.SetMaterial(glowMaterial)
				render.DrawSprite(position + self:GetForward() * 10 + self:GetRight() * -1.5 + self:GetUp() * 22, 20, 20, glowColor)
			cam.End3D()
		end
	end
end