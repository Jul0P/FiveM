Citizen.CreateThread(function()
	while ESX == nil do TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) Citizen.Wait(10) end
    while ESX.GetPlayerData().job == nil do Citizen.Wait(10) end
    if ESX.IsPlayerLoaded() then ESX.PlayerData = ESX.GetPlayerData() end
end)

RegisterNetEvent('esx:playerLoaded') AddEventHandler('esx:playerLoaded', function(xPlayer) ESX.PlayerData = xPlayer end)
RegisterNetEvent('esx:setjob') AddEventHandler('esx:setjob', function(job) ESX.PlayerData.job = job end)

local PlayerData, dragStatus, handcuffTimer, DragStatus, currentTask = {}, {}, {}, {}, {}
local IsHandcuffed,policeDog = false,false

object = {}
function loadDict(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
end

local menu = false
local mainMenu = RageUI.CreateMenu("Los Santos Police Dept.", "MENU")
local subMenu = RageUI.CreateSubMenu(mainMenu,'Intéraction citoyen', 'MENU')
local subMenu2 = RageUI.CreateSubMenu(mainMenu,'Intéraction véhicule', 'MENU') 
local subMenu3 = RageUI.CreateSubMenu(mainMenu,'Appels Police', 'MENU') 
local subMenu4 = RageUI.CreateSubMenu(mainMenu,'Demande de renfort', 'MENU')  
local subMenu5 = RageUI.CreateSubMenu(mainMenu,'Menu Objets', 'MENU')
local subMenu6 = RageUI.CreateSubMenu(mainMenu,'Menu Chien', 'MENU')   
mainMenu.Closed = function() menu = false end 

function OpenMenu()
    if menu then menu = false RageUI.Visible(mainMenu, false) return else menu = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
            while menu do 
                RageUI.IsVisible(mainMenu,function()
                    RageUI.Checkbox("Prendre/Quitter son service", nil, service, {}, {
                        onChecked = function(index, items) service = true ESX.ShowNotification("~g~Vous avez pris votre service") end,
                        onUnChecked = function(index, items) service = false ESX.ShowNotification("~r~Vous avez quitté votre service") end
                    })
                    if service then
                        RageUI.Button("Intéraction citoyen", nil, {RightLabel = "→"}, true, {onSelected = function() end}, subMenu)
                        RageUI.Button("Intéraction véhicule", nil, {RightLabel = "→"}, true, {onSelected = function() end}, subMenu2)
                        RageUI.Button("Appels Police", nil, {RightLabel = "→"}, true, {onSelected = function() end}, subMenu3)
                        RageUI.Button("Demande de renfort", nil, {RightLabel = "→"}, true, {onSelected = function() end}, subMenu4)
                        RageUI.Button("Menu Objets", nil, {RightLabel = "→"}, true, {onSelected = function() end}, subMenu5)
                        RageUI.Button("Menu Chien", nil, {RightLabel = "→"}, true, {onSelected = function() end}, subMenu6)
                        RageUI.Button("Poser/Enlever un Radar", nil, {RightLabel = "→"}, true, {onSelected = function() radar() radar2() end})
                        RageUI.Button("Sortir/Ranger le Bouclier", nil, {RightLabel = "→"}, true, {
                            onSelected = function()  
                                if not bouclier then bouclier = true EnableShield() elseif bouclier then bouclier = false DisableShield() end
                            end
                        })
                        RageUI.Button("Donner une amende", nil, {RightLabel = "→"}, true, {onSelected = function() RageUI.CloseAll() OpenBillingMenu() RageUI.CloseAll() menu = false end})
                    end
                end)
                RageUI.IsVisible(subMenu,function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    RageUI.Button("Prendre les papiers", nil, {RightLabel = "→"}, true, { 
                        onSelected = function()
                            if closestDistance <= 1.5 then TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(closestPlayer), GetPlayerServerId(PlayerId())) RageUI.CloseAll() menu = false
                            else ESX.ShowNotification('Aucune personne proche')
                            end
                        end 
                    })
                    RageUI.Button("Fouiller", nil, {RightLabel = "→"}, true, { 
                        onSelected = function() 
                            if closestDistance <= 1.5 then  getPlayerInv(closestPlayer) menufouille() ExecuteCommand("me fouille l'individu")
                            else ESX.ShowNotification('Aucune personne proche')
                            end
                        end 
                    })
                    RageUI.Button("Escorter", nil, {RightLabel = "→"}, true, { 
                        onSelected = function()
                            if closestDistance <= 1.5 then TriggerServerEvent('G_policejob:drag', GetPlayerServerId(closestPlayer))
                            else ESX.ShowNotification('Aucune personne proche')
                            end
                        end 
                    })
                    RageUI.Button("Menotter/Démenotter", nil, {RightLabel = "→"}, true, { 
                        onSelected = function() 
                            if closestDistance <= 1.5 then TriggerServerEvent('G_policejob:handcuff', GetPlayerServerId(closestPlayer))
                            else ESX.ShowNotification('Aucune personne proche')
                            end
                        end 
                    })
                    RageUI.Button("Mettre dans le véhicule", nil, {RightLabel = "→"}, true, { 
                        onSelected = function() 
                            if closestDistance <= 2.5 then TriggerServerEvent('G_policejob:putInVehicle', GetPlayerServerId(closestPlayer))
                            else ESX.ShowNotification('Aucune personne proche')
                            end
                        end 
                    })
                    RageUI.Button("Sortir du véhicule", nil, {RightLabel = "→"}, true, { 
                        onSelected = function() 
                            if closestDistance <= 3.5 then TriggerServerEvent('G_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
                            else ESX.ShowNotification('Aucune personne proche')
                            end
                        end 
                    })
                end)
                RageUI.IsVisible(subMenu2,function()
                    RageUI.Button("Information véhicule", nil, {RightLabel = "→"}, true, { 
                        onSelected = function() 
                            local numplaque = KeyboardInput("Numéro de la plaque ", nil, 10)
                            if numplaque == nil then ESX.ShowNotification("Vous devez mettre une plaque valide")
                            else InfoVehicle(numplaque) RageUI.CloseAll() menu = false
                            end
                        end 
                    })
                    RageUI.Button("Véhicule en fourrière", nil, {RightLabel = "→"}, true, { 
                        onSelected = function() 
                            local playerPed = PlayerPedId()
						    if IsPedSittingInAnyVehicle(playerPed) then
							    local vehicle = GetVehiclePedIsIn(playerPed, false)			
							    if GetPedInVehicleSeat(vehicle, -1) == playerPed then ESX.ShowNotification('Voiture placée en fourrière') ESX.Game.DeleteVehicle(vehicle)							   
                                else ESX.ShowNotification('Il faut être à la place conducteur ou dehors')
							    end
						    else
							    local vehicle = ESX.Game.GetVehicleInDirection()
							    if DoesEntityExist(vehicle) then ESX.ShowNotification('Voiture placée en fourrière') ESX.Game.DeleteVehicle(vehicle)                                    
                                else ESX.ShowNotification('Aucune voiture')
							    end
						    end
                        end 
                    })
                end)
                RageUI.IsVisible(subMenu3,function()
                    RageUI.Button("Prise de service", nil, {RightLabel = "→"}, true, { 
                        onSelected = function() 
                            local info = "prise" 
                            TriggerServerEvent('G_policejob:PriseEtFinservice', info)
                        end 
                    })
                    RageUI.Button("Fin de service", nil, {RightLabel = "→"}, true, { 
                        onSelected = function() 
                            local info = "fin" 
                            TriggerServerEvent('G_policejob:PriseEtFinservice', info)
                        end 
                    })
                    RageUI.Button("Pause de service", nil, {RightLabel = "→"}, true, { 
                        onSelected = function() 
                            local info = "pause" 
                            TriggerServerEvent('G_policejob:PriseEtFinservice', info)
                        end 
                    })
                    RageUI.Button("Standby", nil, {RightLabel = "→"}, true, { 
                        onSelected = function() 
                            local info = "standby" 
                            TriggerServerEvent('G_policejob:PriseEtFinservice', info)
                        end 
                    })
                    RageUI.Button("Retour Commissariat", nil, {RightLabel = "→"}, true, { 
                        onSelected = function() 
                            local info = 'rdv' 
                            TriggerServerEvent('G_policejob:PriseEtFinservice', info)
                        end 
                    })
                end)
                RageUI.IsVisible(subMenu4,function()
                    RageUI.Button("Petite demande", nil, {RightLabel = "→"}, true, { 
                        onSelected = function() 
                            local raison = 'petite'
                            local elements  = {}
                            local playerPed = PlayerPedId()
                            local coords  = GetEntityCoords(playerPed)
                            local name = GetPlayerName(PlayerId())
                            TriggerServerEvent('renfort', coords, raison)
                        end 
                    })
                    RageUI.Button("Moyenne demande", nil, {RightLabel = "→"}, true, { 
                        onSelected = function() 
                            local raison = 'moyenne' local elements  = {} local playerPed = PlayerPedId() local coords  = GetEntityCoords(playerPed) local name = GetPlayerName(PlayerId())
                            TriggerServerEvent('renfort', coords, raison)
                        end 
                    })
                    RageUI.Button("Grosse demande", nil, {RightLabel = "→"}, true, { 
                        onSelected = function() 
                            local raison = 'grosse' local elements  = {} local playerPed = PlayerPedId() local coords  = GetEntityCoords(playerPed) local name = GetPlayerName(PlayerId())
                            TriggerServerEvent('renfort', coords, raison)
                        end 
                    })
                end)
                RageUI.IsVisible(subMenu5,function()
                    RageUI.Button("Sac", "Appuyez sur [~b~E~s~] pour placer l'~b~Objet", {RightLabel = "→"}, true, { 
                        onSelected = function() 
                            SpawnObj("prop_big_bag_01")
                        end 
                    })
                    RageUI.Button("Plot", "Appuyez sur [~b~E~s~] pour placer l'~b~Objet", {RightLabel = "→"}, true, { 
                        onSelected = function() 
                            SpawnObj("prop_roadcone02a")
                        end 
                    })
                    RageUI.Button("Barrière", "Appuyez sur [~b~E~s~] pour placer l'~b~Objet", {RightLabel = "→"}, true, { 
                        onSelected = function() 
                            SpawnObj("prop_barrier_work05")
                        end 
                    })
                    RageUI.Button("Herse", "Appuyez sur [~b~E~s~] pour placer l'~b~Objet", {RightLabel = "→"}, true, { 
                        onSelected = function() 
                            SpawnObj("p_ld_stinger_s")
                        end 
                    })
                    RageUI.Button("Caisse", "Appuyez sur [~b~E~s~] pour placer l'~b~Objet", {RightLabel = "→"}, true, { 
                        onSelected = function() 
                            SpawnObj("prop_boxpile_07d")
                        end 
                    })
                    RageUI.Button("Suppression", false, {RightBadge = RageUI.BadgeStyle.Alert}, true, { 
                        onSelected = function() 
                            menuobjet()
                        end 
                    })
                end)
                RageUI.IsVisible(subMenu6,function()
                    RageUI.Button("Sortir/Ranger le chien", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            if not DoesEntityExist(policeDog) then
                                RequestModel(351016938)
                                while not HasModelLoaded(351016938) do Wait(0) end
                                policeDog = CreatePed(4, 351016938, GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, -0.98), 0.0, true, false)
                                SetEntityAsMissionEntity(policeDog, true, true)
                            else
                                DeleteEntity(policeDog)
                            end
                        end
                    })
                    RageUI.Button("Demander au chien de vous suivre", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            local playerPed = PlayerPedId()
                            if DoesEntityExist(policeDog) then
                                if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(policeDog), true) <= 5.0 then
                                    TaskGoToEntity(policeDog, playerPed, -1, 1.0, 10.0, 1073741824, 1)
                                else
                                    ESX.ShowNotification('Le chien n\'est pas à côté de vous')
                                end
                            else
                                ESX.ShowNotification('Il n\'y a pas de chien')
					        end
                        end
                    })
                    RageUI.Button("Monter/Sotir d'un Véhicule", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            if DoesEntityExist(policeDog) then
                                if not IsPedInAnyVehicle(policeDog, false) then
                                    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(policeDog)) <= 10.0 then
                                        local vehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 7.5, 0, 70)
                                        if DoesEntityExist(vehicle) then
                                            for i = 0, GetVehicleMaxNumberOfPassengers(vehicle) do
                                                if IsVehicleSeatFree(vehicle, i) then
                                                    TaskEnterVehicle(policeDog, vehicle, 15.0, i, 1.0, 1, 0)
                                                    break
                                                end
                                            end
                                        else
                                            ESX.ShowNotification('Il n\'y a pas de véhicule')
                                        end
                                    else
                                        ESX.ShowNotification('Le chien n\'est pas à côté de vous')
                                    end
                                else
                                    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(policeDog)) <= 5.0 then
                                        TaskLeaveVehicle(policeDog, GetVehiclePedIsIn(policeDog, false), 0)
                                    else
                                        ESX.ShowNotification('Le chien n\'est pas à côté de vous')
                                    end
                                end
                            else
                                ESX.ShowNotification('Il n\'y a pas de chien')
                            end
                        end
                    })
                    RageUI.Button("Assoir le chien", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            if DoesEntityExist(policeDog) then
                                if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(policeDog), true) <= 5.0 then
                                    if IsEntityPlayingAnim(policeDog, "creatures@rottweiler@amb@world_dog_sitting@base", "base", 3) then
                                        ClearPedTasks(policeDog)
                                    else
                                        loadDict('rcmnigel1c')
                                        TaskPlayAnim(PlayerPedId(), 'rcmnigel1c', 'hailing_whistle_waive_a', 8.0, -8, -1, 120, 0, false, false, false)
                                        Wait(2000)
                                        loadDict("creatures@rottweiler@amb@world_dog_sitting@base")
                                        TaskPlayAnim(policeDog, "creatures@rottweiler@amb@world_dog_sitting@base", "base", 8.0, -8, -1, 1, 0, false, false, false)
                                    end
                                else
                                    ESX.ShowNotification('Le chien n\'est pas à côté de vous')
                                end
                            else
                                ESX.ShowNotification('Il n\'y a pas de chien')
                            end
                        end
                    })
                    RageUI.Button("Dire au chien d'attaquer", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            if DoesEntityExist(policeDog) then
                                if not IsPedDeadOrDying(policeDog) then
                                    if GetDistanceBetweenCoords(GetEntityCoords(policeDog), GetEntityCoords(PlayerPedId()), true) <= 3.0 then
                                        local player, distance = ESX.Game.GetClosestPlayer()
                                        if distance ~= -1 then
                                            if distance <= 3.0 then
                                                local playerPed = GetPlayerPed(player)
                                                if not IsPedInCombat(policeDog, playerPed) then
                                                    if not IsPedInAnyVehicle(playerPed, true) then
                                                        TaskCombatPed(policeDog, playerPed, 0, 16)
                                                    end
                                                else
                                                    ClearPedTasksImmediately(policeDog)
                                                end
                                            end
                                        end
                                    end
                                else
                                    ESX.ShowNotification('Le chien n\'est pas à côté de vous')
                                end
                            else
                                ESX.ShowNotification('Il n\'y a pas de chien')
                            end
                        end
                    })
                    RageUI.Button("Lui faire chercher de la drogue", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            if DoesEntityExist(policeDog) then
                                if not IsPedDeadOrDying(policeDog) then
                                    if GetDistanceBetweenCoords(GetEntityCoords(policeDog), GetEntityCoords(PlayerPedId()), true) <= 3.0 then
                                        local player, distance = ESX.Game.GetClosestPlayer()
                                        if distance ~= -1 then
                                            if distance <= 3.0 then
                                                local playerPed = GetPlayerPed(player)
                                                if not IsPedInAnyVehicle(playerPed, true) then
                                                    TriggerServerEvent('esx_policedog:hasClosestDrugs', GetPlayerServerId(player))
                                                end
                                            end
                                        end
                                    end
                                else
                                    ESX.ShowNotification('Le chien n\'est pas à côté de vous')
                                end
                            else
                                ESX.ShowNotification('Il n\'y a pas de chien')
                            end
                        end
                    })
                end)
            Wait(0)
            end
        end)
    end
