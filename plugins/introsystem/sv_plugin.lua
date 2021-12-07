util.AddNetworkString("ixIntroStarted")
net.Receive("ixIntroStarted", function(len, ply)
    local position = net.ReadVector()

    ply.ixIntroBool = true

    if not ( ply:Alive() ) then
        ply:Spawn()
        hook.Run("PlayerLoadout", ply)
    end

    ply:SelectWeapon("ix_keys")
    ply:SetPos(position)
    ply:SetGravity(0.1)
    ply:ConCommand("stopsound")
end)

util.AddNetworkString("ixIntroUpdate")
net.Receive("ixIntroUpdate", function(len, ply)
    local position = net.ReadVector()

    ply.ixIntroBool = true
    
    ply:SelectWeapon("ix_keys")
    ply:SetPos(position)
    ply:SetGravity(0.1)
end)

util.AddNetworkString("ixIntroComplete")
net.Receive("ixIntroComplete", function(len, ply)
    ply.ixIntroBool = false

    ply:SetNoDraw(false)
    ply:Freeze(false)
    ply:GodDisable()

    ply:Spawn()
    hook.Run("PlayerLoadout", ply)
    ply:SelectWeapon("ix_hands")
    ply:SetGravity(1)

    ply:ScreenFade(SCREENFADE.IN, color_black, 1, 2)
    ply:ConCommand("stopsound")
end)

function PLUGIN:PlayerTick(ply)
    if ( ply.ixIntroBool == true ) then
        ply:SetNoDraw(true)
        ply:Freeze(true)
        ply:GodEnable()
        ply:SetGravity(0.1)
    end
end

util.AddNetworkString("ixIntroStart")
function PLUGIN:PlayerLoadedCharacter(ply, char, oldChar)
    ply.ixIntroBool = true
    ply:SetGravity(0.1)

    net.Start("ixIntroStart")
    net.Send(ply)
end