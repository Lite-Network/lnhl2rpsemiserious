util.AddNetworkString("LiteNetworkDealerRegister")
function ix.dealers.Register(dealerType)
    if ( dealerType ) then
        print("Registering Dealer...")
        -- Remove Dealers if exist.
        for k, v in pairs(ents.FindByClass("ix_dealer")) do
            if ( v:GetNWInt("ixDealerType", 0) == dealerType ) then
                v:Remove()
                print("Removed Existing Dealear...")
            end
        end
    
        -- Spawn / Respawn Dealer
        print("Respawning Dealer...")
        timer.Simple(1, function() -- Let the Dealers get removed, then spawn them.
            for k, v in pairs(ix.dealers.data) do
                if ( k == dealerType ) then
                    local spawnCount = v.spawns
                    local randomSpawns = table.Random(spawnCount)
                    local ent = ents.Create("ix_dealer")
                    ent:SetPos(randomSpawns.spawnPos)
                    ent:SetAngles(randomSpawns.spawnAng)
                    ent:Spawn()
        
                    ent:SetModel(v.model)
                    
                    ent:SetNWInt("ixDealerType", k)
                    ent:SetNWString("ixDealerName", v.nick)
        
                    print(tostring(v.name).." dealer has been spawned.")
                end
            end
        end)
    else
        print("Registering Dealers...")
        -- Remove Dealers if exist.
        for k, v in pairs(ents.FindByClass("ix_dealer")) do
            v:Remove()
            print("Removed Existing Dealears...")
        end
    
        -- Spawn / Respawn Dealers
        print("Respawning Dealers...")
        timer.Simple(1, function() -- Let the Dealers get removed, then spawn them.
            for k, v in pairs(ix.dealers.data) do
                local spawnCount = v.spawns
                local randomSpawns = table.Random(spawnCount)
                local ent = ents.Create("ix_dealer")
                ent:SetPos(randomSpawns.spawnPos)
                ent:SetAngles(randomSpawns.spawnAng)
                ent:Spawn()
    
                ent:SetModel(v.model)
                
                ent:SetNWInt("ixDealerType", k)
                ent:SetNWString("ixDealerName", v.nick)
    
                print(tostring(v.name).." dealer has been spawned.")
            end
        end)
    end
end

ix.dealers.Register()

util.AddNetworkString("LiteNetworkDealerBuy")
util.AddNetworkString("LiteNetworkDealerSell")

net.Receive("LiteNetworkDealerBuy", function(len, ply)
    local char = ply:GetCharacter()
    local itemTable = ix.item.Get(net.ReadString())
    local itemCost = net.ReadUInt(16) or 10

    if ( ply:NearEntity("ix_dealer", 96) ) then
        if ( char:HasMoney(itemCost) ) then
            ply:Notify("You successfully purchased "..itemTable.name.."!")
            char:TakeMoney(itemCost)
            char:GetInventory():Add(itemTable.uniqueID or "gnome")
        else
            ply:Notify("You need "..itemCost.." tokens to purchase "..itemTable.name.."!")
        end
    else
        ply:Notify("You need to be near the Dealer to buy stuff from them!")
    end
end)

net.Receive("LiteNetworkDealerSell", function(len, ply)
    local char = ply:GetCharacter()
    local itemTable = ix.item.Get(net.ReadString())
    local itemCost = net.ReadUInt(16) or 10

    if ( ply:NearEntity("ix_dealer", 96) ) then
        local item = char:GetInventory():HasItem(itemTable.uniqueID)
        if ( item ) then
            ply:Notify("You successfully sold "..itemTable.name.." to this dealer!")
            char:GiveMoney(itemCost)

            if ( item:GetData("stacks", 1) > 1 ) then
                item:SetData("stacks", item:GetData("stacks", 1) - 1)
            else
                item:Remove()
            end
        else
            ply:Notify("You do not have "..itemTable.name.." in your inventory!")
        end
    else
        ply:Notify("You need to be near the Dealer to sell stuff to them!")
    end
end)