ix.dealers.data = {
    -- Black Market Dealer
    [1] = {
        spawns = {
            [1] = {
                spawnPos = Vector(0, 0, 0),
                spawnAng = Angle(0, 0, 0),
            },
            [2] = {
                spawnPos = Vector(-57.728702545166, -86.027839660645, -147.96879577637),
                spawnAng = Angle(0, 35.8684425354, 0),
            },
            [3] = {
                spawnPos = Vector(1092.1162109375, 272.27139282227, -143.96875),
                spawnAng = Angle(0, 144.57069396973, 0),
            },
        },
        model = "models/Humans/Group02/Male_04.mdl",
        name = "Black Market Dealer",
        description = "A Black Market Dealer, who sells contraband and resources to wandering refugees or rebels. Which might help them in the future. If you have anything you do not need, you can rely and sell it to this man.",
        nick = table.Random({
            "James Nick",
            "Lee North",
            "Marcus Carlson",
            "Mao Zedong",
            "Slovinski Jones",
            "Greg Smith",
        }),
        buying = {
            ["gunpowder"] = {
                Cost = 170,
                Max = 13,
            },
            ["pistolammo"] = {
                Cost = 200,
                Max = 8,
            },
            ["glue"] = {
                Cost = 40,
                Max = 18,
            },
        },
        selling = {
            ["metalplate"] = {
                Cost = 10,
            },
            ["wood"] = {
                Cost = 3,
            },
            ["gnome"] = {
                Cost = 200,
            },
            ["goldgnome"] = {
                Cost = 20000,
            },
        },
    },
    -- Wandering Trader
    [2] = {
        spawns = {
            [1] = {
                spawnPos = Vector(1739.8284912109, 791.19549560547, -143.96875),
                spawnAng = Angle(0, -134.54281616211, 0),
            },
            [2] = {
                spawnPos = Vector(1114.2884521484, -818.88452148438, -143.96875),
                spawnAng = Angle(0, 83.557250976563, 0),
            },
            [3] = {
                spawnPos = Vector(-975.33557128906, -1114.8834228516, -143.96875),
                spawnAng = Angle(0, 0.49326699972153, 0),
            },
        },
        model = "models/Humans/Group03/Male_05.mdl",
        name = "Wandering Trader",
        description = "A Wandering Trader, if you got anything that you do not need, such as wood or anything that you don't like, you can give it to this man for high or even low prices..",
        nick = table.Random({
            "Jason Hermett",
            "Naide Tech",
            "Gel Dooley",
            "Max Passenger",
            "Ben Dover",
        }),
        buying = {
            ["cloth"] = {
                Cost = 30,
            },
            ["electronics"] = {
                Cost = 650,
                Max = 3,
            },
        },
        selling = {
            ["metalplate"] = {
                Cost = 8,
            },
            ["wood"] = {
                Cost = 6,
            },
            ["damagedotavest"] = {
                Cost = 430,
            }
        },
    },
}