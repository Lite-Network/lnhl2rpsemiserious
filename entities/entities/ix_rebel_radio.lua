AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Resistance Radio"
ENT.Author = "Riggs Mackay"
ENT.Category = "IX:HL2RP"
ENT.Contact = ""
ENT.Purpose = "A Radio that plays old music from early years."
ENT.Instructions = ""
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Holdable = true

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

function ENT:GetLeftBtnPos()
    local leftBtnPos = self:GetPos()
    leftBtnPos = leftBtnPos + self:GetForward() * 10
    leftBtnPos = leftBtnPos + self:GetRight() * -1.3
    leftBtnPos = leftBtnPos + self:GetUp() * 7.4
    return leftBtnPos
end

function ENT:GetRightBtnPos()
    local rightBtnPos = self:GetPos()
    rightBtnPos = rightBtnPos + self:GetForward() * 10
    rightBtnPos = rightBtnPos + self:GetRight() * -8.7
    rightBtnPos = rightBtnPos + self:GetUp() * 7.4
    return rightBtnPos
end

function ENT:SetupDataTables()
    self:NetworkVar("Bool", 0, "Enabled")
end

if (SERVER) then
    function ENT:Initialize()
        self:SetModel("models/props_lab/citizenradio.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)

        local phys = self:GetPhysicsObject()
        if IsValid(phys) then
            phys:EnableMotion(true)
            phys:Wake()
        end
    end

    function ENT:OnRemove()
        self:StopSong()
    end

    function ENT:PerformPickup(ply)
        if timer.Exists("ixCharacterInteraction" .. ply:SteamID()) then return end

        ply:PerformInteraction(0.5, self, function(_)
            ply:GetCharacter():GetInventory():Add("rebel_radio")
            self:StopSong()
            self:Remove()
        end)
    end

    function ENT:GetMusicTable()
		return ix.radioMusic.Resistance
    end

    function ENT:PickSong()
        self:StopSong()

        local indices = {}
        for i = 1, #self:GetMusicTable() do
            if i == self.currentSong then continue end
            table.insert(indices, i)
        end

        self.currentSong = table.Random(indices)

        local song = self:GetMusicTable()[self.currentSong]

        self:EmitSound(song.path)

        timer.Create("ixMusicRadio" .. self:EntIndex(), song.length, 1, function()
            if (IsValid(self)) then
                self:PickSong()
            end
        end)
    end

    function ENT:StopSong()
        if not self.currentSong then return end
        self:StopSound(self:GetMusicTable()[self.currentSong].path)
    end

    function ENT:Use(activator)
        local curTime = CurTime()

        if (self.nextUse and self.nextUse > curTime) then return end
        if activator:KeyDown(IN_WALK) then return self:PerformPickup(activator) end

        local leftBtnPos = self:GetLeftBtnPos()
        local rightBtnPos = self:GetRightBtnPos()

        local tr = activator:GetEyeTrace()
        if tr.HitPos:Distance(leftBtnPos) <= 2 and !self:GetEnabled() then
            self:SetEnabled(true)
            self:PickSong()
        elseif tr.HitPos:Distance(rightBtnPos) <= 2 and self:GetEnabled() then
            self:SetEnabled(false)
            self:StopSong()
            timer.Remove("ixMusicRadio" .. self:EntIndex())
        end

        self.nextUse = curTime + 1
	end
else
    local glowMaterial = ix.util.GetMaterial("sprites/glow04_noz")
    local color_green = Color(0, 255, 0, 255)
    local color_red = Color(255, 50, 50, 255)

    function ENT:Draw()
        self:DrawModel()

        local leftBtnPos = self:GetLeftBtnPos()
        local rightBtnPos = self:GetRightBtnPos()

        render.SetMaterial(glowMaterial)
		render.DrawSprite(leftBtnPos, 10, 10, color_green)
		render.DrawSprite(rightBtnPos, 10, 10, color_red)
    end

    function ENT:Think()
        self.ShowPlayerInteraction = LocalPlayer():KeyDown(IN_WALK)
    end
end