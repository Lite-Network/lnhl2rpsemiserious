PLUGIN.name = "Safebox"
PLUGIN.author = "STEAM_0:1:29606990"
PLUGIN.description = "Personal storage of items for players."

ix.config.Add("safeInvHeight", 10, "How many slots in a column there is in a safebox inventory.", nil, {
	data = {min = 0, max = 20},
	category = PLUGIN.name
})

ix.config.Add("safeInvWidth", 10, "How many slots in a row there is in a safebox inventory.", nil, {
	data = {min = 0, max = 20},
	category = PLUGIN.name
})

ix.config.Add("safeboxOpenTime", 0.5, "How long it takes to open a safebox.", nil, {
	data = {min = 0, max = 50, decimals = 1},
	category = PLUGIN.name
})

ix.safebox = ix.safebox or {}
ix.util.Include("sv_plugin.lua")

function PLUGIN:InitializedPlugins()
	ix.inventory.Register("safebox", ix.config.Get("safeInvWidth"), ix.config.Get("safeInvHeight"))
end

if (CLIENT) then
	net.Receive("ixSafeboxOpen", function()
		if (IsValid(ix.gui.menu)) then
			return
		end

		local ply = LocalPlayer()
		local character = ply:GetCharacter()

		if (!character) then
			return
		end

		local index = character:GetData("safeboxID")
		local inventory = ix.inventory.Get(index)

		if (inventory and inventory.slots) then
			local localInventory = character:GetInventory()
			local panel = vgui.Create("ixStorageView")

			if (localInventory) then
				panel:SetLocalInventory(localInventory)
			end

			panel:SetStorageID(index)
			panel:SetStorageInventory(inventory)
		end
	end)
end