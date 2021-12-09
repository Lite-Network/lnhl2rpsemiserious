--[[ Base Config ]]--

FACTION.name = "City Administrator"
FACTION.description = [[Name: City Administrator
Description: City Administrators are directly appointed by recruits or an advisor. Each Administrator has a tunnel of their own in the city they co-own From this point, they are able to carry out and see to the day-to-day affairs of the city they have been tasked with running and ensuring everything is running smoothly. Some City Administrators have "Interns" or "Assistants" Who are Loyalists with low authority who act as a "helper" or a propaganda tool.]]
FACTION.color = Color(255, 200, 100)

--[[ Helix Base Config ]]--

FACTION.models = {
	"models/suits/male_01_closed_coat_tie.mdl",
	"models/suits/male_01_closed_tie.mdl",
	"models/suits/male_01_open.mdl",
	"models/suits/male_01_open_tie.mdl",
	"models/suits/male_01_open_waistcoat.mdl",
	"models/suits/male_01_shirt.mdl",
	"models/suits/male_01_shirt_tie.mdl",
	
	"models/suits/male_02_closed_coat_tie.mdl",
	"models/suits/male_02_closed_tie.mdl",
	"models/suits/male_02_open.mdl",
	"models/suits/male_02_open_tie.mdl",
	"models/suits/male_02_open_waistcoat.mdl",
	"models/suits/male_02_shirt.mdl",
	"models/suits/male_02_shirt_tie.mdl",
	
	"models/suits/male_03_closed_coat_tie.mdl",
	"models/suits/male_03_closed_tie.mdl",
	"models/suits/male_03_open.mdl",
	"models/suits/male_03_open_tie.mdl",
	"models/suits/male_03_open_waistcoat.mdl",
	"models/suits/male_03_shirt.mdl",
	"models/suits/male_03_shirt_tie.mdl",
	
	"models/suits/male_04_closed_coat_tie.mdl",
	"models/suits/male_04_closed_tie.mdl",
	"models/suits/male_04_open.mdl",
	"models/suits/male_04_open_tie.mdl",
	"models/suits/male_04_open_waistcoat.mdl",
	"models/suits/male_04_shirt.mdl",
	"models/suits/male_04_shirt_tie.mdl",
	
	"models/suits/male_05_closed_coat_tie.mdl",
	"models/suits/male_05_closed_tie.mdl",
	"models/suits/male_05_open.mdl",
	"models/suits/male_05_open_tie.mdl",
	"models/suits/male_05_open_waistcoat.mdl",
	"models/suits/male_05_shirt.mdl",
	"models/suits/male_05_shirt_tie.mdl",
	
	"models/suits/male_06_closed_coat_tie.mdl",
	"models/suits/male_06_closed_tie.mdl",
	"models/suits/male_06_open.mdl",
	"models/suits/male_06_open_tie.mdl",
	"models/suits/male_06_open_waistcoat.mdl",
	"models/suits/male_06_shirt.mdl",
	"models/suits/male_06_shirt_tie.mdl",
	
	"models/suits/male_07_closed_coat_tie.mdl",
	"models/suits/male_07_closed_tie.mdl",
	"models/suits/male_07_open.mdl",
	"models/suits/male_07_open_tie.mdl",
	"models/suits/male_07_open_waistcoat.mdl",
	"models/suits/male_07_shirt.mdl",
	"models/suits/male_07_shirt_tie.mdl",
	
	"models/suits/male_08_closed_coat_tie.mdl",
	"models/suits/male_08_closed_tie.mdl",
	"models/suits/male_08_open.mdl",
	"models/suits/male_08_open_tie.mdl",
	"models/suits/male_08_open_waistcoat.mdl",
	"models/suits/male_08_shirt.mdl",
	"models/suits/male_08_shirt_tie.mdl",
	
	"models/suits/male_09_closed_coat_tie.mdl",
	"models/suits/male_09_closed_tie.mdl",
	"models/suits/male_09_open.mdl",
	"models/suits/male_09_open_tie.mdl",
	"models/suits/male_09_open_waistcoat.mdl",
	"models/suits/male_09_shirt.mdl",
	"models/suits/male_09_shirt_tie.mdl",
}

FACTION.isGloballyRecognized = true
FACTION.isDefault = true

FACTION.payTime = 600
FACTION.pay = 0

--[[ Custom Config ]]--

FACTION.defaultClass = nil
FACTION.adminOnly = false
FACTION.donatorOnly = false
FACTION.noModelSelection = false
FACTION.requiredXP = 3000
FACTION.command = "ix_faction_become_ca"
FACTION.modelWhitelist = "suits/male_"

--[[ Do not change! ]]--

FACTION_CA = FACTION.index