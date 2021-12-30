include('shared.lua')

SWEP.PrintName			= "Flamethrower"	
SWEP.Slot			= 3
SWEP.SlotPos			= 3
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= true
SWEP.WepSelectIcon		= surface.GetTextureID("weapons/swep_flamethrower_d2k")
SWEP.BounceWeaponIcon		= false

//This is how clients can adjust SFX performance rate
CreateClientConVar( "flamethrower_fx", 2, false, false )