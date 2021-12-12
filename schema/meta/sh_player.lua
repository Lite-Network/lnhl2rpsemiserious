--[[---------------------------------------------------------------------------
	Player Meta Functions
---------------------------------------------------------------------------]]--

local PLAYER = FindMetaTable("Player")

function PLAYER:IsCitizen()
	return (self:Team() == FACTION_CITIZEN)
end

function PLAYER:IsRebel()
	return (self:Team() == FACTION_CITIZEN and self.ixRebelState)
end

function PLAYER:IsCWU()
	return (self:Team() == FACTION_CWU)
end

function PLAYER:IsCombine()
	return (self:Team() == FACTION_CCA or self:Team() == FACTION_OTA)
end

function PLAYER:IsCombineCommand()
	return (self:IsCombine() and ((self.ixOTARank == 3) or (self.ixCCARank == 8) or (self.ixCCARank == 9) or (self.ixCCADivision == 6)))
end

function PLAYER:IsCombineLeader()
	return (self:IsCombine() and (self.ixCCADivision == 6))
end

function PLAYER:IsCA()
	return (self:Team() == FACTION_CA)
end

function PLAYER:IsVortigaunt()
	return (self:Team() == FACTION_VORTIGAUNT)
end

function PLAYER:IsDispatch()
	return (self:Team() == FACTION_DISPATCH)
end

function PLAYER:IsDonator()
	return (self:GetUserGroup() == "donator")
end

if ( SERVER ) then
	local PLAYER = FindMetaTable("Player")
	
	util.AddNetworkString("ixAddCombineDisplayMessage")
	function PLAYER:AddCombineDisplayMessage(text, color, sound)
		net.Start("ixAddCombineDisplayMessage")
			net.WriteString(tostring(text) or "Invalid Input..")
			net.WriteColor(color or color_white)
			net.WriteBool(tobool(sound) or false)
		net.Send(self)
	end

	util.AddNetworkString("ixPlaySound")
	function PLAYER:PlaySound(sound)
		net.Start("ixPlaySound")
			net.WriteString(tostring(sound))
		net.Send(self)
	end

	util.AddNetworkString("ixCreateVGUI")
	function PLAYER:OpenVGUI(panel)
		if not isstring(panel) then
			ErrorNoHalt("Warning argument is required to be a string! Instead is "..type(panel).."\n")
			return
		end
	
		net.Start("ixCreateVGUI")
			net.WriteString(panel)
		net.Send(self)
	end

	function PLAYER:NearEntity(entity, radius)
		for k, v in ipairs(ents.FindInSphere(self:GetPos(), radius or 96)) do
			if (v:GetClass() == entity) then
				return true
			end
		end
		return false
	end

	--[[
		-- Used the same as the above but you input a pure entity e.g. --
		local ply = Entity(1)
		local our_ent = Entity(123)
		if ( ply:NearEntityPure(our_ent) ) then
			DoStuff()
		end
	]]

	function PLAYER:NearEntityPure(entity, radius)
		for k, v in ipairs(ents.FindInSphere(self:GetPos(), radius or 96)) do
			if ( v == entity ) then
				return true
			end
		end
		return false
	end

	function PLAYER:NearPlayer(radius)
		for k, v in ipairs(ents.FindInSphere(self:GetPos(), radius or 96)) do
			if v:IsPlayer() and v:Alive() and v:IsValid() then
				return true
			end
		end
		return false
	end
else
	local PLAYER = FindMetaTable("Player")

	function PLAYER:GetPlayerInArea() -- Could be slightly expensive so I'll try some optimization methods ~ scotnay
		-- Area plugin not used method useless
		if ( !ix.area and !ix.area.stored ) then
			return
		end
	  
		local oldArea = self.oldArea or nil
			
		-- If an area already exists it saves us having to loop over everything
		if ( oldArea ) then
			local areaData = ix.area.stored[oldArea]
	  
			if ( !areaData ) then
				self.oldArea = nil
				return self.oldArea
			end
	  
			local min, max = areaData.startPosition, areaData.endPosition
	  
			-- Pos is at feet so we add the center so if the area is off the ground still registers
			local pos = self:GetPos() + self:OBBCenter()
	  
			if ( pos:WithinAABox(max, min) ) then
				self.oldArea = self.oldArea
				return self.oldArea
			else
				self.oldArea = nil
				self.oldAreaTimer = nil
				self:GetPlayerInArea() -- Try again since no longer in area
			end
		else
			for i, v in pairs(ix.area.stored) do
				local min, max = v.startPosition, v.endPosition
		
				local pos = self:GetPos() + self:OBBCenter()
		
				if ( pos:WithinAABox(min, max) ) then
					self.oldArea = i
					return self.oldArea
				end
			end
		end
		return nil
	end
end