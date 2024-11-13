ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

function Menu()
    local open = false
    local xIndex = 1
    local mainMenu = RageUI.CreateMenu("Menu Tabac", "Menu")
    local Localisation = RageUI.CreateSubMenu(mainMenu, "Localisation", "Tabac")
    mainMenu.Closed = function() open = false end
    if not open then open = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
            while open do
                RageUI.IsVisible(mainMenu, function()
                    RageUI.List("Annonce", {"Ouvert", "Fermé", "Personnalisé"}, xIndex, nil, {}, true, {
                        onListChange = function(Index)
                            xIndex = Index
                        end,
                        onSelected = function()
                            if xIndex == 1 then
                                TriggerServerEvent("G_TabacJob:Open")
                            elseif xIndex == 2 then
                                TriggerServerEvent("G_TabacJob:Close")
                            elseif xIndex == 3 then
                                local msg = KeyboardInput("Message", nil, 100)
                                TriggerServerEvent("G_TabacJob:Perso", msg)
                            end
                        end
                    })
                    RageUI.Button("Facture", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            if closestPlayer == -1 or closestDistance > 3.0 then
                                ESX.ShowNotification("Personne Autour")
                            else
                                local amount = KeyboardInput("Veuillez saisir le montant de la facture", nil, 8)
                                TriggerServerEvent("esx_billing:sendBill", GetPlayerServerId(closestPlayer), "society_"..ESX.PlayerData.job.name, ESX.PlayerData.job.name, amount)
                            end
                        end
                    })
                    RageUI.Button("Position GPS du circuit", nil, {RightLabel = "→"}, true, {}, Localisation)
                end)
                RageUI.IsVisible(Localisation, function()
                    RageUI.Button("Obtenir la récolte", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            SetNewWaypoint(2865.81, 4592.44, 46.71)
                        end
                    })
                    RageUI.Button("Obtenir le traitement", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            SetNewWaypoint(207.86, 2779.67, 44.66)
                        end
                    })
                    RageUI.Button("Obtenir la vente", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            SetNewWaypoint(-27.44, -1076.11, 26.55)
                        end
                    })
                end)
            Wait(0)
            end
        end)
    end
end

Keys.Register("F6", "tabac", "Ouvrir le menu tabac", function()
    if ESX.PlayerData.job and ESX.PlayerData.job.name == "tabac" then
        Menu()
    end
end)