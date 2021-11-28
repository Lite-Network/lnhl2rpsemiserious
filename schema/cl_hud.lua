--[[---------------------------------------------------------------------------
	Clientside Hud
---------------------------------------------------------------------------]]--

local colorModify = {
	["$pp_colour_addr"] = 0,
	["$pp_colour_addg"] = 0,
	["$pp_colour_addb"] = 0,
	["$pp_colour_brightness"] = -0.03,
	["$pp_colour_contrast"] = 1,
	["$pp_colour_colour"] = 0.7,
	["$pp_colour_mulr"] = 0,
	["$pp_colour_mulg"] = 0,
	["$pp_colour_mulb"] = 0
}

local colorModifyStorm = {
	["$pp_colour_addr"] = 0,
	["$pp_colour_addg"] = 0.1,
	["$pp_colour_addb"] = 0.2,
	["$pp_colour_brightness"] = -0.03,
	["$pp_colour_contrast"] = 1,
	["$pp_colour_colour"] = 0.7,
	["$pp_colour_mulr"] = 0,
	["$pp_colour_mulg"] = 0.7,
	["$pp_colour_mulb"] = 0.8
}

function Schema:RenderScreenspaceEffects()
	if not (GetGlobalBool("ixAJStatus") == true) then
		if ix.option.Get("hudScreenEffect", true) then
			DrawColorModify(colorModify)
		end
	else
		DrawColorModify(colorModifyStorm)
	end
end

local healthIcon = ix.util.GetMaterial("litenetwork/icons/health.png")
local healthColor = Color(210, 0, 0, 255)
local tokensIcon = ix.util.GetMaterial("litenetwork/icons/money.png")
local tokensColor = Color(133, 227, 91, 255)
local hungerIcon = ix.util.GetMaterial("litenetwork/icons/hunger.png")
local hungerColor = Color(205, 133, 63, 255)
local xpIcon = ix.util.GetMaterial("litenetwork/icons/salary.png")
local xpColor = Color(63, 120, 205)
local surface = surface

local function DrawHud(ply, char) -- Hud inspiration from impulse.
	-- If anyone like smug comments that this is stolen, it aint, I just remade it so fuck off :)
	ix.util.DrawBlurAt(10, ScrH() - 200 - 10, 350, 200, 1)

	surface.SetDrawColor(ColorAlpha(team.GetColor(ply:Team()), 25))
	surface.DrawRect(10, ScrH() - 200 - 10, 350, 200)

	surface.SetDrawColor(Color(30, 30, 30, 100))
	surface.DrawRect(10, ScrH() - 200 - 10, 350, 200)

	surface.SetFont("LiteNetworkFont32")

	surface.SetTextColor(team.GetColor(ply:Team()))
	surface.SetTextPos(20, ScrH() - 200 - 10 + 5)
	surface.DrawText(team.GetName(ply:Team()))

	surface.SetTextColor(color_white)
	surface.SetTextPos(20, ScrH() - 50)
	surface.DrawText(ply:Name())

	surface.SetFont("LiteNetworkFont28")
	surface.SetTextPos(160, ScrH() - 200 - 10 + 50)
	surface.DrawText("Health: "..ply:Health())

	surface.SetDrawColor(healthColor)
	surface.SetMaterial(healthIcon)
	surface.DrawTexturedRect(130, ScrH() - 200 - 10 + 52.5, 25, 25)

	surface.SetTextPos(160, ScrH() - 200 - 10 + 75)
	surface.DrawText("Tokens: "..char:GetMoney())

	surface.SetDrawColor(tokensColor)
	surface.SetMaterial(tokensIcon)
	surface.DrawTexturedRect(130, ScrH() - 200 - 10 + 77.5, 25, 25)

	surface.SetTextPos(160, ScrH() - 200 - 10 + 100)
	surface.DrawText("Hunger: "..char:GetHunger())

	surface.SetDrawColor(hungerColor)
	surface.SetMaterial(hungerIcon)
	surface.DrawTexturedRect(130, ScrH() - 200 - 10 + 102.5, 25, 25)

	surface.SetTextPos(160, ScrH() - 200 - 10 + 125)
	surface.DrawText("XP: "..ply:GetXP())

	surface.SetDrawColor(xpColor)
	surface.SetMaterial(xpIcon)
	surface.DrawTexturedRect(130, ScrH() - 200 - 10 + 125, 25, 25)
end

