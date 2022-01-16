--[[---------------------------------------------------------------------------
	Clientside Fonts
---------------------------------------------------------------------------]]--

surface.CreateFont("BroadcastFont", {
	font = "Cambria",
	size = 24,
	weight = 800,
	antialias = true,
	shadow = true,
	italic = true,
})

surface.CreateFont("AdminChatFont", {
	font = "Cambria",
	size = 18,
	weight = 800,
	antialias = true,
	shadow = true,
})

surface.CreateFont("RadioFont", {
	font = "Segoe Ui",
	size = 24,
	antialias = true,
	shadow = true,
	scanlines = 2,
	blursize = 0.5,
})

surface.CreateFont("lnAkbarFontBig", {
	font = "akbar",
	size = ScreenScale(20),
})

for value = 8, 64 do
	surface.CreateFont("LiteNetworkFont"..tostring(value), {
		font = "Segoe Ui",
		size = tonumber(value),
		weight = 400,
		antialias = true,
		shadow = false,
	})

	surface.CreateFont("LiteNetworkFont"..tostring(value).."-Light", {
		font = "Segoe Ui Light",
		size = tonumber(value),
		weight = 100,
		antialias = true,
		shadow = false,
	})
end

surface.CreateFont("ixCustomChatFont", {
	font = "Segoe Ui",
	size = 24 * ix.option.Get("chatFontScale", 1),
	weight = 400,
	antialias = true,
	shadow = false,
})

surface.CreateFont("ixCustomYellChatFont", {
	font = "Segoe Ui",
	size = 32 + ix.option.Get("chatFontScale", 1),
	weight = 800,
	antialias = true,
	shadow = false,
})

surface.CreateFont("ixCustomWhisperChatFont", {
	font = "Segoe Ui",
	size = 18 + ix.option.Get("chatFontScale", 1),
	weight = 0,
	antialias = true,
	shadow = false,
})

surface.CreateFont("ixCustomPerformingChatFont", {
	font = "Segoe Ui",
	size = 24 + ix.option.Get("chatFontScale", 1),
	weight = 200,
	antialias = true,
	extended = true,
})