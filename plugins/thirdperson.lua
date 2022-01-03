local PLUGIN = PLUGIN

PLUGIN.name = "Lite Network Revamped Thirdperson"
PLUGIN.author = "Riggs Mackay"
PLUGIN.description = "Enables third person camera usage, and forces you to use view bobbing."

ix.config.Add("thirdperson", false, "Allow Thirdperson in the server.", nil, {
	category = "server"
})

if (CLIENT) then
	ix.option.Add("thirdpersonEnabled", ix.type.bool, false, {
		category = "thirdperson",
		hidden = isHidden,
		OnChanged = function(oldValue, value)
			hook.Run("ThirdPersonToggled", oldValue, value)
		end
	})

	ix.option.Add("thirdpersonVertical", ix.type.number, 0, {
		category = "thirdperson", min = 0, max = 30,
		hidden = isHidden
	})

	ix.option.Add("thirdpersonHorizontal", ix.type.number, 0, {
		category = "thirdperson", min = -30, max = 30,
		hidden = isHidden
	})

	ix.option.Add("thirdpersonDistance", ix.type.number, 50, {
		category = "thirdperson", min = 0, max = 100,
		hidden = isHidden
	})

	concommand.Add("ix_togglethirdperson", function()
		local bEnabled = !ix.option.Get("thirdpersonEnabled", false)

		ix.option.Set("thirdpersonEnabled", bEnabled)
	end)

	function PLUGIN:ShouldDrawLocalPlayer()
        if ( LocalPlayer().ixIntroBool ) then
			return false
		end

		if not (IsValid(ix.gui.characterMenu) or (IsValid(ix.gui.menu) and IsValid(ix.gui.menu.projectedTexture))) then
			if ix.option.Get("thirdpersonEnabled") then
				return true
			end
		end
	end

	local headPosLerp
	local headAngleLerp
	function PLUGIN:CalcView(ply, origin, angles, fov)
        if ( ply.ixIntroBool ) then
			return false
		end
		
		local FrameTime = RealFrameTime()
		local view = {
			origin = origin,
			angles = angles,
			fov = fov,
		}

		if not ( headPosLerp ) then
			headPosLerp = origin
		end

		if not ( headAngleLerp ) then
			headAngleLerp = angles
		end

		if (ply and ply:Alive()) and not (ply:GetMoveType() == MOVETYPE_NOCLIP) then
			local newOrigin = ply:EyePos() - (view.angles:Forward() * ix.option.Get("thirdpersonDistance", false)) +
			( view.angles:Right() * ix.option.Get("thirdpersonHorizontal", false) ) +
			( view.angles:Up() * ix.option.Get("thirdpersonVertical", false) )
			
			headPosLerp = LerpVector(FrameTime * 10, headPosLerp, newOrigin)
			headAngleLerp = LerpAngle(FrameTime * 10, headAngleLerp, angles)

			view.origin = headPosLerp
			view.angles = headAngleLerp

			if ix.option.Get("thirdpersonEnabled") then
				if not (IsValid(ix.gui.characterMenu) or (IsValid(ix.gui.menu) and IsValid(ix.gui.menu.projectedTexture))) then
					if not (ply:GetNWEntity("ixRappeling") == true) then
						return view
					end
				end
			else
				headPosLerp = origin
				headAngleLerp = angles
			end
		end
	end
end