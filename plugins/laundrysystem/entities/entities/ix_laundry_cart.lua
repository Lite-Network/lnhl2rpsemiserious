local PLUGIN = PLUGIN

AddCSLuaFile()

ENT.Base 			= "base_gmodentity"
ENT.Type 			= "anim"
ENT.PrintName		= "Laundry Cart"
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
        self:SetModel("models/props_wasteland/laundry_cart001.mdl")
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
        
        if not self.ClothTable then return end
        if not (#self.ClothTable > 0) then return end
        if not ( ply:IsValid() ) then return end
        if not ( ply:GetCharacter() ) then return end
        local char = ply:GetCharacter()
        local tokenReward = #self.ClothTable * PLUGIN.tokenPerCloth
        local clothAmount = self:GetClothesNumber()

        char:GiveMoney(tokenReward)
        if ( self:GetClothesNumber() == 1 ) then
            ply:Notify("You have gained "..tokenReward.." tokens, for washing "..self:GetClothesNumber().." cloth.")
        else
            ply:Notify("You have gained "..tokenReward.." tokens, for washing "..self:GetClothesNumber().." clothes.")
        end

        for _, ent in pairs(self.ClothTable) do
            ent:Remove()
        end

        for _, ent in pairs(ents.FindByClass("ix_laundry_pipe")) do
            ent:SetClothesNumber(ent:GetClothesNumber() - clothAmount)
        end
    end
    
    function ENT:Think()
        local pos = self:LocalToWorld(self:OBBCenter())
        local ang = self:GetAngles()
        local entnum = 0
        self.ClothTable = { }

        for _, ent in pairs(ents.FindInSphere(pos + (ang:Forward() * 20), 20)) do
            if ( ent:GetClass() == "ix_cloth" and not table.HasValue(self.ClothTable, ent) ) then
                if ent:GetClean() then
                    table.insert(self.ClothTable, ent)
                end
            end
        end

        for _, ent in pairs(ents.FindInSphere(pos - (ang:Forward() * 20), 20)) do
            if ( ent:GetClass() == "ix_cloth" ) then
                if ent:GetClean() and not table.HasValue(self.ClothTable, ent) then
                    table.insert(self.ClothTable, ent)
                end
            end
        end

        for _, ent in pairs(self.ClothTable) do
            entnum = entnum + 1
        end

        self:SetClothesNumber(entnum)

        self:NextThink(CurTime() + 0.1)
        return true
    end
elseif ( CLIENT ) then
    function ENT:Draw()
        self:DrawModel()

        local pos = self:LocalToWorld(self:OBBCenter())
        local ang = self:GetAngles()

        local phrase = string.gsub(PLUGIN.PhraseCleanClothes, "<clothes>", self:GetClothesNumber())

        cam.Start3D2D(pos + (ang:Up() * 5) + (ang:Right() * 21), ang + Angle(0, 0, 90), 0.25)
            draw.SimpleText(tostring(phrase), "DermaLarge", 0, 0, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        cam.End3D2D()
    end
end