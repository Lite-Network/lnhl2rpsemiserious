function PLUGIN:SetupPlayerVisibility( client, viewEnt )
	if ( !client.ixIntroBool ) then
		return
	end

	if ( !client.ixIntroPosition ) then
		return
	end

	AddOriginToPVS( client.ixIntroPosition )
end

util.AddNetworkString("ixIntroStarted")
net.Receive("ixIntroStarted", function(len, ply)
    local position = net.ReadVector()

    ply.ixIntroBool = true
	ply.ixIntroPosition = position

    if not ( ply:Alive() ) then
        ply:Spawn()
        hook.Run("PlayerLoadout", ply)
    end

    ply:ScreenFade(SCREENFADE.IN, color_black, 1, 2)
end)

util.AddNetworkString("ixIntroUpdate")
net.Receive("ixIntroUpdate", function(len, ply)
    local position = net.ReadVector()

    ply.ixIntroBool = true
	ply.ixIntroPosition = position
end)

util.AddNetworkString("ixIntroComplete")
net.Receive("ixIntroComplete", function(len, ply)
    ply.ixIntroBool = false
	ply.ixIntroPosition = nil

    ply:ScreenFade(SCREENFADE.IN, color_black, 1, 2)
end)

util.AddNetworkString("ixIntroStart")
function PLUGIN:PlayerLoadedCharacter(ply, char, oldChar)
    if not ( ply:GetPData("ixIntroHistory") ) then
        ply.ixIntroBool = true

        net.Start("ixIntroStart")
        net.Send(ply)

        ply:SetPData("ixIntroHistory", true)
    end
end
