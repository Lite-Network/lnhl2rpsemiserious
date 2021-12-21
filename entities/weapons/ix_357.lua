AddCSLuaFile()

SWEP.Base = "ls_base"

SWEP.PrintName = "357 Magnum"
SWEP.Category = "IX:HL2RP"

SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.HoldType = "revolver"

SWEP.WorldModel = "models/weapons/w_357.mdl"
SWEP.ViewModel = "models/litenetwork/weapons/c_357.mdl"
SWEP.ViewModelFOV = 55

SWEP.Slot = 1
SWEP.SlotPos = 2

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = "Weapon_357.NPC_Reload"
SWEP.EmptySound = "Weapon_357.Empty"

SWEP.Primary.Sound = "Weapon_357.Single"
SWEP.Primary.Recoil = 4.8
SWEP.Primary.Damage = 40
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.02
SWEP.Primary.Delay = RPM(60)
SWEP.Primary.PenetrationScale = 2

SWEP.Primary.Ammo = "357"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 6
SWEP.Primary.DefaultClip = 6

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 0.1
SWEP.Spread.IronsightsMod = 0.4
SWEP.Spread.CrouchMod = 0.9
SWEP.Spread.AirMod = 2
SWEP.Spread.RecoilMod = 0.03
SWEP.Spread.VelocityMod = 1.8

SWEP.UseIronsightsRecoil = false

SWEP.IronsightsPos = Vector(-3.181, -5, 1.113)
SWEP.IronsightsAng = Angle(0, 0, 0)
SWEP.IronsightsFOV = 0.8
SWEP.IronsightsSensitivity = 0.7
SWEP.IronsightsCrosshair = false
SWEP.IronsightsRecoilVisualMultiplier = 0.25

SWEP.LoweredPos = Vector(0, -16, -13)
SWEP.LoweredAng = Angle(70, 0, 0)