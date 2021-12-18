local PLUGIN = PLUGIN

function PLUGIN:PlayerSpawn(ply)
	if not ((ply:IsValid() and ply:GetCharacter()) or (ply.gracePeriod == true)) then
		return
	end

	ply:GetCharacter():SetHunger(100)
	ply:SetHealth(100)
end

function PLUGIN:PlayerTick(ply)
	if not (ply:IsValid() and ply:GetCharacter()) or (ply:Team() == FACTION_OTA) then
		return
	end

	if not ply.HungerTick or ply.HungerTick <= CurTime() then
		local char = ply:GetCharacter()
		local faction = ix.faction.indices[char:GetFaction()]
		
		if (faction.noNeeds == true) then return end
		if (ply:GetMoveType() == MOVETYPE_NOCLIP) then return end

		local hunger = math.Clamp(char:GetHunger() - 1, 0, 100)

		if ((char:GetHunger() == 0)) then
			ply:TakeDamage(math.random(5, 10))
			
			ply:EmitSound("npc/barnacle/barnacle_digesting"..math.random(1,2)..".wav", 50)

			ply:ChatPrint("You are dying of starvation!")

			ply.HungerTick = CurTime() + 30

			return
		end

		char:SetHunger(hunger)

		ply.HungerTick = CurTime() + (ix.config.Get("hungerTime", 60))
	end
end