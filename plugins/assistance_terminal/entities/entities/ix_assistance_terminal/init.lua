AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/props_combine/combine_smallmonitor001.mdl")
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:SetSolid(SOLID_VPHYSICS)

    self:SetNetVar("alarm", false)
end

function ENT:Use(ply)
    local combineAvailable

    for k, v in pairs(player.GetAll()) do
        if ( v:IsCombine() ) then
            combineAvailable = true

            break
        end
    end
    combineAvailable = true
    
    if ( combineAvailable) then
        if not ( ply:IsCombine() ) then
            if ( ply:IsCitizen() or ply:IsCWU() or ply:IsVortigaunt() ) then
                local area = ply:GetArea()
                
                if ( !area or area == "" ) then
                    area = "Unknown Location"
                end

                self:SetNetVar("alarm", true)
                self:SetNetVar("requester", ply:Nick())

                ix.chat.Send(ply, "dispatchradio", "Attention all units, Asisstance Terminal has been triggered at "..area..", requested by "..ply:Nick(), false, nil)

                local waypoint = {
                    pos = ply:EyePos(),
                    text = "Terminal Request - "..ply:Nick().." | "..area,
                    color = team.GetColor(ply:Team()),
                    addedBy = ply,
                    time = CurTime() + 180
                }

                self:SetNetVar("waypoint", #waypointPlugin.waypoints) -- Save the waypoint index for easy access later.

                waypointPlugin:AddWaypoint(waypoint)
            else
                ply:Notify("You need an Identification Card to use the Assistance Terminal!")
            end
        elseif ( self:GetNetVar("alarm", false) ) then
            self:SetNetVar("alarm", false)
            self:SetNetVar("requester", nil)

            local waypointIndex = self:GetNetVar("waypoint")

            if ( waypointIndex ) then
                waypointPlugin:UpdateWaypoint(waypointIndex, nil)

                self:SetNetVar("waypoint", nil)
            end
        end
    else
        ply:Notify("There are no officers available at this time!")
    end
end

function ENT:Think()
    if ( ( self.NextAlert or 0 ) <= CurTime() and self:GetNetVar("alarm") ) then
        self.NextAlert = CurTime() + 3

        self:EmitSound("ambient/alarms/klaxon1.wav", 80, 70)
        self:EmitSound("ambient/alarms/klaxon1.wav", 80, 80)

        self:SetNetVar("alarmLights", true)
        
        timer.Simple(2, function()
            self:SetNetVar("alarmLights", false)
        end)
    end

    self:NextThink(CurTime() + 2)
end
