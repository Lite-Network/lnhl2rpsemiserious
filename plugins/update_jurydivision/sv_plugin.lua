local PLUGIN = PLUGIN

util.AddNetworkString("ixInspectBodyFinish")
function PLUGIN:PlayerUse(ply, ent)
    if ( ent.attacker and ent.attacker:IsPlayer() and ent.attacker:IsCombine() and ( ent.attacker.ixCCADivision == 4 ) ) then
        ply:Freeze(true)
        ply:SetAction("Investigating...", 5, function()
            ply:Freeze(false)
            for i = 1, lootAmount do
                ply:ChatNotify("You have gained "..ix.item.Get(randomLootItem):GetName()..".")
                ply:GetCharacter():GetInventory():Add(randomLootItem)
            end
        end)
    end
end