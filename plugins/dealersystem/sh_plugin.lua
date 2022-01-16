-- Funnily Enough, I activated my brain and started coding this, not sure if it works though.. haven't tested it. Please don't touch it, my best work yet.

local PLUGIN = PLUGIN

PLUGIN.name = "Lite Network Dealer System"
PLUGIN.author = "Riggs Mackay"
PLUGIN.description = "Adds a similiar dealer from impulse into Helix, completly recreated."

ix.dealers = ix.dealers or {}
ix.dealers.data = ix.dealers.data or {}

ix.util.IncludeDir("derma")
ix.util.Include("sh_dealers.lua")
ix.util.Include("sv_plugin.lua")

local META = ix.meta.inventory or ix.middleclass("ix_inventory")

function META:GetItemByUniqueID(uniqueID, onlyMain)
	for _, v in pairs(self:GetItems(onlyMain)) do
		if (v.uniqueID == uniqueID) then
			return v
		end
	end
end

if ( CLIENT ) then
	concommand.Add("ix_dealer_getspawn", function(ply)
		local pos = ply:GetPos()
		local ang = ply:GetAngles()
		SetClipboardText([[
            [0] = {
                spawnPos = Vector(]]..tostring(pos.x)..[[, ]]..tostring(pos.y)..[[, ]]..tostring(pos.z)..[[),
                spawnAng = Angle(0, ]]..tostring(ang.y)..[[, ]]..tostring(ang.r)..[[),
            },
		]])
	end)
end