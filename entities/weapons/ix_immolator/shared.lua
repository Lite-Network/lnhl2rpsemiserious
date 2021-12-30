SWEP.Author		= "Draco_2k"
SWEP.Category		= "Ignition"
SWEP.Purpose		= "Set stuff on fire"
SWEP.Instructions		= "Left-Click: Fire\nReload: Regenerate Ammunition"
SWEP.Spawnable		= true
SWEP.AdminSpawnable	= true

SWEP.ViewModel			= "models/weapons/v_cremator.mdl"
SWEP.WorldModel			= ""

SWEP.HoldType			= "smg"
SWEP.Primary.Automatic		= true
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip		= -1
SWEP.Primary.Ammo		= "none"
SWEP.Secondary.ClipSize		= 75
SWEP.Secondary.DefaultClip		= -1
SWEP.Secondary.Automatic		= true
SWEP.Secondary.Ammo		= "ar2"

SWEP.ReloadDelay = 0


//Precache everything
function SWEP:Precache()

util.PrecacheSound("ambient/machines/keyboard2_clicks.wav")

util.PrecacheSound("ambient/machines/thumper_dust.wav")
util.PrecacheSound("ambient/fire/mtov_flame2.wav")
util.PrecacheSound("ambient/fire/ignite.wav")

util.PrecacheSound("vehicles/tank_readyfire1.wav")

end


//Primary attack
function SWEP:PrimaryAttack()

if (SERVER) then
if (self.Owner:GetAmmoCount("ar2") < 1) || (self.ReloadDelay == 1) then
self:RunoutReload()
return end
end

if (self.Owner:GetAmmoCount("ar2") > 0) && (self.ReloadDelay == 0) then

self.Owner:RemoveAmmo( 1, self.Weapon:GetSecondaryAmmoType() )

self.Owner:MuzzleFlash()

self.Weapon:SetNextPrimaryFire( CurTime() + 0.08 )

if (SERVER) then

	local trace = self.Owner:GetEyeTrace()
	local Distance = self.Owner:GetPos():Distance(trace.HitPos)

	if Distance < 520 then


	//This is how we ignite stuff
	local Ignite = function()

	//Safeguard
	if !self:IsValid() then return end

	//Damage things in radius of impact
	local flame = ents.Create("point_hurt")
	flame:SetPos(trace.HitPos)
	flame:SetOwner(self.Owner)
	flame:SetKeyValue("DamageRadius",128)
	flame:SetKeyValue("Damage",4)
	flame:SetKeyValue("DamageDelay",0.32)
	flame:SetKeyValue("DamageType",8)
	flame:Spawn()
	flame:Fire("TurnOn","",0) 
	flame:Fire("kill","",0.72)

	//Create actual fire - doesn't work very well in practice
	//if trace.HitWorld then
  	//local fire = ents.Create("env_fire")
   	//fire:SetPos(trace.HitPos + Vector(0,0, -8))
	//fire:SetAngles(Angle(0,0, math.random(-360, 360)))
	//fire:SetKeyValue("health", 1)
	//fire:SetKeyValue("firesize", math.random(82,128))
	//fire:SetKeyValue("fireattack", tostring(math.random(0.72,1.32)))
	//fire:SetKeyValue("damagescale", 8)
	//fire:SetKeyValue("spawnflags","178") //162
	//fire:Spawn()
	//fire:Activate()
	//fire:Fire("StartFire","", 0)
	//end

	if trace.HitWorld then
	local nearbystuff = ents.FindInSphere(trace.HitPos, 100)

	for _, stuff in pairs(nearbystuff) do

	if stuff != self.Owner then

	if stuff:GetPhysicsObject():IsValid() && !stuff:IsNPC() && !stuff:IsPlayer() then
	if !stuff:IsOnFire() then stuff:Ignite(math.random(16,32), 100) end end

	if stuff:IsPlayer() then
	if stuff:GetPhysicsObject():IsValid() then
	stuff:Ignite(1, 100) end end

	if stuff:IsNPC() then
	if stuff:GetPhysicsObject():IsValid() then
	local npc = stuff:GetClass()
	if npc == "npc_antlionguard" || npc == "npc_hunter" || npc == "npc_kleiner"
	|| npc == "npc_gman" || npc == "npc_eli" || npc == "npc_alyx"
	|| npc == "npc_mossman" || npc == "npc_breen" || npc == "npc_monk"
	|| npc == "npc_vortigaunt" || npc == "npc_citizen" || npc == "npc_rebel"
	|| npc == "npc_barney" || npc == "npc_magnusson" then
	stuff:Fire("Ignite","",1)
	end
	stuff:Ignite(math.random(12,16), 100) end end

	end
	end
	end

	if trace.Entity:IsValid() then

	if trace.Entity:GetPhysicsObject():IsValid() && !trace.Entity:IsNPC() && !trace.Entity:IsPlayer() then
	if !trace.Entity:IsOnFire() then trace.Entity:Ignite(math.random(16,32), 100) end end

	if trace.Entity:IsPlayer() then
	if trace.Entity:GetPhysicsObject():IsValid() then
	trace.Entity:Ignite(math.random(1,2), 100) end end

	if trace.Entity:IsNPC() then
	if trace.Entity:GetPhysicsObject():IsValid() then
	local npc = trace.Entity:GetClass()
	if npc == "npc_antlionguard" || npc == "npc_hunter" || npc == "npc_kleiner"
	|| npc == "npc_gman" || npc == "npc_eli" || npc == "npc_alyx"
	|| npc == "npc_mossman" || npc == "npc_breen" || npc == "npc_monk"
	|| npc == "npc_vortigaunt" || npc == "npc_citizen" || npc == "npc_rebel"
	|| npc == "npc_barney" || npc == "npc_magnusson" then
	trace.Entity:Fire("Ignite","",1)
	end
	trace.Entity:Ignite(math.random(12,16), 100) end end

	end

	if (SERVER) then
	local firefx = EffectData()
	firefx:SetOrigin(trace.HitPos)
	util.Effect("swep_flamethrower_explosion",firefx,true,true)
	end

	end


	//Ignite stuff; based on how long it takes for flame to reach it
	timer.Simple(Distance/1520, Ignite)

	end