end

function menuobjet()
    local menuobjet = false
    local mainMenu2 = RageUI.CreateMenu("Suppression Objet", "MENU") 
    mainMenu2.Closed = function() menuobjet = false menu = false end
    if menuobjet then menuobjet = false RageUI.Visible(mainMenu2, false) return else menuobjet = true RageUI.Visible(mainMenu2, true)
        CreateThread(function()
            while menuobjet do 
                RageUI.IsVisible(mainMenu2, function()
                    for k,v in pairs(object) do
                        if GoodName(GetEntityModel(NetworkGetEntityFromNetworkId(v))) == 0 then table.remove(object, k) end
                        RageUI.Button("Object: "..GoodName(GetEntityModel(NetworkGetEntityFromNetworkId(v))).." ["..v.."]", nil, {}, true, {
                            onActive = function()
                                local entity = NetworkGetEntityFromNetworkId(v) local ObjCoords = GetEntityCoords(entity)
                                DrawMarker(20, ObjCoords.x, ObjCoords.y, ObjCoords.z+1.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, 0.2, 0.2, 0.2, 0, 0, 200, 170, 1, 0, 2, 1, nil, nil, 0)
                            end,
                            onSelected = function() 
                                RemoveObj(v, k)
                            end
                        })
                    end
                end)
            Wait(0)
            end
        end)
    end
