local PLUGIN = PLUGIN

PLUGIN.name = "Loot Crates"
PLUGIN.author = "Riggs Mackay"
PLUGIN.description = "Allows you to loot certin crates to obtain loot items."

PLUGIN.randomLoot = {}
PLUGIN.randomLoot.common = {
	"metalplate",
	"metalplate",
	"metalplate",
	"cloth",
	"cloth",
	"cloth",
	"wood",
	"wood",
	"plastic",
	"glue",
	"pipe",
	"gear",
	"water",
	"gunpowder",
}

PLUGIN.randomLoot.rare = {
	"bulletcasing",
	"bulletcasing",
	"refinedmetal",
	"refinedmetal",
	"splint",
	"splint",
	"pistolammo",
	"pistolammo",
	"bandage",
	"electronics",
	"ration",
	"gnome",
}

ix.util.Include("sv_plugin.lua")

-- No point putting it in a seperate file when they can get clientside code anyway these fuckers, yeah im talking to you
if (CLIENT) then
	function PLUGIN:PopulateEntityInfo( ent, tooltip )
		local client = LocalPlayer()
		local cl = ent:GetClass()

		if ( !client:IsCombine() or !client:IsCA() or !client:IsDispatch() ) then
			return
		end

		if ( !cl:find( "ix_loot" ) ) then
			return
		end

		local t = tooltip:AddRow( "loot" )
		t:SetText( "Lootable Container" )
		t:SetImportant()
		t:SizeToContents()
	end
end
