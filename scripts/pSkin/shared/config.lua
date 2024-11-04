pSkin = {
	ESX = "new", -- new : nouvelle version d'es_extended (avec la ligne export) / old : ancienne version d'es_extended (sans la ligne export)
	Legacy = true, -- mettez false si vous n'êtes pas sous legacy
	Type = "advanced", -- simple : menu skin basique (identique au esx_skin) / advanced : menu skin avancé (panel et autres choses en plus...)
	MenuX = 1450, -- Position X du menu
	ActiveSkinMenuSpawn = false, -- vous devez également avoir le script esx_identity
	Key = {
		TournerDroite = 47,
        TournerGauche = 75,
        ActiverDesactiverCamera = 82,
        Tourner90 = 22,
        Dezoomer = 11,
        Zoomer = 10,
	},
	AllowedPermission = { -- Ajouter vos identifier pour être whilelist sur le menu
        "",
    },
    AllowedGroup = { -- Ajouter vos group pour être whilelist sur le menu
        "superadmin",
        "admin",
    },
	BackpackWeight = {
		[40] = 16, 
		[41] = 20, 
		[44] = 25, 
		[45] = 23
	}
}