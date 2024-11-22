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

function Garage()
    local open = false
    local mainMenu = RageUI.CreateMenu("Garage Vigneron", "Menu")
    mainMenu.Closed = function() open = false end
    if not open then open = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
            while open do
                RageUI.IsVisible(mainMenu, function()
                    RageUI.Button("Ranger votre véhicule", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            local veh, dist2 = ESX.Game.GetClosestVehicle(playerCoords)
                            if dist2 < 4 then
                                DeleteEntity(veh)
                            end
                        end
                    })
                    RageUI.Button("Bison 3", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            if ESX.Game.IsSpawnPointClear({x = G_VigneronJob.Pos.SpawnVehicule.x, y = G_VigneronJob.Pos.SpawnVehicule.y, z = G_VigneronJob.Pos.SpawnVehicule.z}, 2.0) then
                                ESX.Game.SpawnVehicle("bison3", {x = G_VigneronJob.Pos.SpawnVehicule.x, y = G_VigneronJob.Pos.SpawnVehicule.y, z = G_VigneronJob.Pos.SpawnVehicule.z}, G_VigneronJob.Pos.SpawnVehicule.h, function(vehicle) 
                                    SetVehicleNumberPlateText(vehicle, ESX.PlayerData.job.name)
                                    SetVehicleFixed(vehicle)
                                end)
                                RageUI.CloseAll()
                                open = false
                            else
                                ESX.ShowNotification("La sortie est bloqué")
                            end
                        end
                    })
                end)
            Wait(0)
            end
        end)
    end
end

local pos = {{x = G_VigneronJob.Pos.Garage.x, y = G_VigneronJob.Pos.Garage.y, z = G_VigneronJob.Pos.Garage.z}}

Citizen.CreateThread(function()
    while true do
        local wait = 900
        for k in pairs(pos) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then 
                local coords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(coords.x, coords.y, coords.z, pos[k].x, pos[k].y, pos[k].z)
                if dist <= 2.0 then 
                    wait = 0
                    DrawMarker(G_VigneronJob.Marker.Type, G_VigneronJob.Pos.Garage.x, G_VigneronJob.Pos.Garage.y, G_VigneronJob.Pos.Garage.z-1, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.5, 0.5, 0.5, G_VigneronJob.Marker.R, G_VigneronJob.Marker.V, G_VigneronJob.Marker.B, 255, false, false, p19, false)     
                    if dist <= 1.0 then 
                        wait = 0 
                        ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir le ~p~Garage")
                        if IsControlJustPressed(1,51) then 
                            Garage()
                        end
                    end
                end
            end
        Citizen.Wait(wait)
        end
    end
end)