AddCSLuaFile()

SWEP.Base = "ls_base_melee"

SWEP.PrintName = "Axe"
SWEP.Category = "IX:HL2RP"

SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.HoldType = "melee2"

SWEP.WorldModel = "models/weapons/hl2meleepack/w_axe.mdl"
SWEP.ViewModel = "models/weapons/hl2meleepack/v_axe.mdl"
SWEP.ViewModelFOV = 70

SWEP.Slot = 1
SWEP.SlotPos = 4

SWEP.CSMuzzleFlashes = false

SWEP.Primary.Sound = Sound("WeaponFrag.Roll")
SWEP.Primary.ImpactSound = Sound("Canister.ImpactHard")
SWEP.Primary.ImpactSoundWorldOnly = true
SWEP.Primary.Recoil = 7
SWEP.Primary.Damage = 16
SWEP.Primary.NumShots = 1
SWEP.Primary.HitDelay = 0.3
SWEP.Primary.Delay = 0.7
SWEP.Primary.Range = 96
SWEP.Primary.StunTime = 0.3

function SWEP:PrePrimaryAttack()
	local vm = self:GetOwner():GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence("misscenter1"))
end

function SWEP:MeleeHitFallback(trace)
	if (trace) and (trace.MatType == MAT_WOOD) then
        local randomchance = math.random(1,10)
        
        if (randomchance == math.random(1,10)) then
            if ( SERVER ) then
                self:GetOwner():GetCharacter():GetInventory():Add("wood")
            end
            self:GetOwner():ChatNotify("You have gained 1 piece of wood.")
        end

		self:EmitSound("Wood.ImpactHard")

		return true
	end

	return false
end