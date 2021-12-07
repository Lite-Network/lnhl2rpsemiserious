AddCSLuaFile()

sound.Add({
    name = "ixSPAS12.Fire",
	channel = CHAN_WEAPON,
	volume = 1.0,
    level = 80,
	pitch = {95, 110},
    sound = "weapons/shotgun/shotgun_fire.wav",
})

SWEP.Base = "ls_base_shotgun"

SWEP.PrintName = "SPAS-12"
SWEP.Category = "IX:HL2RP"

SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.HoldType = "shotgun"

SWEP.WorldModel = "models/weapons/w_shotgun.mdl"
SWEP.ViewModel = "models/litenetwork/weapons/c_shotgun.mdl"
SWEP.ViewModelFOV = 55

SWEP.Slot = 3
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = false

SWEP.ReloadShellSound = "Weapon_Shotgun.Reload"
SWEP.EmptySound = "Weapon_Shotun.Empty"

SWEP.Primary.Sound = "ixSPAS12.Fire"
SWEP.Primary.Recoil = 5
SWEP.Primary.Damage = 10
SWEP.Primary.NumShots = 6
SWEP.Primary.Cone = 0.069
SWEP.Primary.Delay = RPM(80)

SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 6
SWEP.Primary.DefaultClip = 6

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.Spread = {}
SWEP.Spread.Min = 0.069
SWEP.Spread.Max = 0.2
SWEP.Spread.IronsightsMod = 1
SWEP.Spread.CrouchMod = 1
SWEP.Spread.AirMod = 2
SWEP.Spread.RecoilMod = 0.01
SWEP.Spread.VelocityMod = 0.15

SWEP.UseIronsightsRecoil = false

SWEP.IronsightsPos = Vector(0.4, 0, 1.08)
SWEP.IronsightsAng = Angle(2.469, 0.991, 0)
SWEP.IronsightsFOV = 0.8
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = false
SWEP.IronsightsRecoilVisualMultiplier = 15