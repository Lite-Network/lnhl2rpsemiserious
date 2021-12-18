
local PLUGIN = PLUGIN
local _tonumber = tonumber
local _math_ceil = math.ceil
local _SoundDuration = SoundDuration
local _Ambients_Cooldown = 10

PLUGIN.name = "Ambient Music"
PLUGIN.description = "Adds background music (ply-side)"
PLUGIN.author = "Bilwin"
PLUGIN.schema = "Any"
PLUGIN.songs = {
	{path = "LiteNetwork/hl2rp/music/passive/passivemusic_1.ogg", duration = 82},
	{path = "LiteNetwork/hl2rp/music/passive/passivemusic_2.ogg", duration = 130},
	{path = "LiteNetwork/hl2rp/music/passive/passivemusic_3.ogg", duration = 92},
	{path = "LiteNetwork/hl2rp/music/passive/passivemusic_4.ogg", duration = 123},
	{path = "LiteNetwork/hl2rp/music/passive/passivemusic_5.ogg", duration = 212},
	{path = "LiteNetwork/hl2rp/music/passive/passivemusic_6.ogg", duration = 207},
	{path = "LiteNetwork/hl2rp/music/passive/passivemusic_7.ogg", duration = 243},
	{path = "LiteNetwork/hl2rp/music/passive/passivemusic_8.ogg", duration = 268},
	{path = "LiteNetwork/hl2rp/music/passive/passivemusic_9.ogg", duration = 150},
	{path = "LiteNetwork/hl2rp/music/passive/passivemusic_10.ogg", duration = 258},
	{path = "LiteNetwork/hl2rp/music/passive/passivemusic_11.ogg", duration = 336},
	{path = "LiteNetwork/hl2rp/music/passive/passivemusic_12.ogg", duration = 257},
	{path = "LiteNetwork/hl2rp/music/passive/passivemusic_13.ogg", duration = 438},
	{path = "LiteNetwork/hl2rp/music/passive/passivemusic_14.ogg", duration = 126},
	{path = "LiteNetwork/hl2rp/music/passive/passivemusic_15.ogg", duration = 126},
	{path = "LiteNetwork/hl2rp/music/passive/passivemusic_16.ogg", duration = 247},
	{path = "LiteNetwork/hl2rp/music/passive/passivemusic_17.ogg", duration = 270},
	{path = "LiteNetwork/hl2rp/music/passive/passivemusic_18.ogg", duration = 319},
	{path = "LiteNetwork/hl2rp/music/passive/passivemusic_19.ogg", duration = 97},
	{path = "LiteNetwork/hl2rp/music/passive/passivemusic_20.ogg", duration = 207},
}

ix.lang.AddTable("english", {
	optEnableAmbient = "Enable ambient",
    optAmbientVolume = "Ambient volume"
})

if (CLIENT) then
    m_flAmbientCooldown = m_flAmbientCooldown or 0
    bAmbientPreSaver = bAmbientPreSaver or false

    ix.option.Add("enableAmbient", ix.type.bool, true, {
		category = PLUGIN.name,
        OnChanged = function(oldValue, value)
            if (value) then
                if IsValid(PLUGIN.ambient) then
                    local volume = ix.option.Get("ambientVolume", 1)
                    PLUGIN.ambient:SetVolume(volume)
                end
            else
                if IsValid(PLUGIN.ambient) then
                    PLUGIN.ambient:SetVolume(0)
                end
            end
        end
	})

	ix.option.Add("ambientVolume", ix.type.number, 0.5, {
		category = PLUGIN.name,
        min = 0.1,
        max = 2,
        decimals = 1,
        OnChanged = function(oldValue, value)
            if IsValid(PLUGIN.ambient) and ix.option.Get("enableAmbient", true) then
                PLUGIN.ambient:SetVolume(value)
            end
        end
	})

    do
        if !table.IsEmpty(PLUGIN.songs) then
            for _, data in ipairs(PLUGIN.songs) do
                util.PrecacheSound(data.path)
            end
        end
    end

    function PLUGIN:CreateAmbient()
        local bEnabled = ix.option.Get('enableAmbient', true)

        if (bEnabled and !bAmbientPreSaver) then
            local flVolume = _tonumber(ix.option.Get('ambientVolume', 1))
            local mSongTable = self.songs[math.random(1, #self.songs)]
            local mSongPath = mSongTable.path
            local mSongDuration = mSongTable.duration or _SoundDuration(mSongPath)

            sound.PlayFile('sound/' .. mSongTable.path, 'noblock', function(radio)
                if IsValid(radio) then
                    if IsValid(self.ambient) then self.ambient:Stop() end

                    radio:SetVolume(flVolume)
                    radio:Play()
                    self.ambient = radio

                    m_flAmbientCooldown = os.time() + _tonumber(mSongDuration) + _Ambients_Cooldown
                end
            end)
        end
    end

    net.Receive('ixPlayAmbient', function()
        if !timer.Exists('mAmbientMusicChecker') then
            timer.Create('mAmbientMusicChecker', 5, 0, function()
                if (m_flAmbientCooldown or 0) > os.time() then return end
                PLUGIN:CreateAmbient()
            end)
        end

        if !timer.Exists('mAmbientChecker') then
            timer.Create('mAmbientChecker', 0.5, 0, function()
                if IsValid(ix.gui.characterMenu) and ix.config.Get("music") ~= "" then
                    if IsValid(PLUGIN.ambient) then
                        PLUGIN.ambient:SetVolume(0)
                    end
                else
                    if ix.option.Get('enableAmbient', true) then
                        if IsValid(PLUGIN.ambient) then
                            local volume = ix.option.Get("ambientVolume", 1)
                            PLUGIN.ambient:SetVolume(volume)
                        end
                    end
                end
            end)
        end
    end)
end

if (SERVER) then
    util.AddNetworkString('ixPlayAmbient')
    function PLUGIN:PlayerLoadedCharacter(ply, character, currentChar)
        net.Start('ixPlayAmbient')
        net.Send(ply)
    end
end