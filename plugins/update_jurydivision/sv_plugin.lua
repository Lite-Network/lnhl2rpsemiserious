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
                    ent.attacker:SetNWBool("ixActiveBOL", true)
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

function PLUGIN:PlayerDeath(ply, inflictor, attacker)
    ply:SetNWBool("ixActiveBOL", false)
end

concommand.Add("ix_hl2rp_activate_bol", function(ply, cmd, args)
	if ( args[1] and ply:IsAdmin() ) then
		local target = ix.util.FindPlayer(args[1])

        if not ( target and target:IsPlayer() ) then
            ply:Notify(tostring(args[1]).." is a invalid person!")
            return false
        end

		target:SetNWBool("ixActiveBOL", true)

        ply:Notify("You put a BOL on "..target:Nick().."!")
	end
end)

concommand.Add("ix_hl2rp_deactivate_bol", function(ply, cmd, args)
	if ( args[1] and ply:IsAdmin() ) then
		local target = ix.util.FindPlayer(args[1])

        if not ( target and target:IsPlayer() ) then
            ply:Notify(tostring(args[1]).." is a invalid person!")
            return false
        end

		target:SetNWBool("ixActiveBOL", false)

        ply:Notify("You lifted "..target:Nick().."'s BOL!")
	end
end)