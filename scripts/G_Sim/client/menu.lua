Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(5000)
	end
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(xPlayer)
    ESX.PlayerData = xPlayer
end)

ArraySim = {}

function Load()
    ESX.TriggerServerCallback("</G_Sim>(G):getData", function(data)
        ArraySim = data
    end)
    ESX.TriggerServerCallback("</G_Sim>(G):getData2", function(data2)
        datanumber = data2
    end)
end

function Sim()
    local mainMenu = RageUI.CreateMenu("Gestion des SIM", "MENU")
    local sim = false
    local ArrayIndex = 1
    mainMenu.Closed = function() sim = false end
	if not sim then sim = true RageUI.Visible(mainMenu, true)
		CreateThread(function()
            ESX.TriggerServerCallback('</G_Sim>(G):getItemAmount', function(cb) 
                if cb > 0 then
                    active = true
                else
                    active = false
                end
            end, "phone")
		    while sim do 
		        RageUI.IsVisible(mainMenu, function() 
                    if not active then
                        RageUI.Separator("Vous n'avez pas de téléphone")
                    else
                        if datanumber == nil then
                            RageUI.Separator("Votre numéro actuel : ~b~Aucun")
                        else
                            RageUI.Separator("Votre numéro actuel : ~b~"..datanumber.."")
                        end 
                    end
                    for _,v in pairs(ArraySim) do
                        RageUI.List(v.name, {"Utiliser", "Donner", "Renommer", "Supprimer"}, ArrayIndex, "Numéro attribué à la carte SIM : ~b~"..v.number, {}, active, {
                            onListChange = function(Index)
                                ArrayIndex = Index
                            end,
                            onSelected = function()
                                if active then
                                    if ArrayIndex == 1 then
                                        TriggerServerEvent("</G_Sim>(G):Use", v.number)
                                        Wait(200)
                                        Load()
                                        TriggerServerEvent("</G_Sim>(G):Load")
                                    elseif ArrayIndex == 2 then
                                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                        local closestPed = GetPlayerPed(closestPlayer)
                                        if IsPedSittingInAnyVehicle(closestPed) then
                                            ESX.ShowNotification('~r~Vous ne pouvez pas donner quelque chose à quelqu\'un dans un véhicule')
                                            return
                                        end
                                        if closestPlayer ~= -1 and closestDistance < 3.0 then
                                            PlayAnim("mp_common", "givetake1_a")
                                            TriggerServerEvent("</G_Sim>(G):Give", GetPlayerServerId(closestPlayer), v.number)
                                            Wait(200)
                                            Load()
                                        else
                                            ESX.ShowNotification("Personne à proximité")
                                        end
                                    elseif ArrayIndex == 3 then
                                        newname = KeyboardInput("Choisissez un nouveau nom pour votre carte sim", v.name, 50)
                                        if not newname or newname == "" then
                                            ESX.ShowNotification("Veuillez entrer un nom valide")
                                        else
                                            TriggerServerEvent("</G_Sim>(G):Rename", v.id, newname)
                                            Wait(200)
                                            Load()
                                        end
                                    elseif ArrayIndex == 4 then
                                        TriggerServerEvent("</G_Sim>(G):Delete", v.number)
                                        Wait(200)
                                        Load()
                                    end
                                end
                            end
                        })
                    end
		        end)                   
		    Wait(0)
		    end
	    end)
    end
end

function PlayAnim(lib, anim)
    if IsPlayerDead(PlayerId()) then
        return
    end
    if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
        return
    end
    RequestAnimDict(lib)
	while not HasAnimDictLoaded(lib) do
		Citizen.Wait(1)
	end
    TaskPlayAnim(GetPlayerPed(-1), lib, anim, 4.0, -1, -1, 50, 0, false, false, false)
    Citizen.Wait(2500)
    ClearPedTasks(GetPlayerPed(-1))
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    blockinput = true
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Wait(0)
    end      
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end

if G_Sim.Key ~= "" then
    Keys.Register(G_Sim.Key, "opensimmenu", "Ouvrir le menu carte sim", function()
        Load()
        Wait(200)
        Sim()
    end)
end

if G_Sim.Command ~= "" then
    RegisterCommand(G_Sim.Command, function()
        Load()
        Wait(200)
        Sim()
    end)
end