local lastBodygroups = {}
local function DrawPlayerIcon(ply)
	if not IsValid(PlayerIcon) then
		PlayerIcon = vgui.Create("ixSpawnIcon")
		PlayerIcon:SetPos(20, ScrH() - 200 - 10 + 50) -- math go brr
		PlayerIcon:SetSize(100, 100)
		PlayerIcon:SetModel(ply:GetModel(), ply:GetSkin())

		timer.Simple(0, function()
			if not IsValid(PlayerIcon) then
				return
			end

			local ent = PlayerIcon.Entity

			if not (ent:GetModel() == ply:GetModel()) then
				PlayerIcon:SetModel(ply:GetModel())
			end

			if IsValid(ent) then
				for k, v in pairs(ply:GetBodyGroups()) do
					ent:SetBodygroup(v.id, ply:GetBodygroup(v.id))
				end
			end
		end)
	else
		timer.Simple(0, function()
			if not IsValid(PlayerIcon) then
				return
			end

			local ent = PlayerIcon.Entity

			if not (ent:GetModel() == ply:GetModel()) then
				PlayerIcon:SetModel(ply:GetModel())
			end

			if IsValid(ent) then
				for k, v in pairs(ply:GetBodyGroups()) do
					ent:SetBodygroup(v.id, ply:GetBodygroup(v.id))
					ent:SetSkin(ply:GetSkin())
				end
			end
		end)
	end
end

ix.gui.CombineHudMessagesList = {
	"Updating biosignal co-ordinates...",
	"Parsing heads-up display and data arrays...",
	"Working deconfliction with other ground assets...",
	"Transmitting physical transition vector...",
	"Sensoring proximity...",
	"Regaining equalization modules...",
	"Encoding network messages...",
	"Analyzing Overwatch protocols...",
	"Filtering incoming messages...",
	"Updating biosignal coordinates...",
	"Synchronizing database records...",
	"Appending all data to black box...",
}
ix.gui.CombineHudMessages = ix.gui.CombineHudMessages or {}
ix.gui.CombineHudMessageID = ix.gui.CombineHudMessageID or 0

