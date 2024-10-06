Config = {
    -- [CLOTHES SHOP]
    zoneClothStop = {
        Binco = {
            {coords = vector3(-822.42, -1073.55, 10.33)},
            {coords = vector3(75.34, -1393.00, 28.38)},
            {coords = vector3(425.59, -806.15, 28.49)},
            {coords = vector3(4.87, 6512.46, 30.88)},
            {coords = vector3(1693.92, 4822.82, 41.06)},
            {coords = vector3(1196.61, 2710.25, 37.22)},
            {coords = vector3(-1101.48, 2710.57, 18.11)},
            Header = "shopui_title_lowendfashion2",
            BlipId = 73,
            BlipColor = 5,
            BlipScale = 0.7,
            Type = "Cloth"
        },
        Suburban = {
            {coords = vector3(-1193.16, -767.98, 16.32)},
            {coords = vector3(125.77, -223.9, 53.56)},
            {coords = vector3(614.19, 2762.79, 41.09)},
            {coords = vector3(-3170.54, 1043.68, 19.86)},
            Header = "shopui_title_midfashion",
            BlipId = 73,
            BlipColor = 5,
            BlipScale = 0.7,
            Type = "Cloth",
        },
        Ponsonbys = {
            {coords = vector3(-709.86, -153.1, 36.42)},
            {coords = vector3(-163.37, -302.73, 38.73)},
            {coords = vector3(-1450.42, -237.66, 48.81)},
            Header = "shopui_title_highendfashion",
            BlipId = 73,
            BlipColor = 5,
            BlipScale = 0.7,
            Type = "Cloth"
        },
        Masks = {
            {coords = vector3(-1337.25, -1277.54, 3.88)},
            Header = "shopui_title_movie_masks",
            BlipId = 362,
            BlipColor = 5,
            BlipScale = 0.7,
            Type = "Mask"
        },
    },
}

Config.Locale = "fr"

Config.IncludeCash = true
Config.IncludeAccounts = true
Config.ExcludeAccountsList = {"bank", "money"}
Config.OpenControl = 289

Config.CloseUiItems = {
    "carteidentite",
    "permis",
    "carte",
    "phone",
    "bread",
    "water",
    "carte"
}