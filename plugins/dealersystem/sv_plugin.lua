util.AddNetworkString("LiteNetworkDealerRegister")
function ix.dealers.Register()
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
            local ent = ents.Create("ix_dealer")
            ent:SetPos(v.spawnPos)
            ent:SetAngles(v.spawnAng)
            ent:Spawn()

            ent:SetModel(v.model)
            
            ent:SetDealer(v.id)
            ent:SetNWInt("ixDealerType", v.id)
            ent:SetNWString("ixDealerName", v.nick)

            print(tostring(v.name).." dealer has been spawned.")
        end
    end)
end

ix.dealers.Register()

function PLUGIN:InitializedPlugins()
end