AddCSLuaFile()

SWEP.Base = "ls_base"

SWEP.PrintName = "MP7"
SWEP.Category = "IX:HL2RP"

SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.HoldType = "smg"

SWEP.WorldModel = "models/weapons/w_smg1.mdl"
SWEP.ViewModel = "models/litenetwork/weapons/c_smg1.mdl"
SWEP.ViewModelFOV = 55

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = "Weapon_SMG1.NPC_Reload"
SWEP.EmptySound = "Weapon_Pistol.Empty"

SWEP.Primary.Sound = "Weapon_SMG1.Single"
SWEP.Primary.Recoil = 0.5
SWEP.Primary.Damage = 9
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.03
SWEP.Primary.Delay = RPM(800)

SWEP.Primary.Ammo = "smg1"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 45
SWEP.Primary.DefaultClip = 45

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.Spread = {}
SWEP.Spread.Min = 0.1
SWEP.Spread.Max = 0.4
SWEP.Spread.IronsightsMod = 0.6
SWEP.Spread.CrouchMod = 0.8
SWEP.Spread.AirMod = 1.2
SWEP.Spread.RecoilMod = 0
SWEP.Spread.VelocityMod = 0.3

SWEP.IronsightsPos = Vector(-4.801, -3, 1.08)
SWEP.IronsightsAng = Angle(0, 0, 2)
SWEP.IronsightsFOV = 0.8
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = false
SWEP.IronsightsRecoilVisualMultiplier = 2