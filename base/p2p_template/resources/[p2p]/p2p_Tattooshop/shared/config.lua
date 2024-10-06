Config = {
    getSharedObject = "last", -- last : es_extended version >= 1.9.0 / old : es_extended version < 1.9.0
    Locale = GetConvar('esx:locale', 'fr'),
    Translate = TranslateCap, -- TranslateCap : es_extended version >= 1.9.0 / _U : es_extended version < 1.9.0
    MenuX = 0, -- or 1450
    key = { -- https://docs.fivem.net/docs/game-references/controls/
        tournerdroite = 47, -- turn left
        tournergauche = 75, -- turn right
        activerdesactivercamera = 82, -- enable cam
        tourner90 = 22, -- turn 90°
        dezoomer = 11, -- zoom out
        zoomer = 10, -- zoom in
    },
    coords = {
        {x = 1322.6, y = -1651.9, z = 51.3},
        {x = -1153.6, y = -1425.6, z = 4.0},
        {x = 322.1, y = 180.4, z = 102.6},
        {x = -3170.0, y = 1075.0, z = 19.9},
        {x = 1864.6, y = 3747.7, z = 32.1},
        {x = -293.7, y = 6200.0, z = 30.5}    
    },
    blip = { -- https://docs.fivem.net/docs/game-references/blips/
        sprite = 75,
        scale = 0.8,
        colour = 1
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
    clothes = {
        male = {
            sex = 0,
            tshirt_1 = 15,
            tshirt_2 = 0,
            arms = 15,
            torso_1 = 15,
            torso_2 = 0,
            pants_1 = 18,
            pants_2 = 0,
            shoes_1 = 34,
            shoes_2 = 0,
            glasses_1 = 0,
            chain_1 = 0,
            chain_2 = 0
        },
        female = {
            sex = 1,
            tshirt_1 = 15,
            tshirt_2 = 0,
            arms = 15,
            torso_1 = 15,
            torso_2 = 0,
            pants_1 = 15,
            pants_2 = 0,
            shoes_1 = 35,
            shoes_2 = 0,
            glasses_1 = 5,
            chain_1 = 0,
            chain_2 = 0
        }
    },
}