end

function SpawnObj(obj)
    local playerPed = PlayerPedId()
	local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
    local objectCoords = (coords + forward * 1.0)
    local Ent = nil
    SpawnObject(obj, objectCoords, function(obj)
        SetEntityCoords(obj, objectCoords, 0.0, 0.0, 0.0, 0)
        SetEntityHeading(obj, GetEntityHeading(playerPed))
        PlaceObjectOnGroundProperly(obj)
        Ent = obj
        Wait(1)
    end)
    Wait(1)
    while Ent == nil do Wait(1) end
    SetEntityHeading(Ent, GetEntityHeading(playerPed))
    PlaceObjectOnGroundProperly(Ent)
    local placed = false
    while not placed do
        Citizen.Wait(1)
        local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
        local objectCoords = (coords + forward * 2.0)
        SetEntityCoords(Ent, objectCoords, 0.0, 0.0, 0.0, 0)
        SetEntityHeading(Ent, GetEntityHeading(playerPed))
        PlaceObjectOnGroundProperly(Ent)
        SetEntityAlpha(Ent, 170, 170)
        if IsControlJustReleased(1, 38) then
            placed = true
        end
    end
    FreezeEntityPosition(Ent, true)
    SetEntityInvincible(Ent, true)
    ResetEntityAlpha(Ent)
    local NetId = NetworkGetNetworkIdFromEntity(Ent)
    table.insert(object, NetId)
