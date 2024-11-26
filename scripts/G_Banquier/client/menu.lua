Citizen.CreateThread(function()
	while ESX == nil do TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) Citizen.Wait(10) end
    while ESX.GetPlayerData().job == nil do Citizen.Wait(10) end
    if ESX.IsPlayerLoaded() then ESX.PlayerData = ESX.GetPlayerData() end
end)

RegisterNetEvent('esx:playerLoaded') AddEventHandler('esx:playerLoaded', function(xPlayer) ESX.PlayerData = xPlayer end)
RegisterNetEvent('esx:setJob') AddEventHandler('esx:setJob', function(job) ESX.PlayerData.job = job end)
 
local menu = false 
local mainMenu = RageUI.CreateMenu('Banquier', 'MENU')
local SubMenu = RageUI.CreateSubMenu(mainMenu, "Annonce", "MENU")
local subMenu2 = RageUI.CreateSubMenu(mainMenu, 'Création - Livret A', 'MENU')
mainMenu.Closed = function() menu = false end

valeur = {}

Citizen.CreateThread(function()
	while true do
		TriggerServerEvent('G_Banquier:load')
		Citizen.Wait(60000)
	end
end)

function Menu()
	if menu then menu = false RageUI.Visible(mainMenu, false) return else menu = true RageUI.Visible(mainMenu, true)
		CreateThread(function()
			while menu do 
		   		RageUI.IsVisible(mainMenu,function() 
            		RageUI.Button("Annonce", nil, {RightLabel = "→"}, true, {onSelected = function() end}, SubMenu)
					RageUI.Button("Faire une Facture", nil, {RightLabel = "→"}, true , {
						onSelected = function()
							OpenBillingMenu()
                	    	RageUI.CloseAll()
							menu = false
						end
					})
					RageUI.Button("Livret A", nil, {RightLabel = "→"}, true , {
						onSelected = function()
							LivretA()
							mainMenu2()
						end
					})
					RageUI.Button("Création - Livret A ", nil, {RightLabel = "→"}, true , {
						onSelected = function()
						end
					}, subMenu2)
        		end)
                RageUI.IsVisible(SubMenu, function() 
                    RageUI.Button("Annonce d'Ouverture", nil, {RightLabel = "→"}, true , {
                        onSelected = function()
                        	TriggerServerEvent('open:banquier')
                        end
                    })		
					RageUI.Button("Annonce de Fermeture", nil, {RightLabel = "→"}, true , {
    					onSelected = function()
        					TriggerServerEvent('close:banquier')
    					end
					})
                end)
				RageUI.IsVisible(subMenu2, function()
                    RageUI.Button("Montant :", nil, {RightLabel = montant2}, true, {
                        onSelected = function() 
                            local montant = KeyboardInput("Montant ", nil, 15)
                            if montant == nil then ESX.ShowNotification("Montant Invalide")
                            else montant1 = montant montant2 = "~g~"..montant1.."$" l1 = true
                            end
                        end
                    })
					RageUI.Button("Taux :", nil, {RightLabel = taux2}, l1, {
                        onSelected = function() 
                            local taux = KeyboardInput("Taux ", nil, 15)
                            if taux == nil then ESX.ShowNotification("Taux Invalide")
                            else taux1 = taux taux2 = "~o~"..taux1.."%" l2 = true
                            end
                        end
                    })
					RageUI.Button("Nom & Prénom :", nil, {RightLabel = nomprenom2}, l2, {
                        onSelected = function() 
                            local nomprenom = KeyboardInput("Nom & Prénom ", nil, 15)
                            if nomprenom == nil then ESX.ShowNotification("Nom & Prénom Invalide")
                            else nomprenom1 = nomprenom nomprenom2 = "~b~"..nomprenom1.."" l3 = true
                            end
                        end
                    })
					RageUI.Button("Banquier en charge :", nil, {RightLabel = ownerfolder2}, l3, {
                        onSelected = function() 
                            local ownerfolder = KeyboardInput("Banquier en charge du Livret A ", nil, 15)
                            if ownerfolder == nil then ESX.ShowNotification("Banquier Invalide")
                            else ownerfolder1 = ownerfolder ownerfolder2 = "~b~"..ownerfolder1.."" l4 = true
                            end
                        end
                    })
					RageUI.Button("Validé", nil, {RightBadge = RageUI.BadgeStyle.Tick, Color = {BackgroundColor = {120,255,0,100}}}, l4, {
                        onSelected = function() 
							local montant = tonumber(montant1)
							taux,nomprenom,ownerfolder = taux1,nomprenom1,ownerfolder1
                            TriggerServerEvent('G_Banquier:openSavingsAccount', montant, taux, nomprenom, ownerfolder)
                            montant2,taux2,nomprenom2,ownerfolder2 = "","","",""
                            l1,l2,l3,l4 = false,false,false,false
                            RageUI.CloseAll()
                            menu = false 
                        end
                    })
				end)
            Wait(0)
          	end
      	end)
    end
end

