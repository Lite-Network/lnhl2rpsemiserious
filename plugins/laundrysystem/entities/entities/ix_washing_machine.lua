local PLUGIN = PLUGIN

AddCSLuaFile()

ENT.Base 			= "base_gmodentity"
ENT.Type 			= "anim"
ENT.PrintName		= "Washing Machine"
ENT.Author			= "Riggs Mackay"
ENT.Purpose			= "Clean it dude."
ENT.Instructions	= "Press E"
ENT.Category 		= "IX:HL2RP (Laundry)"

ENT.AutomaticFrameAdvance = true
ENT.Spawnable = true
ENT.AdminOnly = true

function ENT:SetupDataTables()
	self:NetworkVar("Float", 0, "WashState")
	self:NetworkVar("Float", 1, "ClothType")
	self:NetworkVar("Bool", 2, "Washing")

	if ( SERVER ) then
		self:NetworkVarNotify("Washing", self.OnWash)
	end
end

if ( SERVER ) then
    function ENT:Initialize()
        self:SetModel("models/props_wasteland/laundry_dryer002.mdl")
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
            self.nextUse = CurTime() + 2
            if not (ply.ixCWUClass == 1) then
                ply:Notify("You need to be a Civil Worker's Union Worker Class to use this!")
                return
            end
        end
    end

    function ENT:Think()
        local pos = self:LocalToWorld(self:OBBCenter())
        local ang = self:GetAngles()
        ang:RotateAroundAxis(ang:Up(), 90)
        ang:RotateAroundAxis(ang:Forward(), 90)
    
        for _, ent in pairs(ents.FindInSphere(pos + (ang:Up() * 20) - (ang:Right() * 9), 20)) do
            if ( ent:GetClass() == "ix_cloth" and not self:GetWashing() ) then
                if not ent:GetClean() then
                    self:SetClothType(ent:GetClothType())
                    self:SetWashing(true)
                    self:SetWashState(PLUGIN.washTime)
                    ent:Remove()
                end
            end
        end
    
        self:NextThink(CurTime())
        return true
    end
    
    function ENT:OnWash(ent, name, ov, nv)
        if timer.Exists("ixWashTimer"..self:EntIndex()) then return end
    
        timer.Create("ixWashTimer"..self:EntIndex(), 1, PLUGIN.washTime, function()
            self:SetWashState(self:GetWashState() - 1)
    
            timer.Simple(1, function()
                if self:IsValid() then
                    self:EmitSound("plats/elevator_stop1.wav")
                end
            end)
    
            if ( self:GetWashState() == 0 ) then
                self:SetWashing(false)
                timer.Remove("ixWashTimer"..self:EntIndex())
    
                local pos = self:LocalToWorld(self:OBBCenter())
                local ang = self:GetAngles()
    
                ang:RotateAroundAxis(ang:Up(), 90)
                ang:RotateAroundAxis(ang:Forward(), 90)
    
                local cloth = ents.Create("ix_cloth")
                if not cloth:IsValid() then return end
                cloth:SetPos(pos + (ang:Up() * 25))
                cloth:SetAngles(self:GetAngles())
                cloth:SetClothType(self:GetClothType())
                cloth:SetClean(true)
                cloth:Spawn()
    
                self:EmitSound("plats/elevbell1.wav")
            else
                self:EmitSound("plats/elevator_start1.wav", 60)
                self:EmitSound("plats/elevator_move_loop2.wav", 60)
            end
        end)
    end
    
    function ENT:OnRemove()
        if ( timer.Exists("ixWashTimer"..self:EntIndex()) ) then
            timer.Remove("ixWashTimer"..self:EntIndex())
        end
    
        if ( timer.Exists("ixWashSoundTimer"..self:EntIndex()) ) then
            timer.Remove("ixWashSoundTimer"..self:EntIndex())
        end
    end
end