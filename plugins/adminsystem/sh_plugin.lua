local PLUGIN = PLUGIN

PLUGIN.name = "Lite Network Admin System"
PLUGIN.author = "Riggs Mackay"
PLUGIN.description = "Tools for Moderators and Admins."


function Schema:PlayerConnect(name, ip)
	print(name, " ip: ", ip)
end

if (CLIENT) then
    PLUGIN.colors = {
        ["red"] = Color(230, 0, 0),
        ["orange"] = Color(230, 70, 0),
        ["white"] = Color(230, 230, 230),
    }

    function PLUGIN:HUDPaint()
        if not ( LocalPlayer().ixIntroBool ) then
            local ply = LocalPlayer()
            local char = ply:GetCharacter()

            if not ( char ) then
                return
            end

            if ( char ) and ( ply:IsAdmin() ) and ( ply:GetMoveType() == MOVETYPE_NOCLIP ) and not ( ply:InVehicle() ) then
                ply.adminHud = true
                local onDuty = ix.option.Get("adminOnDuty") or false

                if ( onDuty ) then
                    draw.SimpleText("ADMIN MODE", "LiteNetworkFont24", 20, 20, PLUGIN.colors["white"])
                else
                    draw.SimpleText("ADMIN MODE ( OFF DUTY )", "LiteNetworkFont24", 20, 20, PLUGIN.colors["orange"])
                end

                if ( ply:IsSuperAdmin() ) then
                    local y = 60
                    for k, v in pairs(player.GetAll()) do
                        if ( v:IsAdmin() ) then
                            draw.SimpleText(v:SteamName().." ("..v:Nick()..") - "..team.GetName(v:Team()), "LiteNetworkFont24", 20, y, PLUGIN.colors["white"])
                            y = y + 20
                        end
                    end
                end
                
                for k, v in SortedPairs(player.GetAll()) do
                    local targetedPlayer = v
                    if ( targetedPlayer:IsValid() and targetedPlayer:GetCharacter() ) then
                        local pos = (v:GetPos() + Vector(0, 0, 40)):ToScreen()
                        local teamColor = team.GetColor(targetedPlayer:Team())

                        draw.SimpleText(targetedPlayer:Nick(), "LiteNetworkFont24", pos.x, pos.y, teamColor, TEXT_ALIGN_CENTER)
                        draw.SimpleText(targetedPlayer:SteamName(), "LiteNetworkFont24", pos.x, pos.y + 20, PLUGIN.colors["white"], TEXT_ALIGN_CENTER)

                        if ( targetedPlayer:GetActiveWeapon():IsValid() ) then
                            draw.SimpleText(targetedPlayer:GetActiveWeapon():GetClass() or "Unknown Weapon!", "LiteNetworkFont24", pos.x, pos.y + 40, PLUGIN.colors["red"], TEXT_ALIGN_CENTER)
                        else
                            draw.SimpleText("No Weapon!", "LiteNetworkFont24", pos.x, pos.y + 40, PLUGIN.colors["red"], TEXT_ALIGN_CENTER)
                        end
                    end
                end

                for k, v in pairs(ix.cityCodes) do
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
end