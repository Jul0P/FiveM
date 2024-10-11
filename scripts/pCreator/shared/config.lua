Config = Config or {}
SublimeIndex = SublimeIndex or {}

Config.ServerName = "pBase"

Config.ESX = "new" -- new : nouvelle version d'es_extended (avec la ligne export) / old : ancienne version d'es_extended (sans la ligne export)

Config.MenuX = 1450 -- Position X du menu

Config.FirstSpawn = { x = -769.02502441, y = 323.08599854, z = 195.87930298, h = 106.61 }
Config.SpawnAfterCreator = { x = -1037.63, y = -2737.91, z = 20.17, h = 335.61 }

Config.DisplayRadar = true --> désactive la minimap durant la création

Config.KeyCam = {
    Default = 75,
    Head = 32, 
    Torso = 38, 
    Pant = 45, 
    Shoes = 183 
}

Config.Naked = {
    Male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 15,   ['torso_2'] = 0,
        ['arms'] = 15,
        ['helmet_1'] = -1,  ['helmet_2'] = 0,
        ['glasses_1'] = 0,  ['glasses_2'] = 0,
        ['pants_1'] = 14,  ['pants_2'] = 1,
        ['shoes_1'] = 34,  ['shoes_2'] = 0,
        ['bproof_1'] = 0,  ['bproof_2'] = 0,
        ['chain_1'] = 0,  ['chain_2'] = 0,
        ['mask_1'] = 0,  ['mask_2'] = 0
    },
    Female = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 15,   ['torso_2'] = 0,
        ['arms'] = 15,
        ['helmet_1'] = -1,  ['helmet_2'] = 0,
        ['glasses_1'] = 5,  ['glasses_2'] = 0,
        ['pants_1'] = 15,  ['pants_2'] = 0,
        ['shoes_1'] = 35,  ['shoes_2'] = 0,
        ['bproof_1'] = 0,  ['bproof_2'] = 0,
        ['chain_1'] = 0,  ['chain_2'] = 0,
        ['mask_1'] = 0,  ['mask_2'] = 0
    }
}