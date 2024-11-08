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
    local mainMenu = RageUI.CreateMenu("Menu Vigneron", "Menu")
    local Localisation = RageUI.CreateSubMenu(mainMenu, "Localisation", "Vigneron")
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
                                TriggerServerEvent("G_VigneronJob:Open")
                            elseif xIndex == 2 then
                                TriggerServerEvent("G_VigneronJob:Close")
                            elseif xIndex == 3 then
                                local msg = KeyboardInput("Message", nil, 100)
                                TriggerServerEvent("G_VigneronJob:Perso", msg)
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
                            SetNewWaypoint(-1803.69, 2214.42, 91.43)
                        end
                    })
                    RageUI.Button("Obtenir le traitement", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            SetNewWaypoint(-51.86, 1911.27, 195.36)
                        end
                    })
                    RageUI.Button("Obtenir la vente", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            SetNewWaypoint(-158.3, -54.21, 53.4)
                        end
                    })
                end)
            Wait(0)
            end
        end)
    end
end

Keys.Register("F6", "vigneron", "Ouvrir le menu vigneron", function()
    if ESX.PlayerData.job and ESX.PlayerData.job.name == "vigneron" then
        Menu()
    end
end)