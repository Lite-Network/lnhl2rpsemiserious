AddCSLuaFile()

SWEP.Base = "ls_base"

SWEP.PrintName = "Pulse-Rifle"
SWEP.Category = "IX:HL2RP"

SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.HoldType = "ar2"

SWEP.WorldModel = "models/weapons/w_irifle.mdl"
SWEP.ViewModel = "models/litenetwork/weapons/c_ar2.mdl"
SWEP.ViewModelFOV = 60

SWEP.Slot = 4
SWEP.SlotPos = 2

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = "Weapon_AR2.NPC_Reload"
SWEP.EmptySound = "Weapon_AR2.Empty"

SWEP.Primary.Sound = "Weapon_AR2.Single"
SWEP.Primary.Recoil = 0.8
SWEP.Primary.Damage = 15
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.01
SWEP.Primary.Delay = RPM(652)
SWEP.Primary.Tracer = "AR2Tracer"

SWEP.Primary.Ammo = "ar2"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 0.03
SWEP.Spread.IronsightsMod = 0.7
SWEP.Spread.CrouchMod = 0.7
SWEP.Spread.AirMod = 1.4
SWEP.Spread.RecoilMod = 0.1
SWEP.Spread.VelocityMod = 0.16

SWEP.UseIronsightsRecoil = false

SWEP.IronsightsPos = Vector(-2.201, 0, 1)
SWEP.IronsightsAng = Angle(1.615, 2.507, -7.7)
SWEP.IronsightsFOV = 0.7
SWEP.IronsightsSensitivity = 0.6
SWEP.IronsightsCrosshair = true
SWEP.IronsightsRecoilVisualMultiplier = 4
SWEP.IronsightsMuzzleFlash = "AirboatMuzzleFlash"