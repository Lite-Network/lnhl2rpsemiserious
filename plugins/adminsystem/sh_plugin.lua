local PLUGIN = PLUGIN

PLUGIN.name = "Lite Network Admin System"
PLUGIN.author = "Riggs Mackay"
PLUGIN.description = "Tools for Moderators and Admins."

if (CLIENT) then
    PLUGIN.colors = {
        ["red"] = Color(230, 0, 0),
        ["orange"] = Color(230, 70, 0),
        ["white"] = Color(230, 230, 230),
    }

    function PLUGIN:PreDrawHalos()
        local ply = LocalPlayer()
        local char = ply:GetCharacter()

        if not ( char ) then
            return
        end

        if ( char ) and ( ply:IsAdmin() ) and ( ply:GetMoveType() == MOVETYPE_NOCLIP ) then
            for k, v in pairs(player.GetAll()) do
                if not ( v:IsValid() and v:Alive() and v:GetCharacter() ) then
                    return
                end
                halo.Add({v}, ix.config.Get("color"), 2, 2, 1, true, true)
            end
        end
    end

    function PLUGIN:HUDPaint()
        local ply = LocalPlayer()
        local char = ply:GetCharacter()

        if not ( char ) then
            return
        end

        if ( char ) and ( ply:IsAdmin() ) and ( ply:GetMoveType() == MOVETYPE_NOCLIP ) then
            ply.adminHud = true
            local onDuty = ix.option.Get("adminOnDuty") or false

            if ( onDuty ) then
                draw.SimpleText("ADMIN MODE", "LiteNetworkFont24", 20, 20, PLUGIN.colors["white"])
            else
                draw.SimpleText("ADMIN MODE ( OFF DUTY )", "LiteNetworkFont24", 20, 20, PLUGIN.colors["orange"])
            end

            local y = 60
			for k, v in pairs(player.GetAll()) do
				draw.SimpleText(v:SteamName().." ("..v:Nick()..") - "..team.GetName(v:Team()), "LiteNetworkFont24", 20, y, PLUGIN.colors["white"])
                y = y + 20
			end
            
            for k, v in pairs(player.GetAll()) do
                if ( v:IsValid() and v:GetCharacter() ) then
                    local pos = (v:GetPos() + Vector(0, 0, 40)):ToScreen()
                    local teamColor = team.GetColor(v:Team())

                    draw.SimpleText(v:Nick(), "LiteNetworkFont24", pos.x, pos.y, teamColor, TEXT_ALIGN_CENTER)
                    draw.SimpleText(v:SteamName(), "LiteNetworkFont24", pos.x, pos.y + 20, PLUGIN.colors["white"], TEXT_ALIGN_CENTER)

                    if ( v:GetActiveWeapon():IsValid() ) then
                        draw.SimpleText(v:GetActiveWeapon():GetClass() or "Unknown Weapon!", "LiteNetworkFont24", pos.x, pos.y + 40, PLUGIN.colors["red"], TEXT_ALIGN_CENTER)
                    else
                        draw.SimpleText("No Weapon!", "LiteNetworkFont24", pos.x, pos.y + 40, PLUGIN.colors["red"], TEXT_ALIGN_CENTER)
                    end
                end
            end

            for k, v in pairs(Schema.cityCodes) do
                local value = ix.config.Get("cityCode", 0)
        
                if (value == k) then
                    draw.SimpleText(tostring(v[1]), "LiteNetworkFont24", ScrW() / 2, 20, v[2] or color_white, TEXT_ALIGN_CENTER)
                end
            end
        else
            ply.adminHud = false
        end
    end
end