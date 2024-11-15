ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
    ESX.PlayerData.job = job
end)

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
                            if amount == nil then ESX.ShowNotification("Montant Invalide")
                            else
                                TriggerServerEvent('esx_society:withdrawMoney', 'police', amount)
                            end
                        end
			        })
			        RageUI.Button("Déposer argent société", nil, {RightLabel = "→"}, true , {
				        onSelected = function()
                            local amount = KeyboardInput("Déposer ", nil, 7)
                            amount = tonumber(amount)
                            if amount == nil then ESX.ShowNotification("Montant Invalide")
                            else
                                TriggerServerEvent('esx_society:depositMoney', 'police', amount)
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
    TriggerEvent('esx_society:openBossMenu', 'police', function(data, menu)
        menu.close()
    end, {wash = false})
end

local pos = {{x = 460.62, y = -985.43, z = 30.72}}

Citizen.CreateThread(function()
    while true do
        local wait = 900
        for k in pairs(pos) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then 
                local coords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(coords.x, coords.y, coords.z, pos[k].x, pos[k].y, pos[k].z)
                if dist <= 2.0 then wait = 0
                    DrawMarker(6, 460.62, -985.43, 29.76, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 66, 255, 255, false, false, p19, false) 
                    if dist <= 1.0 then wait = 0 ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir le ~b~Menu Patron")
                        if IsControlJustPressed(1,51) then Boss()
                        end
                    end
                end
            end
        Citizen.Wait(wait)
        end
    end
end)