util.AddNetworkString("ixStartIntro")
function PLUGIN:StartIntro(ply)
    net.Start("ixStartIntro")
    net.Send(ply)
end

function PLUGIN:PlayerLoadedCharacter(ply, char, lastChar)
    PLUGIN:StartIntro(ply)
end