local PLUGIN = PLUGIN

PLUGIN.name = "Third Person & View bobbing"
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
		if not (IsValid(ix.gui.characterMenu) or (IsValid(ix.gui.menu) and IsValid(ix.gui.menu.projectedTexture))) then
			if ix.option.Get("thirdpersonEnabled") then
				return true
			end
		end
	end

	local headPosLerp = Vector(0, 0, 0)
	local headAngleLerp = Angle(0, 90, 0)
	function PLUGIN:CalcView(ply, origin, angles, fov)
		local rl = RealTime()
		local view = {
			origin = origin,
			angles = angles,
			fov = fov,
		}

		if (ply and ply:Alive()) and not (ply:GetMoveType() == MOVETYPE_NOCLIP) then
			local head = ply:LookupAttachment("eyes")
			head = ply:GetAttachment(head)

			if not head or not head.Pos then return end

			headPosLerp = LerpVector(0.1, headPosLerp, head.Pos)
			headAngleLerp = LerpAngle(0.1, headAngleLerp, angles)

			local forwardmultiply = view.angles:Forward()

			if ply:IsVortigaunt() then
				forwardmultiply = (forwardmultiply / 1.5) * 2
			else
				forwardmultiply = view.angles:Forward()
			end

			view.origin = headPosLerp - (forwardmultiply * ix.option.Get("thirdpersonDistance", false)) +
			( view.angles:Right() * ix.option.Get("thirdpersonHorizontal", false) ) +
			( view.angles:Up() * ix.option.Get("thirdpersonVertical", false) )
			view.angles = headAngleLerp

			if ix.option.Get("thirdpersonEnabled") then
				if not (IsValid(ix.gui.characterMenu) or (IsValid(ix.gui.menu) and IsValid(ix.gui.menu.projectedTexture))) then
					if not (ply:GetNWEntity("ixRappeling") == true) then
						return view
					end
				end
			else
				headPosLerp = head.Pos
				headAngleLerp = angles
			end
		end
	end
end