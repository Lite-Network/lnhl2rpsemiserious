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