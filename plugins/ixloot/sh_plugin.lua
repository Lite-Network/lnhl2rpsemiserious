local PLUGIN = PLUGIN

PLUGIN.name = "Loot Crates"
PLUGIN.author = "Riggs Mackay"
PLUGIN.description = "Allows you to loot certin crates to obtain loot items."

PLUGIN.randomLoot = {}
PLUGIN.randomLoot.common = {
	"wood",
	"wood",
	"metalplate",
	"metalplate",
	"metalplate",
	"plastic",
	"plastic",
	"cloth",
	"cloth",
	"glue",
	"glue",
	"gunpowder",
}

PLUGIN.randomLoot.rare = {
	"usp",
	"bulletcasing",
	"bulletcasing",
	"gear",
	"gear",
	"pipe",
	"pipe",
	"refinedmetal",
	"refinedmetal",
	"splint",
	"splint",
	"bandage",
	"electronics",
	"gnome",
}

ix.util.Include("sv_plugin.lua")

-- No point putting it in a seperate file when they can get clientside code anyway these fuckers, yeah im talking to you
if (CLIENT) then
	function PLUGIN:PreDrawHalos()
		local ply = LocalPlayer()
		if not (ply:IsCombine() or ply:IsCA() or ply:IsDispatch()) then
			for k, v in pairs(ents.GetAll()) do
				if v and v:GetClass():find("ix_loot") and (EyePos():Distance(v:GetPos()) < 512) then
					halo.Add({v}, ix.config.Get("color"), 2, 2, 1)
				end
			end
		end
	end
end