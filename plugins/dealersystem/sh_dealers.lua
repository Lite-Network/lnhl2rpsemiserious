ix.dealers.data = {
    [1] = {
        id = 1,
        spawnPos = Vector(0, 0, 0),
        spawnAng = Angle(0, 0, 0),
        model = "models/Humans/Group02/Male_04.mdl",
        name = "Black Market Dealer",
        description = "A Black Market Dealer, who sells contraband and resources to wandering refugees or rebels. Which might help them in the future. If you have anything you do not need, you can rely and sell it to this man.",
        nick = table.Random({
            "James Nick",
            "Lee North",
            "Marcus Carlson",
        }),
        buying = {
            ["metalplate"] = {
                Cost = 10
            },
            ["wood"] = {
                Cost = 3
            },
            ["gnome"] = {
                Cost = 200
            },
            ["goldgnome"] = {
                Cost = 2000
            },
        },
        selling = {
            ["gunpowder"] = {
                Cost = 180,
                Max = 8,
            },
            ["ammo_pistol"] = {
                Cost = 150,
            },
            ["glue"] = {
                Cost = 40,
            },
        },
    },
    [2] = {
        id = 2,
        spawnPos = Vector(17.245190, 120.815842, -81.968811),
        spawnAng = Angle(0, -45, 0),
        model = "models/Humans/Group02/Male_04.mdl",
        name = "Fisherman",
        description = "A Black Market Dealer, who sells contraband and resources to wandering refugees or rebels. Which might help them in the future. If you have anything you do not need, you can rely and sell it to this man.",
        nick = "Fisherman",
    },
}