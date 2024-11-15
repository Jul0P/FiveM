ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
    ESX.PlayerData.job = job
end)

local vestiaire = false 
local mainMenu = RageUI.CreateMenu('Vestiaire', 'MENU')
mainMenu.Closed = function() vestiaire = false end

function Vestiaire()
	if vestiaire then vestiaire = false RageUI.Visible(mainMenu, false) return else vestiaire = true RageUI.Visible(mainMenu, true)
		CreateThread(function()
		    while vestiaire do 
		        RageUI.IsVisible(mainMenu,function() 
                    RageUI.Button("Tenue : Civile", nil, {RightLabel = "→"}, true , {onSelected = function() civil() end})
                    RageUI.Button("Tenue : Cadet", nil, {RightLabel = "→"}, true , {onSelected = function() cadet() end})
                    RageUI.Button("Tenue : Officier", nil, {RightLabel = "→"}, true , {onSelected = function() officier() end})	
                    RageUI.Button("Tenue : Sergeant", nil, {RightLabel = "→"}, true , {onSelected = function() sergeant() end})
                    RageUI.Button("Tenue : Lieutenant", nil, {RightLabel = "→"}, true , {onSelected = function() lieutenant() end})
                    RageUI.Button("Tenue : Capitaine", nil, {RightLabel = "→"}, true , {onSelected = function() capitaine() end})
                    RageUI.Button("Tenue : Commandant", nil, {RightLabel = "→"}, true , {onSelected = function() commandant() end})
                    RageUI.Button("Tenue : NOOSE", nil, {RightLabel = "→"}, true , {onSelected = function() noose() end})
                    RageUI.Button("Tenue : MOTO", nil, {RightLabel = "→"}, true , {onSelected = function() moto() end})
		        end)
		    Wait(0)
		    end
	    end)
    end
end

function civil() ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin) TriggerEvent('skinchanger:loadSkin', skin) end) end

function cadet()
    local model = GetEntityModel(GetPlayerPed(-1))
    TriggerEvent('skinchanger:getSkin', function(skin)
        if model == GetHashKey("mp_m_freemode_01") then
            clothesSkin = {
                ['tshirt_1'] = 58,  ['tshirt_2'] = 0,
                ['torso_1'] = 21,   ['torso_2'] = 0,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 0,
                ['pants_1'] = 69,   ['pants_2'] = 0,
                ['shoes_1'] = 40,   ['shoes_2'] = 0,
                ['helmet_1'] = -1,  ['helmet_2'] = 0,
                ['chain_1'] = 0,    ['chain_2'] = 0,
                ['mask_1'] = -1,    ['mask_2'] = 0,
                ['bproof_1'] = 51,  ['bproof_2'] = 0,
                ['ears_1'] = -1,     ['ears_2'] = 0
            }
        else
            clothesSkin = {
                ['tshirt_1'] = 39,  ['tshirt_2'] = 0,
                ['torso_1'] = 62,   ['torso_2'] = 0,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 14,
                ['pants_1'] = 70,   ['pants_2'] = 0,
                ['shoes_1'] = 25,   ['shoes_2'] = 0,
                ['helmet_1'] = -1,  ['helmet_2'] = 0,
                ['chain_1'] = 0,    ['chain_2'] = 0,
                ['mask_1'] = -1,    ['mask_2'] = 0,
                ['bproof_1'] = 38,  ['bproof_2'] = 0,
                ['ears_1'] = -1,     ['ears_2'] = 0
            }
        end
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
    end)
end

function officier()
    local model = GetEntityModel(GetPlayerPed(-1))
    TriggerEvent('skinchanger:getSkin', function(skin)
        if model == GetHashKey("mp_m_freemode_01") then
            clothesSkin = {
                ['tshirt_1'] = 58,  ['tshirt_2'] = 0,
                ['torso_1'] = 21,  ['torso_2'] = 1,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 0,
                ['pants_1'] = 69,   ['pants_2'] = 0,
                ['shoes_1'] = 40,   ['shoes_2'] = 0,
                ['helmet_1'] = -1,  ['helmet_2'] = 0,
                ['chain_1'] = 0,    ['chain_2'] = 0,
                ['mask_1'] = -1,    ['mask_2'] = 0,
                ['bproof_1'] = 4,   ['bproof_2'] = 0,
                ['ears_1'] = -1,     ['ears_2'] = 0
            }
        else
            clothesSkin = {
                ['tshirt_1'] = 39,  ['tshirt_2'] = 0,
                ['torso_1'] = 62,   ['torso_2'] = 1,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 14,
                ['pants_1'] = 70,   ['pants_2'] = 0,
                ['shoes_1'] = 25,   ['shoes_2'] = 0,
                ['helmet_1'] = -1,  ['helmet_2'] = 0,
                ['chain_1'] = 0,    ['chain_2'] = 0,
                ['mask_1'] = -1,    ['mask_2'] = 0,
                ['bproof_1'] = 4,  ['bproof_2'] = 0,
                ['ears_1'] = -1,     ['ears_2'] = 0
            }
        end
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
    end)
