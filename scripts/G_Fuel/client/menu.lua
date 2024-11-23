CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(5000)
	end
end)

local mainMenu = RageUI.CreateMenu("Station Essence", "Station Essence") 
local fuel = false 

mainMenu.Closed = function() fuel = false end 
mainMenu.EnableMouse = true
IndexFuel = 0
price = 0

local chargement = 0.0

function Fuel() 
    if fuel then fuel = false RageUI.Visible(mainMenu, false) return else fuel = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
            while fuel do 
                RageUI.IsVisible(mainMenu, function()
                    if IsPedInAnyVehicle(PlayerPedId()) then                        
                        local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
                        local fuellevel = GetVehicleFuelLevel(vehicle) / 100
                        local newvalue = fuellevel * 100   

                        RageUI.Button("Faire le plein", nil, {RightLabel = "→ ~g~"..price.."$"}, true, {
                            onSelected = function()
                                if fuellevel == 1 then
                                    ESX.ShowNotification("Votre réservoir est plein")
                                else
                                    mainMenu.EnableMouse = false
                                    percentage = true
                                    TaskLeaveAnyVehicle(GetPlayerPed(-1), 0, 0)
                                    Wait(2000)
                                    SetEntityHeading(GetPlayerPed(-1), 0.625)
                                    LoadAnimDict("timetable@gardener@filling_can")
                                    TaskPlayAnim(GetPlayerPed(-1), "timetable@gardener@filling_can", "gar_ig_5_filling_can", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
                                    FreezeEntityPosition(GetPlayerPed(-1), true)
                                    Wait(IndexFuel * 1000)                               
                                    ClearPedTasks(GetPlayerPed(-1))
                                    FreezeEntityPosition(GetPlayerPed(-1), false)
                                    TaskEnterVehicle(GetPlayerPed(-1), vehicle, 15.0, -1, 1.0, 1, 0)
                                    TriggerServerEvent('G_Fuel:price', price)
                                    mainMenu.EnableMouse = true
                                    percentage = false
                                    SetVehicleFuelLevel(vehicle, Final)  
                                    chargement = 0        
                                    ESX.ShowNotification("Plein Terminé\n~g~+"..IndexFuel.."L ~s~au réservoir\nVous avez payé ~g~"..price.."$")  
                                    IndexFuel = 0 
                                    price = 0  
                                    NewIndex = 0          
                                end
                            end                    
                        }) 
                        RageUI.StatisticPanelAdvanced("Essence", fuellevel, RGBA1, NewIndex, { 12, 255, 0, 255 }, RGBA3, 1)
                        RageUI.Separator(nil)   
                        RageUI.Separator(nil)   
                        RageUI.SliderPanel(IndexFuel, 0, "Taux d'Essence : ~g~+ "..IndexFuel.."L", math.floor(100 - newvalue), {  
                            onSliderChange = function(Index)
                                IndexFuel = Index
                                NewIndex = IndexFuel / 100
                                price = IndexFuel * 5
                                Final = newvalue + IndexFuel
                                valuechargement = 0.0065 / (IndexFuel/2)
                            end
                        }, 1)
                    else
                        if not percentage then
                            RageUI.Separator("Vous devez être dans un véhicule")
                        else                  
                            RageUI.PercentagePanel(chargement, "Taux du réservoir : ~g~"..math.floor(chargement*100).."%", "", "", {}) 
                            if chargement < 1.0 then
                                chargement = chargement + valuechargement
                            end
                        end
                    end
                end)
            Wait(0)
            end
        end)
    end
end

cfgfuel = {}

cfgfuel.fuel = {
	{ x = 49.4187, y = 2778.793, z = 58.043},
	{ x = 263.894, y = 2606.463, z = 44.983},
	{ x = 1039.958, y = 2671.134, z = 39.550},
	{ x = 1207.260, y = 2660.175, z = 37.899},
	{ x = 2539.685, y = 2594.192, z = 37.944},
	{ x = 2679.858, y = 3263.946, z = 55.240},
	{ x = 2005.055, y = 3773.887, z = 32.403},
	{ x = 1687.156, y = 4929.392, z = 42.078},
	{ x = 1701.314, y = 6416.028, z = 32.763},
	{ x = 179.857, y = 6602.839, z = 31.868},
	{ x = -94.4619, y = 6419.594, z = 31.489},
	{ x = -2554.996, y = 2334.40, z = 33.078},
	{ x = -1800.375, y = 803.661, z = 138.651},
	{ x = -1437.622, y = -276.747, z = 46.207},
	{ x = -2096.243, y = -320.286, z = 13.168},
	{ x = -724.619, y = -935.1631, z = 19.213},
	{ x = -526.019, y = -1211.003, z = 18.184},
	{ x = -70.2148, y = -1761.792, z = 29.534},
	{ x = 265.648, y = -1261.309, z = 29.292},
	{ x = 819.653, y = -1028.846, z = 26.403},
	{ x = 1208.951, y = -1402.567, z = 35.224},
	{ x = 1181.381, y = -330.847, z = 69.316},
	{ x = 620.843, y = 269.100, z = 103.089},
	{ x = 2581.321, y = 362.039, z = 108.468},
	{ x = 176.631, y = -1562.025, z = 29.263},
	{ x = 176.631, y = -1562.025, z = 29.263},
	{ x = -319.292, y = -1471.715, z = 30.549},
	{ x = 1784.324, y = 3330.55, z = 41.253}
}

Citizen.CreateThread(function()
    while true do
        local wait = 900
        for k,v in pairs(cfgfuel.fuel) do
            local coords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(coords.x, coords.y, coords.z, v.x, v.y, v.z)
            if dist <= 4.0 then 
                wait = 0
                --DrawMarker(6, v.x, v.y, v.z, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 66, 255, 255, false, false, p19, false) 
                if dist <= 3.0 then 
                    wait = 0 
                    ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir la ~r~Station Essence")
                    if IsControlJustPressed(1,51) then 
                        Fuel()
                    end
                end
            end
        end
    Citizen.Wait(wait)
    end
end)

function LoadAnimDict(dict)
	if not HasAnimDictLoaded(dict) then
		RequestAnimDict(dict)

		while not HasAnimDictLoaded(dict) do
			Citizen.Wait(1)
		end
	end
end 

