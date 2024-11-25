Citizen.CreateThread(function()
	while ESX == nil do 
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
        Citizen.Wait(10) 
    end
    while ESX.GetPlayerData().job == nil do 
        Citizen.Wait(10) 
    end
    if ESX.IsPlayerLoaded() then 
        ESX.PlayerData = ESX.GetPlayerData() 
    end
end)

RegisterNetEvent('esx:playerLoaded') 
AddEventHandler('esx:playerLoaded', function(xPlayer) 
    ESX.PlayerData = xPlayer 
end)

RegisterNetEvent('esx:setJob') 
AddEventHandler('esx:setJob', function(job) 
    ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:setJob2') 
AddEventHandler('esx:setJob2', function(job2) 
    ESX.PlayerData.job2 = job2 
end)

Array = {
    Garage = {},
    Pound = {},
}

function Garage(v) 
    local mainMenu = RageUI.CreateMenu("Garage - "..v.name, "MENU", 0, 0, "commonmenu", "interaction_bgd", 0, 0, 0, 0)
    local garage = false
    mainMenu.Closed = function() garage = false end
    if not garage then garage = true RageUI.Visible(mainMenu, true)
        Citizen.CreateThread(function()
            while garage do 
                RageUI.IsVisible(mainMenu, function()
                    for _,y in pairs(Array.Garage) do
                        local model = y.vehicle
                        local plate = y.plate        
                        local text = GetLabelText(GetDisplayNameFromVehicleModel(y.vehicle.model))
                        if G_GarageCreator.AllVehiclesGarages then
                            RageUI.Button(text, "Plaque : ~y~"..plate.."", {RightLabel = "→"}, true, {
                                onSelected = function()  
                                    SpawnVehicle(model, plate, v.name, v.Get.spawn)
                                    RageUI.CloseAll()
                                    garage = false
                                end
                            })  
                        else
                            if v.name == y.name then
                                RageUI.Button(text, "Plaque : ~y~"..plate.."", {RightLabel = "[~o~"..y.name.."~s~] →"}, true, {
                                    onSelected = function()  
                                        SpawnVehicle(model, plate, v.name, v.Get.spawn)
                                        RageUI.CloseAll()
                                        garage = false
                                    end
                                })
                            else
                                RageUI.Button(text, "Plaque : ~y~"..plate.."~s~\nVous devez aller au Garage [~o~"..y.name.."~s~] pour récupérer votre véhicule", {}, false, {})
                            end
                        end
                    end
                end)
            Wait(0)
            end
        end)
    end
end

function Pound(v) 
    local mainMenu2 = RageUI.CreateMenu("Fourrière - "..v.name, "MENU", 0, 0, "commonmenu", "interaction_bgd", 0, 0, 0, 0)
    local pound = false
    mainMenu2.Closed = function() pound = false end
    if not pound then pound = true RageUI.Visible(mainMenu2, true)
        Citizen.CreateThread(function()
            while pound do 
                RageUI.IsVisible(mainMenu2, function()
                    for _,y in pairs(Array.Pound) do
                        local model = y.vehicle                        
                        local plate = y.plate
                        local text = GetLabelText(GetDisplayNameFromVehicleModel(y.vehicle.model))
                        if G_GarageCreator.AllVehiclesGarages or G_GarageCreator.AllVehiclesGaragesInPound then
                            RageUI.Button(text, "Plaque : ~y~"..plate.."", {RightLabel = "→"}, true, {
                                onSelected = function() 
                                    ESX.TriggerServerCallback('</G_GarageCreator(G)>:Buy', function(cb)
                                        if cb then
                                            SpawnVehicle(model, plate, v.name, v.spawn)
                                            RageUI.CloseAll()
                                            pound = false
                                        else
                                            ESX.ShowNotification("Vous n'avez pas assez d'argent")
                                        end
                                    end)
                                end
                            })    
                        else
                            if v.name == y.name then           
                                RageUI.Button(text, "Plaque : ~y~"..plate.."", {RightLabel = "[~o~"..y.name.."~s~] →"}, true, {
                                    onSelected = function() 
                                        ESX.TriggerServerCallback('</G_GarageCreator(G)>:Buy', function(cb)
                                            if cb then
                                                SpawnVehicle(model, plate, v.name, v.spawn)
                                                RageUI.CloseAll()
                                                pound = false
                                            else
                                                ESX.ShowNotification("Vous n'avez pas assez d'argent")
                                            end
                                        end)
                                    end
                                })
                            else
                                RageUI.Button(text, "Plaque : ~y~"..plate.."~s~\nVous devez aller à la Fourrière [~o~"..y.name.."~s~] pour récupérer votre véhicule", {RightLabel = "→"}, false, {})
                            end
                        end
                    end
                end)
            Wait(0)
            end
        end)
    end
end

function Private(v) 
    local mainMenu3 = RageUI.CreateMenu("Garage - "..v.label, "MENU", 0, 0, "commonmenu", "interaction_bgd", 0, 0, 0, 0)
    local private = false
    mainMenu3.Closed = function() private = false end
    if not private then private = true RageUI.Visible(mainMenu3, true)
        Citizen.CreateThread(function()
            while private do 
                RageUI.IsVisible(mainMenu3, function()
                    for _,y in pairs(v.Content) do
                        if ESX.PlayerData.job.grade >= y.job_grade_min then
                            RageUI.Button(y.label, nil, {RightLabel = "["..v.colortext..""..y.count.."~s~] →"}, true, {
                                onSelected = function()
                                    if y.count > 0 then
                                        if ESX.Game.IsSpawnPointClear(vector3(y.spawn.x, y.spawn.y, y.spawn.z), 2.0) then
                                            ESX.Game.SpawnVehicle(y.name, vector3(y.spawn.x, y.spawn.y, y.spawn.z), y.spawn.w, function(zVehicle)
                                                SetVehicleNumberPlateText(zVehicle, v.name)
                                                SetVehicleFixed(zVehicle)
                                                SetVehicleCustomPrimaryColour(zVehicle, y.color[1], y.color[2], y.color[3])
                                                SetVehicleCustomSecondaryColour(zVehicle, y.color[1], y.color[2], y.color[3])
                                                SetVehicleEngineOn(xVehicle, true, true)
                                                TaskWarpPedIntoVehicle(GetPlayerPed(-1), zVehicle, -1)
                                            end)
                                            y.count = y.count - 1
                                            RageUI.CloseAll()
                                            private = false
                                        else
                                            ESX.ShowNotification("La sortie est bloqué")
                                        end
                                    else
                                        ESX.ShowNotification("Il n'y a plus ce model de véhicule en stock")
                                    end
                                end
                            })                           
                        else
                            RageUI.Button(y.label, "Vous n'êtes pas assez haut gradé pour sortir ce véhicule", {RightLabel = "["..v.colortext..""..y.count.."~s~] →"}, false, {}) 
                        end
                    end
                end)
            Wait(0)
            end
        end)
    end
end

function Private2(v) 
    local mainMenu4 = RageUI.CreateMenu("Garage - "..v.label, "MENU", 0, 0, "commonmenu", "interaction_bgd", 0, 0, 0, 0)
    local private = false
    mainMenu4.Closed = function() private = false end
    if not private then private = true RageUI.Visible(mainMenu4, true)
        Citizen.CreateThread(function()
            while private do 
                RageUI.IsVisible(mainMenu4, function()
                    for _,y in pairs(v.Content) do
                        if ESX.PlayerData.job2.grade >= y.job_grade_min then
                            RageUI.Button(y.label, nil, {RightLabel = "["..v.colortext..""..y.count.."~s~] →"}, true, {
                                onSelected = function()
                                    if y.count > 0 then
                                        if ESX.Game.IsSpawnPointClear(vector3(y.spawn.x, y.spawn.y, y.spawn.z), 10.0) then
                                            ESX.Game.SpawnVehicle(y.name, vector3(y.spawn.x, y.spawn.y, y.spawn.z), y.spawn.w, function(zVehicle)
                                                SetVehicleNumberPlateText(zVehicle, v.name)
                                                SetVehicleFixed(zVehicle)
                                                SetVehicleCustomPrimaryColour(zVehicle, y.color[1], y.color[2], y.color[3])
                                                SetVehicleCustomSecondaryColour(zVehicle, y.color[1], y.color[2], y.color[3])
                                                SetVehicleEngineOn(xVehicle, true, true)
                                                TaskWarpPedIntoVehicle(GetPlayerPed(-1), zVehicle, -1)
                                            end)
                                            y.count = y.count - 1
                                            RageUI.CloseAll()
                                            private = false
                                        else
                                            ESX.ShowNotification("La sortie est bloqué")
                                        end
                                    else
                                        ESX.ShowNotification("Il n'y a plus ce model de véhicule en stock")
                                    end
                                end
                            })                           
                        else
                            RageUI.Button(y.label, "Vous n'êtes pas assez haut gradé pour sortir ce véhicule", {RightLabel = "["..v.colortext..""..y.count.."~s~] →"}, false, {}) 
                        end
                    end
                end)
            Wait(0)
            end
        end)
    end
end

Citizen.CreateThread(function()
    while true do
		local wait = 900
        for _,v in pairs(G_GarageCreator.Public.Garage) do
            local coords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(coords.x, coords.y, coords.z, v.Get.pos.x, v.Get.pos.y, v.Get.pos.z)
            if dist <= 5.0 then
                wait = 1
                DrawMarker(36, v.Get.pos.x, v.Get.pos.y, v.Get.pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 250, 70, 160, false, false, p19, false) 
                if dist <= 2.0 then
                    wait = 1                      
                    ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir le ~b~Garage - "..v.name)
                    if IsControlJustPressed(1,51) then
						ESX.TriggerServerCallback('</G_GarageCreator(G)>:VehicleArrayGarage', function(data)
                            Array.Garage = data
                        end)
                        Garage(v)
                    end
                end
            end
    	end
        for _,v in pairs(G_GarageCreator.Public.Garage) do
            local coords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(coords.x, coords.y, coords.z, v.Put.pos.x, v.Put.pos.y, v.Put.pos.z)
            if dist <= 5.0 then
                wait = 1
                DrawMarker(36, v.Put.pos.x, v.Put.pos.y, v.Put.pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 250, 0, 0, 160, false, false, p19, false) 
                if dist <= 2.0 then
                    wait = 1                      
                    ESX.ShowHelpNotification("~INPUT_TALK~ pour ranger votre ~b~Véhicule")
                    if IsControlJustPressed(1,51) then
                        ReturnVehicle(v)
                    end
                end
            end
    	end
        for _,v in pairs(G_GarageCreator.Public.Pound) do
            local coords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(coords.x, coords.y, coords.z, v.pos.x, v.pos.y, v.pos.z)
            if dist <= 5.0 then
                wait = 1
                DrawMarker(39, v.pos.x, v.pos.y, v.pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 250, 150, 0, 160, false, false, p19, false) 
                if dist <= 2.0 then
                    wait = 1                      
                    ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir la ~b~Fourrière - "..v.name)
                    if IsControlJustPressed(1,51) then
						ESX.TriggerServerCallback('</G_GarageCreator(G)>:VehicleArrayPound', function(data)
                            Array.Pound = data
                        end)
						Pound(v)
                    end
                end
            end
    	end
        for _,v in pairs(G_GarageCreator.Private.Job) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == v.name then
                local coords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(coords.x, coords.y, coords.z, v.pos.x, v.pos.y, v.pos.z)
                if dist <= 5.0 then
                    wait = 1
                    DrawMarker(6, v.pos.x, v.pos.y, v.pos.z-1, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.5, 0.5, 0.5, v.color[1], v.color[2], v.color[3], 160, false, false, p19, false) 
                    if dist <= 2.0 then
                        wait = 1                      
                        ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir le "..v.colortext.."Garage - "..v.label)
                        if IsControlJustPressed(1,51) then
                            Private(v)
                        end
                    end
                end
            end
        end
        for _,v in pairs(G_GarageCreator.Private.Job2) do
            if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == v.name then
                local coords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(coords.x, coords.y, coords.z, v.pos.x, v.pos.y, v.pos.z)
                if dist <= 5.0 then
                    wait = 1
                    DrawMarker(6, v.pos.x, v.pos.y, v.pos.z-1, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.5, 0.5, 0.5, v.color[1], v.color[2], v.color[3], 160, false, false, p19, false) 
                    if dist <= 2.0 then
                        wait = 1                      
                        ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir le "..v.colortext.."Garage - "..v.label)
                        if IsControlJustPressed(1,51) then
                            Private2(v)
                        end
                    end
                end
            end
        end
        for _,v in pairs(G_GarageCreator.Private.Job) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == v.name then
                local coords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(coords.x, coords.y, coords.z, v.posreturn.x, v.posreturn.y, v.posreturn.z)
                if dist <= 5.0 then
                    wait = 1
                    DrawMarker(6, v.posreturn.x, v.posreturn.y, v.posreturn.z-1, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.5, 0.5, 0.5, v.color[1], v.color[2], v.color[3], 160, false, false, p19, false) 
                    if dist <= 2.0 then
                        wait = 1                      
                        ESX.ShowHelpNotification("~INPUT_TALK~ pour ranger votre véhicule dans le "..v.colortext.."Garage - "..v.label)
                        if IsControlJustPressed(1,51) then
                            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false) 
                            local plate = GetVehicleNumberPlateText(vehicle)
                            if GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then                             
                                ESX.ShowNotification("Votre véhicule est bien rentré dans ce garage")
                                ESX.Game.DeleteVehicle(vehicle)
                            else
                                ESX.ShowNotification("Il faut être conducteur pour ranger le véhicule")
                            end
                        end
                    end
                end
            end
        end
        for _,v in pairs(G_GarageCreator.Private.Job2) do
            if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == v.name then
                local coords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(coords.x, coords.y, coords.z, v.posreturn.x, v.posreturn.y, v.posreturn.z)
                if dist <= 5.0 then
                    wait = 1
                    DrawMarker(6, v.posreturn.x, v.posreturn.y, v.posreturn.z-1, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.5, 0.5, 0.5, v.color[1], v.color[2], v.color[3], 160, false, false, p19, false) 
                    if dist <= 2.0 then
                        wait = 1                      
                        ESX.ShowHelpNotification("~INPUT_TALK~ pour ranger votre véhicule dans le "..v.colortext.."Garage - "..v.label)
                        if IsControlJustPressed(1,51) then
                            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false) 
                            local plate = GetVehicleNumberPlateText(vehicle)
                            if GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then                             
                                ESX.ShowNotification("Votre véhicule est bien rentré dans ce garage")
                                ESX.Game.DeleteVehicle(vehicle)
                            else
                                ESX.ShowNotification("Il faut être conducteur pour ranger le véhicule")
                            end
                        end
                    end
                end
            end
        end
    Citizen.Wait(wait)
	end
