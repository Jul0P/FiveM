local garage = false 
local mainMenu = RageUI.CreateMenu('Garage', 'MENU')
mainMenu.Closed = function() garage = false end

function Garage()
	if garage then garage = false RageUI.Visible(mainMenu, false) return else garage = true RageUI.Visible(mainMenu, true)
		CreateThread(function()
		    while garage do 
		        RageUI.IsVisible(mainMenu,function() 
                    for k,v in pairs(vehicle.list) do
                        RageUI.Button(v.label, nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                if ESX.Game.IsSpawnPointClear(vector3(233.15, 198.12, 105.21), 2.0) then
                                    ESX.Game.SpawnVehicle(v.name, vector3(233.15, 198.12, 105.21), 70.32, function(vehicle)
                                    end)
                                else
                                    ESX.ShowNotification("La sortie est bloqué")                                  
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
    {label = 'Toros', name = 'toros'},
    {label = 'Washington', name = 'washington'},
}

local pos = {{x = 230.80, y = 201.93, z = 105.41}}

Citizen.CreateThread(function()
    while true do
        local wait = 900
        for k in pairs(pos) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'banquier' then 
                local coords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(coords.x, coords.y, coords.z, pos[k].x, pos[k].y, pos[k].z)
                if dist <= 2.0 then
                    wait = 0
                    DrawMarker(6, 230.80, 201.93, 104.43, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 66, 255, false, false, p19, false) 
                    if dist <= 1.0 then
                        wait = 0
                        ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir le ~g~Garage")
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