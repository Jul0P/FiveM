local mainMenu = RageUI.CreateMenu("Coffre", "MENU")
local coffre = false
mainMenu.Closed = function() coffre = false end

function Coffre()
    if coffre then coffre = false RageUI.Visible(mainMenu, false) return else coffre = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
            while coffre do
                RageUI.IsVisible(mainMenu, function()
                    RageUI.Button("Déposer un item", nil, {RightLabel = "→"}, true, {
                        onSelected = function() 
                            mettreitem() 
                        end
                    })       
                    RageUI.Button("Prendre un item", nil, {RightLabel = "→"}, true, {
                        onSelected = function() 
                            retireritem() 
                        end
                    }) 
                end)
            Wait(0)
            end
        end)
    end
end

local pos = {{x = 474.86, y = -994.73, z = 26.27}}

Citizen.CreateThread(function()
    while true do
        local wait = 900
        for k in pairs(pos) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then 
                local coords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(coords.x, coords.y, coords.z, pos[k].x, pos[k].y, pos[k].z)
                if dist <= 2.0 then wait = 0
                    DrawMarker(6, 474.86, -994.73, 25.30, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 66, 255, 255, false, false, p19, false)  
                    if dist <= 1.0 then wait = 0 ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir le ~b~Coffre")
                        if IsControlJustPressed(1,51) then Coffre()
                        end
                    end
                end
            end
        Citizen.Wait(wait)
        end
    end
end)

itemstock = {}

function retireritem()
    local Coffre = RageUI.CreateMenu("Coffre", "MENU")
    ESX.TriggerServerCallback('police:getStockItems', function(items) 
        itemstock = items
        RageUI.Visible(Coffre, not RageUI.Visible(Coffre))
            while Coffre do
                Citizen.Wait(0)
                RageUI.IsVisible(Coffre, function()
                    for k,v in pairs(itemstock) do 
                        if v.count > 0 then
                            RageUI.Button("[~b~"..v.count.."~s~] - "..v.label.."", nil, {RightLabel = "→"}, true, {
                                onSelected = function()
                                    local count = KeyboardInput("Nombre d'item à prendre ", "", 3)
                                    TriggerServerEvent('police:getStockItem', v.name, tonumber(count))
                                    retireritem()
                                end
                            })
                        end
                    end
                end, function()
                end)
              if not RageUI.Visible(Coffre) then
              Coffre = RMenu:DeleteType("Coffre", true)
            end
        end
    end)
end

function mettreitem()
    local Inventory = RageUI.CreateMenu("Inventaire", "MENU")
    ESX.TriggerServerCallback('police:getPlayerInventory', function(inventory)
        RageUI.Visible(Inventory, not RageUI.Visible(Inventory))
            while Inventory do
                Citizen.Wait(0)
                RageUI.IsVisible(Inventory, function()
                    for i=1, #inventory.items, 1 do
                        if inventory ~= nil then
                            local item = inventory.items[i]
                            if item.count > 0 then
                                RageUI.Button("[~b~"..item.count.."~s~] - "..item.label.."", nil, {RightLabel = "→"}, true, {
                                    onSelected = function()
                                        local count = KeyboardInput("Nombre d'item à déposer ", "", 3)
                                        TriggerServerEvent('police:putStockItems', item.name, tonumber(count))
                                        mettreitem()
                                    end
                                })
                            end
                        end
                    end
                end, function()
                end)
              if not RageUI.Visible(Inventory) then
              Inventory = RMenu:DeleteType("Inventaire", true)
            end
        end
    end)
end