local PLUGIN = PLUGIN

AddCSLuaFile()

ENT.Base 			= "base_gmodentity"
ENT.Type 			= "anim"
ENT.PrintName		= "Cloth"
ENT.Author			= "Riggs Mackay"
ENT.Purpose			= "Clean it dude."
ENT.Instructions	= "Press E"
ENT.Category 		= "IX:HL2RP (Laundry)"

ENT.AutomaticFrameAdvance = true
ENT.Spawnable = true
ENT.AdminOnly = true

ENT.Holdable = true

function ENT:SetupDataTables()
    self:NetworkVar("Bool", 0, "Clean")
    self:NetworkVar("Float", 1, "ClothType")

    if ( SERVER ) then
        self:NetworkVarNotify("Clean", self.OnClothChangeState)
    end
end

if ( SERVER ) then
    function ENT:Initialize()
        self:SetModel("models/props_junk/garbage_newspaper001a.mdl")
        self:PhysicsInit(SOLID_VPHYSICS) 
        self:SetSolid(SOLID_VPHYSICS)
        self:SetUseType(SIMPLE_USE)
    
        local phys = self:GetPhysicsObject()
        if (phys:IsValid()) then
            phys:Wake()
            phys:EnableMotion(true)
        end

        if not ( self:GetClean() ) then
            self:SetMaterial("models/props_c17/furniturefabric003a")
        else
            self:SetMaterial("models/debug/debugwhite")
        end

        if ( self:GetClothType() == 1 ) then
            self:SetColor(Color(255, 125, 0))
        elseif ( self:GetClothType() == 2 ) then
            self:SetColor(Color(0, 50, 255))
        end
    end
end