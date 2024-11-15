local casier = false 
local mainMenu = RageUI.CreateMenu('Casier Judiciaire', 'MENU')
local subMenu = RageUI.CreateSubMenu(mainMenu, 'Création d\'un Casier', 'MENU')
mainMenu.Closed = function() casier = false end

function Casier()
	if casier then casier = false RageUI.Visible(mainMenu, false) return else casier = true RageUI.Visible(mainMenu, true)
		CreateThread(function()
		    while casier do 
		        RageUI.IsVisible(mainMenu,function() 
                    RageUI.Button("Créer un Casier Judiciaire", nil, {RightLabel = "→"}, true, {onSelected = function() end}, subMenu)
                    RageUI.Button("Base de donnée - Casier Judiciare", nil, {RightLabel = "→"}, true, {onSelected = function() CasierS() mainMenu2() end})
                    RageUI.Button("Base de donnée - Casier Judiciare Fermé", nil, {RightLabel = "→"}, true, {onSelected = function() CasierF() mainMenu3() end})
		        end)
                RageUI.IsVisible(subMenu,function()
                    RageUI.Button("Nom & Prénom :", nil, {RightLabel = nomprenom2}, true, {
                        onSelected = function() 
                            local nomprenom = KeyboardInput("Nom & Prénom ", nil, 15)
                            if nomprenom == nil then ESX.ShowNotification("Nom & Prénom Invalide")
                            else nomprenom1 = nomprenom nomprenom2 = "~b~"..nomprenom1.."" l1 = true
                            end
                        end
                    })
                    RageUI.Button("Montant :", nil, {RightLabel = montant2}, l1, {
                        onSelected = function() 
                            local montant = KeyboardInput("Montant Total de l'Amende ", nil, 15)
                            if montant == nil then ESX.ShowNotification("Montant Invalide")
                            else montant1 = montant montant2 = "~g~"..montant1.."$" l2 = true
                            end
                        end
                    })
					RageUI.Button("Raison :", nil, {RightLabel = raison2}, l2, {
                        onSelected = function() 
                            local raison = KeyboardInput("Raison / Motif ", nil, 150)
                            if raison == nil then ESX.ShowNotification("Raison Invalide")
                            else raison1 = raison raison2 = "~o~"..raison1.."" l3 = true
                            end
                        end
                    })
                    RageUI.Button("Agent en charge :", nil, {RightLabel = ownerfolder2}, l3, {
                        onSelected = function() 
                            local ownerfolder = KeyboardInput("Agent en charge du Casier Judiciaire ", nil, 30)
                            if ownerfolder == nil then ESX.ShowNotification("Agent Invalide")
                            else ownerfolder1 = ownerfolder ownerfolder2 = "~b~"..ownerfolder1.."" l4 = true
                            end
                        end
                    })
					RageUI.Button("Validé", nil, {RightBadge = RageUI.BadgeStyle.Tick, Color = {BackgroundColor = {120,255,0,100}}}, l4, {
                        onSelected = function() 
							local montant = tonumber(montant1)
							raison,nomprenom,ownerfolder = raison1,nomprenom1,ownerfolder1
                            TriggerServerEvent('G_policejob:InsertCJ', montant, raison, nomprenom, ownerfolder)
                            montant2,raison2,nomprenom2,ownerfolder2 = "","","",""
                            l1,l2,l3,l4 = false,false,false,false
                            RageUI.CloseAll()
                            casier = false 
                        end
                    })
                end)
		    Wait(0)
		    end
	    end)
    end
end

valeur = {}
valeur2 = {}

