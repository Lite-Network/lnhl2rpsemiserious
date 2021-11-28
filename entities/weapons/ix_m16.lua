AddCSLuaFile()

sound.Add({
    name = "ixM16.Fire",
	channel = CHAN_WEAPON,
	volume = 1.0,
    level = 80,
	pitch = {95, 110},
    sound = {
        "weapons/tigg_m16/m16_fire_01.wav",
    },
})

SWEP.Base = "ls_base"

SWEP.PrintName = "M16"
SWEP.Category = "IX:HL2RP"

SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.HoldType = "ar2"

SWEP.WorldModel = "models/weapons/w_rif_m4a1.mdl"
SWEP.ViewModel = "models/weapons/tigg/c_m16.mdl"
SWEP.ViewModelFOV = 55

SWEP.Slot = 3
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = "TFA_TIGG_M16.GenericFoley"
SWEP.EmptySound = "Weapon_Pistol.Empty"

SWEP.Primary.Sound = "ixM16.Fire"
SWEP.Primary.Recoil = 0.7
SWEP.Primary.Damage = 9
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.03
SWEP.Primary.Delay = RPM(700)

SWEP.Primary.Ammo = "ixRifleAmmo"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30

SWEP.Primary.Burst = 3

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 5
SWEP.Spread.IronsightsMod = 0.6
SWEP.Spread.CrouchMod = 0.7
SWEP.Spread.AirMod = 1.4
SWEP.Spread.RecoilMod = 0
SWEP.Spread.VelocityMod = 0.5

SWEP.IronsightsPos = Vector(-3.1, -6.5, -0.2)
SWEP.IronsightsAng = Angle(0.15, 0, 0)
SWEP.IronsightsFOV = 0.8
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = false
SWEP.IronsightsRecoilVisualMultiplier = 1

if (CLIENT) then
    sound.Add({
        name = 			"TFA_TIGG_M16.ClipOut",
        channel = 		CHAN_USER_BASE+10,
        volume = 		1.0,
        sound = 			"weapons/tigg_m16/M16_clipout.wav"
    })
    
    sound.Add({
        name = 			"TFA_TIGG_M16.ClipIn",
        channel = 		CHAN_USER_BASE+10,
        volume = 		1.0,
        sound = 			"weapons/tigg_m16/M16_clipin.wav"
    })
    
    sound.Add({
        name = 			"TFA_TIGG_M16.Slide",
        channel = 		CHAN_USER_BASE+10,
        volume = 		1.0,
        sound = 			"weapons/tigg_m16/m16_slide.wav"
    })
    
    sound.Add({
        name = 			"TFA_TIGG_M16.Slide2",
        channel = 		CHAN_USER_BASE+10,
        volume = 		1.0,
        sound = 			"weapons/tigg_m16/m16_slide2.wav"
    })
    
    sound.Add({
        name = 			"TFA_TIGG_M16.Draw",
        channel = 		CHAN_USER_BASE+10,
        volume = 		1.0,
        sound = 			"weapons/tigg_m16/draw.wav"
    })
    
    sound.Add({
        name = 			"TFA_TIGG_M16.Holster",
        channel = 		CHAN_USER_BASE+10,
        volume = 		1.0,
        sound = 			"weapons/tigg_m16/holster.wav"
    })
    
    sound.Add({
        name = 			"TFA_TIGG_M16.FireSelect",
        channel = 		CHAN_USER_BASE+10,
        volume = 		1.0,
        sound = 			"weapons/tigg_m16/gun_fire_mode.wav"
    })
    
    sound.Add({
        name = 			"TFA_TIGG_M16.GenericFoley",
        channel = 		CHAN_USER_BASE+10,
        volume = 		1.0,
        sound = 			"weapons/tigg_m16/clothes_generic_foley.wav"
    })
end