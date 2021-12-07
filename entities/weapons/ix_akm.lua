AddCSLuaFile()

sound.Add({
    name = "ixAKM.Fire",
	channel = CHAN_WEAPON,
	volume = 1.0,
    level = 80,
	pitch = {95, 110},
    sound = "weapons/tfa_nam_ak47b/ak47_fp.wav",
})

sound.Add({
    name = "Weapon_AK47B.MagRelease",
    channel = CHAN_ITEM,
    volume = VOL_NORM,
    soundlevel = SNDLVL_NORM,
    sound = "weapons/tfa_nam_ak47b/ak47_magrelease.wav"
})
sound.Add({
    name = "Weapon_AK47B.Boltrelease",
    channel = CHAN_ITEM,
    volume = VOL_NORM,
    soundlevel = SNDLVL_NORM,
    sound = "weapons/tfa_nam_ak47b/ak47_boltrelease.wav"
})
sound.Add({
    name = "Weapon_AK47B.Magin",
    channel = CHAN_ITEM,
    volume = VOL_NORM,
    soundlevel = SNDLVL_NORM,
    sound = "weapons/tfa_nam_ak47b/ak47_magin.wav"
})
sound.Add({
    name = "Weapon_AK47B.Magout",
    channel = CHAN_ITEM,
    volume = VOL_NORM,
    soundlevel = SNDLVL_NORM,
    sound = "weapons/tfa_nam_ak47b/ak47_magout.wav"
})
sound.Add({
    name = "Weapon_AK47B.Boltback",
    channel = CHAN_ITEM,
    volume = VOL_NORM,
    soundlevel = SNDLVL_NORM,
    sound = "weapons/tfa_nam_ak47b/ak47_boltback.wav"
})
sound.Add({
    name = "Weapon_AK47B.Rattle",
    channel = CHAN_ITEM,
    volume = VOL_NORM,
    soundlevel = SNDLVL_NORM,
    sound = "weapons/tfa_nam_ak47b/ak47_rattle.wav"
})
sound.Add({
    name = "Weapon_AK47B.ROF",
    channel = CHAN_ITEM,
    volume = VOL_NORM,
    soundlevel = SNDLVL_NORM,
    sound = "weapons/tfa_nam_ak47b/ak47_fireselect_1.wav"
})
sound.Add({
    name = "Weapon_AK47B.Empty",
    channel = CHAN_ITEM,
    volume = VOL_NORM,
    soundlevel = SNDLVL_NORM,
    sound = "weapons/tfa_nam_ak47b/ak47_empty.wav"
})
sound.Add({
    name = "Weapon_AK47B.MagoutRattle",
    channel = CHAN_ITEM,
    volume = VOL_NORM,
    soundlevel = SNDLVL_NORM,
    sound = "weapons/tfa_nam_ak47b/ak47_magout_rattle.wav"
})
sound.Add({
    name = "Weapon_gp30.Select",
    channel = CHAN_ITEM,
    volume = VOL_NORM,
    soundlevel = SNDLVL_NORM,
    sound = "weapons/tfa_nam_ak47b/gp30_select.wav"
})
sound.Add({
    name = "Weapon_gp30.DeSelect",
    channel = CHAN_ITEM,
    volume = VOL_NORM,
    soundlevel = SNDLVL_NORM,
    sound = "weapons/tfa_nam_ak47b/gp30_deselect.wav"
})
sound.Add({
    name = "Weapon_gp30.GrenadeIn",
    channel = CHAN_ITEM,
    volume = VOL_NORM,
    soundlevel = SNDLVL_NORM,
    sound = "weapons/tfa_nam_ak47b/gp30_insertgrenade_01.wav"
})
sound.Add({
    name = "Weapon_gp30.GrenadeInClick",
    channel = CHAN_ITEM,
    volume = VOL_NORM,
    soundlevel = SNDLVL_NORM,
    sound = "weapons/tfa_nam_ak47b/gp30_insertgrenade_click.wav"
})

SWEP.Base = "ls_base"

SWEP.PrintName = "AKM"
SWEP.Category = "IX:HL2RP"

SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.HoldType = "ar2"

SWEP.IsINS2Weapon = true
SWEP.WorldModel = "models/weapons/w_rif_ak47.mdl"
SWEP.ViewModel = "models/weapons/v_nam_ak47.mdl"
SWEP.ViewModelFOV = 70

SWEP.Slot = 3
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = "Weapon_AK47B.MagoutRattle"
SWEP.EmptySound = "Weapon_Pistol.Empty"

SWEP.Primary.Sound = "ixAKM.Fire"
SWEP.Primary.Recoil = 0.7
SWEP.Primary.Damage = 13
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.03
SWEP.Primary.Delay = RPM(575)

SWEP.Primary.Ammo = "ixRifleAmmo"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30

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

SWEP.IronsightsPos = Vector(-2.313, -5, 0.101)
SWEP.IronsightsAng = Angle(1.042, 0, 0)
SWEP.IronsightsFOV = 0.8
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = false
SWEP.IronsightsRecoilVisualMultiplier = 1