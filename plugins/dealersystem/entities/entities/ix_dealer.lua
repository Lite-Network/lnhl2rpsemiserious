AddCSLuaFile()

ENT.Base 			= "base_ai"
ENT.Type 			= "ai"
ENT.PrintName		= "Base Dealer"
ENT.Author			= "Riggs Mackay"
ENT.Purpose			= "A Base for Dealers, not not mess with this."
ENT.Instructions	= "Press E"
ENT.Category 		= "IX:HL2RP (Dealers)"

ENT.AutomaticFrameAdvance = true
ENT.Spawnable = false
ENT.AdminOnly = true

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Dealer")
end

if ( SERVER ) then
    function ENT:Initialize()
        self:SetModel("models/eli.mdl")
        self:SetHullType(HULL_HUMAN)
        self:SetHullSizeNormal()
        self:SetSolid(SOLID_BBOX)
        self:SetUseType(SIMPLE_USE)
        self:DropToFloor()

        self:SetNWInt("ixDealerType", 0)
    end

    function ENT:OnTakeDamage()
        return false
    end

    function ENT:Use(ply)
        if ( ( self.useCooldown or 0 ) < CurTime() ) then
            if not ( ply:GetCharacter() and ply:IsCitizen() ) then
                ply:Notify("You need to be a Citizen to speak to the dealer!")
                return
            end
    
            ply:OpenVGUI("LiteNetworkDealer")
    
            self.useCooldown = CurTime() + 3
        end
    end
end