end
end
end


//Unused
function SWEP:SecondaryAttack()
end


//Play a nice sound on deployment
function SWEP:Deploy()
self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
if (SERVER) then
self.Owner:EmitSound( "ambient/machines/keyboard2_clicks.wav", 42, 100 )
end
return true
end


//Think function
function SWEP:Think()

if self.Owner:KeyReleased(IN_ATTACK) && (self.Owner:GetAmmoCount("ar2") > 1) && (self.ReloadDelay != 1) then
if (SERVER) then
self.Owner:EmitSound( "ambient/fire/mtov_flame2.wav", 24, 100 )
end
end

if (self.Owner:GetAmmoCount("ar2") > 0) && (self.ReloadDelay == 0) then

if self.Owner:KeyPressed(IN_ATTACK) then
if (SERVER) then
self.Owner:EmitSound( "ambient/machines/thumper_dust.wav", 46, 100 )
end
end

if self.Owner:KeyDown(IN_ATTACK) then
if (SERVER) then
self.Owner:EmitSound( "ambient/fire/mtov_flame2.wav", math.random(27,35), math.random(32,152) )
end
local trace = self.Owner:GetEyeTrace()
if (SERVER) then
local flamefx = EffectData()
flamefx:SetOrigin(trace.HitPos)
flamefx:SetStart(self.Owner:GetShootPos())
flamefx:SetAttachment(1)
flamefx:SetEntity(self.Weapon)
util.Effect("swep_flamethrower_flame",flamefx,true,true)
end
end

end
end


//Reload function
function SWEP:Reload()

if (self.Owner:GetAmmoCount("ar2") > 74) || (self.ReloadDelay == 1) then return end

self.ReloadDelay = 1

if (SERVER) then
self.Owner:EmitSound( "vehicles/tank_readyfire1.wav", 30, 100 )
end

timer.Simple(1.82, function() if self:IsValid() then self:ReloadSelf() end end)

end


//How to reload if running out of ammo
function SWEP:RunoutReload()

if (self.Owner:GetAmmoCount("ar2") > 74) || (self.ReloadDelay == 1) then return end

self.ReloadDelay = 1

if (SERVER) then
self.Owner:EmitSound( "ambient/machines/thumper_dust.wav", 48, 100 )
self.Owner:EmitSound( "vehicles/tank_readyfire1.wav", 30, 100 )
end

timer.Simple(1.82, function() if self:IsValid() then self:ReloadSelf() end end)

end


//Finish reloading
function SWEP:ReloadSelf()

//Safeguards
if !self then return end
if !self:IsValid() then return end

if (SERVER) then
local ammo = math.Clamp( (75 - self.Owner:GetAmmoCount("ar2")), 0, 75)
self.Owner:GiveAmmo(ammo, "ar2")
end
self.ReloadDelay = 0
if self.Owner:KeyDown(IN_ATTACK) then
if (SERVER) then
self.Owner:EmitSound( "ambient/machines/thumper_dust.wav", 46, 100 )
end
end

end