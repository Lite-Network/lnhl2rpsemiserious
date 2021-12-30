AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

SWEP.Weight			= 5
SWEP.AutoSwitchTo		= true
SWEP.AutoSwitchFrom		= true

//Make sure clients get custom materials
resource.AddFile("materials/weapons/swep_flamethrower_d2k.vtf")
resource.AddFile("materials/weapons/swep_flamethrower_d2k.vmt")

resource.AddFile("materials/effects/muzzleflash2edit.vtf")
resource.AddFile("materials/effects/muzzleflash2edit.vmt")