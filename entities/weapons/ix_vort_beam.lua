if (CLIENT) then
	SWEP.DrawAmmo			= true
	SWEP.PrintName			= "Vortigaunt Beam"
	SWEP.Author				= "JohnyReaper & Riggs Mackay"
	SWEP.DrawCrosshair		= true
	SWEP.ViewModelFOV		= 60

	SWEP.Purpose		= "Zap everything! Vortigaunt Style"
	SWEP.Instructions	= "Primary: Vortigaunt zap.\nSecondary: Self battery healing."
end

SWEP.Category				= "IX:HL2RP" 
SWEP.Slot					= 5
SWEP.SlotPos				= 5
SWEP.Weight					= 5
SWEP.Spawnable     			= true
SWEP.AdminSpawnable  		= true
 
SWEP.ViewModel 				= ""
SWEP.WorldModel 			= ""
SWEP.HoldType 				= "beam"

SWEP.Range					= 2400
SWEP.DamageForce			= 48000	 --12000 is the force done by two vortigaunts claws zap attack
SWEP.AmmoPerUse				= 1		 --we use ar2 altfire ammo,don't exagerate here	
SWEP.HealSound				= Sound("NPC_Vortigaunt.SuitOn")
SWEP.HealLoop				= Sound("NPC_Vortigaunt.StartHealLoop")
SWEP.AttackLoop				= Sound("NPC_Vortigaunt.ZapPowerup")
SWEP.AttackSound			= Sound("npc/vort/attack_shoot.wav")
SWEP.HealDelay				= 1		--we heal again CurTime()+self.HealDelay
SWEP.MaxArmor				= 18	--used for the math.random
SWEP.MinArmor				= 12	--"		"	"	"
SWEP.ArmorLimit				= 100	--100 is the default hl2 armor limit
SWEP.BeamDamage				= 25	
SWEP.BeamChargeTime			= 0.5	--the delay used to charge the beam and zap!
SWEP.Deny					= Sound("Buttons.snd19")			

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Ammo 			= false
SWEP.Primary.Automatic		= false

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Ammo 		= false
SWEP.Secondary.Automatic 	= false

function SWEP:Initialize()
	self.Charging = false
	self.Healing = false
	self.HealTime = CurTime()
	self.ChargeTime = CurTime()
	self:SetWeaponHoldType("beam")

	if ( SERVER ) then
		self:CreateSounds()
	end
end

function SWEP:Think()
	if ( self:GetOwner() == FACTION_VORTIGAUNT ) then
		self:Remove()
	end
end

function SWEP:Precache()
	PrecacheParticleSystem("vortigaunt_beam")
	PrecacheParticleSystem("vortigaunt_beam_charge")
	PrecacheParticleSystem("vortigaunt_charge_token")
	PrecacheParticleSystem("vortigaunt_charge_token_b")
	PrecacheParticleSystem("vortigaunt_charge_token_c")

	util.PrecacheModel(self.ViewModel)
end

function SWEP:CreateSounds()
	if not (self.ChargeSound) then
		self.ChargeSound = CreateSound(self.Weapon, self.AttackLoop)
	end

	if not (self.HealingSound) then
		self.HealingSound = CreateSound(self.Weapon, self.HealLoop)
	end
end

function SWEP:Deploy()
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	self:SetDeploySpeed(1)

	return true
end

function SWEP:DispatchEffect(effectstring)
	local ply = self.Owner
	
	if not (ply) then
		return
	end

	local view
	if (CLIENT) then
		view = GetViewEntity()
	else
		view = ply:GetViewEntity()
	end

	ParticleEffectAttach(effectstring, PATTACH_POINT_FOLLOW, ply, ply:LookupAttachment("rightclaw"))
	ParticleEffectAttach(effectstring, PATTACH_POINT_FOLLOW, ply, ply:LookupAttachment("leftclaw"))
end

function SWEP:ShootEffect(effectstring, startpos, endpos)
	local ply = self.Owner

	if not (ply) then
		return
	end

	local view
	if (CLIENT) then
		view = GetViewEntity()
	else
		view = ply:GetViewEntity()
	end

	startpos = ply:GetAttachment(ply:LookupAttachment("rightclaw")).Pos
	util.ParticleTracerEx(effectstring, startpos, endpos, true, ply:EntIndex(), ply:LookupAttachment("rightclaw"))
end
	
function SWEP:ImpactEffect(traceHit)
	local data = EffectData()
	data:SetOrigin(traceHit.HitPos)
	data:SetNormal(traceHit.HitNormal)
	data:SetScale(20)
	util.Effect("StunstickImpact", data)

	local rand = math.random(1, 1.5)
	self:CreateBlast(rand, traceHit.HitPos)
	self:CreateBlast(rand, traceHit.HitPos)			

	if ( SERVER ) and traceHit.Entity and IsValid(traceHit.Entity) and string.find(traceHit.Entity:GetClass(), "ragdoll") then
		traceHit.Entity:Fire("StartRagdollBoogie")
	end
end

function SWEP:CreateBlast(scale, pos)
	if (CLIENT) then
		return
	end

	local blastspr = ents.Create("env_sprite")
	blastspr:SetPos(pos)
	blastspr:SetKeyValue("model", "sprites/vortring1.vmt")
	blastspr:SetKeyValue("scale", tostring(scale))
	blastspr:SetKeyValue("framerate",60)
	blastspr:SetKeyValue("spawnflags", "1")
	blastspr:SetKeyValue("brightness", "255")
	blastspr:SetKeyValue("angles", "0 0 0")
	blastspr:SetKeyValue("rendermode", "9")
	blastspr:SetKeyValue("renderamt", "255")
	blastspr:Spawn()
	blastspr:Fire("kill", "", 0.45)
