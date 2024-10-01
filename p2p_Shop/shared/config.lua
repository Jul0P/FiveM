Config = {
    Translate = TranslateCap, -- TranslateCap : es_extended version >= 1.9.0 / _U : es_extended version < 1.9.0
    Locale = GetConvar('esx:locale', 'fr'),
    getSharedObject = "last", -- last : es_extended version >= 1.9.0 / old : es_extended version < 1.9.0
    shop = {
        {
            label = "Nourriture",
            desc = "Acheter à manger",
            content = {
                {label = "Pain", name = "bread", desc = nil, price = 5},
                {label = "Sandwich", name = "sandwich", desc = nil, price = 5},
            },
        },
        {
            label = "Boissons",
            desc = "Acheter à boire",
            content = {
                {label = "Eau", name = "water", desc = nil, price = 5},
                {label = "Jus d'Orange", name = "jorange", desc = nil, price = 5},
            },
        },
        {
            label = "Divers",
            desc = "Acheter des objets divers",
            content = {
                {label = "Téléphone", name = "phone", desc = nil, price = 100},
                {label = "GPS", name = "gps", desc = nil, price = 50},
            },
        },
    },
    position = {
        {x = 2557.18, y = 382.4, z = 108.65},
        {x = -3039.46, y = 585.99, z = 7.94},
        {x = -3242.34, y = 1001.7, z = 12.87},
        {x = 547.44, y = 2671.2, z = 42.19},
        {x = 1961.43, y = 3740.94, z = 32.37},
        {x = 2678.9, y = 3280.68, z = 55.27},
        {x = 1729.34, y = 6414.49, z = 35.1},
        {x = 25.95, y = -1345.46, z = 29.55},
        {x = 1136.14, y = -982.3, z = 46.46},
        {x = -1223.19, y = -907.07, z = 10.35},
        {x = -1487.2, y = -379.53, z = 40.19},
        {x = -2968.16, y = 390.43, z = 15.09},
        {x = 1166.02, y = 2708.99, z = 38.19},
        {x = 1392.42, y = 3604.59, z = 35.0},
        {x = -48.5, y = -1757.58, z = 29.46},
        {x = 1163.26, y = -324.1, z = 69.27},
        {x = -707.67, y = -914.72, z = 19.28},
        {x = -1820.71, y = 792.42, z = 138.19},
        {x = 1698.44, y = 4924.65, z = 42.1},
    },
    blip = { -- https://docs.fivem.net/docs/game-references/blips/
        active = true,
        sprite = 59,
        color = 2,
        scale = 0.6
    },
    marker = {
        type = 6, -- https://docs.fivem.net/docs/game-references/markers/
        rotation = {
            x = -90.0,
            y = 0.0,
            z = 0.0
        },
        scale = {
            x = 0.5,
            y = 0.1,
            z = 0.5
        },
        color = { -- https://www.rapidtables.com/web/color/RGB_Color.html
            r = 0,
            g = 255,
            b = 70,
            a = 255
        },
        jump = false,
        rotate = false
    },
    ped = {
        active = true,
        type = 'mp_m_shopkeep_01', -- https://docs.fivem.net/docs/game-references/ped-models/
        position = {
            {x = 24.03, y = -1345.63, z = 28.52, h = 266.0},
            {x = -705.73, y = -914.91, z = 18.24, h = 91.0},
            {x = 1134.25, y = -982.73, z = 45.41, h = 277.332},
            {x = -1222.26, y = -908.55, z = 11.32, h = 34.654},
            {x = -1485.97, y = -378.25, z = 39.16, h = 134.986},
            {x = -2966.40, y = 390.50, z = 14.04, h = 86.336},
            {x = -3038.87, y = 584.49, z = 6.90, h = 16.722},
            {x = -3242.71, y = 999.95, z = 11.83, h = 350.643},
            {x = 1727.79, y = 6415.23, z = 34.03, h = 237.870},
            {x = 1697.62, y = 4923.12, z = 41.06, h = 321.338},
            {x = 2678.15, y = 3279.27, z = 54.24, h = 329.443},
            {x = 1392.02, y = 3606.19, z = 33.98, h = 198.687},
            {x = 549.14, y = 2671.23, z = 41.15, h = 99.854},
            {x = 1166.11, y = 2710.87, z = 37.15, h = 180.121},
            {x = 2557.01, y = 380.76, z = 107.62, h = 0.303},
            {x = 1165.01, y = -324.10, z = 68.20, h = 93.551},
            {x = -47.16, y = -1758.52, z = 28.42, h = 47.141},
            {x = -1819.28, y = 793.36, z = 137.08, h = 127.693},
            {x = 1959.95, y = 3740.10, z = 31.34, h = 298.847},
            {x = 4905.78, y = -4941.23, z = 2.39, h = 18.23},
        },
    }
}