ENT.Base 			= "base_ai"
ENT.Type 			= "ai"
ENT.PrintName		= "Civil Protection Vendor"
ENT.Author			= "Riggs Mackay"
ENT.Purpose			= "Gives out Civil Protection Divsions and Ranks, depending on your XP count."
ENT.Instructions	= "Press E"
ENT.Category 		= "IX:HL2RP"

ENT.AutomaticFrameAdvance = true
ENT.Spawnable = true
ENT.AdminOnly = true

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