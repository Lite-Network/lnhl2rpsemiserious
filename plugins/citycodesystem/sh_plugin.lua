local PLUGIN = PLUGIN

PLUGIN.name = "City Codes"
PLUGIN.author = "Riggs Mackay"
PLUGIN.description = "City Codes for Lite Network, used from Overlord Community."

ix.util.Include("sv_plugin.lua")

ix.cityCodes = {
    [0] = {"GREEN - CIVIL / PRESERVED", Color(46, 112, 37), "Civil"},
    [1] = {"YELLOW - CIVIL UNREST / MARGINAL", Color(223, 195, 33), "Civil Unrest"},
    [2] = {"ORANGE - CITY TURMOIL / LOCKDOWN", Color(211, 124, 42), "City Turmoil"},
    [3] = {"RED - JUDGEMENT WAIVER / FRACTURED", Color(224, 58, 36), "Judgement Waiver"},
    [4] = {"GRAY - AUTONOMOUS JUDGEMENT / LOST", Color(50, 50, 50), "Autonomous Judgement"},
}

local cityCodes = {
	["green"] = 0,
	["yellow"] = 1,
	["orange"] = 2,
	["red"] = 3,
	["gray"] = 4,
}

ix.command.Add("ChangeCityCode", {
	description = "Change the current sociostatus. (green, yellow, orange, red, gray)",
	syntax = ix.type.string,
	OnRun = function(self, ply, status)
		if not (ply:IsCombineCommand() or ply:IsAdmin()) then
			ply:Notify("You can't change the city codes, only commanders can do it.")
			return false
		end

		for code, id in pairs(cityCodes) do
			if (status[1] == code) then
				ix.config.Set("cityCode", id)
			end
		end

		if (status[1] == "red") then -- Judgement Waiver
			if not ( GetGlobalBool("ixJWStatus") == true ) then
				PLUGIN:JudgementWaiverStart()

				if ( GetGlobalBool("ixCTStatus") == true ) then
					PLUGIN:CityTurmoilStop()
				end
				
				if ( GetGlobalBool("ixAJStatus") == true ) then
					timer.Simple(10, function()
						PLUGIN:AutonomousJudgementStop()
					end)
				end
			end
		elseif (status[1] == "gray") then -- Autonomous Judgement
			if ( GetGlobalBool("ixJWStatus") == true ) then
				PLUGIN:JudgementWaiverStopSilent()
			end

			if ( GetGlobalBool("ixCTStatus") == true ) then
				PLUGIN:CityTurmoilStop()
			end

			if not ( GetGlobalBool("ixAJStatus") == true ) then
				PLUGIN:AutonomousJudgementStart()
			end
		elseif (status[1] == "orange") then -- City Turmoil
			if not ( GetGlobalBool("ixCTStatus") == true ) then
				PLUGIN:CityTurmoilStart()
				
				if ( GetGlobalBool("ixJWStatus") == true ) then
					PLUGIN:JudgementWaiverStop()
				end
				
				if ( GetGlobalBool("ixAJStatus") == true ) then
					timer.Simple(10, function()
						PLUGIN:AutonomousJudgementStop()
					end)
				end
			end
		else -- Disable Everything if it is on..
			if ( GetGlobalBool("ixJWStatus") == true ) then
				PLUGIN:JudgementWaiverStop()
			end

			if ( GetGlobalBool("ixAJStatus") == true ) then
				PLUGIN:AutonomousJudgementStop()
			end

			if ( GetGlobalBool("ixCTStatus") == true ) then
				PLUGIN:CityTurmoilStop()
			end
		end
	end
})