end

function sergeant()
    local model = GetEntityModel(GetPlayerPed(-1))
    TriggerEvent('skinchanger:getSkin', function(skin)
        if model == GetHashKey("mp_m_freemode_01") then
            clothesSkin = {
                ['tshirt_1'] = 58,  ['tshirt_2'] = 0,
                ['torso_1'] = 21,   ['torso_2'] = 4,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 0,
                ['pants_1'] = 69,   ['pants_2'] = 0,
                ['shoes_1'] = 40,   ['shoes_2'] = 0,
                ['helmet_1'] = -1,  ['helmet_2'] = 0,
                ['chain_1'] = 0,    ['chain_2'] = 0,
                ['mask_1'] = -1,    ['mask_2'] = 0,
                ['bproof_1'] = 7,  ['bproof_2'] = 0,
                ['ears_1'] = -1,     ['ears_2'] = 0
            }
        else
            clothesSkin = {
                ['tshirt_1'] = 39,  ['tshirt_2'] = 0,
                ['torso_1'] = 62,   ['torso_2'] = 4,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 14,
                ['pants_1'] = 70,   ['pants_2'] = 0,
                ['shoes_1'] = 25,   ['shoes_2'] = 0,
                ['helmet_1'] = -1,  ['helmet_2'] = 0,
                ['chain_1'] = 0,    ['chain_2'] = 0,
                ['mask_1'] = -1,    ['mask_2'] = 0,
                ['bproof_1'] = 7,  ['bproof_2'] = 0,
                ['ears_1'] = -1,     ['ears_2'] = 0
            }
        end
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
    end)
end

function lieutenant()
    local model = GetEntityModel(GetPlayerPed(-1))
    TriggerEvent('skinchanger:getSkin', function(skin)
        if model == GetHashKey("mp_m_freemode_01") then
            clothesSkin = {
                ['tshirt_1'] = 58,  ['tshirt_2'] = 0,
                ['torso_1'] = 21,  ['torso_2'] = 5,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 0,
                ['pants_1'] = 69,   ['pants_2'] = 0,
                ['shoes_1'] = 40,   ['shoes_2'] = 0,
                ['helmet_1'] = -1,  ['helmet_2'] = 0,
                ['chain_1'] = 0,    ['chain_2'] = 0,
                ['ears_1'] = -1,     ['ears_2'] = 0,
                ['bproof_1'] = 30,   ['bproof_2'] = 3
            }
        else
            clothesSkin = {
                ['tshirt_1'] = 39,  ['tshirt_2'] = 0,
                ['torso_1'] = 62,   ['torso_2'] = 5,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 14,
                ['pants_1'] = 70,   ['pants_2'] = 0,
                ['shoes_1'] = 25,   ['shoes_2'] = 0,
                ['helmet_1'] = -1,  ['helmet_2'] = 0,
                ['chain_1'] = 0,    ['chain_2'] = 0,
                ['mask_1'] = -1,    ['mask_2'] = 0,
                ['bproof_1'] = 42,  ['bproof_2'] = 0,
                ['ears_1'] = -1,     ['ears_2'] = 0
            }
        end
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
    end)
end

function capitaine()
    local model = GetEntityModel(GetPlayerPed(-1))
    TriggerEvent('skinchanger:getSkin', function(skin)
        if model == GetHashKey("mp_m_freemode_01") then
            clothesSkin = {
                ['tshirt_1'] = 58,  ['tshirt_2'] = 0,
                ['torso_1'] = 21,   ['torso_2'] = 6,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 0,
                ['pants_1'] = 69,   ['pants_2'] = 0,
                ['shoes_1'] = 40,   ['shoes_2'] = 0,
                ['helmet_1'] = -1,  ['helmet_2'] = 0,
                ['chain_1'] = 0,    ['chain_2'] = 0,
                ['ears_1'] = -1,     ['ears_2'] = 0,
                ['bproof_1'] = 28,  ['bproof_2'] = 0
            }
        else
            clothesSkin = {
                ['tshirt_1'] = 39,  ['tshirt_2'] = 0,
                ['torso_1'] = 62,   ['torso_2'] = 6,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 14,
                ['pants_1'] = 70,   ['pants_2'] = 0,
                ['shoes_1'] = 25,   ['shoes_2'] = 0,
                ['helmet_1'] = -1,  ['helmet_2'] = 0,
                ['chain_1'] = 0,    ['chain_2'] = 0,
                ['mask_1'] = -1,    ['mask_2'] = 0,
                ['bproof_1'] = 37,  ['bproof_2'] = 0,
                ['ears_1'] = -1,     ['ears_2'] = 0
            }
        end
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
    end)
end

