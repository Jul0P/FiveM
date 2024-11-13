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

function Vestiaire()
    local open = false
    local mainMenu = RageUI.CreateMenu("Vestiaire Tabac", "Menu")
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

local pos = {{x = G_TabacJob.Pos.Vestiaire.x, y = G_TabacJob.Pos.Vestiaire.y, z = G_TabacJob.Pos.Vestiaire.z}}

Citizen.CreateThread(function()
    while true do
        local wait = 900
        for k in pairs(pos) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'tabac' then 
                local coords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(coords.x, coords.y, coords.z, pos[k].x, pos[k].y, pos[k].z)
                if dist <= 2.0 then 
                    wait = 0
                    DrawMarker(G_TabacJob.Marker.Type, G_TabacJob.Pos.Vestiaire.x, G_TabacJob.Pos.Vestiaire.y, G_TabacJob.Pos.Vestiaire.z-1, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.5, 0.5, 0.5, G_TabacJob.Marker.R, G_TabacJob.Marker.V, G_TabacJob.Marker.B, 255, false, false, p19, false)    
                    if dist <= 1.0 then 
                        wait = 0 
                        ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir le ~g~Vestiaire")
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