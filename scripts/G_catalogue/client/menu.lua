Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(5000)
	end
end)

local catalogue = false 
local mainMenu = RageUI.CreateMenu('Catalogue - Concess', 'MENU')
local subMenu = RageUI.CreateSubMenu(mainMenu, 'Catalogue - Concess', 'MENU')
mainMenu.Closed = function() deletecache() catalogue = false end

List = {
	info = {},
	listinfo = {},
}

local lveh = {}

function Catalogue()
	if catalogue then catalogue = false RageUI.Visible(mainMenu, false) return else catalogue = true RageUI.Visible(mainMenu, true)
		CreateThread(function()
		    while catalogue do 
		        RageUI.IsVisible(mainMenu, function() 
                    for i = 1, #List.info, 1 do
                        RageUI.Button("Catégorie - "..List.info[i].label, nil, {RightLabel = "→"}, true, {
                            onSelected = function()   
                                categoriesveh = List.info[i].name
                                ESX.TriggerServerCallback('G_catalogue:vehlist', function(listveh)
                                    List.listinfo = listveh
                                end, categoriesveh)
                            end                    
                        }, subMenu)
                    end
		        end)
                RageUI.IsVisible(subMenu, function ()
                    for i2 = 1, #List.listinfo, 1 do
                        RageUI.Button(List.listinfo[i2].name, nil, {RightLabel = "~g~"..ESX.Math.GroupDigits(List.listinfo[i2].price).."$"}, true, {
                            onSelected = function()  
                                labelveh = List.listinfo[i2].model
                                deletecache()
                                ESX.Game.SpawnLocalVehicle(labelveh, {x = -783.67, y = -223.54, z = 37.32}, 137.39, function(vehicle)
                                    table.insert(lveh, vehicle)
                                    FreezeEntityPosition(vehicle, true)
                                    TaskEnterVehicle(PlayerPedId(), vehicle, 10, -1, 1.0, 1, 0)
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

local pos = {{x = -792.9, y = -224.16, z = 37.08}}

Citizen.CreateThread(function()
    while true do
        local wait = 900
        for k in pairs(pos) do 
            local coords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(coords.x, coords.y, coords.z, pos[k].x, pos[k].y, pos[k].z)
            if dist <= 2.0 then
                wait = 0
                DrawMarker(6, -792.9, -224.16, 36.1, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 255, false, false, p19, false) 
                if dist <= 1.0 then
                    wait = 0
                    ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir le ~b~Catalogue")
                    if IsControlJustPressed(1,51) then
                        deletecache()
                        ESX.TriggerServerCallback('G_catalogue:categoriesveh', function(info)
                            List.info = info
                        end)
				        Catalogue()
                    end
                end
            end
        Citizen.Wait(wait)
        end
    end
end)

function deletecache()
	while #lveh > 0 do
		local vehicle = lveh[1]
		ESX.Game.DeleteVehicle(vehicle)
		table.remove(lveh, 1)
	end
end