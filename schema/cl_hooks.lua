--[[---------------------------------------------------------------------------
	Clientside Hooks
---------------------------------------------------------------------------]]--

function Schema:OnReloaded()
	if ((ix.luaReloaded or 0) < CurTime()) then
		for k, v in pairs(player.GetAll()) do
			v:ChatNotify("Lua has been refreshed!")
			--surface.PlaySound("vo/k_lab/ba_pushinit.wav")
		end

		ix.luaReloaded = CurTime() + 5
	end
	
	ix.option.Set("disableAnimations", false, true)
	ix.option.Set("cheapBlur", false, true)
	ix.option.Set("language", "english", true)
	ix.option.Set("observerTeleportBack", false, true)
	ix.option.Set("observerESP", false, true)

	ix.option.stored["minimalTooltips"].hidden = function() return true end
	ix.option.stored["alwaysShowBars"].hidden = function() return true end
	ix.option.stored["animationScale"].hidden = function() return true end
	ix.option.stored["24hourTime"].hidden = function() return true end
	ix.option.stored["openBags"].hidden = function() return true end
	ix.option.stored["disableAnimations"].hidden = function() return true end
	ix.option.stored["cheapBlur"].hidden = function() return true end
	ix.option.stored["language"].hidden = function() return true end
	ix.option.stored["observerTeleportBack"].hidden = function() return true end
	ix.option.stored["observerESP"].hidden = function() return true end
	ix.option.stored["altLower"].hidden = function() return true end
	ix.option.stored["showIntro"].hidden = function() return true end
end

function Schema:BuildBusinessMenu()
	if not LocalPlayer():IsCWU() then return false end

	local bHasItems = false

	for k, _ in pairs(ix.item.list) do
		if (hook.Run("CanPlayerUseBusiness", LocalPlayer(), k) != false) then
			bHasItems = true

			break
		end
	end

	return bHasItems
end

function Schema:MessageReceived()
	if (system.IsWindows() and !system.HasFocus()) then
		system.FlashWindow()
	end
end

function Schema:CreateClientsideRagdoll()
	return false
end

function Schema:OnAchievementAchieved()
	return false
end

function Schema:PostProcessPermitted()
	return false
end

function Schema:ShouldHideBars()
	return true
end

function Schema:IsPlayerRecognized()
	return true
end

function Schema:ShouldDrawCrosshair()
	return false
end

function Schema:ShouldDisplayArea()
	return false
end

function Schema:CanPlayerJoinClass()
	return false
end

function Schema:PlayerFootstep()
	return true
end

function Schema:PopulateCharacterInfo()
	return false
end

function Schema:PopulateImportantCharacterInfo()
	return false
end