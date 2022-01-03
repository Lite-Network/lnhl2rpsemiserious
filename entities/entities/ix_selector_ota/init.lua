AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/willardnetworks/combine/ordinal.mdl")
	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()
	self:SetSolid(SOLID_BBOX)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()
end

function ENT:OnTakeDamage()
	return false
end 

function ENT:AcceptInput(Name, Activator, Caller)
	if ( Name == "Use" ) and Caller:IsPlayer() then
		if Caller:Team() == FACTION_OTA then
			self:EmitSound("npc/metropolice/vo/ten4.wav")
			Caller:OpenVGUI("LiteNetwork.RankMenu.OTA")
		else
			Caller:Notify("You are not part of the Overwatch Transhuman Arm!")
		end
	end
end

concommand.Add("ix_selector_ota", function(ply, cmd, args)
	if not (args[1] and args[2]) then return end
	if not ply:NearEntity("ix_selector_ota") then ply:Notify("You need to be near the Overwatch Transhuman Arm quartermaster in order to use this!") return end
	if not (ply:Team() == FACTION_OTA) then ply:Notify("You need to become a Overwatch Transhuman Arm to run this command.") return end
	if not ( ( ply.ixOverwatchCoolDown or 0 ) > CurTime() ) then
		local char = ply:GetCharacter()

		if (!char) then
			return
		end

		local RandomNumbers = tonumber(args[3]) or Schema:ZeroNumber(math.random(1, 99999), 5)
		local RankID = tonumber(args[1])
		local DivisionID = tonumber(args[2])
		local RankInfo = ix.ranks.ota[RankID]
		local DivisionInfo = ix.divisions.ota[DivisionID]
		local RankInfo = ix.ranks.ota[RankID]
		local CommandingName = "OTA:C08-"..DivisionInfo.name.."-"..RandomNumbers
		local StandardName = "OTA:C08-"..DivisionInfo.name.."-"..RankInfo.name.."-"..RandomNumbers
		local BasicWeapons = {"weapon_physgun", "gmod_tool", "ix_hands", "ix_keys"}

		if not ( DivisionInfo.xp == nil ) then
			if not ( tonumber( ply:GetXP() ) >= DivisionInfo.xp ) then
				ply:Notify("You do not have the correct amount of XP to become that Division!")
				return false
			end
		end

		if not ( DivisionInfo.norank == true ) then
			if not ( RankInfo.xp == nil ) then
				if not ( tonumber( ply:GetXP() ) >= RankInfo.xp ) then
					ply:Notify("You do not have the correct amount of XP to become that Rank!")
					return false
				end
			end
		end

		if ( DivisionInfo.norank == true ) then
			if CommandingName:find("OWC") and not (ply:SteamID() == "STEAM_0:0:203818007" or ply:IsSuperAdmin()) then
				ply:Notify("The Commander Division is whitelisted!")
				return false
			end

			if (CommandingName:find("OWC") and not (ply:SteamID() == "STEAM_0:0:203818007")) and ply:IsSuperAdmin() then
				ply:Notify("You bypassed the whitelist due to you being a superadmin.")
			end

			-- this is probably, the WORST whitelisting system in human kind, but FUCK YOU.. you will not replace this, I spent around 3 hours doing this nigga shit.
			for k, v in pairs(ix.whitelists.OTA.NoRanks) do
				if StandardName:find(k) then
					if ply:IsSuperAdmin() then
						ply:Notify("You bypassed the whitelist due to you being a superadmin.")
					elseif (ply:SteamID() == "STEAM_0:0:203818007") then
						ply:Notify("You are the commander, due that you bypass whitelists.")
					else
						if istable(v) then
							if table.HasValue(v, ply:SteamID()) then
								ply:Notify("WHITELISTED!!!!!")
							else
								ply:Notify("You are not whitelisted.")
								return false
							end
						else
							if v:find(ply:SteamID()) then
								ply:Notify("WHITELISTED!!!!!")
							else
								ply:Notify("You are not whitelisted.")
								return false
							end
						end
					end
				end
			end
			
			ply.ixOTARank = nil
			ply.ixOTADivision = DivisionID

			ply:StripWeapons()

			char:SetName(CommandingName)
			ply:Notify("You are now: "..CommandingName)

			if DivisionInfo.class then
				char:SetClass(DivisionInfo.class)
			end
			ply:ResetBodygroups()
			ply:SetModel(DivisionInfo.model)
			ply:SetSkin(DivisionInfo.skin)
			ply:SetMaxHealth(DivisionInfo.health)
			ply:SetHealth(DivisionInfo.health)
			ply:SetArmor(DivisionInfo.armor)
			ply:SetMaxArmor(DivisionInfo.armor)
			ply:SetupHands()
			
			char:SetData("brokenLegs", false)

			Schema:GiveWeapons(ply, BasicWeapons)
			Schema:GiveWeapons(ply, DivisionInfo.weapons)
		else
			-- this is probably, the WORST whitelisting system in human kind, but FUCK YOU.. you will not replace this, I spent around 3 hours doing this nigga shit.

			local whitelistname = DivisionInfo.name.."-"..RankInfo.name
			for k, v in pairs(ix.whitelists.OTA.Ranks) do
				if (whitelistname:find(k)) then
					if ply:IsSuperAdmin() then
						ply:Notify("You bypassed the whitelist due to you being a superadmin.")
					elseif (ply:SteamID() == "STEAM_0:0:203818007") then
						ply:Notify("You are the commander, due that you bypass whitelists.")
					else
						if istable(v) then
							if table.HasValue(v, ply:SteamID()) then
								ply:Notify("WHITELISTED!!!!!")
							else
								ply:Notify("You are not whitelisted.")
								return false
							end
						else
							if v:find(ply:SteamID()) then
								ply:Notify("WHITELISTED!!!!!")
							else
								ply:Notify("You are not whitelisted.")
								return false
							end
						end
					end
				end
			end
			
			ply.ixOTARank = RankID
			ply.ixOTADivision = DivisionID
			
			ply:StripWeapons()

			char:SetName(StandardName)
			ply:Notify("You are now a: "..StandardName)

			if ( DivisionInfo.class ) then
				char:SetClass(DivisionInfo.class)
			end

			if ( RankInfo.name == "LDR" ) then
				ply:SetModel(DivisionInfo.model_ldr)
				ply:SetSkin(DivisionInfo.skin_ldr)
			else
				ply:SetModel(DivisionInfo.model)
				ply:SetSkin(DivisionInfo.skin)
			end

			ply:ResetBodygroups()
			ply:SetMaxHealth(DivisionInfo.health + RankInfo.health)
			ply:SetHealth(DivisionInfo.health + RankInfo.health)
			ply:SetArmor(DivisionInfo.armor + RankInfo.armor)
			ply:SetMaxArmor(DivisionInfo.armor + RankInfo.armor)
			ply:SetupHands()
			
			char:SetData("brokenLegs", false)

			Schema:GiveWeapons(ply, BasicWeapons)
			if (DivisionInfo.weapons[RankID]) then
				Schema:GiveWeapons(ply, DivisionInfo.weapons[RankID])
			end
		end
	else
		ply:Notify("You need to wait before you can change division and rank again.")
	end
end)