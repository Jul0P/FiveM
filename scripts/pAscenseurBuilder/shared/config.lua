pAscenseurBuilder = {
    ESX = "new", -- new : nouvelle version d'es_extended (avec la ligne export) / old : ancienne version d'es_extended (sans la ligne export)
    MenuX = 1450, -- Position X du menu
    -- # Ne mettez qu'une seule valeur RightLabel active, laissez en toujours au moins deux désactivées (donc avec ceci devant : -- )
    RightLabel = {RightLabel = "→", Color = {BackgroundColor = {120,255,0,100}, HightLightColor = {120,255,0,150}}}, -- Bouton Vert même quand il est sélectionné
    -- RightLabel = {RightLabel = "→", Color = {BackgroundColor = {120,255,0,100}}, -- Bouton Vert mais blanc quand il est sélectionné
    -- RightLabel = {RightLabel = "→"}, -- Bouton Normal
    AllowedPermission = { -- Ajouter vos identifier pour être whilelist sur le menu
        "",
    },
    AllowedGroup = { -- Ajouter vos group pour être whilelist sur le menu
        "superadmin",
        "admin",
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
    }
}