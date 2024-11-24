G_Radio = {
    OpenKey = "F9", -- touche pour ouvrir le menu
    VoiceSystem = "pma-voice", -- "mumble-voip" or "pma-voice"
    Item = {
        Active = true, -- Activer / Désactiver le fait d'avoir besoin d'un item "radio" pour ouvrir le menu
        Name = "radio" -- name de l'item
    },
    PrivateCanal = {
        Active = true, -- Activer / Désactiver les canaux privés
        Info = true, -- Activer / Désactiver la popup Informative en haut à droite du menu
        List = {
            {
                type = "job1", -- job1 or job2
                name = "police",
                label = "Police",
                frequency = 1,
            },
            {
                type = "job1", -- job1 or job2
                name = "ambulance",
                label = "Ambulance",
                frequency = 2,
            },
        }
    }
}