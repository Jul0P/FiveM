function Menu()
	local menu = false 
	local xIndex = 1
	local mainMenu = RageUI.CreateMenu('Barbier', 'MENU')
	mainMenu.Closed = function() menu = false end
	if not menu then menu = true RageUI.Visible(mainMenu, true)
		CreateThread(function()
			while menu do 
		   		RageUI.IsVisible(mainMenu,function() 
					RageUI.List("Annonce", {"Ouvert", "Fermé", "Personnalisé"}, xIndex, nil, {}, true, {
                        onListChange = function(Index)
                            xIndex = Index
                        end,
                        onSelected = function()
                            if xIndex == 1 then
                                TriggerServerEvent("G_BarberJob:Open")
                            elseif xIndex == 2 then
                                TriggerServerEvent("G_BarberJob:Close")
                            elseif xIndex == 3 then
                                local msg = KeyboardInput("Message", nil, 100)
								if msg == nil or msg == "" then
									ESX.ShowNotification("Veuillez rentrer une valeur valide")
								else
									TriggerServerEvent("G_BarberJob:Perso", msg)
								end                            
                            end
                        end
                    })
					RageUI.Button("Faire une Facture", nil, {RightLabel = "→"}, true , {
						onSelected = function()
							local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
							if closestPlayer == -1 or closestDistance > 3.0 then
								ESX.ShowNotification('Personne autour')
							else
								local amount = KeyboardInput('Veuillez saisir le montant de la facture', '', 8)
								if amount == nil or amount == "" then
									ESX.ShowNotification("Veuillez rentrer une valeur valide")
								else
									TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_barber', 'barber', amount)
								end							
							end 
						end
					})
        		end)               
            Wait(0)
          	end
      	end)
    end
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLength)
	AddTextEntry('FMMC_KEY_TIP1', TextEntry)
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
	blockinput = true
	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
		Citizen.Wait(0) 
	end
	if UpdateOnscreenKeyboard() ~= 2 then 
		local result = GetOnscreenKeyboardResult() 
		Citizen.Wait(500) 
		blockinput = false 
		return result
    else 
		Citizen.Wait(500) 
		blockinput = false 
		return nil
	end
end

Citizen.CreateThread(function() 
	for k,v in pairs(G_Barber.Action) do
		local blip = AddBlipForCoord(v.x, v.y, v.z) 
					SetBlipSprite(blip, G_Barber.Blip.Sprite) 
					SetBlipDisplay(blip, G_Barber.Blip.Display) 
					SetBlipScale(blip, G_Barber.Blip.Scale) 
					SetBlipColour(blip, G_Barber.Blip.Colour) 
					SetBlipAsShortRange(blip, true) 
					BeginTextCommandSetBlipName('STRING') 
					AddTextComponentSubstringPlayerName(G_Barber.Blip.Label) 
					EndTextCommandSetBlipName(blip) 
	end
end)

Keys.Register('F6', 'barbierjob', 'Ouvrir le menu barber', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'barber' then
    	Menu()
	end
end)
