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

function Coffre()
    local open = false
    local mainMenu = RageUI.CreateMenu("Menu - Coffre", "Tabac")
    local Coffre = RageUI.CreateSubMenu(mainMenu, "Coffre", "Tabac")
    local Inventory = RageUI.CreateSubMenu(mainMenu, "Inventaire", "Tabac")
    mainMenu.Closed = function() open = false end
    if not open then open = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
            while open do
                RageUI.IsVisible(mainMenu, function()
                    RageUI.Button("Retirer", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            GetCoffre()
                        end
                    }, Coffre)
                    RageUI.Button("Déposer", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            GetInventory()
                        end
                    }, Inventory)
                end)
                RageUI.IsVisible(Coffre, function()
                    for _,v in pairs(data_coffre) do
                        RageUI.Button("[~b~"..v.count.."~s~] - "..v.label, nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                local amount = KeyboardInput("Nombre d'item que vous souhaitez déposer", nil, 5)
                                TriggerServerEvent("G_TabacJob:putInventoryItem", v.name, tonumber(amount), ESX.PlayerData.job.name)
                                GetCoffre()
                            end
                        })
                    end
                end)
                RageUI.IsVisible(Inventory, function()
                    for _,v in pairs(data_inventory) do
                        RageUI.Button("[~b~"..v.count.."~s~] - "..v.label, nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                local amount = KeyboardInput("Nombre d'item que vous souhaitez retirer", nil, 5)
                                TriggerServerEvent("G_TabacJob:putCoffreItem", v.name, tonumber(amount), ESX.PlayerData.job.name)
                                GetInventory()
                            end
                        })
                    end
                end)
            Wait(0)
            end
        end)
    end
end

local pos = {{x = G_TabacJob.Pos.Coffre.x, y = G_TabacJob.Pos.Coffre.y, z = G_TabacJob.Pos.Coffre.z}}

Citizen.CreateThread(function()
    while true do
        local wait = 900
        for k in pairs(pos) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'tabac' then 
                local coords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(coords.x, coords.y, coords.z, pos[k].x, pos[k].y, pos[k].z)
                if dist <= 2.0 then 
                    wait = 0
                    DrawMarker(G_TabacJob.Marker.Type, G_TabacJob.Pos.Coffre.x, G_TabacJob.Pos.Coffre.y, G_TabacJob.Pos.Coffre.z-1, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.5, 0.5, 0.5, G_TabacJob.Marker.R, G_TabacJob.Marker.V, G_TabacJob.Marker.B, 255, false, false, p19, false)  
                    if dist <= 1.0 then 
                        wait = 0 
                        ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir le ~g~Coffre")
                        if IsControlJustPressed(1,51) then 
                            Coffre()
                        end
                    end
                end
            end
        Citizen.Wait(wait)
        end
    end
end)