end)

function SpawnVehicle(vehicle, plate, name, spawn)
	ESX.Game.SpawnVehicle(vehicle.model, {x = spawn.x, y = spawn.y, z = spawn.z}, spawn.w, function(xVehicle)
		ESX.Game.SetVehicleProperties(xVehicle, vehicle)
		SetVehRadioStation(xVehicle, "OFF")
		SetVehicleFixed(xVehicle)
		SetVehicleDeformationFixed(xVehicle)
		SetVehicleUndriveable(xVehicle, false)
		SetVehicleEngineOn(xVehicle, true, true)
		TaskWarpPedIntoVehicle(GetPlayerPed(-1), xVehicle, -1)
	end)
	TriggerServerEvent('</G_GarageCreator(G)>:VehicleStatue', plate, false, name)
end

function ReturnVehicle(v)
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		ESX.TriggerServerCallback('</G_GarageCreator(G)>:ReturnVehicle', function(cb)
			if cb then
                ESX.Game.DeleteVehicle(vehicle)
                TriggerServerEvent('</G_GarageCreator(G)>:VehicleStatue', vehicleProps.plate, true, v.name)
                ESX.ShowNotification("Vous venez de ranger votre véhicule")
			else
				ESX.ShowNotification("Vous ne pouvez pas ranger ce véhicule")
			end
		end, vehicleProps)
	else
		ESX.ShowNotification("Aucun véhicule proche")
	end
