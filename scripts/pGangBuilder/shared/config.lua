pGangBuilder = {
    -- # Ne mettez qu'une seule valeur RightLabel active, laissez en toujours au moins deux désactivées (donc avec ceci devant : -- )
    RightLabel = {RightLabel = "→", Color = {BackgroundColor = {120,255,0,100}, HightLightColor = {120,255,0,150}}}, -- Bouton Vert même quand il est sélectionné
    -- RightLabel = {RightLabel = "→", Color = {BackgroundColor = {120,255,0,100}}, -- Bouton Vert mais blanc quand il est sélectionné
    -- RightLabel = {RightLabel = "→"}, -- Bouton Normal
    NotLegacy = false, -- false : Legacy / true : Ancienne version es_extended
    LastLegacy = false, -- true si vous êtes sur la version où il faut ligne shared_script es_extended imports dans le fxmanifest et qu'il faut retirer les esx:getSharedObject
    Money = "money",
    BlackMoney = "black_money",
    DebugDev = false, -- ne pas toucher
    AllowedPermission = { -- Ajouter vos steamid / license (votre identifier) pour être whilelist sur le menu
        "",
    },
    AllowedGroup = { -- Ajouter vos group pour être whilelist sur le menu
        "superadmin",
        "_dev",
        "admin"
    },
    WeightChest = { 
        {value = 100, label = "100Kg"},
        {value = 250, label = "250Kg"},
        {value = 500, label = "500Kg"},
        {value = 1000, label = "1000Kg"},
    },
    WeightActive = false, -- si vous avez le système de poids de es_extended activer cette option mais désactiver l'autre
    LocalWeightActive = true, -- si vous n'avez pas le système de poids de es_extended activer cette option mais désactiver l'autre
    LocalWeight = {
        money = 0.1, -- # poid de l'argent doit être configuré même si vous avez un es_extended poids
        dirtymoney = 0.1, -- # poid de l'argent sale doit être configuré même si vous avez un es_extended poids
        Item = {
            bread = 1,
            water = 1,
        },
        Weapon = { -- # poid des armes doit être configuré même si vous avez un es_extended poids
            WEAPON_PISTOL50 = 5,
            WEAPON_BAT = 5,
        }
    },
    DefaultMarker = {
        MarkerType = 6,
        MarkerrotX = -90.0,
        MarkerrotY = 0.0,
        MarkerrotZ = 0.0,
        MarkerscaleX = 0.5,
        MarkerscaleY = 0.5,
        MarkerscaleZ = 0.5,
        MarkerR = 0,
        MarkerV = 0,
        MarkerB = 0,
        MarkerO = 200
    },
    ArrayWeapon = {
        -- Melee
        Melee = {
            {name = 'WEAPON_DAGGER', label = 'Poignard'}, 
            {name = 'WEAPON_BAT', label = 'Batte'},
            {name = 'WEAPON_BOTTLE', label = 'Bouteille'}, 
            {name = 'WEAPON_CROWBAR', label = 'Pied de biche'},
            {name = 'WEAPON_FLASHLIGHT', label = 'Lampe torche'},     
            {name = 'WEAPON_GOLFCLUB', label = 'Club de golf'},
            {name = 'WEAPON_HAMMER', label = 'Marteau'},
            {name = 'WEAPON_HATCHET', label = 'Hachette'}, 
            {name = 'WEAPON_KNUCKLE', label = 'Point américain'}, 
            {name = 'WEAPON_KNIFE', label = 'Couteau'},
            {name = 'WEAPON_MACHETE', label = 'Machette'},  
            {name = 'WEAPON_SWITCHBLADE', label = 'Couteau à cran d\'arrêt'},       
            {name = 'WEAPON_NIGHTSTICK', label = 'Matraque'},
            {name = 'WEAPON_WRENCH', label = 'Clé anglaise'},  
            {name = 'WEAPON_BATTLEAXE', label = 'Hache de combat'}, 
            {name = 'WEAPON_POOLCUE', label = 'Queue de billard'},   
        },
        -- Handguns
        Handguns = {
            {name = 'WEAPON_PISTOL', label = 'Pistolet'},
            {name = 'WEAPON_PISTOL_MK2', label = 'Pistolet MK2'},
            {name = 'WEAPON_COMBATPISTOL', label = 'Pistolet de combat'},
            {name = 'WEAPON_APPISTOL', label = 'Pistolet Automatique'},
            {name = 'WEAPON_STUNGUN', label = 'Tazer'}, 
            {name = 'WEAPON_PISTOL50', label = 'Calibre 50'},
            {name = 'WEAPON_SNSPISTOL', label = 'Pétoire'},
            {name = 'WEAPON_SNSPISTOL_MK2', label = 'Pétoire MK2'},
            {name = 'WEAPON_HEAVYPISTOL', label = 'Pistolet Lourd'},
            {name = 'WEAPON_VINTAGEPISTOL', label = 'Pistolet Vintage'},
            {name = 'WEAPON_FLAREGUN', label = 'Lance fusée de détresse'}, 
            {name = 'WEAPON_REVOLVER', label = 'Revolver'},
            {name = 'WEAPON_REVOLVER_MK2', label = 'Revolver MK2'},
            {name = 'WEAPON_DOUBLEACTION', label = 'Revolver double action'},   
            {name = 'WEAPON_CERAMICPISTOL', label = 'Pistolet céramique'}, 
            {name = 'WEAPON_NAVYREVOLVER', label = 'Navy Revolver'}, 
        },
        -- Submachine Guns
        SubmachineGuns = {
            {name = 'WEAPON_MICROSMG', label = 'Micro SMG'},
            {name = 'WEAPON_SMG', label = 'SMG'},
            {name = 'WEAPON_SMG_MK2', label = 'SMG MK2'},
            {name = 'WEAPON_ASSAULTSMG', label = 'SMG d\'Assaut'},
            {name = 'WEAPON_COMBATPDW', label = 'Arme de défense personnelle'},
            {name = 'WEAPON_MACHINEPISTOL', label = 'Pistolet Mitrailleur'},
            {name = 'WEAPON_MINISMG', label = 'Mini SMG'},
        },
        -- Shotguns
        Shotguns = {
            {name = 'WEAPON_PUMPSHOTGUN', label = 'Fusil à pompe'},
            {name = 'WEAPON_PUMPSHOTGUN_MK2', label = 'Fusil à pompe MK2'},
            {name = 'WEAPON_SAWNOFFSHOTGUN', label = 'Carabine à canon scié'},
            {name = 'WEAPON_ASSAULTSHOTGUN', label = 'Carabine d\'Assaut'},
            {name = 'WEAPON_BULLPUPSHOTGUN', label = 'Carabine Bullpup'},
            {name = 'WEAPON_MUSKET', label = 'Mousquet'},   
            {name = 'WEAPON_HEAVYSHOTGUN', label = 'Fusil à pompe lourd'},
            {name = 'WEAPON_DBSHOTGUN', label = 'Fusil à pompe double canon'},  
            {name = 'WEAPON_AUTOSHOTGUN', label = 'Fusil à pompe automatique'}, 
            {name = 'WEAPON_COMBATSHOTGUN', label = 'SPAS 12'},
        },
        -- Assault Rifles
        AssaultRifles = {
            {name = 'WEAPON_ASSAULTRIFLE', label = 'Fusil d\'Assaut'},
            {name = 'WEAPON_ASSAULTRIFLE_MK2', label = 'Fusil d\'Assaut MK2'},
            {name = 'WEAPON_CARBINERIFLE', label = 'Carabine d\'Assaut'},
            {name = 'WEAPON_CARBINERIFLE_MK2', label = 'Carabine d\'Assaut MK2'},
            {name = 'WEAPON_ADVANCEDRIFLE', label = 'Fusil Avancé'},
            {name = 'WEAPON_SPECIALCARBINE', label = 'Carabine Spécialisé'},
            {name = 'WEAPON_SPECIALCARBINE_MK2', label = 'Carabine Spécialisé MK2'},
            {name = 'WEAPON_BULLPUPRIFLE', label = 'Fusil Bullpup'},
            {name = 'WEAPON_BULLPUPRIFLE_MK2', label = 'Fusil Bullpup MK2'},
            {name = 'WEAPON_COMPACTRIFLE', label = 'Fusil compact'},
            {name = 'WEAPON_MILITARYRIFLE', label = 'Steyr AUG'},
        },
        -- Light Machine Guns
        LightMachineGuns = {
            {name = 'WEAPON_MG', label = 'Mitrailleuse'},
            {name = 'WEAPON_COMBATMG', label = 'Mitrailleuse de combat'},
            {name = 'WEAPON_COMBATMG_MK2', label = 'Mitrailleuse de combat MK2'},
            {name = 'WEAPON_GUSENBERG', label = 'Balayeuse Gusenberg'},
        },
        -- Sniper Rifles
        SniperRifles = {
            {name = 'WEAPON_SNIPERRIFLE', label = 'Fusil de sniper'},
            {name = 'WEAPON_HEAVYSNIPER', label = 'Fusil de sniper lourd'},
            {name = 'WEAPON_HEAVYSNIPER_MK2', label = 'Fusil de sniper lourd MK2'},
            {name = 'WEAPON_MARKSMANRIFLE', label = 'Fusil marksman'},
            {name = 'WEAPON_MARKSMANRIFLE_MK2', label = 'Fusil marksman MK2'},
        },
        -- Heavy Weapons
        HeavyWeapons = {
            {name = 'WEAPON_RPG', label = 'Lance Roquette'},
            {name = 'WEAPON_GRENADELAUNCHER', label = 'Lance grenade'},
            {name = 'WEAPON_MINIGUN', label = 'Minigun'},
            {name = 'WEAPON_FIREWORK', label = 'Feu d\'artifice'},
            {name = 'WEAPON_RAILGUN', label = 'Canon électrique'}, 
            {name = 'WEAPON_HOMINGLAUNCHER', label = 'Lance tête chercheuse'},   
            {name = 'WEAPON_COMPACTLAUNCHER', label = 'Lanceur compact'},
        },
        -- Throwables
        Throwables = {
            {name = 'WEAPON_GRENADE', label = 'Grenade'},
            {name = 'WEAPON_BZGAS', label = 'Grenade à gaz bz'},
            {name = 'WEAPON_MOLOTOV', label = 'Cocktail molotov'},
            {name = 'WEAPON_STICKYBOMB', label = 'Bombe collante'},
            {name = 'WEAPON_PROXMINE', label = 'Mine de proximité'}, 
            {name = 'WEAPON_SNOWBALL', label = 'Boule de neige'},   
            {name = 'WEAPON_PIPEBOMB', label = 'Bombe tuyau'},   
            {name = 'WEAPON_BALL', label = 'Balle'},    
            {name = 'WEAPON_SMOKEGRENADE', label = 'Grade fumigène'},
            {name = 'WEAPON_FLARE', label = 'Fusée de détresse'},    
        },
        -- Miscellaneous
        Miscellaneous = {
            {name = 'WEAPON_PETROLCAN', label = 'Jerrican d\'essence'},
            {name = 'GADGET_PARACHUTE', label = 'Parachute'},
            {name = 'WEAPON_FIREEXTINGUISHER', label = 'Extincteur'}, 
        }
    }
}