function mainMenu2()
	local casier2 = false
	local mainMenu2 = RageUI.CreateMenu('Base de donnée - Casier', 'MENU')
	local subMenu2 = RageUI.CreateSubMenu(mainMenu2, 'Base de donnée - Casier', 'MENU')
	mainMenu2.Closed = function() casier2 = false end
	if casier2 then casier2 = false RageUI.Visible(mainMenu2, false) return else casier2 = true RageUI.Visible(mainMenu2, true)
		CreateThread(function()
			while casier2 do 
				RageUI.IsVisible(mainMenu2, function()
					for k,v in pairs(valeur) do
						RageUI.Button("Identité : ~b~"..v.nomprenom.."~s~", nil, {RightLabel = "N°"..v.identifier..""}, true , {
							onSelected = function()
								CasierS()
								valeurprecedent = v.identifier 
							end
						}, subMenu2)
					end
				end)
				RageUI.IsVisible(subMenu2, function()
					for k,v in pairs(valeur) do
						if valeurprecedent == v.identifier then
							RageUI.Button("Nom & Prénom : ~b~"..v.nomprenom.."~s~", nil, {RightLabel = ""}, true , {onSelected = function() end})
							RageUI.Button("Montant : ~g~"..v.montant.."$", nil, {RightLabel = ""}, true , {onSelected = function() end})
							RageUI.Button("Raison : ~o~"..v.raison.."", nil, {RightLabel = ""}, true , {onSelected = function() end})
							RageUI.Button("Agent en charge : ~b~"..v.ownerfolder.."", nil, {RightLabel = ""}, true , {onSelected = function() end})
							if v.status == 'Ouvert' then
								RageUI.Button("Status : ~g~"..v.status.."", nil, {RightLabel = ""}, true , {onSelected = function() end})
							else																								
								RageUI.Button("Status : ~r~"..v.status.."", nil, {RightLabel = ""}, true , {onSelected = function() end})
							end
							RageUI.Button("Modifier le montant total", nil, {RightLabel = "→"}, true , {
								onSelected = function() 
									local mont = KeyboardInput("Modifier le montant de l'amende du casier de ~b~"..v.nomprenom.."~s~ ", nil, 150)
									if mont == nil then 
										ESX.ShowNotification("Valeur Invalide")
									else
										local mont2 = tonumber(mont) 
										TriggerServerEvent('G_policejob:changemontant', v.identifier, mont2)
									end
								end
							})
							RageUI.Button("Modifier le(s) raison(s)", nil, {RightLabel = "→"}, true , {
								onSelected = function() 
									local rais = KeyboardInput("Modifier les raisons du casier de ~b~"..v.nomprenom.."~s~ ", v.raison, 150)
									if rais == nil then 
										ESX.ShowNotification("Valeur Invalide")
									else
										TriggerServerEvent('G_policejob:changeraison', v.identifier, rais)
									end
								end
							})
							RageUI.Button("Fermer le Casier Judiciaire - N°"..v.identifier.."", nil, {RightLabel = "→", Color = {BackgroundColor = {255,70,0,100}}}, true , {
								onSelected = function() 
									TriggerServerEvent('G_policejob:closcasier', v.identifier)
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

function CasierS()
    ESX.TriggerServerCallback('G_policejob:GetCJ', function(data)
		valeur = data
	end)
end

function mainMenu3()
	local casier3 = false
	local mainMenu3 = RageUI.CreateMenu('Base de donnée - Casier Fermé', 'MENU')
	local subMenu3 = RageUI.CreateSubMenu(mainMenu3, 'Base de donnée - Casier Fermé', 'MENU')
	mainMenu3.Closed = function() casier3 = false end
	if casier3 then casier3 = false RageUI.Visible(mainMenu3, false) return else casier3 = true RageUI.Visible(mainMenu3, true)
		CreateThread(function()
			while casier3 do 
				RageUI.IsVisible(mainMenu3, function()
					for k,v in pairs(valeur2) do
						RageUI.Button("Identité : ~b~"..v.nomprenom.."~s~ - ~r~Clos~s~", nil, {RightLabel = "N°"..v.identifier..""}, true , {
							onSelected = function()
								CasierF()
								valeurprecedent = v.identifier 
							end
						}, subMenu3)
					end
				end)
				RageUI.IsVisible(subMenu3, function()
					for k,v in pairs(valeur2) do
						if valeurprecedent == v.identifier then
							RageUI.Button("Nom & Prénom : ~b~"..v.nomprenom.."~s~", nil, {RightLabel = ""}, true , {onSelected = function() end})
							RageUI.Button("Montant : ~g~"..v.montant.."$", nil, {RightLabel = ""}, true , {onSelected = function() end})
							RageUI.Button("Raison : ~o~"..v.raison.."", nil, {RightLabel = ""}, true , {onSelected = function() end})
							RageUI.Button("Agent en charge : ~b~"..v.ownerfolder.."", nil, {RightLabel = ""}, true , {onSelected = function() end})
							if v.status == 'Ouvert' then
								RageUI.Button("Status : ~g~"..v.status.."", nil, {RightLabel = ""}, true , {onSelected = function() end})
							else																								
								RageUI.Button("Status : ~r~"..v.status.."", nil, {RightLabel = ""}, true , {onSelected = function() end})
							end
							RageUI.Button("Ré-Ouvrir le Casier Judiciaire - N°"..v.identifier.."", nil, {RightLabel = "→", Color = {BackgroundColor = {120,255,0,100}}}, true , {
								onSelected = function() 
									TriggerServerEvent('G_policejob:opencasier', v.identifier)
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

function CasierF()
    ESX.TriggerServerCallback('G_policejob:GetCJF', function(data2)
		valeur2 = data2
	end)
end

local pos = {{x = 451.99, y = -998.85, z = 30.68}}

Citizen.CreateThread(function()
    while true do
        local wait = 900
        for k in pairs(pos) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then 
                local coords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(coords.x, coords.y, coords.z, pos[k].x, pos[k].y, pos[k].z)
                if dist <= 2.0 then wait = 0
                    DrawMarker(6, 451.99, -998.85, 29.7, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 66, 255, 255, false, false, p19, false) 
                    if dist <= 1.0 then wait = 0 ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir le(s) ~b~Casier Judiciaire")
                        if IsControlJustPressed(1,51) then Casier()
                        end
                    end
                end
            end
        Citizen.Wait(wait)
        end
    end
end)