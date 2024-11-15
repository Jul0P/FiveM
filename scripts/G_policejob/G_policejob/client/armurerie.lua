local armurerie = false 
local mainMenu = RageUI.CreateMenu('Armurerie', 'MENU')
mainMenu.Closed = function() armurerie = false end

local armureries = 1

function Armurerie()
	if armurerie then armurerie = false RageUI.Visible(mainMenu, false) return else armurerie = true RageUI.Visible(mainMenu, true)
		CreateThread(function()
		    while armurerie do 
		        RageUI.IsVisible(mainMenu,function() 
                    RageUI.List("Prendre", {"Pistolet", "Tazer","Carabine d'Assaut","Fusil à Pompe", "Lampe Torche","Matraque","Fusée de Détresse","Gaz Lacrymogène"}, armureries, nil, {}, true, {
                        onListChange = function(list) armureries = list end,
                        onSelected = function(list)
                            if list == 1 then label = 'weapon_combatpistol'
                                TriggerServerEvent('police:armurerie', label)
                            elseif list == 2 then label = 'weapon_stungun'
                                TriggerServerEvent('police:armurerie', label)
                            elseif list == 3 then label = 'weapon_carbinerifle'
                                TriggerServerEvent('police:armurerie', label)
                            elseif list == 4 then label = 'weapon_pumpshotgun'
                                TriggerServerEvent('police:armurerie', label)
                            elseif list == 5 then label = 'weapon_flashlight'
                                TriggerServerEvent('police:armurerie', label)
                            elseif list == 6 then label = 'weapon_nightstick'
                                TriggerServerEvent('police:armurerie', label)
                            elseif list == 7 then label = 'weapon_flare'
                                TriggerServerEvent('police:armurerie', label)
                            elseif list == 8 then label = 'weapon_bzgas'
                                TriggerServerEvent('police:armurerie', label)
                            end
                        end
                    })
                    RageUI.Button('Prendre un gilet par balle', false, {RightBadge = RageUI.BadgeStyle.Armour}, true, {
						onSelected = function()
							SetPedArmour(GetPlayerPed(-1), 100)
						end
					})
                    RageUI.Button("Déposer son équipement", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            RemoveAllPedWeapons(GetPlayerPed(-1), true)
                            ESX.ShowNotification("Votre équipement vient d'être déposé")
                        end
                    })
		        end)
		    Wait(0)
		    end
	    end)
    end
end

local pos = {{x = 479.09, y = -996.66, z = 30.69}}

Citizen.CreateThread(function()
    while true do
        local wait = 900
        for k in pairs(pos) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then 
                local coords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(coords.x, coords.y, coords.z, pos[k].x, pos[k].y, pos[k].z)
                if dist <= 2.0 then wait = 0
                    DrawMarker(6, 479.09, -996.66, 29.7, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 66, 255, 255, false, false, p19, false) 
                    if dist <= 1.0 then wait = 0 ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir l'~b~Armurerie")
                        if IsControlJustPressed(1,51) then Armurerie()
                        end
                    end
                end
            end
        Citizen.Wait(wait)
        end
    end
end)