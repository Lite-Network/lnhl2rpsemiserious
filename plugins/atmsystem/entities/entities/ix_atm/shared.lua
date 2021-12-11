ENT.Base 			= "base_ai"
ENT.Type 			= "anim"
ENT.PrintName		= "ATM Machine"
ENT.Author			= "Riggs Mackay"
ENT.Purpose			= "Allows you to deposit or withdraw tokens incase you lose them to mugging or dying."
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