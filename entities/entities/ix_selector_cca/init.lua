AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/wn7new/metropolice/male_01.mdl")
	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()
	self:SetSolid(SOLID_BBOX)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()
	self:SetBodyGroups("00012012")
end

function ENT:OnTakeDamage()
	return false
end 

function ENT:AcceptInput(Name, Activator, Caller)
	if ( Name == "Use" ) and Caller:IsPlayer() then
		if Caller:Team() == FACTION_CCA then
			self:EmitSound("npc/metropolice/vo/ten4.wav")
			Caller:OpenVGUI("LiteNetwork.RankMenu.CCA")
		else
			Caller:Notify("You are not part of the Combine Civil Authority!")
		end
	end
end

concommand.Add("ix_selector_cca", function(ply, cmd, args)
	if not (args[1] and args[2]) then return end
	if not ply:NearEntity("ix_selector_cca") then ply:Notify("You need to be near the Combine Civil Authority quartermaster in order to use this!") return end
	if not (ply:Team() == FACTION_CCA) then ply:Notify("You need to become a Combine Civil Authority to run this command.") return end
	if not ((ply.ccaSelectionCoolDown or 0) > CurTime()) then
		local char = ply:GetCharacter()

		if (!char) then
			return
		end

		local RandomNumbers = tonumber(args[3]) or math.random(1000,9999)
		local RankID = tonumber(args[1])
		local DivisionID = tonumber(args[2])
		local RankInfo = ix.ranks.cca[RankID]
		local DivisionInfo = ix.divisions.cca[DivisionID]
		local CommandingName = "CCA:C17-"..DivisionInfo.name.."-"..RandomNumbers
		local StandardName = "CCA:C17-"..DivisionInfo.name.."-"..RankInfo.name.."-"..RandomNumbers
		local BasicWeapons = {"weapon_physgun", "gmod_tool", "ix_hands", "ix_keys"}

		if not (DivisionInfo.xp == nil) then
			if not (tonumber(ply:GetXP()) >= DivisionInfo.xp) then
				ply:Notify("You do not have the correct amount of XP to become that Division!")
				return false
			end
		end

		if not (DivisionInfo.norank == true) then
			if not (RankInfo.xp == nil) then
				if not (tonumber(ply:GetXP()) >= RankInfo.xp) then
					ply:Notify("You do not have the correct amount of XP to become that Rank!")
					return false
				end
			end
		end

		if (DivisionInfo.norank == true) then
			if CommandingName:find("COMMANDER") and not (ply:SteamID() == "STEAM_0:0:102502702" or ply:IsSuperAdmin()) then
				ply:Notify("The Commander Division is whitelisted!")
				return false
			end

			if (CommandingName:find("COMMANDER") and not (ply:SteamID() == "STEAM_0:0:102502702")) and ply:IsSuperAdmin() then
				ply:Notify("You bypassed the whitelist due to you being a superadmin.")
			end

			-- this is probably, the WORST whitelisting system in human kind, but FUCK YOU.. you will not replace this, I spent around 3 hours doing this nigga shit.
			for k, v in pairs(ix.whitelists.CCA.NoRanks) do
				if StandardName:find(k) then
					if ply:IsSuperAdmin() then
						ply:Notify("You bypassed the whitelist due to you being a superadmin.")
					elseif (ply:SteamID() == "STEAM_0:0:102502702") then
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

			ply:StripWeapons()

			char:SetName(CommandingName)
			ply:Notify("You are now: "..CommandingName)

			if DivisionInfo.class and char then
				char:SetClass(DivisionInfo.class)
			end
			if DivisionInfo.model then
				ply:SetModel(DivisionInfo.model)
			else
				if ply:GetModel() == "models/ma/hla/metropolice.mdl" then
					ply:SetModel(table.Random(ix.faction.Get(ply:Team()).models))
				end
			end
			ply:ResetBodygroups()
			ply:SetBodygroup(1, DivisionInfo.bg_cape)
			ply:SetBodygroup(2, DivisionInfo.bg_body)
			ply:SetBodygroup(3, DivisionInfo.bg_head)
			ply:SetBodygroup(4, DivisionInfo.bg_armor)
			ply:SetBodygroup(5, DivisionInfo.bg_belt)
			ply:SetBodygroup(6, DivisionInfo.bg_pants)
			ply:SetBodygroup(7, DivisionInfo.bg_bag)
			ply:SetBodygroup(8, DivisionInfo.bg_satchel)
			ply:SetSkin(DivisionInfo.skin)
			ply:SetMaxHealth(DivisionInfo.health)
			ply:SetHealth(DivisionInfo.health)
			ply:SetArmor(DivisionInfo.armor)
			ply:SetMaxArmor(DivisionInfo.armor)
			ply:SetupHands()

			char:SetData("brokenLegs", false)
			char:SetData("lastCombineName", CommandingName)

			Schema:GiveWeapons(ply, BasicWeapons)
			Schema:GiveWeapons(ply, DivisionInfo.weapons)
		else
			-- this is probably, the WORST whitelisting system in human kind, but FUCK YOU.. you will not replace this, I spent around 3 hours doing this nigga shit.
			local whitelistname = DivisionInfo.name.."-"..RankInfo.name
			for k, v in pairs(ix.whitelists.CCA.Ranks) do
				if (whitelistname == k) then
					if ply:IsSuperAdmin() then
						ply:Notify("You bypassed the whitelist due to you being a superadmin.")
					elseif (ply:SteamID() == "STEAM_0:0:102502702") then
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
			
			ply:StripWeapons()

			char:SetName(StandardName)
			ply:Notify("You are now a: "..StandardName)

			if DivisionInfo.class then
				char:SetClass(DivisionInfo.class)
			end
			if DivisionInfo.model then
				ply:SetModel(DivisionInfo.model)
			else
				if ply:GetModel() == "models/ma/hla/metropolice.mdl" then
					ply:SetModel(table.Random(ix.faction.Get(ply:Team()).models))
				end
			end
			ply:ResetBodygroups()
			ply:SetBodygroup(1, RankInfo.bg_cape)
			ply:SetBodygroup(2, DivisionInfo.bg_body)
			ply:SetBodygroup(3, RankInfo.bg_head)
			ply:SetBodygroup(4, RankInfo.bg_armor)
			ply:SetBodygroup(5, RankInfo.bg_belt)
			ply:SetBodygroup(6, RankInfo.bg_pants)
			ply:SetBodygroup(7, RankInfo.bg_bag)
			ply:SetBodygroup(8, RankInfo.bg_satchel)
			ply:SetSkin(DivisionInfo.skin)
			ply:SetMaxHealth(DivisionInfo.health + RankInfo.health)
			ply:SetHealth(DivisionInfo.health + RankInfo.health)
			ply:SetArmor(DivisionInfo.armor + RankInfo.armor)
			ply:SetMaxArmor(DivisionInfo.armor + RankInfo.armor)
			ply:SetupHands()
			
			char:SetData("brokenLegs", false)
			char:SetData("lastCombineName", StandardName)

			Schema:GiveWeapons(ply, BasicWeapons)
			if (DivisionInfo.weapons[RankID]) then
				Schema:GiveWeapons(ply, DivisionInfo.weapons[RankID])
			end
		end
		ply.ccaSelectionCoolDown = CurTime() + 10
	else
		ply:Notify("You need to wait before you can change division and rank again.")
	end
end)