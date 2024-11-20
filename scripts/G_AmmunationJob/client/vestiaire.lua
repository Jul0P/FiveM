function Vestiaire()
    local open = false
    local mainMenu = RageUI.CreateMenu("Vestiaire Ammunation", "Menu")
    mainMenu.Closed = function() open = false end
    if not open then open = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
            while open do
                RageUI.IsVisible(mainMenu, function()
                    RageUI.Button("Tenue : Civile", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            ESX.TriggerServerCallback("esx_skin:getPlayerSkin", function(skin, jobSkin) 
                                TriggerEvent("skinchanger:loadSkin", skin)
                            end)
                        end
                    })
                    RageUI.Button("Tenue : Entreprise", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            entreprise()
                        end
                    })
                end)
            Wait(0)
            end
        end)
    end
end

local pos = {{x = G_AmmunationJob.Pos.Vestiaire.x, y = G_AmmunationJob.Pos.Vestiaire.y, z = G_AmmunationJob.Pos.Vestiaire.z}}

Citizen.CreateThread(function()
    while true do
        local wait = 900
        for k in pairs(pos) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ammunation' then 
                local coords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(coords.x, coords.y, coords.z, pos[k].x, pos[k].y, pos[k].z)
                if dist <= 2.0 then 
                    wait = 0
                    DrawMarker(G_AmmunationJob.Marker.Type, G_AmmunationJob.Pos.Vestiaire.x, G_AmmunationJob.Pos.Vestiaire.y, G_AmmunationJob.Pos.Vestiaire.z-1, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.5, 0.5, 0.5, G_AmmunationJob.Marker.R, G_AmmunationJob.Marker.V, G_AmmunationJob.Marker.B, 255, false, false, p19, false)   
                    if dist <= 1.0 then 
                        wait = 0 
                        ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir le ~r~Vestiaire")
                        if IsControlJustPressed(1,51) then 
                            Vestiaire()
                        end
                    end
                end
            end
        Citizen.Wait(wait)
        end
    end
end)