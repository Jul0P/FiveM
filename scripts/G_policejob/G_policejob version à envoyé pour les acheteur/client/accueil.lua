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

local accueil = false 
local mainMenu = RageUI.CreateMenu('Accueil', 'MENU')
local subMenu = RageUI.CreateSubMenu(mainMenu, 'Prise de Rendez-vous', 'MENU')
local subMenu2 = RageUI.CreateSubMenu(mainMenu, 'Dépôt de plainte', 'MENU')
mainMenu.Closed = function() accueil = false end

function Accueil()
	if accueil then accueil = false RageUI.Visible(mainMenu, false) return else accueil = true RageUI.Visible(mainMenu, true)
		CreateThread(function()
		    while accueil do 
		        RageUI.IsVisible(mainMenu, function() 
			        RageUI.Button("Prendre un rendez-vous", nil, {RightLabel = "→"}, true, {onSelected = function() end}, subMenu)
			        RageUI.Button("Déposer une plainte", nil, {RightLabel = "→"}, true, {onSelected = function() end}, subMenu2)
                    RageUI.Button("Appeler un agent", nil, {RightLabel = "→"}, true, {
				        onSelected = function()
                            TriggerServerEvent("police:appel") 
                            ESX.ShowNotification("Votre appel est bien passé")
				        end
			        })
		        end)
                RageUI.IsVisible(subMenu, function ()
                    RageUI.Button("Nom :", nil, {RightLabel = nom2}, true, {
                        onSelected = function() 
                            local nom = KeyboardInput("Nom ", nil, 15)
                            if nom == nil then ESX.ShowNotification("Vous devez mettre un nom")
                            else nom1 = nom nom2 = "~b~"..nom1.."" d1 = true
                            end
                        end
                    })
                    RageUI.Button("Prénom :", nil, {RightLabel = prenom2}, d1, {
                        onSelected = function() 
                            local prenom = KeyboardInput("Prénom ", nil, 15)
                            if prenom == nil then ESX.ShowNotification("Vous devez mettre un prénom")
                            else prenom1 = prenom prenom2 = "~b~"..prenom1.."" d2 = true
                            end
                        end
                    })
                    RageUI.Button("Numéro de téléphone :", nil, {RightLabel = tel2}, d2, {
                        onSelected = function() 
                            local tel = KeyboardInput("Numéro de téléphone ", nil, 15)
                            if tel == nil then ESX.ShowNotification("Vous devez mettre un numéro de téléphone")
                            else tel1 = tel tel2 = "~b~"..tel1.."" d3 = true
                            end
                        end
                    })
                    RageUI.Button("Disponibilité :", nil, {RightLabel = dis2}, d3, {
                        onSelected = function() 
                            local dis = KeyboardInput("Disponibilité ", nil, 25)
                            if dis == nil then ESX.ShowNotification("Vous devez mettre vos disponibilités")
                            else dis1 = dis dis2 = "~b~"..dis1.."" d4 = true
                            end
                        end
                    })
                    RageUI.Button("Raison :", nil, {RightLabel = rai2}, d4, {
                        onSelected = function() 
                            local rai = KeyboardInput("Raison ", nil, 100)
                            if rai == nil then ESX.ShowNotification("Vous devez mettre une raison")
                            else rai1 = rai rai2 = "~b~"..rai1.."" d5 = true
                            end
                        end
                    })
                    RageUI.Button("Valider", false, {RightBadge = RageUI.BadgeStyle.Tick}, d5, {
                        onSelected = function()
                            nom,prenom,tel,dis,rai = nom1,prenom1,tel1,dis1,rai1
                            TriggerServerEvent("police:appelembed", nom, prenom, tel, dis, rai) 
                            nom2,prenom2,tel2,dis2,rai2 = "","","","",""
                            d1,d2,d3,d4,d5 = false,false,false,false,false
                            RageUI.CloseAll()
                            accueil = false 
                        end
                    })
                end)
                RageUI.IsVisible(subMenu2, function ()
                    RageUI.Button("Nom & Prénom :", nil, {RightLabel = np2}, true, {
                        onSelected = function() 
                            local np = KeyboardInput("Nom & Prénom ", nil, 25)
                            if np == nil then ESX.ShowNotification("Vous devez mettre un nom & prénom")
                            else np1 = np np2 = "~b~"..np1.."" p1 = true
                            end
                        end
                    })
                    RageUI.Button("Numéro de Téléphone :", nil, {RightLabel = ptel2}, p1, {
                        onSelected = function() 
                            local ptel = KeyboardInput("Numéro de Téléphone ", nil, 15)
                            if ptel == nil then ESX.ShowNotification("Vous devez mettre un numéro de téléphone")
                            else ptel1 = ptel ptel2 = "~b~"..ptel1.."" p2 = true
                            end
                        end
                    })
                    RageUI.Button("Motif :", nil, {RightLabel = motif2}, p2, {
                        onSelected = function() 
                            local motif = KeyboardInput("Motif ", nil, 100)
                            if motif == nil then ESX.ShowNotification("Vous devez mettre un motif")
                            else motif1 = motif motif2 = "~b~"..motif1.."" p3 = true
                            end
                        end
                    })
                    RageUI.Button("Valider", false, {RightBadge = RageUI.BadgeStyle.Tick}, p3, {
                        onSelected = function()
                            np,ptel,motif = np1,ptel1,motif1
                            TriggerServerEvent("police:plainte", np, ptel, motif)
                            np2,ptel2,motif2 = "","",""
                            p1,p2,p3 = false,false,false
                            RageUI.CloseAll()
                            accueil = false 
                        end
                    })
                end)
		    Wait(0)
		    end
	    end)
    end
end

local pos = {{x = 441.25, y = -981.93, z = 30.69}}

Citizen.CreateThread(function()
    while true do
        local wait = 900
        for k in pairs(pos) do
            local coords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(coords.x, coords.y, coords.z, pos[k].x, pos[k].y, pos[k].z)
            if dist <= 2.0 then wait = 0
                DrawMarker(6, 441.25, -981.93, 29.7, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 66, 255, 255, false, false, p19, false) 
                if dist <= 1.0 then wait = 0 ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir l'~b~Accueil")
                    if IsControlJustPressed(1,51) then Accueil()
                    end
                end
            end
        Citizen.Wait(wait)
        end
    end
end)