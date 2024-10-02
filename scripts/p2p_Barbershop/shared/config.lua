Config = {
    getSharedObject = "last", -- last : es_extended version >= 1.9.0 / old : es_extended version < 1.9.0
    Locale = GetConvar('esx:locale', 'fr'),
    Translate = TranslateCap, -- TranslateCap : es_extended version >= 1.9.0 / _U : es_extended version < 1.9.0
    MenuX = 0,
    price = 100,
    key = { -- https://docs.fivem.net/docs/game-references/controls/
        tournerdroite = 47, -- turn left
        tournergauche = 75, -- turn right
        activerdesactivercamera = 82, -- activate cam
        tourner90 = 22, -- turn 90°
        dezoomer = 11, -- zoom out
        zoomer = 10, -- zoom in
    },
    coords = {
        {x = -814.3, y = -183.8, z = 36.57},
        {x = 136.8, y = -1708.4, z = 28.30},
        {x = -1282.6, y = -1116.8, z = 6.00},
        {x = 1931.5, y = 3729.7, z = 31.85},
        {x = 1212.8, y = -472.9, z = 65.22},
        {x = -32.9, y = -152.3, z = 56.08},
        {x = -278.1, y = 6228.5, z = 30.70},
    },
    blip = { -- https://docs.fivem.net/docs/game-references/blips/
        sprite = 71,
        scale = 0.7,
        colour = 17,
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
            g = 0,
            b = 0,
            a = 200
        },
        jump = false,
        rotate = false
    },
    array = {
        cheveux = 79,
        barbe = 29,
        sourcil = 34,
        maquillage = 95,
        bouche = 10,
        lentille = 32,
    },
    index = {
        couleurcheveuxprimaire = {1, 1},
        couleurbarbeprimaire = {1, 1},
        couleursourcilprimaire = {1, 1},
        couleurmaquillageprimaire = {1, 1},
        couleurboucheprimaire = {1, 1},
        couleurcheveuxsecondaire = {1, 1},
        couleurbarbesecondaire = {1, 1},
        couleursourcilsecondaire = {1, 1},
        couleurmaquillagesecondaire = {1, 1},
        couleurbouchesecondaire = {1, 1},
    }
}