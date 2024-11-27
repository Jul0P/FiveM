ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

function Coffre()
    local open = false
    local mainMenu = RageUI.CreateMenu("Menu - Coffre", "Auto-École")
    local Coffre = RageUI.CreateSubMenu(mainMenu, "Coffre", "Auto-École")
    local Inventory = RageUI.CreateSubMenu(mainMenu, "Inventaire", "Auto-École")
    mainMenu.Closed = function() open = false end
    if not open then open = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
            while open do
                RageUI.IsVisible(mainMenu, function()
                    RageUI.Button("Retirer", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            GetCoffre()
                        end
                    }, Coffre)
                    RageUI.Button("Déposer", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            GetInventory()
                        end
                    }, Inventory)
                end)
                RageUI.IsVisible(Coffre, function()
                    for _,v in pairs(data_coffre) do
                        RageUI.Button("[~b~"..v.count.."~s~] - "..v.label, nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                local amount = KeyboardInput("Nombre d'item que vous souhaitez retirer", nil, 5)
                                if amount == nil or amount == "" or not tonumber(amount) then
                                    ESX.ShowNotification("Vous devez rentrer une valeur valide")
                                else                       
                                    TriggerServerEvent("G_DrivingSchoolJob:putInventoryItem", v.name, tonumber(amount), ESX.PlayerData.job.name)
                                    GetCoffre()
                                end
                            end
                        })
                    end
                end)
                RageUI.IsVisible(Inventory, function()
                    for _,v in pairs(data_inventory) do
                        RageUI.Button("[~b~"..v.count.."~s~] - "..v.label, nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                local amount = KeyboardInput("Nombre d'item que vous souhaitez déposer", nil, 5)
                                if amount == nil or amount == "" or not tonumber(amount) then
                                    ESX.ShowNotification("Vous devez rentrer une valeur valide")
                                else                       
                                    TriggerServerEvent("G_DrivingSchoolJob:putCoffreItem", v.name, tonumber(amount), ESX.PlayerData.job.name)
                                    GetInventory()
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


function Garage()
    local open = false
    local mainMenu = RageUI.CreateMenu("Garage Auto-École", "Menu")
    mainMenu.Closed = function() open = false end
    if not open then open = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
            while open do
                RageUI.IsVisible(mainMenu, function()
                    RageUI.Button("Ranger votre véhicule", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            local veh, dist2 = ESX.Game.GetClosestVehicle(playerCoords)
                            if dist2 < 4 then
                                DeleteEntity(veh)
                            else 
                                DeleteEntity(returnvehicle)
                            end
                        end
                    })
                    RageUI.Separator("↓ Liste des véhicules ↓")
                    for k,v in pairs(G_DrivingSchool.Garage) do
                        RageUI.Button(v.label, nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                if ESX.Game.IsSpawnPointClear({x = G_DrivingSchool.Coords.SpawnVehicle.x, y = G_DrivingSchool.Coords.SpawnVehicle.y, z = G_DrivingSchool.Coords.SpawnVehicle.z}, 2.0) then
                                    ESX.Game.SpawnVehicle(v.name, {x = G_DrivingSchool.Coords.SpawnVehicle.x, y = G_DrivingSchool.Coords.SpawnVehicle.y, z = G_DrivingSchool.Coords.SpawnVehicle.z}, G_DrivingSchool.Coords.SpawnVehicle.w, function(vehicle) 
                                        SetVehicleNumberPlateText(vehicle, ESX.PlayerData.job.name)
                                        SetVehicleFixed(vehicle)
                                        returnvehicle = vehicle
                                    end)
                                    RageUI.CloseAll()
                                    open = false
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

function Gestion()
    local open = false
    local mainMenu = RageUI.CreateMenu("Gestion Auto-École", "Menu")
    local subMenu = RageUI.CreateSubMenu(mainMenu, "Gestion des salaires", "Menu")
    mainMenu.Closed = function() open = false end
    if not open then open = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
            while open do
                RageUI.IsVisible(mainMenu, function()
                    if SocietyAccount ~= nil then
                        RageUI.Button("Argent de la société :", nil, {RightLabel = "~g~"..SocietyAccount.."$"}, true, {})
                    end
                    RageUI.Button("Retirer de l'argent", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            local amount = KeyboardInput("Combien voulez vous retirer", nil, 10)
                            if amount == nil or amount == "" or not tonumber(amount) then
                                ESX.ShowNotification("Vous devez rentrer une valeur valide")
                            else                       
                                TriggerServerEvent("esx_society:withdrawMoney", ESX.PlayerData.job.name, amount)
                                Wait(100)
                                RefreshMoney()
                            end
                        end
                    })
                    RageUI.Button("Déposer de l'argent", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            local amount = KeyboardInput("Combien voulez vous déposer", nil, 10)
                            if amount == nil or amount == "" or not tonumber(amount) then
                                ESX.ShowNotification("Vous devez rentrer une valeur valide")
                            else                       
                                TriggerServerEvent("esx_society:depositMoney", ESX.PlayerData.job.name, amount)
                                Wait(100)
                                RefreshMoney()
                            end
                        end
                    })
                    RageUI.Button("Gestion des salaires", nil, {RightLabel = "→"}, true , {
                        onSelected = function()
                            RefreshGrade()
                        end
                    }, subMenu)
                    RageUI.Button("Ouvrir le menu patron", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            TriggerEvent("esx_society:openBossMenu", ESX.PlayerData.job.name, function(data, menu)
                                menu.close()
                            end, {wash = false})
                            RageUI.CloseAll()
                            open = false
                        end 
                    })
                end)
                RageUI.IsVisible(subMenu, function()
                    for k,v in pairs(data_grade) do
                        RageUI.Button(v.label, nil, {RightLabel = "~g~"..v.salary.."$ ~s~→"}, true, {
                            onSelected = function()
                                local amount = KeyboardInput("Veuillez saisir le montant d'un nouveau salaire", nil, 8)
                                if amount == nil or amount == "" or not tonumber(amount) then
                                    ESX.ShowNotification("Vous devez rentrer une valeur valide")
                                else                       
                                    TriggerServerEvent("G_DrivingSchoolJob:setSocietySalary", v, amount)
                                    Wait(200)
                                    RefreshGrade()
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

function Vestiaire()
    local open = false
    local mainMenu = RageUI.CreateMenu("Vestiaire Auto-École", "Menu")
    mainMenu.Closed = function() open = false end
    if not open then open = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
            while open do
                RageUI.IsVisible(mainMenu, function()
                    RageUI.Button("Tenue : Civile", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            ESX.TriggerServerCallback("esx_skin:getPlayerSkin", function(skin, jobSkin) 
                                TriggerEvent("skinchanger:loadSkin", skin)
                            end)
                        end
                    })
                    RageUI.Separator("↓ Liste des tenues ↓")
                    for k,v in pairs(G_DrivingSchool.Tenue) do
                        RageUI.Button(v.Label, nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                local model = GetEntityModel(GetPlayerPed(-1))
                                TriggerEvent("skinchanger:getSkin", function(skin)
                                    if model == GetHashKey("mp_m_freemode_01") then
                                        clothesSkin = {
                                            ['tshirt_1'] = v.male.tshirt_1, ['tshirt_2'] = v.male.tshirt_2,
                                            ['torso_1'] = v.male.torso_1, ['torso_2'] = v.male.torso_2,
                                            ['decals_1'] = v.male.decals_1, ['decals_2'] = v.male.decals_2,
                                            ['chain_1'] = v.male.chain_1, ['chain_2'] = v.male.chain_2,
                                            ['arms'] = v.male.arms,
                                            ['pants_1'] = v.male.pants_1, ['pants_2'] = v.male.pants_2,
                                            ['shoes_1'] = v.male.shoes_1, ['shoes_2'] = v.male.shoes_2,
                                            ['helmet_1'] = v.male.helmet_1, ['helmet_2'] = v.male.helmet_2
                                        }
                                    else
                                        clothesSkin = {
                                            ['tshirt_1'] = v.female.tshirt_1, ['tshirt_2'] = v.female.tshirt_2,
                                            ['torso_1'] = v.female.torso_1, ['torso_2'] = v.female.torso_2,
                                            ['decals_1'] = v.female.decals_1, ['decals_2'] = v.female.decals_2,
                                            ['chain_1'] = v.female.chain_1, ['chain_2'] = v.female.chain_2,
                                            ['arms'] = v.female.arms,
                                            ['pants_1'] = v.female.pants_1, ['pants_2'] = v.female.pants_2,
                                            ['shoes_1'] = v.female.shoes_1, ['shoes_2'] = v.female.shoes_2,
                                            ['helmet_1'] = v.female.helmet_1, ['helmet_2'] = v.female.helmet_2
                                        }
                                    end
                                    TriggerEvent("skinchanger:loadClothes", skin, clothesSkin)
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

function Menu()
    local open = false
    local xIndex,xIndex2,xIndex3 = 1,1,1
    local mainMenu = RageUI.CreateMenu("Menu Auto-École", "Menu")
    local subMenu = RageUI.CreateSubMenu(mainMenu, "Gestion des licenses", "Menu")
    local subMenu2 = RageUI.CreateSubMenu(subMenu, "Gestion des licenses", "Menu")
    mainMenu.Closed = function() open = false end
    if not open then open = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
            while open do
                RageUI.IsVisible(mainMenu, function()
                    RageUI.List("Annonce", {"Ouvert", "Fermé", "Personnalisé"}, xIndex, nil, {}, true, {
                        onListChange = function(Index)
                            xIndex = Index
                        end,
                        onSelected = function()
                            if xIndex == 1 then
                                TriggerServerEvent("G_DrivingSchoolJob:Open")
                            elseif xIndex == 2 then
                                TriggerServerEvent("G_DrivingSchoolJob:Close")
                            elseif xIndex == 3 then
                                local msg = KeyboardInput("Message", nil, 100)
                                if msg == nil or msg == "" then
                                    ESX.ShowNotification("Vous devez rentrer une valeur valide")
                                else                       
                                    TriggerServerEvent("G_DrivingSchoolJob:Perso", msg)
                                end
                            end
                        end
                    })
                    RageUI.List("Donner une license", {"Code", "Voiture", "Moto", "Camion", "Avion", "Hélicoptère", "Bateau"}, xIndex2, nil, {}, true, {
                        onListChange = function(Index)
                            xIndex2 = Index
                        end,
                        onSelected = function()
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            if closestPlayer ~= -1 and closestDistance <= 3.0 then
                                if xIndex2 == 1 then
                                    TriggerServerEvent('G_DrivingSchool:addLicense', 'dmv', GetPlayerServerId(closestPlayer))
                                elseif xIndex2 == 2 then 
                                    TriggerServerEvent('G_DrivingSchool:addLicense', 'drive', GetPlayerServerId(closestPlayer))
                                elseif xIndex2 == 3 then
                                    TriggerServerEvent('G_DrivingSchool:addLicense', 'drive_bike', GetPlayerServerId(closestPlayer))
                                elseif xIndex2 == 4 then
                                    TriggerServerEvent('G_DrivingSchool:addLicense', 'drive_truck', GetPlayerServerId(closestPlayer))
                                elseif xIndex2 == 5 then
                                    TriggerServerEvent('G_DrivingSchool:addLicense', 'drive_plane', GetPlayerServerId(closestPlayer))
                                elseif xIndex2 == 6 then
                                    TriggerServerEvent('G_DrivingSchool:addLicense', 'drive_helico', GetPlayerServerId(closestPlayer))
                                elseif xIndex2 == 7 then
                                    TriggerServerEvent('G_DrivingSchool:addLicense', 'drive_boat', GetPlayerServerId(closestPlayer))
                                end
                                Wait(200)
                                getDataLicense()
                                getDataUser()
                            else
                                ESX.ShowNotification("Aucune personne à proximité")
                            end
                        end
                    })
                    RageUI.Button("Gestion des licenses", nil, {RightLabel = "→"}, true, {}, subMenu)
                    RageUI.Button("Facture", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            if closestPlayer == -1 or closestDistance > 3.0 then
                                ESX.ShowNotification("Personne Autour")
                            else
                                local amount = KeyboardInput("Veuillez saisir le montant de la facture", nil, 8)
                                if amount == nil or amount == "" or not tonumber(amount) then
                                    ESX.ShowNotification("Vous devez rentrer une valeur valide")
                                else                       
                                    TriggerServerEvent("esx_billing:sendBill", GetPlayerServerId(closestPlayer), "society_"..ESX.PlayerData.job.name, ESX.PlayerData.job.name, amount)
                                end
                            end
                        end
                    })               
                end)
                RageUI.IsVisible(subMenu, function()
                    for k,v in pairs(data_users) do
                        RageUI.Button(v.firstname.." "..v.lastname, nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                parallel = v.identifier
                            end
                        }, subMenu2)
                    end
                end)
                RageUI.IsVisible(subMenu2, function()
                    for k,v in pairs(data_licenses) do
                        if parallel == v.owner then
                            RageUI.List(v.label, {"Révoquer"}, xIndex3, nil, {}, true, {
                                onListChange = function(Index)
                                    xIndex3 = Index
                                end,
                                onSelected = function()
                                    TriggerServerEvent("G_DrivingSchool:deleteLicense", v)
                                    Wait(200)
                                    getDataLicense()
                                    getDataUser()
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

function Accueil()
    local accueil = false 
    local mainMenu = RageUI.CreateMenu('Accueil', 'Menu')
    local subMenu = RageUI.CreateSubMenu(mainMenu, 'Prise de Rendez-vous', 'Menu')
    mainMenu.Closed = function() accueil = false end
	if not accueil then accueil = true RageUI.Visible(mainMenu, true)
		CreateThread(function()
		    while accueil do 
		        RageUI.IsVisible(mainMenu, function() 
			        RageUI.Button("Prendre un rendez-vous", nil, {RightLabel = "→"}, true, {}, subMenu)
                    RageUI.Button("Appeler un moniteur", nil, {RightLabel = "→"}, true, {
				        onSelected = function()
                            TriggerServerEvent("G_DrivingSchool:appel") 
                            ESX.ShowNotification("Votre appel est bien passé")
				        end
			        })
		        end)
                RageUI.IsVisible(subMenu, function ()
                    RageUI.Button("Nom & Prénom :", nil, {RightLabel = np2}, true, {
                        onSelected = function() 
                            local np = KeyboardInput("Nom & Prénom ", nil, 15)
                            if np == nil then ESX.ShowNotification("Vous devez mettre un nom et un prénom")
                            else np1 = np np2 = "~b~"..np1.."" d1 = true
                            end
                        end
                    })
                    RageUI.Button("Numéro de téléphone :", nil, {RightLabel = tel2}, d1, {
                        onSelected = function() 
                            local tel = KeyboardInput("Numéro de téléphone ", nil, 15)
                            if tel == nil then ESX.ShowNotification("Vous devez mettre un numéro de téléphone")
                            else tel1 = tel tel2 = "~b~"..tel1.."" d2 = true
                            end
                        end
                    })
                    RageUI.Button("Disponibilité :", nil, {RightLabel = dis2}, d2, {
                        onSelected = function() 
                            local dis = KeyboardInput("Disponibilité ", nil, 25)
                            if dis == nil then ESX.ShowNotification("Vous devez mettre vos disponibilités")
                            else dis1 = dis dis2 = "~b~"..dis1.."" d3 = true
                            end
                        end
                    })
                    RageUI.Button("Raison :", nil, {RightLabel = rai2}, d3, {
                        onSelected = function() 
                            local rai = KeyboardInput("Raison ", nil, 100)
                            if rai == nil then ESX.ShowNotification("Vous devez mettre une raison")
                            else rai1 = rai rai2 = "~b~"..rai1.."" d4 = true
                            end
                        end
                    })
                    RageUI.Button("Valider", false, {RightBadge = RageUI.BadgeStyle.Tick, Color = {BackgroundColor = {120,255,0,100}}}, d4, {
                        onSelected = function()
                            np,tel,dis,rai = np1,tel1,dis1,rai1
                            TriggerServerEvent("G_DrivingSchool:appelembed", np, tel, dis, rai) 
                            np2,tel2,dis2,rai2 = "","","",""
                            d1,d2,d3,d4 = false,false,false,false
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

Citizen.CreateThread(function()
    while true do
        local wait = 900
        local coords = GetEntityCoords(GetPlayerPed(-1), false)
        local dist = Vdist(coords.x, coords.y, coords.z, G_DrivingSchool.Coords.Accueil.x, G_DrivingSchool.Coords.Accueil.y, G_DrivingSchool.Coords.Accueil.z)
        if dist <= 2.0 then
            wait = 0
            DrawMarker(G_DrivingSchool.Marker.Type, G_DrivingSchool.Coords.Accueil.x, G_DrivingSchool.Coords.Accueil.y, G_DrivingSchool.Coords.Accueil.z-1, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.5, 0.5, 0.5, G_DrivingSchool.Marker.R, G_DrivingSchool.Marker.V, G_DrivingSchool.Marker.B, 255, false, false, p19, false)    
            if dist <= 1.0 then
                wait = 0
                ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir l'~b~Accueil")
                if IsControlJustPressed(1,51) then
                    Accueil()
                end
            end
        end
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'drivingdealer' then 
            local dist = Vdist(coords.x, coords.y, coords.z, G_DrivingSchool.Coords.Coffre.x, G_DrivingSchool.Coords.Coffre.y, G_DrivingSchool.Coords.Coffre.z)
            if dist <= 2.0 then 
                wait = 0
                DrawMarker(G_DrivingSchool.Marker.Type, G_DrivingSchool.Coords.Coffre.x, G_DrivingSchool.Coords.Coffre.y, G_DrivingSchool.Coords.Coffre.z-1, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.5, 0.5, 0.5, G_DrivingSchool.Marker.R, G_DrivingSchool.Marker.V, G_DrivingSchool.Marker.B, 255, false, false, p19, false)    
                if dist <= 1.0 then 
                    wait = 0 
                    ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir le ~b~Coffre")
                    if IsControlJustPressed(1,51) then 
                        Coffre()
                    end
                end
            end
            local dist = Vdist(coords.x, coords.y, coords.z, G_DrivingSchool.Coords.Garage.x, G_DrivingSchool.Coords.Garage.y, G_DrivingSchool.Coords.Garage.z)
            if dist <= 2.0 then 
                wait = 0
                DrawMarker(G_DrivingSchool.Marker.Type, G_DrivingSchool.Coords.Garage.x, G_DrivingSchool.Coords.Garage.y, G_DrivingSchool.Coords.Garage.z-1, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.5, 0.5, 0.5, G_DrivingSchool.Marker.R, G_DrivingSchool.Marker.V, G_DrivingSchool.Marker.B, 255, false, false, p19, false)     
                if dist <= 1.0 then 
                    wait = 0 
                    ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir le ~b~Garage")
                    if IsControlJustPressed(1,51) then 
                        Garage()
                    end
                end
            end
            if ESX.PlayerData.job.grade_name == "boss" then
                local dist = Vdist(coords.x, coords.y, coords.z, G_DrivingSchool.Coords.Gestion.x, G_DrivingSchool.Coords.Gestion.y, G_DrivingSchool.Coords.Gestion.z)
                if dist <= 2.0 then 
                    wait = 0
                    DrawMarker(G_DrivingSchool.Marker.Type, G_DrivingSchool.Coords.Gestion.x, G_DrivingSchool.Coords.Gestion.y, G_DrivingSchool.Coords.Gestion.z-1, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.5, 0.5, 0.5, G_DrivingSchool.Marker.R, G_DrivingSchool.Marker.V, G_DrivingSchool.Marker.B, 255, false, false, p19, false)     
                    if dist <= 1.0 then 
                        wait = 0 
                        ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir le ~b~Gestion")
                        if IsControlJustPressed(1,51) then 
                            RefreshMoney()
                            Gestion()
                        end
                    end
                end
            end
            local dist = Vdist(coords.x, coords.y, coords.z, G_DrivingSchool.Coords.Vestiaire.x, G_DrivingSchool.Coords.Vestiaire.y, G_DrivingSchool.Coords.Vestiaire.z)
            if dist <= 2.0 then 
                wait = 0
                DrawMarker(G_DrivingSchool.Marker.Type, G_DrivingSchool.Coords.Vestiaire.x, G_DrivingSchool.Coords.Vestiaire.y, G_DrivingSchool.Coords.Vestiaire.z-1, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.5, 0.5, 0.5, G_DrivingSchool.Marker.R, G_DrivingSchool.Marker.V, G_DrivingSchool.Marker.B, 255, false, false, p19, false)     
                if dist <= 1.0 then 
                    wait = 0 
                    ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir le ~b~Vestiaire")
                    if IsControlJustPressed(1,51) then 
                        Vestiaire()
                    end
                end
            end
        end
    Citizen.Wait(wait)
    end
end)

Keys.Register("F6", "drivingdealer", "Ouvrir le menu drivingdealer", function()
    if ESX.PlayerData.job and ESX.PlayerData.job.name == "drivingdealer" then
        getDataLicense()
        getDataUser()
        Menu()
    end
end)