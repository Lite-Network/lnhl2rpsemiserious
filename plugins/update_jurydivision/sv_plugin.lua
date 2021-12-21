local PLUGIN = PLUGIN

util.AddNetworkString("ixInspectBodyFinish")
function PLUGIN:PlayerUse(ply, ent)
	if not ((ent.useCooldown or 0) < CurTime()) then
        return
    end

    if ( ent.player and ent.player:IsPlayer() and ent.attacker and ent.attacker:IsPlayer() and ply:IsCombine() and ( ply.ixCCADivision == 4 ) )  and not ( ent.alreadyUsed ) then
        ent.alreadyUsed = true
        ply:Freeze(true)
        ply:SetAction("Investigating...", 5, function()
            ply:Freeze(false)
            net.Start("ixInspectBodyFinish")
                net.WriteString(ent.weaponUsed or nil)
                net.WriteString(tostring(ent.playerName) or nil)
                net.WriteEntity(ent.attacker or nil)
            net.Send(ply)

            if ( ( ent.playerName:find("CCA:") ) or ( ent.playerName:find("OTA:") ) ) then
                Schema:AddCombineDisplayMessage("All Units.. new BOL suspect has been registered.. be advised!", Color(255, 255, 0), true)
            
                for k, v in pairs(player.GetAll()) do
                    if (v:IsCombine()) then
                        ix.util.EmitQueuedSounds(v, {
                            "npc/overwatch/radiovoice/on1.wav",
                            "npc/overwatch/radiovoice/attention.wav",
                            "npc/overwatch/radiovoice/allunitsbolfor243suspect.wav",
                            "npc/overwatch/radiovoice/noncitizen.wav",
                            "npc/overwatch/radiovoice/respond.wav",
                            "npc/overwatch/radiovoice/off4.wav",
                        }, 3, 0.2, 70)
                    end
                end

                timer.Simple(3, function()
                    ix.chat.Send(ply, "dispatchradioforce", "Attention, all units BOL for 243 suspect "..tostring(ent.attacker:Nick())..", respond.", false)
                end)
            end
        end)

        ent.useCooldown = CurTime() + 3
    elseif ( ent:GetClass() == "prop_ragdoll" ) and ( ent.alreadyUsed ) then
        ply:ChatNotify("It seems like the body has been investigated by a Jury Officer.")
        
        ent.useCooldown = CurTime() + 3
    end
end