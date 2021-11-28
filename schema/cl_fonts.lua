--[[---------------------------------------------------------------------------
	Clientside Fonts
---------------------------------------------------------------------------]]--

surface.CreateFont("BroadcastFont", {
	font = "Cambria",
	size = ScreenScale(7),
	weight = 800,
	antialias = true,
	shadow = true,
	italic = true,
})

surface.CreateFont("AdminChatFont", {
	font = "Cambria",
	size = ScreenScale(6),
	weight = 800,
	antialias = true,
	shadow = true,
})

surface.CreateFont("RadioFont", {
	font = "Consolas",
	size = ScreenScale(7),
	shadow = true,
	italic = true,
	scanlines = 2,
	blursize = 0.5,
})

surface.CreateFont("lnAkbarFontBig", {
	font = "akbar",
	size = ScreenScale(20),
})

surface.CreateFont("LiteNetworkFont24", {
	font = "Segoe Ui",
	size = 24,
	weight = 400,
	antialias = true,
	shadow = false,
})

surface.CreateFont("LiteNetworkFont28", {
	font = "Segoe Ui",
	size = 28,
	weight = 400,
	antialias = true,
	shadow = false,
})

surface.CreateFont("LiteNetworkFont32", {
	font = "Segoe Ui",
	size = 32,
	weight = 800,
	antialias = true,
	shadow = false,
})

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