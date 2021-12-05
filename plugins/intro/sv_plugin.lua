util.AddNetworkString("ixIntroStarted")
net.Receive("ixIntroStarted", function(len, ply)
    local data = net.ReadTable()

    ply.ixInIntro = true

    if not ( ply:Alive() ) then
        ply:Spawn()
        hook.Run("PlayerLoadout", ply)
    end

    ply:SelectWeapon("ix_keys")
    ply:SetPos(Vector(data[1], data[2], data[3]))
    ply:SetGravity(0.1)
end)

util.AddNetworkString("ixIntroUpdate")
net.Receive("ixIntroUpdate", function(len, ply)
    local data = net.ReadTable()

    ply.ixInIntro = true
    
    ply:SelectWeapon("ix_keys")
    ply:SetPos(Vector(data[1], data[2], data[3]))
    ply:SetGravity(0.1)
end)

util.AddNetworkString("ixIntroComplete")
net.Receive("ixIntroComplete", function(len, ply)
    ply.ixInIntro = false

    ply:SetNoDraw(false)
    ply:Freeze(false)
    ply:GodDisable()

    ply:Spawn()
    hook.Run("PlayerLoadout", ply)
    ply:SelectWeapon("ix_hands")
    ply:SetGravity(1)

    ply:ScreenFade(SCREENFADE.OUT, color_black, 1, 2)
end)

function PLUGIN:PlayerTick(ply)
    if ( ply.ixInIntro == true ) then
        ply:SetNoDraw(true)
        ply:Freeze(true)
        ply:GodEnable()
        ply:SetGravity(0.1)
    end
end

util.AddNetworkString("ixIntroStart")
function PLUGIN:PlayerLoadedCharacter(ply, char, oldChar)
    ply.ixInIntro = true
    ply:SetGravity(0.1)

    net.Start("ixIntroStart")
    net.Send(ply)
end