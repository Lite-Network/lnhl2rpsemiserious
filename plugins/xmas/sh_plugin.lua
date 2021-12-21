local PLUGIN = PLUGIN
PLUGIN.name = "Christmas"
PLUGIN.author = "Bilwin & Riggs Mackay"
PLUGIN.Active = "winter"
PLUGIN.Seasons = {
    ["winter"] = {
        fogColor = Vector(135, 206, 235),
        fogStart = 500,
        fogEnd = 1300,
        fogDensity = 0.15,
        fogFade = 0
    },
    ["summer"] = {
        fogColor = Vector(170, 100, 31),
        fogStart = 500,
        fogEnd = 1300,
        fogDensity = 0.15,
        fogFade = 0
    }
}

if ( CLIENT ) then
    local activeSeasonData = PLUGIN.Seasons[PLUGIN.Active]
    local newFogData = {
        ["fog_start"] = activeSeasonData.fogStart,
        ["fog_end"] = activeSeasonData.fogEnd,
        ["fog_color"] = activeSeasonData.fogColor,
        ["fog_max_density"] = activeSeasonData.fogDensity,
        ["fog_fade"] = activeSeasonData.fogFade
    }

    local function SetupFog()
        render.FogMode(MATERIAL_FOG_LINEAR)
            render.FogStart(newFogData.fog_start)
            render.FogEnd(newFogData.fog_end)
            render.FogColor(newFogData.fog_color.r, newFogData.fog_color.g, newFogData.fog_color.b)
        render.FogMaxDensity(math.Clamp(newFogData.fog_max_density * ( newFogData.fog_fade or 0 ), 0.19, 1))

        return true
    end

    PLUGIN.SetupWorldFog = SetupFog
    PLUGIN.SetupSkyboxFog = SetupFog

    local nextSnow = 0
    function PLUGIN:Think()
        if ( nextSnow > CurTime() ) then return end

        local tr = util.TraceLine({
            start = LocalPlayer():EyePos(),
            endpos = LocalPlayer():EyePos() + Vector(0, 0, 10000),
            filter = function(ent)
                if ent:IsPlayer() then 
                    return false 
                end

                return true
            end
        })

        LocalPlayer().InSnow = true

        if tr.HitSky then
            LocalPlayer().InSnow = true

            local snow = EffectData()
            snow:SetMagnitude(math.random(10,50))
            snow:SetScale(math.random(2.0,7.0))
            snow:SetRadius(LocalPlayer():GetPos().z + math.random(256,1024))

            util.Effect("ixSnowEffect", snow)
        else
            LocalPlayer().InSnow = false
        end

        nextSnow = CurTime() + 0.05
    end
end