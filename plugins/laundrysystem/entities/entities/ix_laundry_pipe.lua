local PLUGIN = PLUGIN

AddCSLuaFile()

ENT.Base 			= "base_gmodentity"
ENT.Type 			= "anim"
ENT.PrintName		= "Laundry Pipe"
ENT.Author			= "Riggs Mackay"
ENT.Purpose			= "Clean it dude."
ENT.Instructions	= "Press E"
ENT.Category 		= "IX:HL2RP (Laundry)"

ENT.AutomaticFrameAdvance = true
ENT.Spawnable = true
ENT.AdminOnly = true

function ENT:SetupDataTables()
    self:NetworkVar("Float", 0, "ClothesNumber")
end

if ( SERVER ) then
    function ENT:Initialize()
        self:SetModel("models/props_pipes/pipe03_45degree01.mdl")
        self:PhysicsInit(SOLID_VPHYSICS) 
        self:SetSolid(SOLID_VPHYSICS)
        self:SetUseType(SIMPLE_USE)
    
        local phys = self:GetPhysicsObject()
        if (phys:IsValid()) then
            phys:Wake()
            phys:EnableMotion(false)
        end
    end

    function ENT:Use(activator, ply)
		if ((self.nextUse or 0) < CurTime()) then
            if not (ply.ixCWUClass == 1) then
                ply:Notify("You need to be a Civil Worker's Union Worker Class to use this!")
                return
            end
            if not ( self:GetClothesNumber() >= 6 ) then
                local pos = self:LocalToWorld(self:OBBCenter())
                local ang = self:GetAngles()

                local cloth = ents.Create("ix_cloth")
                if not cloth:IsValid() then return end
                cloth:SetPos(pos + (ang:Forward() * 30))
                cloth:SetAngles(self:GetAngles())

                if ( math.random(1, 4) == 4 ) then
                    cloth:SetClothType(2)
                else
                    cloth:SetClothType(1)
                end

                cloth:SetClean(false)
                cloth:Spawn()
                self:EmitSound("doors/vent_open"..math.random(1, 3)..".wav", 60)

                self:SetClothesNumber(self:GetClothesNumber() + 1)
            end

            self.nextUse = CurTime() + 2
        end
    end

    function ENT:Think()
        self:NextThink(CurTime())
        return true
    end

    function ENT:OnRemove()
        if ( timer.Exists("ixAddClothTimer"..self:EntIndex()) ) then
            timer.Remove("ixAddClothTimer"..self:EntIndex())
        end
    end
end