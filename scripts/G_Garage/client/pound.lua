Citizen.CreateThread(function()
	while ESX == nil do 
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
        Citizen.Wait(5000) 
    end
    if ESX.IsPlayerLoaded() then 
        ESX.PlayerData = ESX.GetPlayerData() 
    end
end)

RegisterNetEvent('esx:playerLoaded') 
AddEventHandler('esx:playerLoaded', function(xPlayer) 
    ESX.PlayerData = xPlayer 
end)

Array = {
    Pound = {},
}

function Pound(v) 
    local pound = false
    local mainMenu2 = RageUI.CreateMenu("Fourrière", "MENU", 0, 0, "commonmenu", "interaction_bgd", 0, 0, 0, 0)
    mainMenu2.Closed = function() pound = false end
    if not pound then pound = true RageUI.Visible(mainMenu2, true)
        Citizen.CreateThread(function()
            while pound do 
                RageUI.IsVisible(mainMenu2, function()
                    for _,y in pairs(Array.Pound) do
                        local model = y.vehicle                        
                        local plate = y.plate
                        local text = GetLabelText(GetDisplayNameFromVehicleModel(y.vehicle.model))
                        RageUI.Button(text, "Plaque : ~y~"..plate.."", {RightLabel = "→"}, true, {
                            onSelected = function() 
                                ESX.TriggerServerCallback('G_Garage:Buy', function(cb)
                                    if cb then
                                        SpawnVehicle(model, plate, v.spawn)
                                        RageUI.CloseAll()
                                        pound = false
                                    else
                                        ESX.ShowNotification("Vous n'avez pas assez d'argent")
                                    end
                                end)
                            end
                        })    
                    end
                end)
            Wait(0)
            end
        end)
    end
end

Citizen.CreateThread(function()
    while true do
		local wait = 900
        for _,v in pairs(G_Garage.Pound.Pos) do
            local coords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(coords.x, coords.y, coords.z, v.pos.x, v.pos.y, v.pos.z)
            if dist <= 5.0 then
                wait = 1
                DrawMarker(G_Garage.Pound.Marker.Type, v.pos.x, v.pos.y, v.pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 250, 150, 0, 160, false, false, p19, false) 
                if dist <= 2.0 then
                    wait = 1                      
                    ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir la ~b~Fourrière")
                    if IsControlJustPressed(1,51) then
                        ESX.TriggerServerCallback('G_Garage:VehicleArrayPound', function(data)
                            Array.Pound = data
                        end)
                        Wait(100)
                        Pound(v)
                    end
                end
            end
        end
    Citizen.Wait(wait)
	end
end)