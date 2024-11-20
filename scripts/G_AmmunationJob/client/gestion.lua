function Gestion()
    local open = false
    local mainMenu = RageUI.CreateMenu("Gestion Ammunation", "Menu")
    mainMenu.Closed = function() open = false end
    if not open then open = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
            while open do
                RageUI.IsVisible(mainMenu, function()
                    if SocietyAccount ~= nil then
                        RageUI.Button("Argent de la société :", nil, {RightLabel = "~g~"..SocietyAccount.."$"}, true, {})
                    end
                    RageUI.Button("Retirer de l'argent", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            local amount = KeyboardInput("Combien voulez vous retirer", nil, 10)
                            TriggerServerEvent("esx_society:withdrawMoney", ESX.PlayerData.job.name, amount)
                            Wait(100)
                            RefreshMoney()
                        end
                    })
                    RageUI.Button("Déposer de l'argent", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            local amount = KeyboardInput("Combien voulez vous déposer", nil, 10)
                            TriggerServerEvent("esx_society:depositMoney", ESX.PlayerData.job.name, amount)
                            Wait(100)
                            RefreshMoney()
                        end
                    })
                    RageUI.Button("Ouvrir le menu patron", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            TriggerEvent("esx_society:openBossMenu", ESX.PlayerData.job.name, function(data, menu)
                                menu.close()
                            end, {wash = false})
                            RageUI.CloseAll()
                            open = false
                        end 
                    })
                end)
            Wait(0)
            end
        end)
    end
end

local pos = {{x = G_AmmunationJob.Pos.Gestion.x, y = G_AmmunationJob.Pos.Gestion.y, z = G_AmmunationJob.Pos.Gestion.z}}

Citizen.CreateThread(function()
    while true do
        local wait = 900
        for k in pairs(pos) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == "ammunation" and ESX.PlayerData.job.grade_name == "boss" then 
                local coords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(coords.x, coords.y, coords.z, pos[k].x, pos[k].y, pos[k].z)
                if dist <= 2.0 then 
                    wait = 0
                    DrawMarker(G_AmmunationJob.Marker.Type, G_AmmunationJob.Pos.Gestion.x, G_AmmunationJob.Pos.Gestion.y, G_AmmunationJob.Pos.Gestion.z-1, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.5, 0.5, 0.5, G_AmmunationJob.Marker.R, G_AmmunationJob.Marker.V, G_AmmunationJob.Marker.B, 255, false, false, p19, false)   
                    if dist <= 1.0 then 
                        wait = 0 
                        ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir le ~r~Gestion")
                        if IsControlJustPressed(1,51) then 
                            RefreshMoney()
                            Gestion()
                        end
                    end
                end
            end
        Citizen.Wait(wait)
        end
    end
end)