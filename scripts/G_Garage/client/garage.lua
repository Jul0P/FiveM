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
    Garage = {},
}

function Garage(v) 
    local garage = false
    local mainMenu = RageUI.CreateMenu("Garage", "MENU", 0, 0, "commonmenu", "interaction_bgd", 0, 0, 0, 0)
    mainMenu.Closed = function() garage = false end
    if not garage then garage = true RageUI.Visible(mainMenu, true)
        Citizen.CreateThread(function()
            while garage do 
                RageUI.IsVisible(mainMenu, function()
                    for _,y in pairs(Array.Garage) do
                        local model = y.vehicle
                        local plate = y.plate        
                        local text = GetLabelText(GetDisplayNameFromVehicleModel(y.vehicle.model))        
                        RageUI.Button(text, "Plaque : ~y~"..plate.."", {RightLabel = "→"}, true, {
                            onSelected = function()  
                                SpawnVehicle(model, plate, v.Get.spawn)
                                RageUI.CloseAll()
                                garage = false
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
        for _,v in pairs(G_Garage.Garage.Pos) do
            local coords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(coords.x, coords.y, coords.z, v.Get.pos.x, v.Get.pos.y, v.Get.pos.z)
            if dist <= 5.0 then
                wait = 1
                DrawMarker(G_Garage.Garage.Marker.Type, v.Get.pos.x, v.Get.pos.y, v.Get.pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 250, 70, 160, false, false, p19, false) 
                if dist <= 2.0 then
                    wait = 1                      
                    ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir le ~b~Garage")
                    if IsControlJustPressed(1,51) then
						ESX.TriggerServerCallback('G_Garage:VehicleArrayGarage', function(data)
                            Array.Garage = data
                        end)
                        Wait(100)
                        Garage(v)
                    end
                end
            end
    	end
        for _,v in pairs(G_Garage.Garage.Pos) do
            local coords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(coords.x, coords.y, coords.z, v.Put.pos.x, v.Put.pos.y, v.Put.pos.z)
            if dist <= 5.0 then
                wait = 1
                DrawMarker(G_Garage.Garage.Marker.Type, v.Put.pos.x, v.Put.pos.y, v.Put.pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 250, 0, 0, 160, false, false, p19, false) 
                if dist <= 2.0 then
                    wait = 1                      
                    ESX.ShowHelpNotification("~INPUT_TALK~ pour ranger votre ~b~Véhicule")
                    if IsControlJustPressed(1,51) then
                        ReturnVehicle(v)
                    end
                end
            end
    	end
    Citizen.Wait(wait)
	end
end)