end

function SpawnObject(model, coords, cb)
	local model = GetHashKey(model)
	Citizen.CreateThread(function()
		RequestModels(model)
        Wait(1)
		local obj = CreateObject(model, coords.x, coords.y, coords.z, true, false, true)
		if cb then
			cb(obj)
		end
	end)
end

function RequestModels(modelHash)
	if not HasModelLoaded(modelHash) and IsModelInCdimage(modelHash) then RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do Citizen.Wait(1)
		end
	end
end

function RemoveObj(id, k)
    Citizen.CreateThread(function()
        SetNetworkIdCanMigrate(id, true)
        local entity = NetworkGetEntityFromNetworkId(id)
        NetworkRequestControlOfEntity(entity)
        local test = 0
        while test > 100 and not NetworkHasControlOfEntity(entity) do NetworkRequestControlOfEntity(entity) Wait(1) test = test + 1
        end
        SetEntityAsNoLongerNeeded(entity)
        local test = 0
        while test < 100 and DoesEntityExist(entity) do  SetEntityAsNoLongerNeeded(entity) TriggerServerEvent("DeleteEntity", NetworkGetNetworkIdFromEntity(entity)) DeleteEntity(entity) DeleteObject(entity)
            if not DoesEntityExist(entity) then  table.remove(object, k) end
            SetEntityCoords(entity, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0)
            Wait(1)
            test = test + 1
        end
    end)
end

function GoodName(hash)
    if hash == GetHashKey("prop_roadcone02a") then return "Plot"
    elseif hash == GetHashKey("prop_barrier_work05") then return "Barrière"
    elseif hash == GetHashKey("prop_big_bag_01") then return "Sac"
    elseif hash == GetHashKey("prop_boxpile_07d") then return "Caisse"
    elseif hash == GetHashKey("p_ld_stinger_s") then return "Herse"
    else return hash
    end
end

local Items = {}
local Armes = {}
local ArgentSale = {}

function getPlayerInv(player)
    Items = {}
    Armes = {}
    ArgentSale = {}
    ESX.TriggerServerCallback('G_policejob:getOtherPlayerData', function(data)
        for i=1, #data.inventory, 1 do
            if data.inventory[i].count > 0 then
                table.insert(Items, {label = data.inventory[i].label, value = data.inventory[i].name, itemType = 'item_standard', amount = data.inventory[i].count})
            end
        end
        for i=1, #data.weapons, 1 do
			table.insert(Armes, {label = ESX.GetWeaponLabel(data.weapons[i].name), value = data.weapons[i].name, itemType = 'item_weapon', amount = data.weapons[i].ammo})
		end
        for i=1, #data.accounts, 1 do
            if data.accounts[i].name == 'black_money' and data.accounts[i].money > 0 then
                table.insert(ArgentSale, {label = ESX.Math.Round(data.accounts[i].money), value = 'black_money', itemType = 'item_account', amount = data.accounts[i].money})
                break
            end
        end
    end, GetPlayerServerId(player))
