--[[---------------------------------------------------------------------------
	Initializing Extra Command Classes
---------------------------------------------------------------------------]]--

ix.command.Add("Tie", {
	description = "Tie someone infront of you.",
	OnCheckAccess = function(_, ply)
		return ply:IsCombine() or ply:IsRebel()
	end,
	OnRun = function(itemTable, ply)
		local data = {}
			data.start = ply:GetShootPos()
			data.endpos = data.start + ply:GetAimVector() * 96
			data.filter = ply
		local target = util.TraceLine(data).Entity

		if (IsValid(target) and target:IsPlayer() and target:GetCharacter()
		and !target:GetNetVar("tying") and !target:IsRestricted()) then
			ply:SetAction("You are tying "..target:Nick(), 3)

			ply:DoStaredAction(target, function()
				if ( SERVER ) then target:Freeze(true) end
				target:SetRestricted(true)
				target:SetNetVar("tying")
				target:NotifyLocalized("fTiedUp")

				if (target:IsCombine()) then
					local location = target:GetArea() or "unknown location"

					Schema:AddCombineDisplayMessage("Downloading lost radio contact information...")
					Schema:AddCombineDisplayMessage("WARNING! Radio contact lost for unit at "..location.."...", Color(255, 0, 0, 255), true)
				end
			end, 3, function()
				ply:SetAction()

				target:SetAction()
				target:SetNetVar("tying")
			end)

			target:SetNetVar("tying", true)
			target:SetAction("You are being tied by "..ply:Nick(), 3)

			ply.ixDraggedTarget = target
			target.ixDraggedBy = ply
		else
			ply:NotifyLocalized("plyNotValid")
		end
	end
})

ix.command.Add("Apply", {
	description = "Prints your Name and Team.",
	OnRun = function(_, ply)
		if (SERVER) then
			ix.chat.Send(ply, "me", "shows their identification card showing: (Name: "..ply:Nick().." | Affiliation: "..team.GetName(ply:Team())..") ", false)
		end
	end
})

ix.command.Add("ForceRespawn", {
	description = "Forcefully respawn yourself.",
	OnRun = function(_, ply)
		if not (ply:IsAdmin()) then
			return "You do not have access to this command!"
		end
		ply:Spawn()
		if ply.deathPos and ply.deathAngles then
			ply:SetPos(ply.deathPos)
			ply:SetAngles(ply.deathAngles)
		end
	end
})

ix.command.Add("Discord", {
	description = "Join our Discord Server!",
	OnRun = function(_, ply)
		ply:SendLua([[gui.OpenURL("https://discord.gg/xWfkwBvAc4")]])
	end
})

ix.command.Add("Content", {
	description = "Get our Server's Content Pack.",
	OnRun = function(_, ply)
		ply:SendLua([[gui.OpenURL("https://steamcommunity.com/sharedfiles/filedetails/?id=2631631230")]])
	end
})

ix.command.Add("CharFallOver", {
	description = "@cmdCharFallOver",
	arguments = bit.bor(ix.type.number, ix.type.optional),
	OnRun = function(self, ply, time)
		if ply:IsAdmin() then
			ply:Notify("Your character fell over, do not abuse it.")
		else
            ply:Notify("You need to be a staff member to fall over!")
			return false
		end

		if (!ply:Alive() or ply:GetMoveType() == MOVETYPE_NOCLIP) then
			return "@notNow"
		end

		if (time and time > 0) then
			time = math.Clamp(time, 1, 60)
		end

		if (!IsValid(ply.ixRagdoll)) then
			ply:SetRagdolled(true, time)
		end
	end
})

ix.command.Add("SetModel", {
	description = "Set your model as a staff member.",
	arguments = ix.type.string,
	OnRun = function(_, ply, chosenModel)
		if not ply:IsAdmin() then
			return "You need to be a staff member to change your model!"
		end

		ply:SetModel(tostring(chosenModel))
	end
})

