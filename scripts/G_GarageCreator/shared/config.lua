G_GarageCreator = {
    AllVehiclesGarages = false, -- si 'false' Les véhicules rangés dans un garage ne seront disponible que dans ce même garage
    AllVehiclesGaragesInPound = false, -- si 'false' Les véhicules détruits seront mis à la fourrière ayant le nom du garage de la derrière sortie du véhicule
    Public = {
        Garage = {
            {   
                name = "Central", 
                Get = {
                    pos = vector3(213.68, -809.46, 31.01), 
                    spawn = vector4(230.6, -799.0, 30.5, 160.0)
                },
                Put = {
                    pos = vector3(224.6, -764.5, 30.8)
                },
            },
            {   
                name = "Middle",
                Get = {
                    pos = vector3(-281.03, -888.07, 31.32),
                    spawn = vector4(-285.69, -887.02, 31.08, 173.9)
                },
                Put = {
                    pos = vector3(-289.28, -886.36, 31.08)
                },
            },
        },
        Pound = {
            {
                name = "Central",
                pos = vector3(409.21, -1622.96, 29.29),
                spawn = vector4(403.23, -1642.35, 29.29, 229.09)
            }, 
        },
    },
    Private = {
        Job = {
            {
                name = "police",
                label = "Police",
                colortext = "~b~", -- https://docs.fivem.net/docs/game-references/text-formatting/
                color = {0, 110, 255}, -- https://htmlcolorcodes.com/fr/
                pos = vector3(457.1, -1016.99, 28.38),
                posreturn = vector3(452.7, -1007.73, 27.66),
                Content = {
                    {name = "sultan", label = "Sultan", count = 5, job_grade_min = 2, color = {0, 110, 255}, spawn = vector4(446.05, -1026.26, 28.65, 14.49)},
                }
            }, 
        },
        Job2 = {
            {
                name = "famillies",
                label = "Families",
                colortext = "~g~", -- https://docs.fivem.net/docs/game-references/text-formatting/
                color = {0, 255, 0}, -- https://htmlcolorcodes.com/fr/
                pos = vector3(-19.88, -1430.49, 30.67),
                posreturn = vector3(-25.41, -1427.09, 30.66),
                Content = {
                    {name = "sultan", label = "Sultan", count = 5, job_grade_min = 2, color = {0, 255, 0}, spawn = vector4(-25.42, -1427.10, 30.67, 178.49)},
                }
            }, 
        },         
    }
}