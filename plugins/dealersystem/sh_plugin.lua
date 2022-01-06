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