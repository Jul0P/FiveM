Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(5000)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
    ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:playerLogout')
AddEventHandler('esx:playerLogout', function()
    ESX.PlayerLoaded = false
    ESX.PlayerData = {}
end)

AddEventHandler('playerSpawned', function()
    Citizen.CreateThread(function()
        while not ESX.PlayerLoaded do 
            Citizen.Wait(100) 
        end
        GetAccess()
    end)
end)

local iIndex = 1

result = {}

function GetAccess()
    ESX.TriggerServerCallback("G_ClothesItem:getData", function(data)
        result = data
    end)
end

RegisterNetEvent('G_ClothesItem:Sync')
AddEventHandler('G_ClothesItem:Sync', function()
    ESX.TriggerServerCallback("G_ClothesItem:getData", function(data)
        result = data
    end)
end)

local theIndex = 1
local theItem = {"Aucun", "Masque", "Lunette", "Sac", "Veste", "T-Shirt", "Pantalon", "Chaussure", "Chaine", "Casque", "Accessoire d'Oreille", "Montre", "Bracelet", "Gilet par balle"}

function ClothesMenu()
    local clothesmenu = false
    local Clothes_mainMenu = RageUI.CreateMenu("Menu Clothes", "Liste des vêtements")  
    Clothes_mainMenu.Closed = function() clothesmenu = false end 
    if not clothesmenu then clothesmenu = true RageUI.Visible(Clothes_mainMenu, true)
        CreateThread(function()
            while clothesmenu do 
                RageUI.IsVisible(Clothes_mainMenu,function()
                    if #result == 0 then
                        RageUI.Separator("Vous n'avez aucun vêtements / accessoires")
                    else
                        RageUI.List("Filtre", theItem, theIndex, nil, {}, true, {
                            onListChange = function(Index)
                                theIndex = Index
                            end
                        })
                        RageUI.Line()
                    end
                    for i = 1, #result, 1 do
                        if theItem[theIndex] == result[i].type or theItem[theIndex] == "Aucun" then
                            RageUI.List(result[i].label, {"Mettre", "Enlever", "Renommer", "Donner", "Jeter"}, iIndex, nil, {}, true, {
                                onListChange = function(Index)
                                    iIndex = Index
                                end,
                                onSelected = function(Index)
                                    k = json.decode(result[i].item)
                                    ped = GetPlayerPed(-1)
                                    if Index == 1 then
                                        if result[i].type == "Masque" then   
                                            if ped then
                                                RequestAnimDict('missfbi4')            
                                                while not HasAnimDictLoaded('missfbi4') do
                                                    Citizen.Wait(0)
                                                end           
                                                TaskPlayAnim(PlayerPedId(), 'missfbi4', 'takeoff_mask', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                TriggerEvent("skinchanger:change", "mask_1", k.item_1-1)
                                                TriggerEvent("skinchanger:change", "mask_2", k.item_2-1)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end
                                        elseif result[i].type == "Lunette" then            
                                            if ped then
                                                RequestAnimDict('clothingspecs')           
                                                while not HasAnimDictLoaded('clothingspecs') do
                                                    Citizen.Wait(0)
                                                end         
                                                TaskPlayAnim(PlayerPedId(), 'clothingspecs', 'try_glasses_positive_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                TriggerEvent("skinchanger:change", "glasses_1", k.item_1-1)
                                                TriggerEvent("skinchanger:change", "glasses_2", k.item_2-1)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end
                                        elseif result[i].type == "Sac" then            
                                            if ped then
                                                RequestAnimDict('clothingtie')           
                                                while not HasAnimDictLoaded('clothingtie') do
                                                    Citizen.Wait(0)
                                                end         
                                                TaskPlayAnim(PlayerPedId(), 'clothingtie', 'try_tie_neutral_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                TriggerEvent("skinchanger:change", "bags_1", k.item_1-1)
                                                TriggerEvent("skinchanger:change", "bags_2", k.item_2-1)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end
                                        elseif result[i].type == "Veste" then            
                                            if ped then
                                                RequestAnimDict('clothingtie')           
                                                while not HasAnimDictLoaded('clothingtie') do
                                                    Citizen.Wait(0)
                                                end         
                                                TaskPlayAnim(PlayerPedId(), 'clothingtie', 'try_tie_neutral_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                TriggerEvent("skinchanger:change", "torso_1", k.item_1-1)
                                                TriggerEvent("skinchanger:change", "torso_2", k.item_2-1)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end 
                                        elseif result[i].type == "T-Shirt" then            
                                            if ped then
                                                RequestAnimDict('clothingtie')           
                                                while not HasAnimDictLoaded('clothingtie') do
                                                    Citizen.Wait(0)
                                                end         
                                                TaskPlayAnim(PlayerPedId(), 'clothingtie', 'try_tie_neutral_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                TriggerEvent("skinchanger:change", "tshirt_1", k.item_1-1)
                                                TriggerEvent("skinchanger:change", "tshirt_2", k.item_2-1)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end  
                                        elseif result[i].type == "Pantalon" then            
                                            if ped then
                                                RequestAnimDict('clothingtrousers')           
                                                while not HasAnimDictLoaded('clothingtrousers') do
                                                    Citizen.Wait(0)
                                                end         
                                                TaskPlayAnim(PlayerPedId(), 'clothingtrousers', 'try_trousers_neutral_c', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                TriggerEvent("skinchanger:change", "pants_1", k.item_1-1)
                                                TriggerEvent("skinchanger:change", "pants_2", k.item_2-1)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end
                                        elseif result[i].type == "Chaussure" then            
                                            if ped then
                                                RequestAnimDict('clothingshoes')           
                                                while not HasAnimDictLoaded('clothingshoes') do
                                                    Citizen.Wait(0)
                                                end         
                                                TaskPlayAnim(PlayerPedId(), 'clothingshoes', 'try_shoes_positive_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                TriggerEvent("skinchanger:change", "shoes_1", k.item_1-1)
                                                TriggerEvent("skinchanger:change", "shoes_2", k.item_2-1)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end  
                                        elseif result[i].type == "Chaine" then            
                                            if ped then
                                                RequestAnimDict('clothingtie')           
                                                while not HasAnimDictLoaded('clothingtie') do
                                                    Citizen.Wait(0)
                                                end         
                                                TaskPlayAnim(PlayerPedId(), 'clothingtie', 'try_tie_positive_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(3000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                TriggerEvent("skinchanger:change", "chain_1", k.item_1-1)
                                                TriggerEvent("skinchanger:change", "chain_2", k.item_2-1)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end          
                                        elseif result[i].type == "Casque" then           
                                            if ped then
                                                RequestAnimDict('missheistdockssetup1hardhat@')           
                                                while not HasAnimDictLoaded('missheistdockssetup1hardhat@') do
                                                    Citizen.Wait(0)
                                                end           
                                                TaskPlayAnim(PlayerPedId(), 'missheistdockssetup1hardhat@', 'put_on_hat', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                TriggerEvent("skinchanger:change", "helmet_1", k.item_1-2)
                                                TriggerEvent("skinchanger:change", "helmet_2", k.item_2-1)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end
                                        elseif result[i].type == "Accessoire d'Oreille" then       
                                            if ped then
                                                RequestAnimDict('mini@ears_defenders')           
                                                while not HasAnimDictLoaded('mini@ears_defenders') do
                                                    Citizen.Wait(0)
                                                end
                                                TaskPlayAnim(PlayerPedId(), 'mini@ears_defenders', 'takeoff_earsdefenders_idle', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                TriggerEvent("skinchanger:change", "ears_1", k.item_1-2)
                                                TriggerEvent("skinchanger:change", "ears_2", k.item_2-1)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end  
                                        elseif result[i].type == "Montre" then       
                                            if ped then
                                                --RequestAnimDict('mini@ears_defenders')           
                                                --while not HasAnimDictLoaded('mini@ears_defenders') do
                                                --    Citizen.Wait(0)
                                                --end
                                                --TaskPlayAnim(PlayerPedId(), 'mini@ears_defenders', 'takeoff_earsdefenders_idle', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                TriggerEvent("skinchanger:change", "watches_1", k.item_1-2)
                                                TriggerEvent("skinchanger:change", "watches_2", k.item_2-1)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end    
                                        elseif result[i].type == "Bracelet" then       
                                            if ped then
                                                --RequestAnimDict('mini@ears_defenders')           
                                                --while not HasAnimDictLoaded('mini@ears_defenders') do
                                                --    Citizen.Wait(0)
                                                --end
                                                --TaskPlayAnim(PlayerPedId(), 'mini@ears_defenders', 'takeoff_earsdefenders_idle', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                TriggerEvent("skinchanger:change", "bracelets_1", k.item_1-2)
                                                TriggerEvent("skinchanger:change", "bracelets_2", k.item_2-1)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end   
                                        elseif result[i].type == "Gilet par balle" then       
                                            if ped then
                                                RequestAnimDict('clothingtie')           
                                                while not HasAnimDictLoaded('clothingtie') do
                                                Citizen.Wait(0)
                                                end
                                                TaskPlayAnim(PlayerPedId(), 'clothingtie', 'try_tie_neutral_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                TriggerEvent("skinchanger:change", "bproof_1", k.item_1-1)
                                                TriggerEvent("skinchanger:change", "bproof_2", k.item_2-1)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end         
                                        end
                                    elseif Index == 2 then
                                        if result[i].type == "Masque" then   
                                            if ped then
                                                RequestAnimDict('missfbi4')            
                                                while not HasAnimDictLoaded('missfbi4') do
                                                    Citizen.Wait(0)
                                                end           
                                                TaskPlayAnim(PlayerPedId(), 'missfbi4', 'takeoff_mask', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
                                                    if skina.sex == 1 then
                                                        TriggerEvent("skinchanger:change", "mask_1", G_Clothes.Masque.Variations.Female.mask_1)
                                                        TriggerEvent("skinchanger:change", "mask_2", G_Clothes.Masque.Variations.Female.mask_2)
                                                    else
                                                        TriggerEvent("skinchanger:change", "mask_1", G_Clothes.Masque.Variations.Male.mask_1)
                                                        TriggerEvent("skinchanger:change", "mask_2", G_Clothes.Masque.Variations.Male.mask_2)
                                                    end
                                                end)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end
                                        elseif result[i].type == "Lunette" then            
                                            if ped then
                                                RequestAnimDict('clothingspecs')           
                                                while not HasAnimDictLoaded('clothingspecs') do
                                                    Citizen.Wait(0)
                                                end         
                                                TaskPlayAnim(PlayerPedId(), 'clothingspecs', 'try_glasses_positive_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
                                                    if skina.sex == 1 then
                                                        TriggerEvent("skinchanger:change", "glasses_1", G_Clothes.Lunette.Variations.Female.glasses_1)
                                                        TriggerEvent("skinchanger:change", "glasses_2", G_Clothes.Lunette.Variations.Female.glasses_2)
                                                    else
                                                        TriggerEvent("skinchanger:change", "glasses_1", G_Clothes.Lunette.Variations.Male.glasses_1)
                                                        TriggerEvent("skinchanger:change", "glasses_2", G_Clothes.Lunette.Variations.Male.glasses_2)
                                                    end
                                                end)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end
                                        elseif result[i].type == "Sac" then            
                                            if ped then
                                                RequestAnimDict('clothingtie')           
                                                while not HasAnimDictLoaded('clothingtie') do
                                                    Citizen.Wait(0)
                                                end         
                                                TaskPlayAnim(PlayerPedId(), 'clothingtie', 'try_tie_neutral_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
                                                    if skina.sex == 1 then
                                                        TriggerEvent("skinchanger:change", "bags_1", G_Clothes.Sac.Variations.Female.bags_1)
                                                        TriggerEvent("skinchanger:change", "bags_2", G_Clothes.Sac.Variations.Female.bags_2)
                                                    else
                                                        TriggerEvent("skinchanger:change", "bags_1", G_Clothes.Sac.Variations.Male.bags_1)
                                                        TriggerEvent("skinchanger:change", "bags_2", G_Clothes.Sac.Variations.Male.bags_2)
                                                    end
                                                end)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end
                                        elseif result[i].type == "Veste" then            
                                            if ped then
                                                RequestAnimDict('clothingtie')           
                                                while not HasAnimDictLoaded('clothingtie') do
                                                    Citizen.Wait(0)
                                                end         
                                                TaskPlayAnim(PlayerPedId(), 'clothingtie', 'try_tie_neutral_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
                                                    if skina.sex == 1 then
                                                        TriggerEvent("skinchanger:change", "torso_1", G_Clothes.Torse.Variations.Female.torso_1)
                                                        TriggerEvent("skinchanger:change", "torso_2", G_Clothes.Torse.Variations.Female.torso_2)
                                                    else
                                                        TriggerEvent("skinchanger:change", "torso_1", G_Clothes.Torse.Variations.Male.torso_1)
                                                        TriggerEvent("skinchanger:change", "torso_2", G_Clothes.Torse.Variations.Male.torso_2)                                              
                                                    end
                                                end)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end 
                                        elseif result[i].type == "T-Shirt" then            
                                            if ped then
                                                RequestAnimDict('clothingtie')           
                                                while not HasAnimDictLoaded('clothingtie') do
                                                    Citizen.Wait(0)
                                                end         
                                                TaskPlayAnim(PlayerPedId(), 'clothingtie', 'try_tie_neutral_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
                                                    if skina.sex == 1 then
                                                        TriggerEvent("skinchanger:change", "tshirt_1", G_Clothes.TShirt.Variations.Female.tshirt_1)
                                                        TriggerEvent("skinchanger:change", "tshirt_2", G_Clothes.TShirt.Variations.Female.tshirt_2)
                                                    else
                                                        TriggerEvent("skinchanger:change", "tshirt_1", G_Clothes.TShirt.Variations.Male.tshirt_1)
                                                        TriggerEvent("skinchanger:change", "tshirt_2", G_Clothes.TShirt.Variations.Male.tshirt_2)
                                                    end
                                                end)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end  
                                        elseif result[i].type == "Pantalon" then            
                                            if ped then
                                                RequestAnimDict('clothingtrousers')           
                                                while not HasAnimDictLoaded('clothingtrousers') do
                                                    Citizen.Wait(0)
                                                end         
                                                TaskPlayAnim(PlayerPedId(), 'clothingtrousers', 'try_trousers_neutral_c', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
                                                    if skina.sex == 1 then
                                                        TriggerEvent("skinchanger:change", "pants_1", G_Clothes.Pantalon.Variations.Female.pants_1)
                                                        TriggerEvent("skinchanger:change", "pants_2", G_Clothes.Pantalon.Variations.Female.pants_2)
                                                    else
                                                        TriggerEvent("skinchanger:change", "pants_1", G_Clothes.Pantalon.Variations.Male.pants_1)
                                                        TriggerEvent("skinchanger:change", "pants_2", G_Clothes.Pantalon.Variations.Male.pants_2)
                                                    end
                                                end)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end
                                        elseif result[i].type == "Chaussure" then            
                                            if ped then
                                                RequestAnimDict('clothingshoes')           
                                                while not HasAnimDictLoaded('clothingshoes') do
                                                    Citizen.Wait(0)
                                                end         
                                                TaskPlayAnim(PlayerPedId(), 'clothingshoes', 'try_shoes_positive_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
                                                    if skina.sex == 1 then
                                                        TriggerEvent("skinchanger:change", "shoes_1", G_Clothes.Chaussure.Variations.Female.shoes_1)
                                                        TriggerEvent("skinchanger:change", "shoes_2", G_Clothes.Chaussure.Variations.Female.shoes_2)
                                                    else
                                                        TriggerEvent("skinchanger:change", "shoes_1", G_Clothes.Chaussure.Variations.Male.shoes_1)
                                                        TriggerEvent("skinchanger:change", "shoes_2", G_Clothes.Chaussure.Variations.Male.shoes_2)
                                                    end
                                                end)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end  
                                        elseif result[i].type == "Chaine" then            
                                            if ped then
                                                RequestAnimDict('clothingtie')           
                                                while not HasAnimDictLoaded('clothingtie') do
                                                    Citizen.Wait(0)
                                                end         
                                                TaskPlayAnim(PlayerPedId(), 'clothingtie', 'try_tie_positive_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(3000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
                                                    if skina.sex == 1 then
                                                        TriggerEvent("skinchanger:change", "chain_1", G_Clothes.Chaine.Variations.Female.chain_1)
                                                        TriggerEvent("skinchanger:change", "chain_2", G_Clothes.Chaine.Variations.Female.chain_2)
                                                    else
                                                        TriggerEvent("skinchanger:change", "chain_1", G_Clothes.Chaine.Variations.Male.chain_1)
                                                        TriggerEvent("skinchanger:change", "chain_2", G_Clothes.Chaine.Variations.Male.chain_2)
                                                    end
                                                end)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end          
                                        elseif result[i].type == "Casque" then           
                                            if ped then
                                                RequestAnimDict('missheistdockssetup1hardhat@')           
                                                while not HasAnimDictLoaded('missheistdockssetup1hardhat@') do
                                                    Citizen.Wait(0)
                                                end           
                                                TaskPlayAnim(PlayerPedId(), 'missheistdockssetup1hardhat@', 'put_on_hat', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)                
                                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
                                                    if skina.sex == 1 then
                                                        TriggerEvent("skinchanger:change", "helmet_1", G_Clothes.Casque.Variations.Female.helmet_1)
                                                        TriggerEvent("skinchanger:change", "helmet_2", G_Clothes.Casque.Variations.Female.helmet_2)
                                                    else
                                                        TriggerEvent("skinchanger:change", "helmet_1", G_Clothes.Casque.Variations.Male.helmet_1)
                                                        TriggerEvent("skinchanger:change", "helmet_2", G_Clothes.Casque.Variations.Male.helmet_2)
                                                    end
                                                end)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end
                                        elseif result[i].type == "Accessoire d'Oreille" then       
                                            if ped then
                                                RequestAnimDict('mini@ears_defenders')           
                                                while not HasAnimDictLoaded('mini@ears_defenders') do
                                                    Citizen.Wait(0)
                                                end
                                                TaskPlayAnim(PlayerPedId(), 'mini@ears_defenders', 'takeoff_earsdefenders_idle', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
                                                    if skina.sex == 1 then
                                                        TriggerEvent("skinchanger:change", "ears_1", G_Clothes.Oreille.Variations.Female.ears_1)
                                                        TriggerEvent("skinchanger:change", "ears_2", G_Clothes.Oreille.Variations.Female.ears_2)
                                                    else
                                                        TriggerEvent("skinchanger:change", "ears_1", G_Clothes.Oreille.Variations.Male.ears_1)
                                                        TriggerEvent("skinchanger:change", "ears_2", G_Clothes.Oreille.Variations.Male.ears_2)
                                                    end
                                                end)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end         
                                        elseif result[i].type == "Montre" then       
                                            if ped then
                                                -- RequestAnimDict('mini@ears_defenders')           
                                                -- while not HasAnimDictLoaded('mini@ears_defenders') do
                                                --     Citizen.Wait(0)
                                                -- end
                                                -- TaskPlayAnim(PlayerPedId(), 'mini@ears_defenders', 'takeoff_earsdefenders_idle', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
                                                    if skina.sex == 1 then
                                                        TriggerEvent("skinchanger:change", "watches_1", G_Clothes.Montre.Variations.Female.watches_1)
                                                        TriggerEvent("skinchanger:change", "watches_2", G_Clothes.Montre.Variations.Female.watches_2)
                                                    else
                                                        TriggerEvent("skinchanger:change", "watches_1", G_Clothes.Montre.Variations.Male.watches_1)
                                                        TriggerEvent("skinchanger:change", "watches_2", G_Clothes.Montre.Variations.Male.watches_2)
                                                    end
                                                end)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end   
                                        elseif result[i].type == "Bracelet" then       
                                            if ped then
                                                -- RequestAnimDict('mini@ears_defenders')           
                                                -- while not HasAnimDictLoaded('mini@ears_defenders') do
                                                --     Citizen.Wait(0)
                                                -- end
                                                -- TaskPlayAnim(PlayerPedId(), 'mini@ears_defenders', 'takeoff_earsdefenders_idle', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
                                                    if skina.sex == 1 then
                                                        TriggerEvent("skinchanger:change", "bracelets_1", G_Clothes.Bracelet.Variations.Female.bracelets_1)
                                                        TriggerEvent("skinchanger:change", "bracelets_2", G_Clothes.Bracelet.Variations.Female.bracelets_2)
                                                    else
                                                        TriggerEvent("skinchanger:change", "bracelets_1", G_Clothes.Bracelet.Variations.Male.bracelets_1)
                                                        TriggerEvent("skinchanger:change", "bracelets_2", G_Clothes.Bracelet.Variations.Male.bracelets_2)
                                                    end
                                                end)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end     
                                        elseif result[i].type == "Gilet par balle" then       
                                            if ped then
                                                RequestAnimDict('clothingtie')           
                                                while not HasAnimDictLoaded('clothingtie') do
                                                Citizen.Wait(0)
                                                end
                                                TaskPlayAnim(PlayerPedId(), 'clothingtie', 'try_tie_neutral_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
                                                    if skina.sex == 1 then
                                                        TriggerEvent("skinchanger:change", "bproof_1", G_Clothes.GiletParBalle.Variations.Female.bproof_1)
                                                        TriggerEvent("skinchanger:change", "bproof_2", G_Clothes.GiletParBalle.Variations.Female.bproof_2)
                                                    else
                                                        TriggerEvent("skinchanger:change", "bproof_1", G_Clothes.GiletParBalle.Variations.Male.bproof_1)
                                                        TriggerEvent("skinchanger:change", "bproof_2", G_Clothes.GiletParBalle.Variations.Male.bproof_2)
                                                    end
                                                end)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end   
                                        end
                                    elseif Index == 3 then
                                        result[i].type = result[i].type
                                        local txt = KeyboardInput(result[i].label, "", 40)
                                        if txt then                                          
                                            TriggerServerEvent("G_ClothesItem:Rename", result[i].id, txt, result[i].type)
                                            result[i].label = txt
                                        else
                                            ESX.ShowNotification("Veuillez entrer un nom valide")
                                        end
                                    elseif Index == 4 then
                                        if result[i].index == 99 then
                                            SetPedComponentVariation(PlayerPedId(), 1, 0, 0, 2)
                                        else
                                            ClearPedProp(PlayerPedId(), result[i].index)
                                        end
                                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                        local closestPed = GetPlayerPed(closestPlayer)
                                        if IsPedSittingInAnyVehicle(closestPed) then
                                            ESX.ShowNotification('~r~Impossible de donner un objet dans un véhicule')
                                            return
                                        end
                                        if closestPlayer ~= -1 and closestDistance < 3.0 then
                                            TriggerServerEvent('G_ClothesItem:Give', GetPlayerServerId(closestPlayer), result[i].id, result[i].label)        
                                            table.remove(result, i)      
                                        else
                                            ESX.ShowNotification("~r~Aucun joueurs proche")           
                                        end
                                    elseif Index == 5 then
                                        TriggerServerEvent('G_ClothesItem:Delete', result[i].id, result[i].label,result[i])
                                        TriggerEvent('G_ClothesItem:Sync')
                                    end
                                end
                            })
                        end
                    end
                end)
            Wait(0)
            end
        end)
    end
end

if G_Clothes.ControlOpenMenuClothes ~= "" then
    Keys.Register(G_Clothes.ControlOpenMenuClothes, "ClothesMenu", "Ouvrir le menu vêtement", function()
        GetAccess()
        Wait(200)
        ClothesMenu()
    end)
end

if G_Clothes.CommandOpenMenuClothes ~= "" then
    RegisterCommand(G_Clothes.CommandOpenMenuClothes, function()
        GetAccess()
        Wait(200)
        ClothesMenu()
    end)
end
