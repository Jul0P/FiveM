ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
    ESX.PlayerData.job = job
end)

local garage = false 
local mainMenu = RageUI.CreateMenu('Garage', 'MENU')
mainMenu.Closed = function() garage = false end

function Garage()
	if garage then garage = false RageUI.Visible(mainMenu, false) return else garage = true RageUI.Visible(mainMenu, true)
		CreateThread(function()
		    while garage do 
		        RageUI.IsVisible(mainMenu,function() 
                    RageUI.Button("Ranger le véhicule", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                            if dist4 < 4 then
                                DeleteEntity(veh)
                            end 
                        end
                    })
                    for k,v in pairs(vehicle.list) do
                        RageUI.Button(v.label, nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                if ESX.Game.IsSpawnPointClear(vector3(446.02, -986.23, 25.69), 2.0) then
                                    ESX.Game.SpawnVehicle(v.name, vector3(446.02, -986.23, 25.69), 271.43, function(vehicle)
                                    end)
                                elseif ESX.Game.IsSpawnPointClear(vector3(446.30, -988.94, 25.69), 2.0) then
                                    ESX.Game.SpawnVehicle(v.name, vector3(446.30, -988.94, 25.69), 271.43, function(vehicle)
                                    end)
                                elseif ESX.Game.IsSpawnPointClear(vector3(446.14, -991.62, 25.69), 2.0) then
                                    ESX.Game.SpawnVehicle(v.name, vector3(446.14, -991.62, 25.69), 271.43, function(vehicle)
                                    end)
                                elseif ESX.Game.IsSpawnPointClear(vector3(446.28, -994.24, 25.69), 2.0) then
                                    ESX.Game.SpawnVehicle(v.name, vector3(446.28, -994.24, 25.69), 271.43, function(vehicle)
                                    end)
                                elseif ESX.Game.IsSpawnPointClear(vector3(437.47, -986.09, 25.69), 2.0) then
                                    ESX.Game.SpawnVehicle(v.name, vector3(437.47, -986.09, 25.69), 90.06, function(vehicle)
                                    end)
                                elseif ESX.Game.IsSpawnPointClear(vector3(436.95, -988.82, 25.69), 2.0) then
                                    ESX.Game.SpawnVehicle(v.name, vector3(436.95, -988.82, 25.69), 90.06, function(vehicle)
                                    end)
                                elseif ESX.Game.IsSpawnPointClear(vector3(437.33, -991.52, 25.69), 2.0) then
                                    ESX.Game.SpawnVehicle(v.name, vector3(437.33, -991.52, 25.69), 90.06, function(vehicle)
                                    end)
                                elseif ESX.Game.IsSpawnPointClear(vector3(437.18, -994.30, 25.69), 2.0) then
                                    ESX.Game.SpawnVehicle(v.name, vector3(437.18, -994.30, 25.69), 90.06, function(vehicle)
                                    end)
                                else ESX.ShowNotification("La sortie est bloqué")                                  
                                end
                            end
                        })
                    end
                    for k,v in pairs(vehicle.heli) do
                        RageUI.Button(v.labelh, nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                if ESX.Game.IsSpawnPointClear(vector3(449.23, -981.32, 43.69), 2.0) then
                                    ESX.Game.SpawnVehicle(v.nameh, vector3(449.23, -981.32, 43.69), 90.64, function(vehicle)
                                    end)
                                else ESX.ShowNotification("La sortie est bloqué")                                  
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

vehicle = {}

vehicle.list = {
    {label = 'Crown Victoria', name = 'police'},
    {label = 'Dodge Charger 2014', name = 'police2'},
    {label = 'Ford Interceptor', name = 'police3'},
    {label = 'Moto', name = 'policeb'},
    {label = 'VIR', name = 'ghispo2'},
    {label = 'Riot', name = 'riot'},
    {label = 'Police T', name = 'policet'},
}

vehicle.heli = {{labelh = 'Hélicoptère', nameh = 'as350'}}

local pos = {{x = 459.87, y = -986.60, z = 25.69}}

Citizen.CreateThread(function()
    while true do
        local wait = 900
        for k in pairs(pos) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then 
                local coords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(coords.x, coords.y, coords.z, pos[k].x, pos[k].y, pos[k].z)
                if dist <= 2.0 then wait = 0
                    DrawMarker(6, 459.87, -986.60, 24.72, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 66, 255, 255, false, false, p19, false) 
                    if dist <= 1.0 then wait = 0
                        ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir le ~b~Garage")
                        if IsControlJustPressed(1,51) then Garage()
                        end
                    end
                end
            end
        Citizen.Wait(wait)
        end
    end
end)