end

function menufouille()
    local menufouille = false
    local mainMenu4 = RageUI.CreateMenu("Menu Fouille", "MENU")
    mainMenu4.Closed = function() menufouille = false menu = false mainMenu4 = RMenu:DeleteType("Menu Fouille", true) end
    if menufouille then menufouille = false RageUI.Visible(mainMenu4, false) return else menufouille = true RageUI.Visible(mainMenu4, true)
        CreateThread(function()
            while mainMenu4 do
			    RageUI.IsVisible(mainMenu4,function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    RageUI.Separator("↓ Argent - Non Déclaré ↓")
				    for k,v in pairs(ArgentSale) do
					    RageUI.Button(""..v.label.."$", nil, {RightLabel = "→"}, true , {
						    onSelected = function()
							    local argentsale = KeyboardInput("Montant d'argent sale à prendre ", "", 7)
                                if tonumber(argentsale) == nil or tonumber(argentsale) > v.amount then ESX.ShowNotification("Montant Invalide")				    			
                                else TriggerServerEvent('G_policejob:confiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(argentsale))
				    			end
				    		end
				    	})
				    end
                    RageUI.Separator("↓ Armes ↓")
				    for k,v in pairs(Armes) do
					    RageUI.Button("[x"..v.amount.."] - "..v.label.."", nil, {RightLabel = "→"}, true , {
					    	onSelected = function()
                                arme = v.amount
				    			TriggerServerEvent('G_policejob:confiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, arme)
				    		end
					    })
				    end
                    RageUI.Separator("↓ Item ↓")
				    for k,v in pairs(Items) do
					    RageUI.Button("[x"..v.amount.."] - "..v.label.."", nil, {RightLabel = "→"}, true , {
					    	onSelected = function()
							local item = KeyboardInput("Nombre d'item à prendre ", "", 7)
                            if tonumber(item) == nil or tonumber(item) > v.amount then
                                ESX.ShowNotification("Montant Invalide")				    			
                            else
				    			TriggerServerEvent('G_policejob:confiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(item))
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

local shieldEntity = nil
local animDict = "combat@gestures@gang@pistol_1h@beckon"
local animName = "0"
local prop = "prop_ballistic_shield"

function EnableShield()
    local ped = GetPlayerPed(-1)
    local pedPos = GetEntityCoords(ped, false)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(200)
    end
    TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, (2 + 16 + 32), 0.0, 0, 0, 0)
    RequestModel(GetHashKey(prop))
    while not HasModelLoaded(GetHashKey(prop)) do
        Citizen.Wait(200)
    end
    local shield = CreateObject(GetHashKey(prop), pedPos.x, pedPos.y, pedPos.z, 1, 1, 1)
    shieldEntity = shield
    AttachEntityToEntity(shieldEntity, ped, GetEntityBoneIndexByName(ped, "IK_L_Hand"), 0.0, -0.05, -0.10, -30.0, 180.0, 40.0, 0, 0, 1, 0, 0, 1)
    SetWeaponAnimationOverride(ped, GetHashKey("Gang1H"))
    SetEnableHandcuffs(ped, true)
end

function DisableShield()
    local ped = GetPlayerPed(-1)
    DeleteEntity(shieldEntity)
    ClearPedTasksImmediately(ped)
    SetWeaponAnimationOverride(ped, GetHashKey("Default"))
    SetEnableHandcuffs(ped, false)
end

function OpenIdentityCardMenu(player)
	ESX.TriggerServerCallback('G_policejob:getOtherPlayerData', function(data)
		local elements = {
			{label = 'name', data.name}
		}
		if Config.EnableESXIdentity then
			table.insert(elements, {label = 'sex', data.sex})
			table.insert(elements, {label = 'dob', data.dob})
			table.insert(elements, {label = 'height', data.height})
		end
		if data.drunk then
			table.insert(elements, {label = 'bac', data.drunk})
		end
		if data.licenses then
			table.insert(elements, {label = 'license_label'})

			for i=1, #data.licenses, 1 do
				table.insert(elements, {label = data.licenses[i].label})
			end
		end
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
			title    = 'citizen_interaction',
			align    = 'top-left',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

local IsDragged = false
local Ped = nil

RegisterNetEvent("G_policejob:drag")
AddEventHandler("G_policejob:drag", function(player)
    IsDragged = not IsDragged Ped = tonumber(player)
    if IsDragged then escorter()
    end
end)

function escorter()
    Citizen.CreateThread(function()
        local pPed = GetPlayerPed(-1)
	    while IsDragged do Wait(1) pPed = GetPlayerPed(-1) 
            local targetPed = GetPlayerPed(GetPlayerFromServerId(Ped))
	    	if not IsPedSittingInAnyVehicle(targetPed) then AttachEntityToEntity(pPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
            else IsDragged = false DetachEntity(pPed, true, false) end
	    	if IsPedDeadOrDying(targetPed, true) then IsDragged = false DetachEntity(pPed, true, false) end
        end
        DetachEntity(pPed, true, false)
    end)
end

RegisterNetEvent('G_policejob:handcuff')
AddEventHandler('G_policejob:handcuff', function()
    IsHandcuffed = not IsHandcuffed;
    local playerPed = GetPlayerPed(-1)
    Citizen.CreateThread(function()
        if IsHandcuffed then RequestAnimDict('mp_arresting')
            while not HasAnimDictLoaded('mp_arresting') do Citizen.Wait(100)
            end
            TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
            DisableControlAction(2, 37, true)
            SetEnableHandcuffs(playerPed, true)
            SetPedCanPlayGestureAnims(playerPed, false)
            FreezeEntityPosition(playerPed,  true)
            DisableControlAction(0, 24, true)
            DisableControlAction(0, 257, true) 
            DisableControlAction(0, 25, true) 
            DisableControlAction(0, 263, true) 
            DisableControlAction(0, 37, true) 
            DisableControlAction(0, 47, true)  
            DisplayRadar(false)
        else ClearPedSecondaryTask(playerPed) SetEnableHandcuffs(playerPed, false) SetPedCanPlayGestureAnims(playerPed, true) FreezeEntityPosition(playerPed, false)
        end
    end)
end)

Citizen.CreateThread(function()
    while true do Wait(0)
        if IsHandcuffed then DisableControlAction(0, 142, true)  DisableControlAction(0, 30,  true) DisableControlAction(0, 31,  true) 
        else Wait(50)
        end
    end
end)

RegisterNetEvent('G_policejob:putInVehicle')
AddEventHandler('G_policejob:putInVehicle', function()
    local playerPed = GetPlayerPed(-1)
    local coords = GetEntityCoords(playerPed)
    if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
        local vehicle = GetClosestVehicle(coords.x,  coords.y,  coords.z,  5.0,  0,  71)
        if DoesEntityExist(vehicle) then
            local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
            local freeSeat = nil
            for i=maxSeats - 1, 0, -1 do
                if IsVehicleSeatFree(vehicle, i) then freeSeat = i
                break
                end
            end
            if freeSeat ~= nil then TaskWarpPedIntoVehicle(playerPed,  vehicle,  freeSeat)
            end
        end
    end
end)

RegisterNetEvent('G_policejob:OutVehicle')
AddEventHandler('G_policejob:OutVehicle', function(t)
    local ped = GetPlayerPed(t)
    ClearPedTasksImmediately(ped)
    plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
    local xnew = plyPos.x+2
    local ynew = plyPos.y+2
    SetEntityCoords(GetPlayerPed(-1), xnew, ynew, plyPos.z)
end)

function InfoVehicle(numplaque)
    local menuvehicle = false
    local mainMenu3 = RageUI.CreateMenu("Information Véhicule", "MENU")
    mainMenu3.Closed = function() menuvehicle = false menu = false mainMenu3 = RMenu:DeleteType("Information Véhicule", true) end
    ESX.TriggerServerCallback('G_policejob:getVehicleInfos', function(retrivedInfo)
        if menuvehicle then menuvehicle = false RageUI.Visible(mainMenu3, false) return else menuvehicle = true RageUI.Visible(mainMenu3, true)
            CreateThread(function()
                while mainMenu3 do
				    RageUI.IsVisible(mainMenu3,function()
                        if not retrivedInfo.owner then owner = "Inconnu" else owner = retrivedInfo.owner end
                        RageUI.Separator("Numéro de la Plaque : "..retrivedInfo.plate.."")
                        RageUI.Separator("Propriétaire : "..owner.."")
                    end)
                Wait(0)
                end
            end)
        end
    end, numplaque)
end

RegisterNetEvent('G_policejob:InfoService')
AddEventHandler('G_policejob:InfoService', function(service, nom)
    if service == 'prise' then
        PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
        ESX.ShowAdvancedNotification('LSPD INFORMATIONS', '~b~Prise de service', 'Agent : ~g~'..nom..'\n~w~Code : ~g~10-7\n~w~Information : ~g~Prise de service', 'CHAR_CALL911', 8)
        Wait(1000)
        PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
    elseif service == 'fin' then
        PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
        ESX.ShowAdvancedNotification('LSPD INFORMATIONS', '~b~Fin de service', 'Agent : ~g~'..nom..'\n~w~Code : ~g~10-8\n~w~Information : ~r~Fin de service', 'CHAR_CALL911', 8)
        Wait(1000)
        PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
    elseif service == 'pause' then
        PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
        ESX.ShowAdvancedNotification('LSPD INFORMATIONS', '~b~Pause de service', 'Agent : ~g~'..nom..'\n~w~Code : ~g~10-6\n~w~Information : ~o~Pause de service', 'CHAR_CALL911', 8)
        Wait(1000)
        PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
    elseif service == 'standby' then
        PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
        ESX.ShowAdvancedNotification('LSPD INFORMATIONS', '~b~Mise en standby', 'Agent : ~g~'..nom..'\n~w~Code : ~g~10-9\n~w~Information : ~b~Standby, en attente de dispatch', 'CHAR_CALL911', 8)
        Wait(1000)
        PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
    elseif service == 'rdv' then
        PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
        ESX.ShowAdvancedNotification('LSPD INFORMATIONS', '~b~Retour PDP', 'Agent : ~g~'..nom..'\n~w~Code : ~g~10-19\n~s~Information : ~b~Retour Commissariat', 'CHAR_CALL911', 8)
        Wait(1000)
        PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	end
end)

RegisterNetEvent('renfort:setBlip')
AddEventHandler('renfort:setBlip', function(coords, raison)
	if raison == 'petite' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
		ESX.ShowAdvancedNotification('LSPD INFORMATIONS', '~b~Demande de renfort', 'Demande de renfort demandé\nRéponse: ~g~CODE-2\n~w~Importance: ~g~Légère', 'CHAR_CALL911', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
		color = 2
	elseif raison == 'moyenne' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
		ESX.ShowAdvancedNotification('LSPD INFORMATIONS', '~b~Demande de renfort', 'Demande de renfort demandé\nRéponse: ~g~CODE-3\n~w~Importance: ~o~Importante', 'CHAR_CALL911', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
		color = 47
	elseif raison == 'grosse' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
		PlaySoundFrontend(-1, "FocusIn", "HintCamSounds", 1)
		ESX.ShowAdvancedNotification('LSPD INFORMATIONS', '~b~Demande de renfort', 'Demande de renfort demandé\nRéponse: ~g~CODE-99\n~w~Importance: ~r~URGENTE !\nDANGER IMPORTANT', 'CHAR_CALL911', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
		PlaySoundFrontend(-1, "FocusOut", "HintCamSounds", 1)
		color = 1
	end
	local blipId = AddBlipForCoord(coords)
	SetBlipSprite(blipId, 161)
	SetBlipScale(blipId, 1.2)
	SetBlipColour(blipId, color)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Demande renfort')
	EndTextCommandSetBlipName(blipId)
	Wait(80 * 1000)
	RemoveBlip(blipId)
end)

function OpenBillingMenu()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {title = "Amende"},
	    function(data, menu)
		    local amount = tonumber(data.value)
		    local player, distance = ESX.Game.GetClosestPlayer()  
		    if player ~= -1 and distance <= 3.0 then  
		        menu.close()
		        if amount == nil then ESX.ShowNotification("~r~Problèmes~s~: Montant invalide")
		        else
			        local playerPed = GetPlayerPed(-1)
			        TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
			        Citizen.Wait(5000)
			        TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_police', ('police'), amount)
			        Citizen.Wait(100)
			        ESX.ShowNotification("~r~Vous avez bien envoyer la facture")
		        end
		    else ESX.ShowNotification("~r~Problèmes~s~: Aucun joueur à proximitée")
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
	local blip = AddBlipForCoord(451.86, -992.86, 29.68) 
				 SetBlipSprite (blip, 60) 
				 SetBlipDisplay(blip, 4) 
				 SetBlipScale  (blip, 0.8) 
				 SetBlipColour (blip, 29) 
				 SetBlipAsShortRange(blip, true) 
				 BeginTextCommandSetBlipName('STRING') 
				 AddTextComponentSubstringPlayerName('Poste du Los Santos Police Dept.') 
				 EndTextCommandSetBlipName(blip) 
end)

Citizen.CreateThread(function()
    local hash = GetHashKey("s_m_y_cop_01")
    while not HasModelLoaded(hash) do RequestModel(hash) Wait(20)
	end
	ped = CreatePed("PED_TYPE_CIVMALE", "s_m_y_cop_01", 442.72, -981.91, 29.68, 88.56, false, true)
    ped2 = CreatePed("PED_TYPE_CIVMALE", "s_m_y_cop_01", 480.30, -996.65, 29.68, 89.56, false, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped2, true)
	FreezeEntityPosition(ped2, true)
    SetEntityInvincible(ped2, true)
end)

Keys.Register('F6', 'police', 'Ouvrir le menu police', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then OpenMenu()
	end
end)

local RadarAng,maxSpeed,LastSpeed = 0,0,0 local info,LastPlate,LastVehDesc,LastInfo = "","","","" local isRadarPlaced = false local RadarPos = {}
function GetPlayers() local players = {} for i = 0, 256 do if NetworkIsPlayerActive(i) then table.insert(players, i) end end return players end
function drawTxt(x,y ,width,height,scale, text, r,g,b,a) SetTextFont(0) SetTextProportional(0) SetTextScale(scale, scale) SetTextColour(r, g, b, a) SetTextDropShadow(0, 0, 0, 0,255) SetTextEdge(1, 0, 0, 0, 255) SetTextDropShadow() SetTextOutline() SetTextEntry("STRING") AddTextComponentString(text) DrawText(x - width/2, y - height/2 + 0.005) end
function GetClosestDrivingPlayerFromPos(radius, pos) local players = GetPlayers() local closestDistance = radius or -1 local closestPlayer = -1 local closestVeh = -1 for _ ,value in ipairs(players) do local target = GetPlayerPed(value) if(target ~= ply) then local ped = GetPlayerPed(value) if GetVehiclePedIsUsing(ped) ~= 0 then local targetCoords = GetEntityCoords(ped, 0) local distance = GetDistanceBetweenCoords(targetCoords["x"], targetCoords["y"], targetCoords["z"], pos["x"], pos["y"], pos["z"], true) if(closestDistance == -1 or closestDistance > distance) then closestVeh = GetVehiclePedIsUsing(ped) closestPlayer = value closestDistance = distance end end end end return closestPlayer, closestVeh, closestDistance end
function radarSetSpeed(defaultText) DisplayOnscreenKeyboard(1, "FMMC_MPM_TIP1", "", defaultText or "", "", "", "", 5) while (UpdateOnscreenKeyboard() == 0) do DisableAllControlActions(0); Wait(0); end if (GetOnscreenKeyboardResult()) then local gettxt = tonumber(GetOnscreenKeyboardResult()) if gettxt ~= nil then return gettxt else ClearPrints() SetTextEntry_2("STRING") AddTextComponentString("~r~Veuillez entrer un nombre correct !") DrawSubtitleTimed(3000, 1) return end end return end
function radar() if isRadarPlaced then if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), RadarPos.x, RadarPos.y, RadarPos.z, true) < 0.9 then RequestAnimDict("anim@apt_trans@garage") while not HasAnimDictLoaded("anim@apt_trans@garage") do Wait(1) end TaskPlayAnim(GetPlayerPed(-1), "anim@apt_trans@garage", "gar_open_1_left", 1.0, -1.0, 5000, 0, 1, true, true, true) Citizen.Wait(2000) SetEntityAsMissionEntity(Radar, false, false) DeleteObject(Radar) DeleteEntity(Radar) Radar = nil RadarPos = {} RadarAng = 0 isRadarPlaced = false RemoveBlip(RadarBlip) RadarBlip = nil LastPlate,LastVehDesc,LastInfo = "","","" LastSpeed = 0 else ClearPrints() SetTextEntry_2("STRING") AddTextComponentString("La distance entre le capteur et de récepteur est trop élevé, rapprochez vous") DrawSubtitleTimed(3000, 1) Citizen.Wait(1500) end else maxSpeed = radarSetSpeed("130") Citizen.Wait(200) RadarPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 1.5, 0) RadarAng = GetEntityRotation(GetPlayerPed(-1)) if maxSpeed ~= nil then RequestAnimDict("anim@apt_trans@garage") while not HasAnimDictLoaded("anim@apt_trans@garage") do Wait(1) end TaskPlayAnim(GetPlayerPed(-1), "anim@apt_trans@garage", "gar_open_1_left", 1.0, -1.0, 5000, 0, 1, true, true, true) Citizen.Wait(1500) RequestModel("prop_cctv_pole_01a") while not HasModelLoaded("prop_cctv_pole_01a") do Wait(1) end Radar = CreateObject(GetHashKey('prop_cctv_pole_01a'), RadarPos.x, RadarPos.y, RadarPos.z - 7, true, true, true) SetEntityRotation(Radar, RadarAng.x, RadarAng.y, RadarAng.z - 115) SetEntityAsMissionEntity(Radar, true, true) FreezeEntityPosition(Radar, true) isRadarPlaced = true RadarBlip = AddBlipForCoord(RadarPos.x, RadarPos.y, RadarPos.z) SetBlipSprite(RadarBlip, 380) SetBlipColour(RadarBlip, 1) SetBlipAsShortRange(RadarBlip, true) BeginTextCommandSetBlipName("STRING") AddTextComponentString("Radar") EndTextCommandSetBlipName(RadarBlip) end end end
function radar2() if not opti then opti = true Citizen.CreateThread(function() while opti do Wait(0) if isRadarPlaced then if HasObjectBeenBroken(Radar) then SetEntityAsMissionEntity(Radar, false, false) SetEntityVisible(Radar, false) DeleteObject(Radar) DeleteEntity(Radar) Radar = nil RadarPos = {} RadarAng = 0 isRadarPlaced = false RemoveBlip(RadarBlip) RadarBlip = nil LastPlate,LastVehDesc,LastInfo = "","","" LastSpeed = 0 end if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), RadarPos.x, RadarPos.y, RadarPos.z, true) > 300 then SetEntityAsMissionEntity(Radar, false, false) SetEntityVisible(Radar, false) DeleteObject(Radar) DeleteEntity(Radar) Radar = nil RadarPos = {} RadarAng = 0 isRadarPlaced = false RemoveBlip(RadarBlip) RadarBlip = nil LastPlate,LastVehDesc,LastInfo = "","","" LastSpeed = 0 ClearPrints() SetTextEntry_2("STRING") AddTextComponentString("La distance entre le capteur et de récepteur est trop élevé, rapprochez vous") DrawSubtitleTimed(3000, 1) end end if isRadarPlaced then local viewAngle = GetOffsetFromEntityInWorldCoords(Radar, -8.0, -4.4, 0.0) local ply, veh, dist = GetClosestDrivingPlayerFromPos(30, viewAngle) if veh ~= nil then local vehPlate = GetVehicleNumberPlateText(veh) or "Aucune" local vehSpeedKm = GetEntitySpeed(veh)*3.6 local vehDesc = GetDisplayNameFromVehicleModel(GetEntityModel(veh)) if vehDesc == "CARNOTFOUND" then vehDesc = "Aucun" end if vehSpeedKm < maxSpeed then info = string.format("Informations Véhicules\n    Vehicule : ~b~%s\n    ~w~Plaque : ~b~%s\n    ~w~Km/h : ~r~%s", vehDesc, vehPlate, math.ceil(vehSpeedKm)) else info = string.format("Informations Véhicules\n    Vehicule : ~b~%s\n    ~w~Plaque : ~b~%s\n    ~w~Km/h : ~r~%s", vehDesc, vehPlate, math.ceil(vehSpeedKm)) if LastPlate ~= vehPlate then LastSpeed = vehSpeedKm LastVehDesc = vehDesc LastPlate = vehPlate elseif LastSpeed < vehSpeedKm and LastPlate == vehPlate then LastSpeed = vehSpeedKm end LastInfo = string.format("~r~Véhicule en Infraction~s~\n   Vehicule : ~r~%s\n   ~w~Plaque : ~r~%s\n   ~w~Km/h : ~r~%s", LastVehDesc, LastPlate, math.ceil(LastSpeed)) end DrawRect(0.94, 0.07, 0.1, 0.08, 0, 0, 0, 220) drawTxt(1.00, 0.04, 0.2, 0.03, 0.24, info, 255, 255, 255, 255) DrawRect(0.94, 0.185, 0.1, 0.08, 0, 0, 0, 220) drawTxt(1.00, 0.155, 0.2, 0.03, 0.24, LastInfo, 255, 255, 255, 255) end end end end) elseif opti then opti = false end end