function mainMenu2()
	local menu2 = false
	local mainMenu2 = RageUI.CreateMenu('Livret A', 'MENU')
	local subMenu3 = RageUI.CreateSubMenu(mainMenu2, 'Livret A', 'MENU')
	mainMenu2.Closed = function() menu2 = false end
	if menu2 then menu2 = false RageUI.Visible(mainMenu2, false) return else menu2 = true RageUI.Visible(mainMenu2, true)
		CreateThread(function()
			while menu2 do 
				RageUI.IsVisible(mainMenu2, function()
					for k,v in pairs(valeur) do
						RageUI.Button("Client : ~b~"..v.nomprenom.."~s~", nil, {RightLabel = "N°"..v.identifier..""}, true , {
							onSelected = function()
								LivretA()
								valeurprecedent = v.identifier 
							end
						}, subMenu3)
					end
				end)
				RageUI.IsVisible(subMenu3, function()
					for _,v in ipairs(valeur) do
						if valeurprecedent == v.identifier then
							RageUI.Button("Nom & Prénom : ~b~"..v.nomprenom.."~s~", nil, {RightLabel = "→"}, true , {onSelected = function() end})
							RageUI.Button("Montant : ~g~"..v.montant.."$", nil, {RightLabel = "→"}, true , {onSelected = function() end})
							RageUI.Button("Taux : ~o~"..v.taux.."%", nil, {RightLabel = "→"}, true , {onSelected = function() end})
							RageUI.Button("Banquier en charge : ~b~"..v.ownerfolder.."", nil, {RightLabel = "→"}, true , {onSelected = function() end})
							if v.status == 'Ouvert' then
								RageUI.Button("Status : ~g~"..v.status.."", nil, {RightLabel = "→"}, true , {onSelected = function() end})
							else																								
								RageUI.Button("Status : ~r~"..v.status.."", nil, {RightLabel = "→"}, true , {onSelected = function() end})
							end
							RageUI.Button("Déposer", nil, {RightLabel = "→"}, true , {
								onSelected = function() 
									local depose = KeyboardInput("Déposer de l'argent dans le Livret A ", nil, 10)
									if depose == nil then 
										ESX.ShowNotification("Montant Invalide")
									else
										local depose2 = tonumber(depose) 
										TriggerServerEvent('G_Banquier:depositMoneySavingsAccount', v.identifier, depose2)
									end
								end
							})
							RageUI.Button("Retirer", nil, {RightLabel = "→"}, true , {
								onSelected = function() 
									local retire = KeyboardInput("Retirer de l'argent du Livret A ", nil, 10)
									if retire == nil then 
										ESX.ShowNotification("Montant Invalide")
									else
										local retire2 = tonumber(retire) 
										TriggerServerEvent('G_Banquier:withdrawSavings', v.identifier, retire2)
									end
								end
							})
							RageUI.Button("Modifier le taux", nil, {RightLabel = "→"}, true , {
								onSelected = function() 
									local tox = KeyboardInput("Modifier le taux du Livret A ", nil, 10)
									if tox == nil then 
										ESX.ShowNotification("Valeur Invalide")
									else
										local tox2 = tonumber(tox) 
										TriggerServerEvent('G_Banquier:changeSavingsAccountRate', v.identifier, tox2)
									end
								end
							})
							RageUI.Button("Fermer le Livret A - N°"..v.identifier.."", nil, {RightLabel = "→", Color = {BackgroundColor = {255,70,0,100}}}, true , {
								onSelected = function() 
									TriggerServerEvent('G_Banquier:closeSavingsAccount', v.identifier)
								end
							})
						end
					end
				end)
			Wait(0)
			end
		end)
	end
end

function LivretA()
	ESX.TriggerServerCallback('G_Banquier:getSavingsAccounts', function(data)
		valeur = data
	end)
end

function OpenBillingMenu()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {title = "Facture"},
	    function(data, menu)
		    local amount = tonumber(data.value)
		    local player, distance = ESX.Game.GetClosestPlayer()  
		    if player ~= -1 and distance <= 3.0 then  
		        menu.close()
		        if amount == nil then
			        ESX.ShowNotification("~r~Problème~s~\nMontant Invalide")
		        else
			        local playerPed = GetPlayerPed(-1)
			        TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
			        Citizen.Wait(5000)
			        TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_banquier', ('banquier'), amount)
			        Citizen.Wait(100)
			        ESX.ShowNotification("Vous avez bien envoyé la facture")
		        end
		    else
		        ESX.ShowNotification("~r~Problème~s~\nAucun joueur à proximité")
		    end
	    end, function(data, menu)
		menu.close()
	end)
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLength)
	AddTextEntry('FMMC_KEY_TIP1', TextEntry .. ':')
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
	blockinput = true
	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do Citizen.Wait(0) end
	if UpdateOnscreenKeyboard() ~= 2 then local result = GetOnscreenKeyboardResult() Citizen.Wait(500) blockinput = false return result
    else Citizen.Wait(500) blockinput = false return nil
	end
end

Citizen.CreateThread(function() 
	local blip = AddBlipForCoord(244.65, 220.41, 106.28) 
				 SetBlipSprite (blip, 536) 
				 SetBlipDisplay(blip, 4) 
				 SetBlipScale  (blip, 0.7) 
				 SetBlipColour (blip, 2) 
				 SetBlipAsShortRange(blip, true) 
				 BeginTextCommandSetBlipName('STRING') 
				 AddTextComponentSubstringPlayerName('Banquier - Pacific Bank') 
				 EndTextCommandSetBlipName(blip) 
end)

Citizen.CreateThread(function()
    local hash = GetHashKey("cs_bankman")
    while not HasModelLoaded(hash) do
        RequestModel(hash)
        Wait(20)
	end
	ped = CreatePed("PED_TYPE_CIVMALE", "a_f_y_business_01", 243.64, 226.23, 105.28, 158.61, false, true)
    ped2 = CreatePed("PED_TYPE_CIVMALE", "cs_bankman", 247.04, 224.98, 105.28, 164.96, false, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped2, true)
	FreezeEntityPosition(ped2, true)
    SetEntityInvincible(ped2, true)
end)

Keys.Register('F6', 'open', 'Ouvrir le menu banquier', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'banquier' then
    	Menu()
	end
end)