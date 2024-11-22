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

function Vente()
    local open = false
    local mainMenu = RageUI.CreateMenu("Vente Vigneron", "Menu")
    mainMenu.Closed = function() open = false end
    if not open then open = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
            while open do
                RageUI.IsVisible(mainMenu, function()
                    RageUI.Button("Lancer/Stopper la Vente", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            xVente()
                        end
                    })
                end)
            Wait(0)
            end
        end)
    end
end

function xVente()
    vente = not vente
    while vente do
        FreezeEntityPosition(PlayerPedId(), true)
        Citizen.Wait(2000)
        TriggerServerEvent("G_VigneronJob:vente", "vin")
    end
    if not vente then
        FreezeEntityPosition(PlayerPedId(), false)
    end
end

local pos = {{x = G_VigneronJob.Pos.Vente.x, y = G_VigneronJob.Pos.Vente.y, z = G_VigneronJob.Pos.Vente.z}}

Citizen.CreateThread(function()
    while true do
        local wait = 900
        for k in pairs(pos) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then 
                local coords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(coords.x, coords.y, coords.z, pos[k].x, pos[k].y, pos[k].z)
                if dist <= 8.0 then 
                    wait = 0
                    DrawMarker(G_VigneronJob.Marker.Type, G_VigneronJob.Pos.Vente.x, G_VigneronJob.Pos.Vente.y, G_VigneronJob.Pos.Vente.z-1, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.5, 0.5, 0.5, G_VigneronJob.Marker.R, G_VigneronJob.Marker.V, G_VigneronJob.Marker.B, 255, false, false, p19, false)   
                    if dist <= 6.0 then 
                        wait = 0 
                        ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir la ~p~Vente Vigneron")
                        if IsControlJustPressed(1,51) then 
                            Vente()
                        end
                    end
                end
            end
        Citizen.Wait(wait)
        end
    end
end)