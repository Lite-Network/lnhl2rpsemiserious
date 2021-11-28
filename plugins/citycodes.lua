local PLUGIN = PLUGIN

PLUGIN.name = "City Codes"
PLUGIN.author = "Riggs Mackay"
PLUGIN.description = "City Codes for Lite Network, used from Overlord Community."

Schema.cityCodes = {
    [0] = {"GREEN - CIVIL / PRESERVED", Color(46, 112, 37)},
    [1] = {"YELLOW - CIVIL UNREST / MARGINAL", Color(223, 195, 33)},
    [2] = {"ORANGE - CITY TURMOIL / LOCKDOWN", Color(211, 124, 42)},
    [3] = {"RED - JUDGEMENT WAIVER / FRACTURED", Color(224, 58, 36)},
    [4] = {"GRAY - AUTONOMOUS JUDGEMENT / LOST", Color(50, 50, 50)},
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

		if (status[1] == "red") then
			if not (GetGlobalBool("ixJWStatus", false) == true) then
				Schema:JudgementWaiverStart()
				
				if (GetGlobalBool("ixAJStatus", false) == true) then
					timer.Simple(10, function()
						Schema:AutonomousJudgementStop()
					end)
				end
			else
				if (GetGlobalBool("ixAJStatus", false) == true) then
					Schema:AutonomousJudgementStop()
				end
			end
		elseif (status[1] == "gray") then
			if (GetGlobalBool("ixJWStatus", false) == true) then
				Schema:JudgementWaiverStopSilent()
			end

			if not (GetGlobalBool("ixAJStatus", false) == true) then
				Schema:AutonomousJudgementStart()
			end
		else
			if (GetGlobalBool("ixJWStatus", false) == true) then
				Schema:JudgementWaiverStop()
			end

			if (GetGlobalBool("ixAJStatus", false) == true) then
				Schema:AutonomousJudgementStop()
			end
		end
	end
})