end

Citizen.CreateThread(function()
    for _,v in pairs(G_GarageCreator.Public.Garage) do
        local blip = AddBlipForCoord(v.Get.pos.x, v.Get.pos.y, v.Get.pos.z)
        SetBlipSprite(blip, 290)
        SetBlipScale (blip, 0.7)
        SetBlipColour(blip, 38)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName("Garage")
        EndTextCommandSetBlipName(blip)
    end
    for _,v in pairs(G_GarageCreator.Public.Pound) do
        local blip = AddBlipForCoord(v.pos.x, v.pos.y, v.pos.z)
        SetBlipSprite(blip, 67)
        SetBlipScale (blip, 0.7)
        SetBlipColour(blip, 64)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName("Fourrière")
        EndTextCommandSetBlipName(blip)
    end
    for _,v in pairs(G_GarageCreator.Private.Job) do
        if ESX.PlayerData.job and ESX.PlayerData.job.name == v.name then
            local blip = AddBlipForCoord(v.pos.x, v.pos.y, v.pos.z)
            SetBlipSprite(blip, 290)
            SetBlipScale (blip, 0.7)
            SetBlipColour(blip, 2)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName("Garage Entreprise - "..v.label.."")
            EndTextCommandSetBlipName(blip)
        end
    end
    for _,v in pairs(G_GarageCreator.Private.Job2) do
        if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == v.name then
            local blip = AddBlipForCoord(v.pos.x, v.pos.y, v.pos.z)
            SetBlipSprite(blip, 290)
            SetBlipScale (blip, 0.7)
            SetBlipColour(blip, 1)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName("Garage Organisation - "..v.label.."")
            EndTextCommandSetBlipName(blip)
        end
    end
end)