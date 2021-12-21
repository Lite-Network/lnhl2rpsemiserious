local PLUGIN = PLUGIN

function PLUGIN:SearchLootContainer(ent, ply)
    if not ( ply:IsCombine() or ply:IsCA() or ply:IsDispatch() ) then
        if not ent.containerAlreadyUsed or ent.containerAlreadyUsed <= CurTime() then
            local randomChance = math.random(1,20)
            local randomAmountChance = math.random(1,4)
            local lootAmount = 1

            local randomLootItem = table.Random(PLUGIN.randomLoot.common)
            if ( randomAmountChance == 4 ) then
                lootAmount = math.random(1,5)
            else
                lootAmount = 1
            end

            ply:Freeze(true)
            ply:SetAction("Searching...", 5, function()
                ply:Freeze(false)
                for i = 1, lootAmount do
                    if (randomChance == math.random(1,20)) then
                        randomLootItem = table.Random(PLUGIN.randomLoot.rare)
                        ply:ChatNotify("You have gained "..ix.item.Get(randomLootItem):GetName()..".")
                        ply:GetCharacter():GetInventory():Add(randomLootItem)
                    else
                        randomLootItem = table.Random(PLUGIN.randomLoot.common)
                        ply:ChatNotify("You have gained "..ix.item.Get(randomLootItem):GetName()..".")
                        ply:GetCharacter():GetInventory():Add(randomLootItem)
                    end
                end
            end)
            ent.containerAlreadyUsed = CurTime() + 120
        else
            if not ent.ixContainerNothingInItCooldown or ent.ixContainerNothingInItCooldown <= CurTime() then
                ply:ChatNotify("There is nothing in the container!")
                ent.ixContainerNothingInItCooldown = CurTime() + 1
            end
        end
    else
        if not ent.ixContainerNotAllowed or ent.ixContainerNotAllowed <= CurTime() then
            ply:ChatNotify("Your Faction is not allowed to loot containers.")
            ent.ixContainerNotAllowed = CurTime() + 1
        end
    end
end

function Schema:SpawnRandomLoot(position, rareItem)
    local randomLootItem = table.Random(PLUGIN.randomLoot.common)

    if (rareItem == true) then
        randomLootItem = table.Random(PLUGIN.randomLoot.rare)
    end

    ix.item.Spawn(randomLootItem, position)
end