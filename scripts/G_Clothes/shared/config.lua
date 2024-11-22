G_Clothes = {
    -- # Ne mettez qu'une seule valeur RightLabel active, laissez en toujours au moins deux désactivées (donc avec ceci devant : -- )
    RightLabel = {RightLabel = "→", Color = {BackgroundColor = {120,255,0,100}, HightLightColor = {120,255,0,150}}}, -- Bouton Vert même quand il est sélectionné
    -- RightLabel = {RightLabel = "→", Color = {BackgroundColor = {120,255,0,100}}, -- Bouton Vert mais blanc quand il est sélectionné
    -- RightLabel = {RightLabel = "→"}, -- Bouton Normal
    ControlOpenMenuClothes = "F11", -- ## pour mettre aucune touche, il suffit de laisser les "" vide
    CommandOpenMenuClothes = "clothesmenu", -- ## pour mettre aucune commande, il suffit de laisser les "" vide
    NotLegacy = true, -- si vous êtes en legacy mettez false
    LineInMenu = 15, -- nombre de ligne s'affichant dans le menu maximum (plus vous en mettez plus le menu sera long de haut en bas)
    Clothes = {
        Active = true,
        Price = 100, -- Prix d'une tenue
        SubActive = {
            Masque = true,
            Torse = true,
            TShirt = true,
            Pantalon = true,
            Chaussure = true,
            Calque = true,
            Chaine = true,
            Casque = true,
            Lunette = true,
            Oreille = true,
            Montre = true,
            Bracelet = true,
            Sac = true,
            GiletParBalle = true,
            Bras = true,
        },
    },
    Masque = {
        Active = true,
        Price = 50, -- Prix d'un masque (en item)
        Variations = {
            Female = {mask_1 = 0, mask_2 = 0},
            Male = {mask_1 = 0, mask_2 = 0},
        },
    },
    Torse = {
        Active = true,
        Price = 35, -- Prix d'un torse (en item)
        Variations = {
            Female = {torso_1 = 15, torso_2 = 0},
            Male = {torso_1 = 15, torso_2 = 0},
        },
    },
    TShirt = {
        Active = true,
        Price = 20, -- Prix d'un t-shirt (en item)
        Variations = {
            Female = {tshirt_1 = 15, tshirt_2 = 0},
            Male = {tshirt_1 = 15, tshirt_2 = 0},
        },
    },
    Pantalon = {
        Active = true,
        Price = 30, -- Prix d'un pantalon (en item)
        Variations = {
            Female = {pants_1 = 15, pants_2 = 0},
            Male = {pants_1 = 18, pants_2 = 0},
        },
    },
    Chaussure = {
        Active = true,
        Price = 25, -- Prix d'une chaussure (en item)
        Variations = {
            Female = {shoes_1 = 35, shoes_2 = 0},
            Male = {shoes_1 = 34, shoes_2 = 0},
        },
    },
    Chaine = {
        Active = true,
        Price = 15, -- Prix d'une chaine (en item)
        Variations = {
            Female = {chain_1 = 0, chain_2 = 0},
            Male = {chain_1 = 0, chain_2 = 0},
        },
    },
    Casque = {
        Active = true,
        Price = 20, -- Prix d'un casque (en item)
        Variations = {
            Female = {helmet_1 = -1, helmet_2 = 0},
            Male = {helmet_1 = -1, helmet_2 = 0},
        },
    },
    Lunette = {
        Active = true,
        Price = 10, -- Prix d'une lunette (en item)
        Variations = {
            Female = {glasses_1 = 5, glasses_2 = 0},
            Male = {glasses_1 = 0, glasses_2 = 0},
        },
    },
    Oreille = {
        Active = true,
        Price = 5, -- Prix d'un accessoire d'oreille (en item)
        Variations = {
            Female = {ears_1 = -1, ears_2 = 0},
            Male = {ears_1 = -1, ears_2 = 0},
        },
    },
    Montre = {
        Active = true,
        Price = 20, -- Prix d'une montre (en item)
        Variations = {
            Female = {watches_1 = 0, watches_2 = 0},
            Male = {watches_1 = 0, watches_2 = 0},
        },
    },
    Bracelet = {
        Active = true,
        Price = 10, -- Prix d'un bracelet (en item)
        Variations = {
            Female = {bracelets_1 = 0, bracelets_2 = 0},
            Male = {bracelets_1 = 0, bracelets_2 = 0},
        },
    },
    Sac = {
        Active = true,
        Price = 25, -- Prix d'un sac (en item)
        Variations = {
            Female = {bags_1 = 0, bags_2 = 0},
            Male = {bags_1 = 0, bags_2 = 0},
        },
    },
    GiletParBalle = {
        Active = true,
        Price = 40, -- Prix d'un gilet par balle (en item)
        Variations = {
            Female = {bproof_1 = 0, bproof_2 = 0},
            Male = {bproof_1 = 0, bproof_2 = 0},
        },
    },
    Pos = {
        Clothes = {
            {x = 72.254, y = -1399.102, z = 29.396},
            {x = -703.776, y = -152.258, z = 37.435},
            {x = -167.863, y = -298.969, z = 39.743},
            {x = 428.694, y = -800.106, z = 29.511},
            {x = -829.413, y = -1073.710, z = 10.328},
            {x = -1447.797, y = -242.461, z = 49.840},
            {x = 11.632, y = 6514.224, z = 31.897},
            {x = 123.646, y = -219.440, z = 54.577},
            {x = 1696.291, y = 4829.312, z = 42.083},
            {x = 618.093, y = 2759.629, z = 42.108},
            {x = 1190.550, y = 2713.441, z = 38.242},
            {x = -1193.429, y = -772.262, z = 17.344},
            {x = -3172.496, y = 1048.133, z = 20.883},
            {x = -1108.441, y = 2708.923, z = 19.127},
        },
        Mask = {
            {x = -1338.74, y = -1278.12, z = 4.88},
        }
    },
    Blip = {
        Clothes = {
            Sprite = 73,
            Display = 4,
            Scale = 0.75,
            Colour = 47,
            Title = "Magasin de Vêtement",
        },
        Mask = {
            Sprite = 362,
            Display = 4,
            Scale = 0.75,
            Colour = 2,
            Title = "Magasin de Masque",
        }
    },
    Marker = {
        Type = 6,
        rotX = -90.0,
        rotY = 0.0,
        rotZ = 0.0,
        scaleX = 0.5,
        scaleY = 0.5,
        scaleZ = 0.5,
        R = 0,
        V = 0,
        B = 0,
        O = 255
    }
}