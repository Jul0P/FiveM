G_DrivingSchool = {
    Webhook = "",
    MinimundeBonneReponse = 2,
    Coords = {
        Accueil = {x = -927.48, y = -2038.66, z = 9.40},
        Coffre = {x = -936.53, y = -2038.02, z = 9.40},
        Garage = {x = -956.01, y = -2050.07, z = 9.40},
        SpawnVehicle = {x = -958.32, y = -2060.37, z = 9.40, w = 133.07},
        Gestion = {x = -931.40, y = -2033.68, z = 16.04},
        Vestiaire = {x = -942.34, y = -2040.47, z = 9.40},
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
        O = 255,
    },
    Blip = {
        Pos = {x = -928.63, y = -2037.33, z = 8.40},
        Sprite = 498,
        Display = 4,
        Scale = 0.9,
        Colour = 0,
        Title = "Auto-École",
    },
    Ped = {
        Coords = {x = -928.62, y = -2037.32, z = 8.40, w = 226.61},
        Hash = "a_f_y_business_01",
        Type = "PED_TYPE_CIVMALE"
    },
    Garage = {
        {label = "Sentinel", name = "sentinel"},
        {label = "Exemplar", name = "exemplar"},
    },
    Tenue = {
        {
            Label = "Tenue Entreprise",
            male = {
                tshirt_1 = 2, tshirt_2 = 0,
                torso_1 = 22, torso_2 = 0,
                decals_1 = 0, decals_2 = 0,
                chain_1 = 0, chain_2 = 0,
                arms = 0,
                pants_1 = 89, pants_2 = 22,
                shoes_1 = 62, shoes_2 = 6,
                helmet_1 = 7, helmet_2 = 0,
            },
            female = {
                tshirt_1 = 14, tshirt_2 = 0,
                torso_1 = 73, torso_2 = 0,
                decals_1 = 0, decals_2 = 0,
                chain_1 = 0, chain_2 = 0,
                arms = 0,
                pants_1 = 92, pants_2 = 22,
                shoes_1 = 65, shoes_2 = 6,
                helmet_1 = 7, helmet_2 = 1,
            }
        },
        {
            Label = "Tenue Entreprise 2",
            male = {
                tshirt_1 = 2, tshirt_2 = 0,
                torso_1 = 22, torso_2 = 0,
                decals_1 = 0, decals_2 = 0,
                chain_1 = 0, chain_2 = 0,
                arms = 0,
                pants_1 = 89, pants_2 = 22,
                shoes_1 = 62, shoes_2 = 6,
                helmet_1 = 7, helmet_2 = 0
            },
            female = {
                tshirt_1 = 14, tshirt_2 = 0,
                torso_1 = 73, torso_2 = 0,
                decals_1 = 0, decals_2 = 0,
                chain_1 = 0, chain_2 = 0,
                arms = 0,
                pants_1 = 92, pants_2 = 22,
                shoes_1 = 65, shoes_2 = 6,
                helmet_1 = 7, helmet_2 = 1,
            }
        },
    },
    AutoEcole = {
        Coords = {
            {x = -932.6718, y = -2035.28, z = 12.83, dist = 5.0},
        },
        Voiture = {
            {name = "blista", Spawn = vector3(-900.27, -2037.51, 9.28), SpawnHeading = 224.65}
        },
        Moto = {
            {name = "bati", Spawn = vector3(-900.27, -2037.51, 9.28), SpawnHeading = 224.65}
        },
        Camion = {
            {name = "mule", Spawn = vector3(-900.27, -2037.51, 9.28), SpawnHeading = 224.65}
        },
        CheckPoints = {
            {
                Pos = {x = -942.613, y = -2122.07, z = 9.31},
                Action = function(playerPed)
                    ESX.ShowAdvancedNotification('Moniteur', '~b~Commentaire', "Allons sur la route, tournez à droite, vitesse limitée à~w~ ~y~50km/h", 'CHAR_JOSH')
                    ErrorSpeed = 1
                end
            },
            {
                Pos = {x = -952.756, y = -2141.62, z = 8.93},
                Action = function(playerPed)
                    ESX.ShowAdvancedNotification('Moniteur', '~b~Commentaire', "Veuillez marquer l'arrêt, puis tourner à gauche", 'CHAR_JOSH')
                    ErrorSpeed = 1
                end
            },       
            {
                Pos = {x = -891.01, y = -2188.996, z = 8.11},
                Action = function(playerPed)
                    ESX.ShowAdvancedNotification('Moniteur', '~b~Commentaire', "Attentions aux véhicules venant à l'avant", 'CHAR_JOSH')
                    ErrorSpeed = 1
                end
            },        
            {
                Pos = {x = -877.35, y = -2223.892, z = 5.82},
                Action = function(playerPed)
                    ESX.ShowAdvancedNotification('Moniteur', '~b~Commentaire', "Veuillez marquer l'arrêt, puis continuez votre route", 'CHAR_JOSH')
                    ErrorSpeed = 1
                end
            },      
            {
                Pos = {x = -505.61, y = -2148.90, z = 8.58},
                Action = function(playerPed)
                    ESX.ShowAdvancedNotification('Moniteur', '~b~Commentaire', "Maintenant, continuez jusqu'à l'entrée de ville la plus proche", 'CHAR_JOSH')
                    ErrorSpeed = 1
                end
            },         
            {
                Pos = {x = -240.34, y = -1844.899, z = 29.13},
                Action = function(playerPed)
                    ESX.ShowAdvancedNotification('Moniteur', '~b~Commentaire', "Prenez à droite, nous rentrons en ville", 'CHAR_JOSH')
                    ErrorSpeed = 1
                end
            },     
            {
                Pos = {x = -144.61, y = -1749.872, z = 29.69},
                Action = function(playerPed)
                    ESX.ShowAdvancedNotification('Moniteur', '~b~Commentaire', "Continuez tout droit", 'CHAR_JOSH')
                    ErrorSpeed = 1
                end
            }, 
            {
                Pos = {x = -40.70, y = -1625.88, z = 28.94},
                Action = function(playerPed)
                    ESX.ShowAdvancedNotification('Moniteur', '~b~Commentaire', "Attendez que le feu soit vert pour continuer", 'CHAR_JOSH')
                    ErrorSpeed = 1
                end
            },	
            {
                Pos = {x = 59.160, y = -1523.13, z = 28.85}, 
                Action = function(playerPed)
                    ESX.ShowAdvancedNotification('Moniteur', '~b~Commentaire', "Laissez passer le pieton.", 'CHAR_JOSH')
                    ErrorSpeed = 1
                    pieton = true
                end
            },
            {
                Pos = {x = 136.71, y = -1415.05, z = 28.90},
                Action = function(playerPed)
                    ESX.ShowAdvancedNotification('Moniteur', '~b~Commentaire', "Tournez à gauche dès que possible", 'CHAR_JOSH')
                    ErrorSpeed = 1
                end
            },
            {
                Pos = {x = -78.79, y = -1354.72, z = 28.96},
                Action = function(playerPed)
                    ESX.ShowAdvancedNotification('Moniteur', '~b~Commentaire', "Faite attention au feu", 'CHAR_JOSH')
                    ErrorSpeed = 1
                end
            },
            {
                Pos = {x = -104.37, y = -1161.46, z = 25.38},
                Action = function(playerPed)
                    ESX.ShowAdvancedNotification('Moniteur', '~b~Commentaire', "Tournez à gauche", 'CHAR_JOSH')
                    ErrorSpeed = 2
                end
            },
            {
                Pos = {x = -246.99, y = -1132.73, z = 22.59},
                Action = function(playerPed)
                    ESX.ShowAdvancedNotification('Moniteur', '~b~Commentaire', "Continuez tout droit", 'CHAR_JOSH')
                    ErrorSpeed = 2
                end
            },
            {
                Pos = {x = -513.00, y = -1078.86, z = 22.38},
                Action = function(playerPed)
                    ESX.ShowAdvancedNotification('Moniteur', '~b~Commentaire', "Tournez à gauche, nous commençons à revenir en direction de l'auto école", 'CHAR_JOSH')
                    ErrorSpeed = 2
                end
            },
            {
                Pos = {x = -621.46, y = -1278.53, z = 10.33},
                Action = function(playerPed)
                    ESX.ShowAdvancedNotification('Moniteur', '~b~Commentaire', "Continuez tout droit", 'CHAR_JOSH')
                    ErrorSpeed = 2
                end
            },
            {
                Pos = {x = -659.58, y = -1439.92, z = 10.15},
                Action = function(playerPed)
                    ESX.ShowAdvancedNotification('Moniteur', '~b~Commentaire', "Ralentissez.", 'CHAR_JOSH')
                    ErrorSpeed = 2
                end
            },   
            {
                Pos = {x = -967.76, y = -2071.56, z = 8.98},
                Action = function(playerPed)
                    startedconduite = false
                    if DriveErrorsS() < 5 then
                        StopDriveTest(true)
                    else
                        StopDriveTest(false)
                    end
                end
            }
        }
    }
}