PLUGIN.name = "Stackable Items"
PLUGIN.description = "Adds the ability to stack items in one"
PLUGIN.author = "Bilwin"
PLUGIN.schema = "Any"
PLUGIN.version = 1.0

ix.util.Include("sh_meta.lua")

// If an item can be stacked then this will make it auto-stack.
if ( SERVER ) then
	function PLUGIN:InventoryItemAdded( oldInv, inv, item )
		if ( item.base != "stackable" ) then
			return
		end

		local i = inv:HasItem( item.uniqueID )

		if ( !i ) then
			return
		end

		ix.item.PerformInventoryAction( inv:GetOwner(), "combine", item, inv:GetID(), { i:GetID() } )
	end

	function PLUGIN:OnItemTransferred( item, curInv, inv )
		if ( inv == curInv ) then
			return
		end

		if ( item.base != "stackable" ) then
			return
		end

		local i = inv:HasItem( item.uniqueID )

		if ( !i ) then
			return
		end

		ix.item.PerformInventoryAction( inv:GetOwner(), "combine", item, inv:GetID(), { i:GetID() } )
	end
end
