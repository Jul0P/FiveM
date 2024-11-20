function Menu()
    local open = false
    local xIndex = 1
    local mainMenu = RageUI.CreateMenu("Menu Ammunation", "Menu")
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
                                TriggerServerEvent("G_AmmunationJob:Open")
                            elseif xIndex == 2 then
                                TriggerServerEvent("G_AmmunationJob:Close")
                            elseif xIndex == 3 then
                                local msg = KeyboardInput("Message", nil, 100)
                                TriggerServerEvent("G_AmmunationJob:Perso", msg)
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
                end)
            Wait(0)
            end
        end)
    end
end

Keys.Register("F6", "ammunation", "Ouvrir le menu ammunation", function()
    if ESX.PlayerData.job and ESX.PlayerData.job.name == "ammunation" then
        Menu()
    end
end)