ix.command.Add("Search", {
	description = "Search the person tied infront of you.",
	OnRun = function(self, ply)
        local data = {}
        data.start = ply:GetShootPos()
        data.endpos = data.start + ply:GetAimVector() * 96
        data.filter = ply
        local target = util.TraceLine(data).Entity
    
        if (IsValid(target) and target:IsPlayer() and target:IsRestricted()) then
            if (!ply:IsRestricted()) then
                Schema:SearchPlayer(ply, target)
            else
                return "@notNow"
            end
        end
	end
})

ix.command.Add("ToggleSecondZoneGate", {
	description = "Opens the 404 Zone Sector 2 combine gate.",
	OnRun = function(_, ply)
		if not (ply:IsCombineCommand() or ply:IsAdmin()) then
			ply:Notify("You need to be a higher ranking to open the gate.")
			return false
		end

		for k, v in pairs(ents.FindByName("zone2_404zone_gate_1")) do
			if ( !v.Opened ) then
				Schema:AddCombineDisplayMessage("Attention Sector 2 404 Zone Gate has been opened", Color(255, 0, 0), true)
				v:Fire("SetAnimation", "open")
				v:EmitSound("ambient/machines/wall_move1.wav", 90)

				v:EmitSound("LiteNetwork/hl2rp/cityvoice/unknown_alarm.ogg", 80)
				timer.Simple(4, function()
					v:EmitSound("LiteNetwork/hl2rp/cityvoice/unknown_alarm.ogg", 80)
				end)

				v.Opened = true

				timer.Simple(2.5, function()
					v:EmitSound("plats/hall_elev_stop.wav", 90)
				end)
			else
				Schema:AddCombineDisplayMessage("Attention Sector 2 404 Zone Gate has been closed", Color(255, 0, 0), true)
				v:Fire("SetAnimation", "close")
				v:EmitSound("ambient/machines/wall_move2.wav", 90)

				v:EmitSound("LiteNetwork/hl2rp/cityvoice/unknown_alarm.ogg", 80)
				timer.Simple(4, function()
					v:EmitSound("LiteNetwork/hl2rp/cityvoice/unknown_alarm.ogg", 80)
				end)

				v.Opened = false

				timer.Simple(5, function()
					v:EmitSound("plats/tram_hit4.wav", 90)
				end)
			end
		end
	end
})

ix.command.Add("ToggleAPCGate", {
	description = "Opens the APC Garage combine gate.",
	OnRun = function(_, ply)
		if not ((ply:Nick():find("GRID") or ply:Nick():find("OTA") or ply:IsAdmin()) or (ply:IsCombineCommand() or ply:IsAdmin())) then
			ply:Notify("You need to be a higher ranking to open the gate.")
			return false
		end

		for k, v in pairs(ents.FindByName("zone_2_apcgarage_gate_1")) do
			if ( !v.Opened ) then
				Schema:AddCombineDisplayMessage("Attention APC Garage Gate has been opened", Color(255, 0, 0), true)
				v:Fire("SetAnimation", "open")
				v:EmitSound("ambient/machines/wall_move1.wav", 90)

				v:EmitSound("LiteNetwork/hl2rp/cityvoice/unknown_alarm.ogg", 80)
				timer.Simple(4, function()
					v:EmitSound("LiteNetwork/hl2rp/cityvoice/unknown_alarm.ogg", 80)
				end)

				v.Opened = true

				timer.Simple(2.5, function()
					v:EmitSound("plats/hall_elev_stop.wav", 90)
				end)
			else
				Schema:AddCombineDisplayMessage("Attention APC Garage Gate has been closed", Color(255, 0, 0), true)
				v:Fire("SetAnimation", "close")
				v:EmitSound("ambient/machines/wall_move2.wav", 90)

				v:EmitSound("LiteNetwork/hl2rp/cityvoice/unknown_alarm.ogg", 80)
				timer.Simple(4, function()
					v:EmitSound("LiteNetwork/hl2rp/cityvoice/unknown_alarm.ogg", 80)
					
					timer.Simple(4, function()
						v:EmitSound("LiteNetwork/hl2rp/cityvoice/unknown_alarm.ogg", 80)
					end)
				end)

				v.Opened = false

				timer.Simple(5, function()
					v:EmitSound("plats/tram_hit4.wav", 90)
				end)
			end
		end
	end
})