function ix.gui.AddCombineDisplayMessage(text, col, sound, soundfile, font)
	local ply = LocalPlayer()

	ix.gui.CombineHudMessageID = ix.gui.CombineHudMessageID + 1
	text = "<:: "..string.upper(text)

	local data = {
		message = "",
		bgCol = col,
		messagefont = font or "BudgetLabel"
	}

	table.insert(ix.gui.CombineHudMessages, data)

	if (#ix.gui.CombineHudMessages > math.random(4,8)) then
		table.remove(ix.gui.CombineHudMessages, 1)
	end

	local i = 1
	local id = "ix.gui.CombineHudMessages.ID."..ix.gui.CombineHudMessageID

	timer.Create(id, 0.01, #text + 1, function()
		data.message = string.sub(text, 1, i + 2)
		i = i + 3

		if data.message == #text then
			timer.Remove(id)
		end
	end)

	if sound then
		ply:EmitSound(soundfile or "npc/roller/code2.wav")
	end
end

local nextMessage = 0
local lastMessage = ""

function Schema:Think()
	if IsValid(ix.gui.menu) or IsValid(ix.gui.characterMenu) then return end

	local ply = LocalPlayer()
	local char = ply:GetCharacter()

	if (nextMessage or 0) < CurTime() then
		local message = ix.gui.CombineHudMessagesList[math.random(1, #ix.gui.CombineHudMessagesList)]

		if message != (lastMessage or "") then
			ix.gui.AddCombineDisplayMessage(message, nil, false)
			lastMessage = message
		end

		nextMessage = CurTime() + math.random(4,20)
	end
end

local combatweapons = {
	["ix_usp"] = true,
	["ix_mp7"] = true,
	["ix_357"] = true,
	["ix_spas12"] = true,
	["ix_ar2"] = true,
}
local function DrawCombineHud(ply, char)
	local ply = LocalPlayer()
	local char = ply:GetCharacter()
	local pos = LocalPlayer():GetPos()
    local grid = math.Round(pos.x / 100).." / "..math.Round(pos.y / 100)
	local zone = ply:GetPlayerInArea() or "<UNDOCUMENTED ZONE>"

	for i = 1, #ix.gui.CombineHudMessages do
		local msgData = ix.gui.CombineHudMessages[i]
		msgData.y = msgData.y or 0

		surface.SetFont("BudgetLabel")
		local w, h = surface.GetTextSize(msgData.message)

		x, y = 10, ((i - 1) * h) + 5

		msgData.y = Lerp(0.07, msgData.y, y)

		draw.SimpleTextOutlined(msgData.message, "BudgetLabel", x, msgData.y, msgData.bgCol or color_white, nil, nil, 1, color_black)
	end

	-- City Codes
	draw.SimpleTextOutlined([[<:: // LOCAL INFORMATION ASSET \\ ::>]], "BudgetLabel", ScrW() / 2, 5, team.GetColor(ply:Team()), TEXT_ALIGN_CENTER, nil, 1, color_black)
	for k, v in pairs(Schema.cityCodes) do
		local value = ix.config.Get("cityCode", 0)

		if (value == k) then
			draw.SimpleTextOutlined("<:: CITY CODE: "..v[1].." ::>", "BudgetLabel", ScrW() / 2, 5 + 16, v[2] or color_white, TEXT_ALIGN_CENTER, nil, 1, color_black)
		end
	end

	-- Top Right
	draw.SimpleTextOutlined("// LOCAL ASSET ::>", "BudgetLabel", ScrW() - 10, 5, team.GetColor(ply:Team()), TEXT_ALIGN_RIGHT, nil, 1, color_black)
	draw.SimpleTextOutlined("VITALS: "..ply:Health().."% ::>", "BudgetLabel", ScrW() - 10, 5 + 16 * 2, color_white, TEXT_ALIGN_RIGHT, nil, 1, color_black)
	draw.SimpleTextOutlined("SPS CHARGE: "..ply:Armor().."% ::>", "BudgetLabel", ScrW() - 10, 5 + 16 * 3, color_white, TEXT_ALIGN_RIGHT, nil, 1, color_black)
	draw.SimpleTextOutlined("BIOSIGNAL GRID: "..grid.." ::>", "BudgetLabel", ScrW() - 10, 5 + 16 * 4, color_white, TEXT_ALIGN_RIGHT, nil, 1, color_black)
	draw.SimpleTextOutlined("BIOSIGNAL ZONE: "..zone.." ::>", "BudgetLabel", ScrW() - 10, 5 + 16 * 5, color_white, TEXT_ALIGN_RIGHT, nil, 1, color_black)
	draw.SimpleTextOutlined("AIR FILTER STATUS: 100% ::>", "BudgetLabel", ScrW() - 10, 5 + 16 * 6, color_white, TEXT_ALIGN_RIGHT, nil, 1, color_black)

	local y = 16

	if (ix.option.Get("showLocalAssets", true) == true) then
		draw.SimpleTextOutlined("<:: LOCAL ASSETS //", "BudgetLabel", 10, 5 + 16 * 10, team.GetColor(ply:Team()), nil, nil, 1, color_black)
		for k, v in SortedPairs(player.GetAll()) do
			if v:IsCombine() then
				local zone = v:GetPlayerInArea() or "<UNDOCUMENTED ZONE>"

				local health = v:Health().."%"
				if not v:Alive() then
					health = "<BIOSIGNAL LOST>"
				end
				draw.SimpleTextOutlined("<:: UNIT: "..string.upper(v:Nick()), "BudgetLabel", 10, (5 + 16 * 10) + y, color_white, nil, nil, 1, color_black)
				draw.SimpleTextOutlined(" | VITALS: "..v:Health(), "BudgetLabel", 250, (5 + 16 * 10) + y, color_white, nil, nil, 1, color_black)
				draw.SimpleTextOutlined(" | ZONE: "..string.upper(zone), "BudgetLabel", 350, (5 + 16 * 10) + y, color_white, nil, nil, 1, color_black)
				y = y + 16
			end
		end
	end

	if IsValid(ply:GetActiveWeapon()) and combatweapons[ply:GetActiveWeapon():GetClass()] then
		local weapon = ply:GetActiveWeapon()
		local weaponname = weapon:GetPrintName()
		local weaponammo1 = weapon:Clip1()
		local weaponammo2 = ply:GetAmmoCount(weapon:GetPrimaryAmmoType())
		local weaponammo3 = ply:GetAmmoCount(weapon:GetSecondaryAmmoType())
		local weaponprimarycolor = color_white

		if weaponammo1 == 0 then
			weaponammo1 = "N/A"
		end

		if weaponammo2 == 0 then
			weaponammo2 = "N/A"
		end

		if weaponammo3 == 0 then
			weaponammo3 = "N/A"
		end

		if weapon:GetClass() == "ix_mp7" then
			weaponname = "MP7"
		elseif weapon:GetClass() == "ix_usp" then
			weaponname = "USP MATCH"
		elseif weapon:GetClass() == "ix_357" then
			weaponname = "357 REVOLVER"
		elseif weapon:GetClass() == "ix_spas12" then
			weaponname = "SPAS-12 SHOTGUN"
		elseif weapon:GetClass() == "ix_ar2" then
			weaponname = "OSIPR"
		end

		if (weapon:Clip1() < weapon:GetMaxClip1() / 4) then
			weaponprimarycolor = Color(255, 0, 0)

			if ((ply.nextAmmoWarn or 0) < CurTime()) then
				ix.gui.AddCombineDisplayMessage("LOW ON DAGGERS.. RELOAD IMMEDIATELY!", weaponprimarycolor, true)

				ply.nextAmmoWarn = CurTime() + 20
			end
		end

		draw.SimpleTextOutlined("<:: LOCAL WEAPONRY //", "BudgetLabel", 10, (5 + 16 * 12) + y, team.GetColor(ply:Team()), nil, nil, 1, color_black)
		draw.SimpleTextOutlined("<:: FIREARM: "..string.upper(weaponname), "BudgetLabel", 10, (5 + 16 * 13) + y, color_white, nil, nil, 1, color_black)
		draw.SimpleTextOutlined("<:: AM: [ "..weaponammo1.." ] / [ "..weaponammo2.." ]", "BudgetLabel", 10, (5 + 16 * 14) + y, weaponprimarycolor, nil, nil, 1, color_black)
		draw.SimpleTextOutlined("<:: SC: [ "..weaponammo3.." ]", "BudgetLabel", 10, (5 + 16 * 15) + y, color_white, nil, nil, 1, color_black)
    end
end

local function DrawSpookyHud(ply)
	local ply = LocalPlayer()
	local char = ply:GetCharacter()
	if not ply.spookyText or ply.spookyText <= CurTime() then
		if (math.random(1, 1000) == math.random(1, 1000)) then
			draw.SimpleText(table.Random({
				"I need help..",
				"You can't let him win..",
				"Don't leave me.."..ply:Nick(),
				"Please die..",
				"It took them 4 hours..",
				"Xray 9 is human..",
				"Many conscripts have died during the attack...",
				"Ramirez will return..",
				"Ramirez will make chaos..",
				"The Nuke..",
				"2012..",
				"Shadow..",
				"Company..",
				"Lite Network will survive..",
				"November the 12th..",
				"ESCAPE.. ESCAPE.. ESCAPE.. ESCAPE..",
				"blue door.."}), "lnAkbarFontBig", ScrW() / math.random(1.5, 2.5), ScrH() / math.random(1.5, 2.5), Color(200, 0, 0), TEXT_ALIGN_CENTER, 0)

			ply.spookyText = CurTime() + math.random(300, 1800)
		end
	end
end

local function DrawPlayerInfo(ply)
	local ply = LocalPlayer()
	local char = ply:GetCharacter()

	for _, v in ipairs(player.GetAll()) do
		local v = v
		if (ply:GetPos():Distance(v:GetPos()) < 1024) and (v:IsLineOfSightClear(ply)) then
			if not v:Alive() then
				v.alpha = 0
				v.alpha2 = 0
			end

			if v:IsValid() and v:Alive() and v:GetCharacter() and not (v:GetMoveType() == MOVETYPE_NOCLIP) then
				local HeadBone = v:EyePos() + Vector(0, 0, 10)
				local HeadPos = HeadBone:ToScreen()

				local headpos_x = HeadPos.x
				local headpos_y = HeadPos.y

				v.alpha = v.alpha or 0
				v.alpha2 = v.alpha2 or 0

				local teamcol = team.GetColor(v:Team())
				local team = team.GetName(v:Team())
				local distance = ply:GetPos():Distance(v:GetPos())
				local lineofsight = v:IsLineOfSightClear(ply)
				local entitytrace = ply:GetEyeTrace().Entity == v
				local talking = (v.ixVoiceTalking == true)
				local name = v:Nick()
				local namecolor = Color(teamcol.r, teamcol.g, teamcol.b, v.alpha)
				local health = v:Health()

				if talking then
					draw.DrawText("Talking..", "ixMediumFont", headpos_x, headpos_y - ScreenScale(12), Color(200, 200, 200, v.alpha2), TEXT_ALIGN_CENTER)
				end

				if v:GetNetVar("IsAFK") then
					draw.DrawText("AWAY FROM KEYBOARD (AFK)", "ixMediumFont", headpos_x, headpos_y - ScreenScale(24), Color(200, 0, 0, v.alpha2), TEXT_ALIGN_CENTER)
				end

				if health >= 1 then
					draw.DrawText(name, "ixMediumFont", headpos_x, headpos_y - ScreenScale(4), Color(teamcol.r, teamcol.g, teamcol.b, v.alpha), TEXT_ALIGN_CENTER)

					if health >= 100 then
						draw.DrawText("Healthy", "ixSmallFont", headpos_x, headpos_y + ScreenScale(4), Color(0, 255, 0, v.alpha), TEXT_ALIGN_CENTER)
					elseif health >= 80 then
						draw.DrawText("Wounded", "ixSmallFont", headpos_x, headpos_y + ScreenScale(4), Color(200, 180, 0, v.alpha), TEXT_ALIGN_CENTER)
					elseif health >= 60 then
						draw.DrawText("Injured", "ixSmallFont", headpos_x, headpos_y + ScreenScale(4), Color(210, 150, 0, v.alpha), TEXT_ALIGN_CENTER)
					elseif health >= 40 then
						draw.DrawText("Looks Injured", "ixSmallFont", headpos_x, headpos_y + ScreenScale(4), Color(230, 100, 0, v.alpha), TEXT_ALIGN_CENTER)
					elseif health >= 20 then
						draw.DrawText("Looks Seriously Injured", "ixSmallFont", headpos_x, headpos_y + ScreenScale(4), Color(230, 40, 0, v.alpha), TEXT_ALIGN_CENTER)
					elseif health >= 0 then
						draw.DrawText("Very close to death", "ixSmallFont", headpos_x, headpos_y + ScreenScale(4), Color(150, 0, 0, v.alpha - math.random(20, 100)), TEXT_ALIGN_CENTER)
					end
				end

				if distance < 256 and lineofsight and entitytrace then
					v.alpha = Lerp(0.05, v.alpha, 255)
				else
					v.alpha = Lerp(0.05, v.alpha, 0)
				end

				if distance < 512 and lineofsight then
					v.alpha2 = Lerp(0.05, v.alpha2, 255)
				else
					v.alpha2 = Lerp(0.05, v.alpha2, 0)
				end
			end
		end
	end
end

function Schema:HUDPaint()
	local ply = LocalPlayer()
	local char = ply:GetCharacter()

	if (ply:IsValid() and ply:Alive() and char) then
		if ix.hudEnabled == false or (ix.CinematicIntro and ply:Alive()) or (IsValid(ix.gui.menu) or IsValid(ix.gui.characterMenu)) or (hook.Run("ShouldDrawHUDBox") == false) then
			if IsValid(PlayerIcon) then
				PlayerIcon:Remove()
			end
			return false
		end

		if ix.option.Get("hudDrawBox", true) then
			DrawHud(ply, char)
			DrawPlayerIcon(ply, char)
		end
		
		if ix.option.Get("hudDrawPlayerInformation", true) then
			DrawPlayerInfo(ply)
		end

		if ply:IsCombine() then
			DrawCombineHud(ply, char)
		end

		DrawSpookyHud(ply, char)
	else
		if IsValid(PlayerIcon) then
			PlayerIcon:Remove()
		end
	end
end

local letterBoxFade = 0
local letterBoxTitleFade = 0
local letterBoxHoldTime = nil
ix.CinematicholdTime = 10
function Schema:HUDPaintBackground()
	local ply = LocalPlayer()
	local char = ply:GetCharacter()
	local ft = FrameTime()

	if ix.CinematicIntro and ply:Alive() then
		local letterBoxHeight = ScrH() / 8

		if letterBoxHoldTime and letterBoxHoldTime + ix.CinematicholdTime + 4 < CurTime() then
			letterBoxFade = Lerp(ft, letterBoxFade, 0)
			letterBoxTitleFade = Lerp(ft * 4, letterBoxTitleFade, 0)

			if letterBoxFade <= 0.01 then
				ix.CinematicIntro = false
			end
		elseif letterBoxHoldTime and letterBoxHoldTime + ix.CinematicholdTime < CurTime() then
			letterBoxTitleFade = Lerp(ft * 4, letterBoxTitleFade, 0)
		else
			letterBoxFade = Lerp(ft, letterBoxFade, 1)

			if letterBoxFade >= 0.9 then
				letterBoxTitleFade = Lerp(ft, letterBoxTitleFade, 1)
				letterBoxHoldTime = letterBoxHoldTime or CurTime()
			end
		end

		surface.SetDrawColor(color_black)
		surface.DrawRect(0, 0, ScrW(), (letterBoxHeight * letterBoxFade))
		surface.DrawRect(0, (ScrH() - (letterBoxHeight * letterBoxFade)) + 1, ScrW(), letterBoxHeight)

		draw.DrawText(ix.CinematicTitle, "ixTitleFont", 20, ScrH() - ScreenScale(20) * 2, ColorAlpha(color_white, (255 * letterBoxTitleFade)))
	else
		letterBoxTitleFade = 0
		letterBoxHoldTime = nil
	end
end