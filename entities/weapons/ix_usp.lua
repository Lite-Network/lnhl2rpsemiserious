AddCSLuaFile()

sound.Add({
    name = "ixUSP.Fire",
	channel = CHAN_WEAPON,
	volume = 1.0,
    level = 80,
	pitch = {95, 110},
    sound = {
        "weapons/pistol/player_pistol_fire1.wav",
        "weapons/pistol/player_pistol_fire2.wav",
        "weapons/pistol/player_pistol_fire3.wav",
    },
})

SWEP.Base = "ls_base"

SWEP.PrintName = "USP Match Pistol"
SWEP.Category = "IX:HL2RP"

SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.HoldType = "revolver"

SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.ViewModel = "models/litenetwork/weapons/c_pistol.mdl"
SWEP.ViewModelFOV = 55

SWEP.Slot = 1
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = "Weapon_Pistol.NPC_Reload"
SWEP.EmptySound = "Weapon_Pistol.Empty"

SWEP.Primary.Sound = "ixUSP.Fire"
SWEP.Primary.Recoil = 0.6
SWEP.Primary.Damage = 13
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.018
SWEP.Primary.Delay = RPM(425)

SWEP.Primary.Ammo = "pistol"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 18
SWEP.Primary.DefaultClip = 18

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.Spread = {}
SWEP.Spread.Min = 0.008
SWEP.Spread.Max = 0.1
SWEP.Spread.IronsightsMod = 0.9
SWEP.Spread.CrouchMod = 1
SWEP.Spread.AirMod = 2
SWEP.Spread.RecoilMod = 0
SWEP.Spread.VelocityMod = 1.025

SWEP.UseIronsightsRecoil = false

SWEP.IronsightsPos = Vector(-2.36, -5, 2.68)
SWEP.IronsightsAng = Angle(1.71, 1.855, -8.058)
SWEP.IronsightsFOV = 0.8
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = false
SWEP.IronsightsRecoilVisualMultiplier = 2