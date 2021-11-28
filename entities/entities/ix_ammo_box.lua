AddCSLuaFile()

ENT.Base 			= "base_gmodentity"
ENT.Type 			= "anim"
ENT.PrintName		= "Ammo Crate"
ENT.Author			= "Riggs Mackay"
ENT.Purpose			= "Give out Ammo for certain weapons."
ENT.Instructions	= "Press E"
ENT.Category 		= "IX:HL2RP"

ENT.AutomaticFrameAdvance = true
ENT.Spawnable = true
ENT.AdminOnly = true

ENT.Holdable = true -- lul

game.AddAmmoType({
    name = "ixRifleammo",
    dmgtype = DMG_BULLET,
    tracer = TRACER_LINE_AND_WHIZ,
    force = 5000,
    minsplash = 10,
    maxsplash = 100
})

AmmoCrateAmmunition = {}
AmmoCrateAmmunition["Pistol"] = 180
AmmoCrateAmmunition["357"] = 60
AmmoCrateAmmunition["SMG1"] = 450
AmmoCrateAmmunition["slam"] = 3
AmmoCrateAmmunition["Grenade"] = 3
AmmoCrateAmmunition["Buckshot"] = 50
AmmoCrateAmmunition["XBowBolt"] = 12
AmmoCrateAmmunition["SniperRound"] = 50
AmmoCrateAmmunition["SniperPenetratedRound"] = 50
AmmoCrateAmmunition["AR2"] = 300
AmmoCrateAmmunition["ixRifleammo"] = 300

if (CLIENT) then
	function ENT:OnPopulateEntityInfo(container)
	   local EntityName = container:AddRow("EntityName")
	   EntityName:SetImportant()
	   EntityName:SetText(self.PrintName)
	   EntityName:SizeToContents()

	   local EntityDescription = container:AddRow("EntityDescription")
	   EntityDescription:SetText(self.Purpose)
	   EntityDescription:SizeToContents()
    end
end

if (SERVER) then
    function ENT:Initialize()
        self:SetModel("models/items/ammocrate_ar2.mdl")
        self:PhysicsInit(SOLID_VPHYSICS) 
        self:SetSolid(SOLID_VPHYSICS)
        self:SetUseType(SIMPLE_USE)
        self.OpenDoor = false
    
        local phys = self:GetPhysicsObject()
        if (phys:IsValid()) then
            phys:Wake()
            phys:EnableMotion(false)
        end
    end

	function ENT:SpawnFunction(ply, trace)
        local angles = ply:GetAngles()

		local entity = ents.Create("ix_ammo_box")
		entity:SetPos(trace.HitPos)
		entity:SetAngles(Angle(0, (entity:GetPos() - ply:GetPos()):Angle().y - 180, 0))
		entity:Spawn()
		entity:Activate()

		return entity
	end
    
    function ENT:OnTakeDamage()
        return false
    end 
    
    function ENT:AcceptInput(Name, Activator, Caller)
        if (Name == "Use" and Caller:IsPlayer()) then
            if not self.AlreadyUsed or self.AlreadyUsed <= CurTime() then
                self:SetBodygroup(1, 1)
                self:EmitSound("items/ammocrate_open.wav")
                self:ResetSequence("open")
                timer.Simple(0.5, function()
                    for k, v in ipairs(Caller:GetWeapons()) do
                        local AmmoName = game.GetAmmoName(v:GetPrimaryAmmoType())
                        if AmmoCrateAmmunition[AmmoName] and Caller:GetAmmoCount(AmmoName) and Caller:GetAmmoCount(AmmoName) < AmmoCrateAmmunition[AmmoName] then
                            local giveAmmo =  AmmoCrateAmmunition[AmmoName] - Caller:GetAmmoCount(AmmoName)
                            local AmmoName = AmmoCrateAmmunition[AmmoName]
                            Caller:GiveAmmo(giveAmmo, v:GetPrimaryAmmoType(), true)
                        end
                    end
                    Caller:ChatNotify("Your ammunition for your weapon has been fully refilled to it's limits.")
                    self:EmitSound("items/ammo_pickup.wav", 80)
                    self:SetBodygroup(1, 0)
                end)
                timer.Simple(1, function()
                    self:ResetSequence("close")
                    self:EmitSound("items/ammocrate_close.wav")
                end)
				self.AlreadyUsed = CurTime() + 1.5
            end
        end
    end
end