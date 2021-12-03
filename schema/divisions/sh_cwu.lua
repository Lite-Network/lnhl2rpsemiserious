ix.divisions.cwu = {}
ix.divisions.cwu[1] = {
    id = 1,
    name = "Worker",
    description = [[Name: Worker
Description: A Standard City Worker, you are the lowest class in the Civil Worker's Union. You maintain the streets and keep them clean and tidy, you report anti-civil activity and you stay loyal to the Universal Union, or not. You may not open up your own store.]],
    xp = 30,
    class = CLASS_CWU_WORKER,
	loadout = function(ply)
		ply:SetBodygroup(2, 6)
	end,
}

ix.divisions.cwu[2] = {
    id = 2,
    name = "Cook",
    description = [[Name: Cook
Description: A Cook, you are capable of handing out food to random civilians whether it may be for Money or for Free.. up to you! Same applies to the Universal Union. You may open your own store to sell your Food with reasonable prices.]],
    xp = 100,
    class = CLASS_CWU_COOK,
	loadout = function(ply)
		ply:SetBodygroup(1, 1)
		ply:SetBodygroup(2, 2)
	end,
}

ix.divisions.cwu[3] = {
    id = 3,
    name = "Medical Worker",
    description = [[Name: Medical Worker
Description: A Medical Worker, in the Civil Worker's Union is capable of healing civilians or Benefactors whether it be for Tokens or for free. You may open up your own Store to sell medical items. Though in Fighting Scenarios you might aswell support the Universal Union by healing!]],
    xp = 300,
    class = CLASS_CWU_MEDIC,
	loadout = function(ply)
		ply:SetBodygroup(2, 3)
	end,
}

ix.divisions.cwu[4] = {
    id = 4,
    name = "Infestation Control Team",
    description = [[Name: Infestation Control Team
Description: Employed as cleanup crews and researchers, Hazmat Workers are stationed primarily in and around the Quarantine Zone or Sewers to stem the infestation of alien flora and fauna from Xen. Most of them wear yellow hazmat suits, green medical gloves, black rubber boots, and helmets identical to that of Combine Workers.]],
    xp = 600,
    class = CLASS_CWU_ICT,
    model = "models/hlvr/characters/hazmat_worker/npc/hazmat_worker_citizen.mdl",
}

ix.divisions.cwu[5] = {
    id = 5,
    name = "Researcher",
    description = [[Name: Researcher
Description: A Researcher's Task is to advance into the Combine or Human Technology to find more machinery to make to potentially improve the City, or you can improve the City populist by increasing their stats freely in the Research Facility. You may not open your own store, however you can open your own Lab in the Research Facility in Sector 3.]],
    xp = 1000,
    class = CLASS_CWU_SCIENTIST,
	loadout = function(ply)
		ply:SetBodygroup(2, 5)
	end,
}

ix.divisions.cwu[6] = {
    id = 6,
    name = "Director",
    description = [[Name: Director
Description: The Director's job is to keep the Civil Worker's Union in tip top shape, once in a while a City Administrator might come to your doorstep to see how thing's are going. You cannot own any stores, however your own the Civil Worker's Union Headquarters in Plaza.]],
    xp = 2500,
    class = CLASS_CWU_DIRECTOR,
	loadout = function(ply)
		ply:SetBodygroup(2, 28)
		ply:SetBodygroup(3, 9)
	end,
}