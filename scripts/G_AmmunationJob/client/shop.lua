function Shop()
    local open = false
    local mainMenu = RageUI.CreateMenu("Shop Ammunation", "Menu")
    local Item = RageUI.CreateSubMenu(mainMenu, "Partie - Item", "Menu")
    local Weapon = RageUI.CreateSubMenu(mainMenu, "Partie - Weapon", "Menu")
    mainMenu.Closed = function() open = false end
    if not open then open = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
            while open do
                RageUI.IsVisible(mainMenu, function()
                    RageUI.Button("Item", nil, {RightLabel = "→"}, true, {}, Item)
                    RageUI.Button("Weapon", nil, {RightLabel = "→"}, true, {}, Weapon)
                end)
                RageUI.IsVisible(Item, function()
                    for _,v in pairs(G_AmmunationJob.Item) do
                        RageUI.Button(v.label, nil, {RightLabel = "~g~"..v.price.."$ ~s~→"}, true, {
                            onSelected = function()
                                TriggerServerEvent("G_AmmunationJob:BuyItem", v)
                            end
                        })
                    end
                end)
                RageUI.IsVisible(Weapon, function()
                    for _,v in pairs(G_AmmunationJob.Weapon) do
                        RageUI.Button(v.label, nil, {RightLabel = "~g~"..v.price.."$ ~s~→"}, true, {
                            onSelected = function()
                                TriggerServerEvent("G_AmmunationJob:BuyWeapon", v)
                            end
                        })
                    end
                end)
            Wait(0)
            end
        end)
    end
end

local pos = {{x = G_AmmunationJob.Pos.Shop.x, y = G_AmmunationJob.Pos.Shop.y, z = G_AmmunationJob.Pos.Shop.z}}

Citizen.CreateThread(function()
    while true do
        local wait = 900
        for k in pairs(pos) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ammunation' then 
                local coords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(coords.x, coords.y, coords.z, pos[k].x, pos[k].y, pos[k].z)
                if dist <= 2.0 then 
                    wait = 0
                    DrawMarker(G_AmmunationJob.Marker.Type, G_AmmunationJob.Pos.Shop.x, G_AmmunationJob.Pos.Shop.y, G_AmmunationJob.Pos.Shop.z-1, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.5, 0.5, 0.5, G_AmmunationJob.Marker.R, G_AmmunationJob.Marker.V, G_AmmunationJob.Marker.B, 255, false, false, p19, false)   
                    if dist <= 1.0 then 
                        wait = 0 
                        ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir le ~r~Shop")
                        if IsControlJustPressed(1,51) then 
                            Shop()
                        end
                    end
                end
            end
        Citizen.Wait(wait)
        end
    end
end)