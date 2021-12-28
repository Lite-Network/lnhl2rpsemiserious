AddCSLuaFile()

sound.Add({
    name = "ixM14.Fire",
	channel = CHAN_WEAPON,
	volume = 1.0,
    level = 80,
	pitch = {95, 110},
    sound = {
        "weapons/scout/scout_fire-1.wav",
    },
})

SWEP.Base = "ls_base"

SWEP.PrintName = "M14"
SWEP.Category = "IX:HL2RP"

SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.HoldType = "ar2"

SWEP.WorldModel = "models/weapons/w_tfa_mni14b.mdl"
SWEP.ViewModel = "models/weapons/v_tfa_mni14b.mdl"
SWEP.ViewModelFOV = 50

SWEP.Slot = 3
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = "Weapon_danger_mini14_rifle.rattle"
SWEP.EmptySound = "Weapon_danger_mini14_rifle.empty"

SWEP.Primary.Sound = "ixM14.Fire"
SWEP.Primary.Recoil = 1
SWEP.Primary.Damage = 25
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.03
SWEP.Primary.Delay = RPM(170)
SWEP.Primary.PenetrationScale = 2

SWEP.Primary.Ammo = "ixRifleAmmo"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 20
SWEP.Primary.DefaultClip = 20

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 5
SWEP.Spread.IronsightsMod = 0.2
SWEP.Spread.CrouchMod = 0.8
SWEP.Spread.AirMod = 3
SWEP.Spread.RecoilMod = 0.2
SWEP.Spread.VelocityMod = 3

SWEP.IronsightsPos = Vector(-7.211, -50, 1.009)
SWEP.IronsightsAng = Angle(-0.151, 0, 0)
SWEP.IronsightsFOV = 0.3
SWEP.IronsightsSensitivity = 0.3
SWEP.IronsightsCrosshair = false
SWEP.IronsightsRecoilVisualMultiplier = 1

if (CLIENT) then
    local soundData = {
        name 		= "Weapon_danger_mini14_rifle.Magout" ,
        channel 	= CHAN_WEAPON,
        volume 		= 0.5,
        soundlevel 	= 80,
        pitchstart 	= 100,
        pitchend 	= 100,
        sound 		= "weapons/mni14/mini14_magout.wav"
    }
    sound.Add(soundData)
    local soundData = {
        name 		= "Weapon_danger_mini14_rifle.Magin" ,
        channel 	= CHAN_WEAPON,
        volume 		= 0.5,
        soundlevel 	= 80,
        pitchstart 	= 100,
        pitchend 	= 100,
        sound 		= "weapons/mni14/mini14_magin.wav"
    }
    sound.Add(soundData)
    local soundData = {
        name 		= "Weapon_danger_mini14_rifle.Magin2" ,
        channel 	= CHAN_WEAPON,
        volume 		= 0.5,
        soundlevel 	= 80,
        pitchstart 	= 100,
        pitchend 	= 100,
        sound 		= "weapons/mni14/magin.wav"
    }
    sound.Add(soundData)
    local soundData = {
        name 		= "Weapon_danger_mini14_rifle.bolt" ,
        channel 	= CHAN_WEAPON,
        volume 		= 0.5,
        soundlevel 	= 80,
        pitchstart 	= 100,
        pitchend 	= 100,
        sound 		= "weapons/mni14/mini14_boltback.wav"
    }
    sound.Add(soundData)
    local soundData = {
        name 		= "Weapon_danger_mini14_rifle.bolt2" ,
        channel 	= CHAN_WEAPON,
        volume 		= 0.5,
        soundlevel 	= 80,
        pitchstart 	= 100,
        pitchend 	= 100,
        sound 		= "weapons/mni14/mini14_boltrelease.wav"
    }
    sound.Add(soundData)
    local soundData = {
        name 		= "Weapon_danger_mini14_rifle.rattle" ,
        channel 	= CHAN_WEAPON,
        volume 		= 0.5,
        soundlevel 	= 80,
        pitchstart 	= 100,
        pitchend 	= 100,
        sound 		= "weapons/mni14/galil_rattle.wav"
    }
    sound.Add(soundData)
    local soundData = {
        name 		= "Weapon_danger_mini14_rifle.empty" ,
        channel 	= CHAN_WEAPON,
        volume 		= 0.5,
        soundlevel 	= 80,
        pitchstart 	= 100,
        pitchend 	= 100,
        sound 		= "weapons/mni14/mini14_empty.wav"
    }
    sound.Add(soundData)    
end