end	

function SWEP:Shoot(dmg, effect)
	local ply = self.Owner
	if !ply then return end

	local traceres = util.QuickTrace(self.Owner:EyePos(), self.Owner:GetAimVector() * self.Range, self.Owner)
	self:ShootEffect(effect or "vortigaunt_beam",ply:EyePos(), traceres.HitPos)

	if ( SERVER ) then
		if IsValid(traceres.Entity) then
			local DMG = DamageInfo()
			DMG:SetDamageType(DMG_SHOCK)
			DMG:SetDamage(dmg or self.BeamDamage)
			DMG:SetAttacker(self.Owner)
			DMG:SetInflictor(self)
			DMG:SetDamagePosition(traceres.HitPos)
			DMG:SetDamageForce(ply:GetAimVector() * self.DamageForce)

			traceres.Entity:TakeDamageInfo(DMG)
		end
	end

	self.Weapon:EmitSound(self.AttackSound)
	self:ImpactEffect(traceres)
end

function SWEP:Holster(wep)
	self:StopEveryThing()
	return true
end

function SWEP:OnRemove()
	self:StopEveryThing()
end

function SWEP:StopEveryThing()
	self.Charging = false

	if ( SERVER ) and self.ChargeSound then
		self.ChargeSound:Stop()
	end

	self.Healing = false

	if ( SERVER ) and self.HealingSound then
		self.HealingSound:Stop()
	end

	local ply = self.LastOwner
	if not (ply) then
		return
	end
	
	local Weapon = self.Weapon

	if not (ply:GetViewModel()) then
		return
	end

	if (CLIENT) then
		if (ply == LocalPlayer()) then
			ply:GetViewModel():StopParticles()
		end
	end

	ply:StopParticles()
end

function SWEP:PrimaryAttack()
	if self.Owner:Health() <= 30 then 
		if ( SERVER ) then
			self.Owner:Notify("You are too weak to perfom a zap attack!")
		end
		self.Weapon:SetNextPrimaryFire(CurTime() + 2)
		return
	end
	
	self:DispatchEffect("vortigaunt_charge_token_b")
	self:DispatchEffect("vortigaunt_charge_token_c")

	self.ChargeTime = CurTime() + self.BeamChargeTime

	self.Weapon:SendWeaponAnim(ACT_VM_RELOAD)
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	timer.Simple(0.5,function()
		if IsValid(self.Owner:GetViewModel()) then
			self.Owner:GetViewModel():StopParticles()
		end

		self.Owner:StopParticles()
		
		if not (self.Owner:Alive()) then return end

		self:Shoot()
		self.Weapon:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
		timer.Simple(0.75,function()
			if !IsValid(self.Owner) or self.Owner:GetActiveWeapon() != self or !IsValid(self) then
				return
			end

			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		end)

		if ( SERVER ) and self.ChargeSound then	
			self.ChargeSound:Stop()
			self.Weapon:EmitSound(self.AttackSound)
		end
	end)

	if ( SERVER ) and self.ChargeSound then
		self.ChargeSound:PlayEx(100, 150)
	end

	self.Weapon:SetNextPrimaryFire(CurTime() + 2)
	self.Weapon:SetNextSecondaryFire(CurTime() + 2)
end

function SWEP:SecondaryAttack()
	if not (self.Owner:Alive()) then
		return
	end

	local eye = self.Owner:GetEyeTrace()
	if not (eye.Entity:IsPlayer()) then
		return
	end

	if self.Owner:Health() <= 30 then
		if ( SERVER ) then
			self.Owner:Notify("You are too weak to heal someone!")
			self:SetNextSecondaryFire(CurTime() + 2)
		end
		return
	end

	local target = eye.Entity
	if (target:GetPos():Distance(self.Owner:GetShootPos()) > 100) then
		return
	end

	if target:Health() >= target:GetMaxHealth() then 
		if ( SERVER ) then
			self.Owner:Notify(target:Nick().." is perfectly healthy!")
			self:SetNextSecondaryFire(CurTime() + 2)
		end

		return
	end

	self:DispatchEffect("vortigaunt_charge_token")

	if ( SERVER ) then
		self.Owner:ForceSequence("vort_chantloop", nil, 2)

		self.Owner:EmitSound("npc/vort/health_charge.wav", 100, 150, 1, CHAN_AUTO)
		self.Owner:Freeze(true)
	end

	if ( SERVER ) then
		self.Owner:SetAction("Healing "..target:Nick().."..", 2, function()
			self.Owner:StopParticles()

			if not (self.Owner:Alive()) then
				return
			end

			if target:GetPos():Distance(self.Owner:GetShootPos()) <= 100 then
				local randomNum = math.random(ix.config.Get("VortHealMin", 5),ix.config.Get("VortHealMax", 20))
				target:SetHealth(math.Clamp(target:Health() + randomNum, 0, target:GetMaxHealth()))

				self.Owner:StopSound("npc/vort/health_charge.wav")
				self.Owner:EmitSound("npc/vort/vort_attack_shoot"..math.random(1,4)..".wav")
				self.Owner:EmitSound("items/suitchargeok1.wav", 70)
				self.Owner:Freeze(false)
			else
				self.Owner:StopSound("npc/vort/health_charge.wav") 
				self.Owner:EmitSound("npc/vort/vort_attack_shoot"..math.random(1,4)..".wav")
				self.Owner:EmitSound("items/suitchargeok1.wav", 70)
				self.Owner:Freeze(false)
			end
		end)
	end

	self:SetNextSecondaryFire(CurTime() + 3)
end

function SWEP:Reload()
end