function commandant()
    local model = GetEntityModel(GetPlayerPed(-1))
    TriggerEvent('skinchanger:getSkin', function(skin)
        if model == GetHashKey("mp_m_freemode_01") then
            clothesSkin = {
                ['tshirt_1'] = 58,  ['tshirt_2'] = 0,
                ['torso_1'] = 21,   ['torso_2'] = 8,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 0,
                ['pants_1'] = 69,   ['pants_2'] = 2,
                ['shoes_1'] = 40,   ['shoes_2'] = 0,
                ['helmet_1'] = -1,  ['helmet_2'] = 0,
                ['chain_1'] = 0,    ['chain_2'] = 0,
                ['ears_1'] = -1,     ['ears_2'] = 0,
                ['bproof_1'] = 57,  ['bproof_2'] = 0
            }
        else
            clothesSkin = {
                ['tshirt_1'] = 39,  ['tshirt_2'] = 0,
                ['torso_1'] = 62,   ['torso_2'] = 8,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 14,
                ['pants_1'] = 70,   ['pants_2'] = 0,
                ['shoes_1'] = 25,   ['shoes_2'] = 0,
                ['helmet_1'] = -1,  ['helmet_2'] = 0,
                ['chain_1'] = 0,    ['chain_2'] = 0,
                ['mask_1'] = -1,    ['mask_2'] = 0,
                ['bproof_1'] = 37,  ['bproof_2'] = 0,
                ['ears_1'] = -1,     ['ears_2'] = 0
            }
        end
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
    end)
end

function noose()
    local model = GetEntityModel(GetPlayerPed(-1))
    TriggerEvent('skinchanger:getSkin', function(skin)
        if model == GetHashKey("mp_m_freemode_01") then
            clothesSkin = {
                ['tshirt_1'] = 58,  ['tshirt_2'] = 0,
                ['torso_1'] = 21,   ['torso_2'] = 8,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 0,
                ['pants_1'] = 69,   ['pants_2'] = 2,
                ['shoes_1'] = 40,   ['shoes_2'] = 0,
                ['helmet_1'] = -1,  ['helmet_2'] = 0,
                ['chain_1'] = 0,    ['chain_2'] = 0,
                ['ears_1'] = -1,     ['ears_2'] = 0,
                ['bproof_1'] = 57,  ['bproof_2'] = 0
            }
        else
            clothesSkin = {
                ['tshirt_1'] = 14,  ['tshirt_2'] = 0,
                ['torso_1'] = 86,   ['torso_2'] = 0,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 18,
                ['pants_1'] = 24,   ['pants_2'] = 0,
                ['shoes_1'] = 25,   ['shoes_2'] = 0,
                ['helmet_1'] = 80,  ['helmet_2'] = 0,
                ['chain_1'] = 0,    ['chain_2'] = 0,
                ['ears_1'] = -1,    ['ears_2'] = 0,
                ['bproof_1'] = 37,   ['bproof_2'] = 2,
                ['mask_1'] = 22,     ['mask_2'] = 0
            }
        end
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
    end)
end

function moto()
    local model = GetEntityModel(GetPlayerPed(-1))
    TriggerEvent('skinchanger:getSkin', function(skin)
        if model == GetHashKey("mp_m_freemode_01") then
            clothesSkin = {
                ['tshirt_1'] = 58,  ['tshirt_2'] = 0,
                ['torso_1'] = 142,   ['torso_2'] = 0,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 23,
                ['pants_1'] = 66,   ['pants_2'] = 1,
                ['shoes_1'] = 13,   ['shoes_2'] = 0,
                ['helmet_1'] = 17,  ['helmet_2'] = 1,
                ['chain_1'] = 0,    ['chain_2'] = 0,
                ['ears_1'] = -1,     ['ears_2'] = 0,
                ['bproof_1'] = 0,   ['bproof_2'] = 0,
                ['mask_1'] = 0,     ['mask_2'] = 0
            }
        else
            clothesSkin = {
                ['tshirt_1'] = 14,  ['tshirt_2'] = 0,
                ['torso_1'] = 157,   ['torso_2'] = 0,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 31,
                ['pants_1'] = 67,   ['pants_2'] = 1,
                ['shoes_1'] = 9,   ['shoes_2'] = 0,
                ['helmet_1'] = 17,  ['helmet_2'] = 1,
                ['chain_1'] = 0,    ['chain_2'] = 0,
                ['ears_1'] = -1,    ['ears_2'] = 0,
                ['bproof_1'] = 0,   ['bproof_2'] = 0,
                ['mask_1'] = 0,     ['mask_2'] = 0
            }
        end
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
    end)
end


local pos = {{x = 461.73, y = -999.43, z = 30.68}}

Citizen.CreateThread(function()
    while true do
        local wait = 900
        for k in pairs(pos) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then 
                local coords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(coords.x, coords.y, coords.z, pos[k].x, pos[k].y, pos[k].z)
                if dist <= 2.0 then wait = 0
                    DrawMarker(6, 461.73, -999.43, 29.7, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 66, 255, 255, false, false, p19, false) 
                    if dist <= 1.0 then wait = 0 ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir le ~b~Vestiaire")
                        if IsControlJustPressed(1,51) then Vestiaire()
                        end
                    end
                end
            end
        Citizen.Wait(wait)
        end
    end
end)