AddCSLuaFile()

SWEP.Base = "ls_base"

SWEP.PrintName = "Combine Sniper Rifle"
SWEP.Category = "IX:HL2RP"

SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.HoldType = "ar2"

SWEP.WorldModel = "models/weapons/w_combinesniper_e2.mdl"
SWEP.ViewModel = "models/weapons/combine_sniper_weapon.mdl"
SWEP.ViewModelFOV = 50

SWEP.Slot = 3
SWEP.SlotPos = 2

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = "npc/sniper/reload1.wav"
SWEP.EmptySound = "Weapon_AR2.Empty"

SWEP.Primary.Sound = "sniper/shot.wav"
SWEP.Primary.Recoil = 10
SWEP.Primary.Damage = 70
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0
SWEP.Primary.Delay = RPM(50)
SWEP.Primary.Tracer = "AR2Tracer"

SWEP.Primary.Ammo = "SniperPenetratedRound"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 6
SWEP.Primary.DefaultClip = 6

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 5
SWEP.Spread.IronsightsMod = 0.7
SWEP.Spread.CrouchMod = 0.7
SWEP.Spread.AirMod = 1.4
SWEP.Spread.RecoilMod = 0.1
SWEP.Spread.VelocityMod = 0.16

SWEP.UseIronsightsRecoil = false

SWEP.IronsightsPos = Vector(-5.64, -50, 0.639)
SWEP.IronsightsAng = Angle(0, 0, 0)
SWEP.IronsightsFOV = 0.2
SWEP.IronsightsSensitivity = 0.2
SWEP.IronsightsCrosshair = true
SWEP.IronsightsRecoilVisualMultiplier = 4
SWEP.IronsightsMuzzleFlash = "AirboatMuzzleFlash"

function SWEP:DrawHUD()
    if self:GetIronsights() then
        if not CombineSniperOverlay then
            CombineSniperOverlay = ix.util.GetMaterial("effects/combine_binocoverlay")
            CombineSniperOverlay:Recompute()
        end

        surface.SetDrawColor(Color(255, 255, 255, 255))
        surface.SetMaterial(CombineSniperOverlay)
        surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
    end
end

function SWEP:ShootBullet(damage, num_bullets, aimcone)
	local bullet = {}

	bullet.Num 	= num_bullets
	bullet.Src 	= self.Owner:GetShootPos() -- Source
	bullet.Dir 	= self.Owner:GetAimVector() -- Dir of bullet
	bullet.Spread 	= Vector(aimcone, aimcone, 0)	-- Aim Cone

	if self.Primary.Tracer then
		bullet.TracerName = self.Primary.Tracer
	end

	if self.Primary.Range then
		bullet.Distance = self.Primary.Range
	end

	bullet.Tracer	= 1 -- Show a tracer on every x bullets
	bullet.Force	= 1 -- Amount of force to give to phys objects
	bullet.Damage	= damage
	bullet.AmmoType = ""

	if CLIENT then
		bullet.Callback = function(attacker, tr)
			debugoverlay.Cross(tr.HitPos, 2, 3, Color(255, 0, 0), true)
		end
	end

	self.Owner:FireBullets(bullet)

	self:ShootEffects()

    self.Owner:EmitSound("npc/sniper/sniper1.wav", 90)
end

sound.Add({
    name = "clipout_com",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    sound = "sniper/magout.wav"
})

sound.Add({
    name = "clipin_com",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    sound = "sniper/magin.wav"
})

sound.Add({
    name = "boltpull_com",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    sound = "npc/sniper/reload1.wav"
})

sound.Add({
    name = "deploy_com",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    sound = "sniper/foley.wav"
})