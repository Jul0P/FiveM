local boss = false 
local mainMenu = RageUI.CreateMenu('Gestion Entreprise', 'MENU')
mainMenu.Closed = function() boss = false end

function Boss()
	if boss then boss = false RageUI.Visible(mainMenu, false) return else boss = true RageUI.Visible(mainMenu, true)
		CreateThread(function()
		    while boss do 
		        RageUI.IsVisible(mainMenu,function() 
			        RageUI.Button("Retirer argent société", nil, {RightLabel = "→"}, true , {
				        onSelected = function()
                            local amount = KeyboardInput("Retirer ", nil, 7)
                            amount = tonumber(amount)
                            if amount == nil then
                                ESX.ShowNotification("Montant Invalide")
                            else
                                TriggerServerEvent('esx_society:withdrawMoney', 'banquier', amount)
                            end
                        end
			        })
			        RageUI.Button("Déposer argent société", nil, {RightLabel = "→"}, true , {
				        onSelected = function()
                            local amount = KeyboardInput("Déposer ", nil, 7)
                            amount = tonumber(amount)
                            if amount == nil then
                                ESX.ShowNotification("Montant Invalide")
                            else
                                TriggerServerEvent('esx_society:depositMoney', 'banquier', amount)
                            end
				        end
			        })
                    RageUI.Button("Ouvrir le menu société", nil, {RightLabel = "→"}, true, {
                        onSelected = function()   
                            bossdefault()
                            RageUI.CloseAll()
                            boss = false
                        end
                    })
		        end)
		    Wait(0)
		    end
	    end)
    end
end

function bossdefault()
    TriggerEvent('esx_society:openBossMenu', 'banquier', function(data, menu)
        menu.close()
    end, {wash = false})
end

local pos = {{x = 259.53, y = 205.29, z = 110.29}}

Citizen.CreateThread(function()
    while true do
        local wait = 900
        for k in pairs(pos) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'banquier' then 
                local coords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(coords.x, coords.y, coords.z, pos[k].x, pos[k].y, pos[k].z)
                if dist <= 2.0 then
                    wait = 0
                    DrawMarker(6, 259.53, 205.29, 109.29, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 66, 255, false, false, p19, false) 
                    if dist <= 1.0 then
                        wait = 0
                        ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir le ~g~Menu Patron")
                        if IsControlJustPressed(1,51) then
					        Boss()
                        end
                    end
                end
            end
        Citizen.Wait(wait)
        end
    end
end)