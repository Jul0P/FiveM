if pF5.ESX == "new" then
	ESX = exports["es_extended"]:getSharedObject()
elseif pF5.ESX == "old" then
	ESX = nil
	Citizen.CreateThread(function()
		while ESX == nil do
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
			Citizen.Wait(0)
		end
	end)
end

PlayerData = {}

local societymoney, societymoney2 = nil, nil

Citizen.CreateThread(function()
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	while ESX.GetPlayerData().job2 == nil do
		Citizen.Wait(10)
	end
	ESX.PlayerData = ESX.GetPlayerData()
	RefreshMoney()
	RefreshMoney2()
    WeaponList = ESX.GetWeaponList()
    for i = 1, #WeaponList, 1 do
        if WeaponList[i].name == "WEAPON_UNARMED" then
            WeaponList[i] = nil
        else
            WeaponList[i].hash = GetHashKey(WeaponList[i].name)
        end
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer) 
    ESX.PlayerData = xPlayer 
    ESX.PlayerLoaded = true 
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function() 
    ESX.PlayerLoaded = false 
    ESX.PlayerData = {} 
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	RefreshMoney()
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
	ESX.PlayerData.job2 = job2
	RefreshMoney2()
end)

data_key = {}

function Load_Key()
    ESX.TriggerServerCallback('pF5:key', function(data)
        data_key = data
    end)
end

function RefreshMoney()
	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
		ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
			UpdateSocietyMoney(money)
		end, ESX.PlayerData.job.name)
	end
end

function RefreshMoney2()
	if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
		ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
			UpdateSociety2Money(money)
		end, ESX.PlayerData.job2.name)
	end
end

RegisterNetEvent('esx_addonaccount:setMoney')
AddEventHandler('esx_addonaccount:setMoney', function(society, money)
	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' and 'society_' .. ESX.PlayerData.job.name == society then
		UpdateSocietyMoney(money)
	end
	if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' and 'society_' .. ESX.PlayerData.job2.name == society then
		UpdateSociety2Money(money)
	end
end)

Config = {}

Config.list = {
    {class = 0, name = 'Compacts'},
    {class = 1, name = 'Sedans'},
    {class = 2, name = 'SUVs'},
    {class = 3, name = 'Coupes'},
    {class = 4, name = 'Muscle'},
    {class = 5, name = 'Sports Classics'},
    {class = 6, name = 'Sports'},
    {class = 7, name = 'Super'},
    {class = 8, name = 'Motorcycles'},
    {class = 9, name = 'Off-road'},
    {class = 10, name = 'Industrial'},
    {class = 11, name = 'Utility'},
    {class = 12, name = 'Vans'},
    {class = 13, name = 'Cycles'},
    {class = 14, name = 'Boats'},
    {class = 15, name = 'Helicopters'},
    {class = 16, name = 'Planes'},
    {class = 17, name = 'Service'},
    {class = 18, name = 'Emergency'},
    {class = 19, name = 'Military'},
    {class = 20, name = 'Commercial'},
    {class = 21, name = 'Trains'},
}

object = {}

local heightShift = 0.0
local distanceShift = 2.0
local rotationShift = 0.0
local heightShiftMax = 5.0

function SpawnObj(obj, name)   
    menuf5 = false
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
        SetEntityHeading(Ent, GetEntityHeading(playerPed) + rotationShift)
        PlaceObjectOnGroundProperly(Ent)
        SetEntityCoords(Ent, GetEntityCoords(Ent) + vector3(0.0, 0.0, heightShift), 0.0, 0.0, 0.0, 0)
        SetEntityAlpha(Ent, 170, 170)
        SetEntityCollision(Ent, 0, 0)
        DisableControlAction(0, 21, true)
        DisableControlAction(0, 22, true)

        DrawScaleformMovieFullscreen(Scale, 255, 255, 255, 255, 0);

        if IsControlPressed(0, 174) then -- LEFT
            rotationShift = rotationShift - 1
        elseif IsControlPressed(0, 175) then -- RIGHT
            rotationShift = rotationShift + 1
        elseif IsControlPressed(0, 172) then -- UP
            if heightShift <= heightShiftMax then
                heightShift = heightShift + 0.01
            end
        elseif IsControlPressed(0, 173) then -- DOWN
            if heightShift >= -heightShiftMax then
                heightShift = heightShift - 0.01
            end
        elseif IsControlPressed(0, 178) then -- RESET
            heightShift = 0.0
            rotationShift = 0.0
        end
        if IsControlJustReleased(1, 38) then
            placed = true
        end
    end
    SetEntityNoCollisionEntity(Ent, car, false)
    SetEntityCollision(Ent, 1, 1)
    FreezeEntityPosition(Ent, true)
    SetEntityInvincible(Ent, true)
    ResetEntityAlpha(Ent)
    local NetId = NetworkGetNetworkIdFromEntity(Ent)
    table.insert(object, {
        id = NetId,
        name = name
    })
end

function SpawnObject(model, coords, cb)
	local model = GetHashKey(model)
    menuf5 = false
    DrawInstructions()
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
	if not HasModelLoaded(modelHash) and IsModelInCdimage(modelHash) then 
        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do 
            Citizen.Wait(1)
		end
	end
end

function DrawInstructions()
    Scale = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS");
    repeat
        Citizen.Wait(0)
    until HasScaleformMovieLoaded(Scale)

    BeginScaleformMovieMethod(Scale, "CLEAR_ALL");
    EndScaleformMovieMethod();

    BeginScaleformMovieMethod(Scale, "SET_DATA_SLOT");
    ScaleformMovieMethodAddParamInt(5);
    PushScaleformMovieMethodParameterString("~INPUT_CONTEXT~");
    PushScaleformMovieMethodParameterString("Placer");
    EndScaleformMovieMethod();

    BeginScaleformMovieMethod(Scale, "SET_DATA_SLOT");
    ScaleformMovieMethodAddParamInt(4);
    PushScaleformMovieMethodParameterString("~INPUT_FRONTEND_RRIGHT~");
    PushScaleformMovieMethodParameterString("Annuler");
    EndScaleformMovieMethod();

    BeginScaleformMovieMethod(Scale, "SET_DATA_SLOT");
    ScaleformMovieMethodAddParamInt(3);
    PushScaleformMovieMethodParameterString("~INPUT_CELLPHONE_UP~");
    PushScaleformMovieMethodParameterString("~INPUT_CELLPHONE_DOWN~");
    PushScaleformMovieMethodParameterString("Hauteur d'objet");
    EndScaleformMovieMethod();

    BeginScaleformMovieMethod(Scale, "SET_DATA_SLOT");
    ScaleformMovieMethodAddParamInt(2);
    PushScaleformMovieMethodParameterString("~INPUT_CELLPHONE_RIGHT~");
    PushScaleformMovieMethodParameterString("~INPUT_CELLPHONE_LEFT~");
    PushScaleformMovieMethodParameterString("Tourner l'objet");
    EndScaleformMovieMethod();

    BeginScaleformMovieMethod(Scale, "SET_DATA_SLOT");
    ScaleformMovieMethodAddParamInt(1);
    PushScaleformMovieMethodParameterString("~INPUT_CELLPHONE_OPTION~");
    PushScaleformMovieMethodParameterString("Reset position");
    EndScaleformMovieMethod();

    BeginScaleformMovieMethod(Scale, "DRAW_INSTRUCTIONAL_BUTTONS");
    ScaleformMovieMethodAddParamInt(0);
    EndScaleformMovieMethod();
end

function RemoveObj(id, indox)
    Citizen.CreateThread(function()
        SetNetworkIdCanMigrate(id, true)
        local entity = NetworkGetEntityFromNetworkId(id)
        NetworkRequestControlOfEntity(entity)
        local test = 0
        while test > 100 and not NetworkHasControlOfEntity(entity) do 
            NetworkRequestControlOfEntity(entity) 
            Wait(1) 
            test = test + 1
        end
        SetEntityAsNoLongerNeeded(entity)
        local test = 0
        while test < 100 and DoesEntityExist(entity) do  
            SetEntityAsNoLongerNeeded(entity) 
            DeleteEntity(entity) 
            DeleteObject(entity)
            --if not DoesEntityExist(entity) then  
                --table.remove(object, indox) 
            --end
            SetEntityCoords(entity, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0)
            Wait(1)
            test = test + 1
        end
        table.remove(object, indox)
    end)
end

function GoodName(hash)
    for k,v in pairs(pF5.Civil) do
        if hash == GetHashKey(v.model) then 
            return v.name
        end
    end
    for k,v in pairs(pF5.LSPD) do
        if hash == GetHashKey(v.model) then 
            return v.name
        end
    end
    for k,v in pairs(pF5.EMS) do
        if hash == GetHashKey(v.model) then 
            return v.name
        end
    end
    for k,v in pairs(pF5.Mecano) do
        if hash == GetHashKey(v.model) then 
            return v.name
        end
    end
    for k,v in pairs(pF5.Gang) do
        if hash == GetHashKey(v.model) then 
            return v.name
        end
    end
    for k,v in pairs(pF5.Armes) do
        if hash == GetHashKey(v.model) then 
            return v.name
        end
    end
    for k,v in pairs(pF5.Drogue) do
        if hash == GetHashKey(v.model) then 
            return v.name
        end
    end
end

function removeallclothes()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            if skina.torso_1 ~= skinb.torso_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['torso_1'] = skina.torso_1, ['torso_2'] = skina.torso_2, ['tshirt_1'] = skina.tshirt_1, ['tshirt_2'] = skina.tshirt_2, ['arms'] = skina.arms})
            else
                if skina.sex == 1 then
                    TriggerEvent('skinchanger:loadClothes', skinb, {['torso_1'] = pF5.Clothes.Female.torso_1, ['torso_2'] = pF5.Clothes.Female.torso_2, ['tshirt_1'] = pF5.Clothes.Female.tshirt_1, ['tshirt_2'] = pF5.Clothes.Female.tshirt_2, ['arms'] = pF5.Clothes.Female.arms})
                else
                    TriggerEvent('skinchanger:loadClothes', skinb, {['torso_1'] = pF5.Clothes.Male.torso_1, ['torso_2'] = pF5.Clothes.Male.torso_2, ['tshirt_1'] = pF5.Clothes.Male.tshirt_1, ['tshirt_2'] = pF5.Clothes.Male.tshirt_2, ['arms'] = pF5.Clothes.Male.arms})
                end
            end
        end)
    end)
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            if skina.pants_1 ~= skinb.pants_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['pants_1'] = skina.pants_1, ['pants_2'] = skina.pants_2})
            else
                if skina.sex == 1 then
                    TriggerEvent('skinchanger:loadClothes', skinb, {['pants_1'] = pF5.Clothes.Female.pants_1, ['pants_2'] = pF5.Clothes.Female.pants_2})
                else
                    TriggerEvent('skinchanger:loadClothes', skinb, {['pants_1'] = pF5.Clothes.Male.pants_1, ['pants_2'] = pF5.Clothes.Male.pants_2})
                end
            end
        end)
    end)
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            if skina.shoes_1 ~= skinb.shoes_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['shoes_1'] = skina.shoes_1, ['shoes_2'] = skina.shoes_2})
            else
                if skina.sex == 1 then
                    TriggerEvent('skinchanger:loadClothes', skinb, {['shoes_1'] = pF5.Clothes.Female.shoes_1, ['shoes_2'] = pF5.Clothes.Female.shoes_2})
                else
                    TriggerEvent('skinchanger:loadClothes', skinb, {['shoes_1'] = pF5.Clothes.Male.shoes_1, ['shoes_2'] = pF5.Clothes.Male.shoes_2})
                end
            end
        end)
    end)
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            if skina.bags_1 ~= skinb.bags_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['bags_1'] = skina.bags_1, ['bags_2'] = skina.bags_2})
            else
                if skina.sex == 1 then
                    TriggerEvent('skinchanger:loadClothes', skinb, {['bags_1'] = pF5.Clothes.Female.bags_1, ['bags_2'] = pF5.Clothes.Female.bags_2})
                else
                    TriggerEvent('skinchanger:loadClothes', skinb, {['bags_1'] = pF5.Clothes.Male.bags_1, ['bags_2'] = pF5.Clothes.Male.bags_2})
                end
            end
        end)
    end)
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            if skina.bproof_1 ~= skinb.bproof_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['bproof_1'] = skina.bproof_1, ['bproof_2'] = skina.bproof_2})
            else
                if skina.sex == 1 then
                    TriggerEvent('skinchanger:loadClothes', skinb, {['bproof_1'] = pF5.Clothes.Female.bproof_1, ['bproof_2'] = pF5.Clothes.Female.bproof_2})
                else
                    TriggerEvent('skinchanger:loadClothes', skinb, {['bproof_1'] = pF5.Clothes.Male.bproof_1, ['bproof_2'] = pF5.Clothes.Male.bproof_2})
                end
            end
        end)
    end)
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            if skina.glasses_1 ~= skinb.glasses_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['glasses_1'] = skina.glasses_1, ['glasses_2'] = skina.glasses_2})
            else
                if skina.sex == 1 then
                    TriggerEvent('skinchanger:loadClothes', skinb, {['glasses_1'] = pF5.Clothes.Female.glasses_1, ['glasses_2'] = pF5.Clothes.Female.glasses_2})
                else
                    TriggerEvent('skinchanger:loadClothes', skinb, {['glasses_1'] = pF5.Clothes.Male.glasses_1, ['glasses_2'] = pF5.Clothes.Male.glasses_2})
                end
            end
        end)
    end)
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            if skina.ears_1 ~= skinb.ears_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['ears_1'] = skina.ears_1, ['ears_2'] = skina.ears_2})
            else
                if skina.sex == 1 then
                    TriggerEvent('skinchanger:loadClothes', skinb, {['ears_1'] = pF5.Clothes.Female.ears_1, ['ears_2'] = pF5.Clothes.Female.ears_2})
                else
                    TriggerEvent('skinchanger:loadClothes', skinb, {['ears_1'] = pF5.Clothes.Male.ears_1, ['ears_2'] = pF5.Clothes.Male.ears_2})
                end
            end
        end)
    end)
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            if skina.helmet_1 ~= skinb.helmet_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['helmet_1'] = skina.helmet_1, ['helmet_2'] = skina.helmet_2})
            else
                if skina.sex == 1 then
                    TriggerEvent('skinchanger:loadClothes', skinb, {['helmet_1'] = pF5.Clothes.Female.helmet_1, ['helmet_2'] = pF5.Clothes.Female.helmet_2})
                else
                    TriggerEvent('skinchanger:loadClothes', skinb, {['helmet_1'] = pF5.Clothes.Male.helmet_1, ['helmet_2'] = pF5.Clothes.Male.helmet_2})
                end
            end
        end)
    end)
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            if skina.chain_1 ~= skinb.chain_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['chain_1'] = skina.chain_1, ['chain_2'] = skina.chain_2})
            else
                if skina.sex == 1 then
                    TriggerEvent('skinchanger:loadClothes', skinb, {['chain_1'] = pF5.Clothes.Female.chain_1, ['chain_2'] = pF5.Clothes.Female.chain_2})
                else
                    TriggerEvent('skinchanger:loadClothes', skinb, {['chain_1'] = pF5.Clothes.Male.chain_1, ['chain_2'] = pF5.Clothes.Male.chain_2})
                end
            end
        end)
    end)
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            if skina.mask_1 ~= skinb.mask_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['mask_1'] = skina.mask_1, ['mask_2'] = skina.mask_2})
            else
                if skina.sex == 1 then
                    TriggerEvent('skinchanger:loadClothes', skinb, {['mask_1'] = pF5.Clothes.Female.mask_1, ['mask_2'] = pF5.Clothes.Female.mask_2})
                else
                    TriggerEvent('skinchanger:loadClothes', skinb, {['mask_1'] = pF5.Clothes.Male.mask_1, ['mask_2'] = pF5.Clothes.Male.mask_2})
                end
            end
        end)
    end)
end

RegisterNetEvent('pF5:actionhaut')
AddEventHandler('pF5:actionhaut', function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            local lib, anim = 'clothingtie', 'try_tie_neutral_a'
            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            end)
            Citizen.Wait(1000)
            ClearPedTasks(PlayerPedId())

            if skina.torso_1 ~= skinb.torso_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['torso_1'] = skina.torso_1, ['torso_2'] = skina.torso_2, ['tshirt_1'] = skina.tshirt_1, ['tshirt_2'] = skina.tshirt_2, ['arms'] = skina.arms})
            else
                if skina.sex == 1 then
                    TriggerEvent('skinchanger:loadClothes', skinb, {['torso_1'] = pF5.Clothes.Female.torso_1, ['torso_2'] = pF5.Clothes.Female.torso_2, ['tshirt_1'] = pF5.Clothes.Female.tshirt_1, ['tshirt_2'] = pF5.Clothes.Female.tshirt_2, ['arms'] = pF5.Clothes.Female.arms})
                else
                    TriggerEvent('skinchanger:loadClothes', skinb, {['torso_1'] = pF5.Clothes.Male.torso_1, ['torso_2'] = pF5.Clothes.Male.torso_2, ['tshirt_1'] = pF5.Clothes.Male.tshirt_1, ['tshirt_2'] = pF5.Clothes.Male.tshirt_2, ['arms'] = pF5.Clothes.Male.arms})
                end
            end
        end)
    end)
end)

RegisterNetEvent('pF5:actionpantalon')
AddEventHandler('pF5:actionpantalon', function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            local lib, anim = 'clothingtrousers', 'try_trousers_neutral_c'

            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            end)
            Citizen.Wait(1000)
            ClearPedTasks(PlayerPedId())

            if skina.pants_1 ~= skinb.pants_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['pants_1'] = skina.pants_1, ['pants_2'] = skina.pants_2})
            else
                if skina.sex == 1 then
                    TriggerEvent('skinchanger:loadClothes', skinb, {['pants_1'] = pF5.Clothes.Female.pants_1, ['pants_2'] = pF5.Clothes.Female.pants_2})
                else
                    TriggerEvent('skinchanger:loadClothes', skinb, {['pants_1'] = pF5.Clothes.Male.pants_1, ['pants_2'] = pF5.Clothes.Male.pants_2})
                end
            end
        end)
    end)
end)

RegisterNetEvent('pF5:actionchaussure')
AddEventHandler('pF5:actionchaussure', function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            local lib, anim = 'clothingshoes', 'try_shoes_positive_a'
            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            end)
            Citizen.Wait(1000)
            ClearPedTasks(PlayerPedId())
            if skina.shoes_1 ~= skinb.shoes_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['shoes_1'] = skina.shoes_1, ['shoes_2'] = skina.shoes_2})
            else
                if skina.sex == 1 then
                    TriggerEvent('skinchanger:loadClothes', skinb, {['shoes_1'] = pF5.Clothes.Female.shoes_1, ['shoes_2'] = pF5.Clothes.Female.shoes_2})
                else
                    TriggerEvent('skinchanger:loadClothes', skinb, {['shoes_1'] = pF5.Clothes.Male.shoes_1, ['shoes_2'] = pF5.Clothes.Male.shoes_2})
                end
            end
        end)
    end)
end)

RegisterNetEvent('pF5:actionsac')
AddEventHandler('pF5:actionsac', function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            local lib, anim = 'clothingtie', 'try_tie_neutral_a'
            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            end)
            Citizen.Wait(1000)
            ClearPedTasks(PlayerPedId())
            if skina.bags_1 ~= skinb.bags_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['bags_1'] = skina.bags_1, ['bags_2'] = skina.bags_2})
            else
                if skina.sex == 1 then
                    TriggerEvent('skinchanger:loadClothes', skinb, {['bags_1'] = pF5.Clothes.Female.bags_1, ['bags_2'] = pF5.Clothes.Female.bags_2})
                else
                    TriggerEvent('skinchanger:loadClothes', skinb, {['bags_1'] = pF5.Clothes.Male.bags_1, ['bags_2'] = pF5.Clothes.Male.bags_2})
                end
            end
        end)
    end)
end)


RegisterNetEvent('pF5:actiongiletparballe')
AddEventHandler('pF5:actiongiletparballe', function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            local lib, anim = 'clothingtie', 'try_tie_neutral_a'
            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            end)
            Citizen.Wait(1000)
            ClearPedTasks(PlayerPedId())
            if skina.bproof_1 ~= skinb.bproof_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['bproof_1'] = skina.bproof_1, ['bproof_2'] = skina.bproof_2})
            else
                if skina.sex == 1 then
                    TriggerEvent('skinchanger:loadClothes', skinb, {['bproof_1'] = pF5.Clothes.Female.bproof_1, ['bproof_2'] = pF5.Clothes.Female.bproof_2})
                else
                    TriggerEvent('skinchanger:loadClothes', skinb, {['bproof_1'] = pF5.Clothes.Male.bproof_1, ['bproof_2'] = pF5.Clothes.Male.bproof_2})
                end
            end
        end)
    end)
end)

RegisterNetEvent('pF5:actionglasses')
AddEventHandler('pF5:actionglasses', function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
			local lib, anim = 'clothingspecs', 'try_glasses_positive_a'
            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            end)
            Citizen.Wait(1000)
            ClearPedTasks(PlayerPedId())
            if skina.glasses_1 ~= skinb.glasses_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['glasses_1'] = skina.glasses_1, ['glasses_2'] = skina.glasses_2})
            else
                if skina.sex == 1 then
                    TriggerEvent('skinchanger:loadClothes', skinb, {['glasses_1'] = pF5.Clothes.Female.glasses_1, ['glasses_2'] = pF5.Clothes.Female.glasses_2})
                else
                    TriggerEvent('skinchanger:loadClothes', skinb, {['glasses_1'] = pF5.Clothes.Male.glasses_1, ['glasses_2'] = pF5.Clothes.Male.glasses_2})
                end
            end
        end)
    end)
end)

RegisterNetEvent('pF5:actionears')
AddEventHandler('pF5:actionears', function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            local lib, anim = 'mini@ears_defenders', 'takeoff_earsdefenders_idle'
            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            end)
            Citizen.Wait(1000)
            ClearPedTasks(PlayerPedId())
            if skina.ears_1 ~= skinb.ears_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['ears_1'] = skina.ears_1, ['ears_2'] = skina.ears_2})
            else
                if skina.sex == 1 then
                    TriggerEvent('skinchanger:loadClothes', skinb, {['ears_1'] = pF5.Clothes.Female.ears_1, ['ears_2'] = pF5.Clothes.Female.ears_2})
                else
                    TriggerEvent('skinchanger:loadClothes', skinb, {['ears_1'] = pF5.Clothes.Male.ears_1, ['ears_2'] = pF5.Clothes.Male.ears_2})
                end
            end
        end)
    end)
end)

RegisterNetEvent('pF5:actionhelmet')
AddEventHandler('pF5:actionhelmet', function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            local lib, anim = 'missheistdockssetup1hardhat@', 'put_on_hat'
            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            end)
            Citizen.Wait(1000)
            ClearPedTasks(PlayerPedId())
            if skina.helmet_1 ~= skinb.helmet_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['helmet_1'] = skina.helmet_1, ['helmet_2'] = skina.helmet_2})
            else
                if skina.sex == 1 then
                    TriggerEvent('skinchanger:loadClothes', skinb, {['helmet_1'] = pF5.Clothes.Female.helmet_1, ['helmet_2'] = pF5.Clothes.Female.helmet_2})
                else
                    TriggerEvent('skinchanger:loadClothes', skinb, {['helmet_1'] = pF5.Clothes.Male.helmet_1, ['helmet_2'] = pF5.Clothes.Male.helmet_2})
                end
            end
        end)
    end)
end)

RegisterNetEvent('pF5:actionchain')
AddEventHandler('pF5:actionchain', function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            local lib, anim = 'clothingtie', 'try_tie_positive_a'
            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            end)
            Citizen.Wait(3000)
            ClearPedTasks(PlayerPedId())
            if skina.chain_1 ~= skinb.chain_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['chain_1'] = skina.chain_1, ['chain_2'] = skina.chain_2})
            else
                if skina.sex == 1 then
                    TriggerEvent('skinchanger:loadClothes', skinb, {['chain_1'] = pF5.Clothes.Female.chain_1, ['chain_2'] = pF5.Clothes.Female.chain_2})
                else
                    TriggerEvent('skinchanger:loadClothes', skinb, {['chain_1'] = pF5.Clothes.Male.chain_1, ['chain_2'] = pF5.Clothes.Male.chain_2})
                end
            end
        end)
    end)
end)

RegisterNetEvent('pF5:actionmask')
AddEventHandler('pF5:actionmask', function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            local lib, anim = 'missfbi4', 'takeoff_mask'
            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            end)
            Citizen.Wait(1000)
            ClearPedTasks(PlayerPedId())
            if skina.mask_1 ~= skinb.mask_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['mask_1'] = skina.mask_1, ['mask_2'] = skina.mask_2})
            else
                if skina.sex == 1 then
                    TriggerEvent('skinchanger:loadClothes', skinb, {['mask_1'] = pF5.Clothes.Female.mask_1, ['mask_2'] = pF5.Clothes.Female.mask_2})
                else
                    TriggerEvent('skinchanger:loadClothes', skinb, {['mask_1'] = pF5.Clothes.Male.mask_1, ['mask_2'] = pF5.Clothes.Male.mask_2})
                end
            end
        end)
    end)
end)

function GoRagdoll()
    Citizen.CreateThread(function()
        isInRagdoll = not isInRagdoll
        while isInRagdoll do
            Citizen.Wait(10)
            SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
        end
    end)
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLength)
	AddTextEntry('FMMC_KEY_TIP1', TextEntry .. ':')
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

function PlayAnim(lib, anim)
    if IsPlayerDead(PlayerId()) then
        return
    end
    if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
        return
    end
    RequestAnimDict(lib)
	while not HasAnimDictLoaded(lib) do
		Citizen.Wait(1)
	end
    TaskPlayAnim(GetPlayerPed(-1), lib, anim, 4.0, -1, -1, 50, 0, false, false, false)
    Citizen.Wait(2500)
    ClearPedTasks(GetPlayerPed(-1))
end

function GoToTarget(x, y, z, vehicle, driver, vehhash, target)
    enroute = true
    while enroute do
        Citizen.Wait(500)
        local player = PlayerPedId()
        local playerPos = GetEntityCoords(player)
        SetDriverAbility(driver, 1.0)  
        SetDriverAggressiveness(driver, 0.0)
        TaskVehicleDriveToCoord(driver, vehicle, playerPos.x, playerPos.y, playerPos.z, 20.0, 0, vehhash, 4457279, 1, true)
        local distanceToTarget = #(playerPos - GetEntityCoords(vehicle))
        if distanceToTarget < 15 or distanceToTarget > 150 then
            RemoveBlip(mechBlip)
            TaskVehicleTempAction(driver, vehicle, 27, 6000)
            SetVehicleUndriveable(vehicle, true)
            SetEntityHealth(mechPed, 2000)
            GoToTargetWalking(x, y, z, vehicle, driver)
            enroute = false
        end
    end
end

function GoToTargetWalking(x, y, z, vehicle, driver)
    Citizen.Wait(500)
    TaskWanderStandard(driver, 10.0, 10)
	SetVehicleUndriveable(vehicle, false)
    TriggerServerEvent('pF5:result')
    Citizen.Wait(35000)
	DeletePed(mechPed)
    mechPed = nil
end 

function GangsterAS()
    aimanim = not aimanim
    while aimanim do
        Player = PlayerPedId(), DecorGetInt(PlayerPedId())
        ped = PlayerPedId()

        if CheckWeapon2(ped) then
            inVeh = IsPedInVehicle(PlayerPedId(-1), GetVehiclePedIsIn(PlayerPedId(-1), false), false)
            local _, hash = GetCurrentPedWeapon(Player, 1)
            if not inVeh then
                loadAnimDict("combat@aim_variations@1h@gang")
                if IsPlayerFreeAiming(PlayerId()) or (IsControlPressed(0, 24) and GetAmmoInClip(Player, hash) > 0) then
                    if not IsEntityPlayingAnim(Player, "combat@aim_variations@1h@gang", "aim_variation_a", 3) then
                        TaskPlayAnim(Player, "combat@aim_variations@1h@gang", "aim_variation_a", 8.0, -8.0, -1, 49, 0, 0, 0, 0)
                        SetEnableHandcuffs(Player, true)
                    end
                elseif IsEntityPlayingAnim(Player, "combat@aim_variations@1h@gang", "aim_variation_a", 3) then
                    ClearPedTasks(Player)
                    SetEnableHandcuffs(Player, false)
                end
                Citizen.Wait(50)
            end
            Citizen.Wait(50)
        end
        Citizen.Wait(80)
    end
end

function HillbillyAS()
    aimanim2 = not aimanim2
    while aimanim2 do
        Player = PlayerPedId(), DecorGetInt(PlayerPedId())
        ped = PlayerPedId()

        if CheckWeapon2(ped) then
            inVeh = IsPedInVehicle(PlayerPedId(-1), GetVehiclePedIsIn(PlayerPedId(-1), false), false)
            local _, hash = GetCurrentPedWeapon(Player, 1)
            if not inVeh then
                loadAnimDict("combat@aim_variations@1h@hillbilly")
                if IsPlayerFreeAiming(PlayerId()) or (IsControlPressed(0, 24) and GetAmmoInClip(Player, hash) > 0) then
                    if not IsEntityPlayingAnim(Player, "combat@aim_variations@1h@hillbilly", "aim_variation_a", 3) then
                        TaskPlayAnim(Player, "combat@aim_variations@1h@hillbilly", "aim_variation_a", 8.0, -8.0, -1, 49, 0, 0, 0, 0)
                        SetEnableHandcuffs(Player, true)
                    end
                elseif IsEntityPlayingAnim(Player, "combat@aim_variations@1h@hillbilly", "aim_variation_a", 3) then
                    ClearPedTasks(Player)
                    SetEnableHandcuffs(Player, false)
                end
                Citizen.Wait(50)
            end
            Citizen.Wait(50)
        end
        Citizen.Wait(80)
    end
end

function SideHolsterAnimation()
    holsteranim = not holsteranim
    while holsteranim do
        Player = PlayerPedId(), DecorGetInt(PlayerPedId())
        ped = PlayerPedId()

        loadAnimDict("rcmjosh4")
        loadAnimDict("reaction@intimidation@cop@unarmed")
        if not IsPedInAnyVehicle(ped, false) then
            if GetVehiclePedIsTryingToEnter (ped) == 0 and (GetPedParachuteState(ped) == -1 or GetPedParachuteState(ped) == 0) and not IsPedInParachuteFreeFall(ped) then
                if CheckWeapon(ped) then
                    if holstered then
                        blocked   = true
                            SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
                            TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "intro", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
                            
                                Citizen.Wait(100)
                                SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
                            TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
                                Citizen.Wait(400)
                            ClearPedTasks(ped)
                        holstered = false
                    else
                        blocked = false
                    end
                    Citizen.Wait(50)
                else
                    if not holstered then
                            TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
                                Citizen.Wait(500)
                            TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "outro", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
                                Citizen.Wait(60)
                            ClearPedTasks(ped)
                        holstered = true
                    end
                    Citizen.Wait(40)
                end
                Citizen.Wait(50)
            else
                SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
            end
        else
            holstered = true
        end
        Citizen.Wait(40)
    end
end

function BackHolsterAnimation()
    holsteranim2 = not holsteranim2
    while holsteranim2 do
        Player = PlayerPedId(), DecorGetInt(PlayerPedId())
        ped = PlayerPedId()

        loadAnimDict("reaction@intimidation@1h")
        if not IsPedInAnyVehicle(ped, false) then
            if GetVehiclePedIsTryingToEnter (ped) == 0 and (GetPedParachuteState(ped) == -1 or GetPedParachuteState(ped) == 0) and not IsPedInParachuteFreeFall(ped) then
                if CheckWeapon(ped) then
                    if holstered then
                        pos = GetEntityCoords(ped, true)
                        rot = GetEntityHeading(ped)
                        blocked   = true
                            TaskPlayAnimAdvanced(ped, "reaction@intimidation@1h", "intro", GetEntityCoords(ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0.325, 0, 0)
                                Citizen.Wait(600)
                            ClearPedTasks(ped)
                        holstered = false
                    else
                        blocked = false
                    end
                    Citizen.Wait(40)
                else
                    if not holstered then
                        pos = GetEntityCoords(ped, true)
                        rot = GetEntityHeading(ped)
                            TaskPlayAnimAdvanced(ped, "reaction@intimidation@1h", "outro", GetEntityCoords(ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0.125, 0, 0)
                                Citizen.Wait(2000)
                            ClearPedTasks(ped)
                        holstered = true
                    end
                    Citizen.Wait(40)
                end
                Citizen.Wait(50)
            else
                SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
            end
        else
            holstered = true
        end
        Citizen.Wait(40)
    end
end

function FrontHolsterAnimation()
    holsteranim3 = not holsteranim3
    while holsteranim3 do
        Player = PlayerPedId(), DecorGetInt(PlayerPedId())
        ped = PlayerPedId()

        loadAnimDict("combat@combat_reactions@pistol_1h_gang")
        if not IsPedInAnyVehicle(ped, false) then
            if GetVehiclePedIsTryingToEnter (ped) == 0 and (GetPedParachuteState(ped) == -1 or GetPedParachuteState(ped) == 0) and not IsPedInParachuteFreeFall(ped) then
                if CheckWeapon(ped) then
                    if holstered then
                        pos = GetEntityCoords(ped, true)
                        rot = GetEntityHeading(ped)
                        blocked   = true
                            TaskPlayAnimAdvanced(ped, "combat@combat_reactions@pistol_1h_gang", "0", GetEntityCoords(ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0.325, 0, 0)
                                Citizen.Wait(600)
                            ClearPedTasks(ped)
                        holstered = false
                    else
                        blocked = false
                    end
                    Citizen.Wait(40)
                else
                    if not holstered then
                        pos = GetEntityCoords(ped, true)
                        rot = GetEntityHeading(ped)
                            TaskPlayAnimAdvanced(ped, "combat@combat_reactions@pistol_1h_gang", "0", GetEntityCoords(ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0.125, 0, 0)
                                Citizen.Wait(1000)
                            ClearPedTasks(ped)
                        holstered = true
                    end
                    Citizen.Wait(40)
                end
                Citizen.Wait(50)
            else
                SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
            end
        else
            holstered = true
        end
        Citizen.Wait(40)
    end
end

function AgressiveFrontHolsterAnimation()
    holsteranim4 = not holsteranim4
    while holsteranim4 do
        Player = PlayerPedId(), DecorGetInt(PlayerPedId())
        ped = PlayerPedId()

        loadAnimDict("combat@combat_reactions@pistol_1h_hillbilly")
        loadAnimDict("combat@combat_reactions@pistol_1h_gang")
        if not IsPedInAnyVehicle(ped, false) then
            if GetVehiclePedIsTryingToEnter (ped) == 0 and (GetPedParachuteState(ped) == -1 or GetPedParachuteState(ped) == 0) and not IsPedInParachuteFreeFall(ped) then
                if CheckWeapon(ped) then
                    if holstered then
                        pos = GetEntityCoords(ped, true)
                        rot = GetEntityHeading(ped)
                        blocked   = true
                            TaskPlayAnimAdvanced(ped, "combat@combat_reactions@pistol_1h_hillbilly", "0", GetEntityCoords(ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0.325, 0, 0)
                                Citizen.Wait(600)
                            ClearPedTasks(ped)
                        holstered = false
                    else
                        blocked = false
                    end
                    Citizen.Wait(40)
                else
                    if not holstered then
                        pos = GetEntityCoords(ped, true)
                        rot = GetEntityHeading(ped)
                            TaskPlayAnimAdvanced(ped, "combat@combat_reactions@pistol_1h_gang", "0", GetEntityCoords(ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0.125, 0, 0)
                                Citizen.Wait(1000)
                            ClearPedTasks(ped)
                        holstered = true
                    end
                    Citizen.Wait(40)
                end
                Citizen.Wait(50)
            else
                SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
            end
        else
            holstered = true
        end
        Citizen.Wait(40)
    end
end

function SideLegHolsterAnimation()
    holsteranim5 = not holsteranim5
    while holsteranim5 do
        Player = PlayerPedId(), DecorGetInt(PlayerPedId())
        ped = PlayerPedId()

        loadAnimDict("reaction@male_stand@big_variations@d")
        if not IsPedInAnyVehicle(ped, false) then
            if GetVehiclePedIsTryingToEnter (ped) == 0 and (GetPedParachuteState(ped) == -1 or GetPedParachuteState(ped) == 0) and not IsPedInParachuteFreeFall(ped) then
                if CheckWeapon(ped) then
                    if holstered then
                        pos = GetEntityCoords(ped, true)
                        rot = GetEntityHeading(ped)
                        blocked   = true
                            TaskPlayAnimAdvanced(ped, "reaction@male_stand@big_variations@d", "react_big_variations_m", GetEntityCoords(ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0.325, 0, 0)
                                Citizen.Wait(500)
                            ClearPedTasks(ped)
                        holstered = false
                    else
                        blocked = false
                    end
                    Citizen.Wait(40)
                else
                    if not holstered then
                        pos = GetEntityCoords(ped, true)
                        rot = GetEntityHeading(ped)
                            TaskPlayAnimAdvanced(ped, "reaction@male_stand@big_variations@d", "react_big_variations_m", GetEntityCoords(ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0.125, 0, 0)
                                Citizen.Wait(500)
                            ClearPedTasks(ped)
                        holstered = true
                    end
                    Citizen.Wait(40)
                end
            else
                SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
            end
            Citizen.Wait(50)
        else
            holstered = true
        end
        Citizen.Wait(40)
    end
end

function CheckWeapon(ped)
	if IsEntityDead(ped) then
		blocked = false
			return false
		else
			for i = 1, #pF5.DrawingWeapons do
				if GetHashKey(pF5.DrawingWeapons[i]) == GetSelectedPedWeapon(ped) then
					return true
				end
			end
		return false
	end
end

function CheckWeapon2(ped)
	if IsEntityDead(ped) then
		blocked = false
			return false
		else
			for i = 1, #pF5.AimWeapons do
				if GetHashKey(pF5.AimWeapons[i]) == GetSelectedPedWeapon(ped) then
					return true
				end
			end
		return false
	end
end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(50)
	end
end

local handsup = false

if pF5.Active.KeyHandsup then
    Keys.Register(pF5.KeyHandsup, "Hands-Up", "Lever les mains", function()
        Citizen.CreateThread(function()
            RequestAnimDict("missminuteman_1ig_2")
            while not HasAnimDictLoaded("missminuteman_1ig_2") do
                Wait(100)
            end
            if not handsup then
                TaskPlayAnim(PlayerPedId(), "missminuteman_1ig_2", "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false, false)
                handsup = true 
            else
                handsup = false
                ClearPedTasks(PlayerPedId())
            end
        end)
    end)
end

local function startPointing(plyPed)
    ESX.Streaming.RequestAnimDict("anim@mp_point", function()
        SetPedConfigFlag(plyPed, 36, 1)
        TaskMoveNetworkByName(plyPed, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
        RemoveAnimDict("anim@mp_point")
    end)
end

local function stopPointing(plyPed)
    RequestTaskMoveNetworkStateTransition(plyPed, "Stop")

    if not IsPedInjured(plyPed) then
        ClearPedSecondaryTask(plyPed)
    end

    SetPedConfigFlag(plyPed, 36, 0)
    ClearPedSecondaryTask(plyPed)
end

function CrouchAndPointing()
    CAP = not CAP
    Citizen.CreateThread(function()
        while CAP do
            Citizen.Wait(10)
            if g._handsup or g._pointing or g._crouched then
                if not IsPedOnFoot(PlayerPedId()) then
                    ResetPedMovementClipset(PlayerPedId(), 0)
                    stopPointing()
                    g._handsup, g._pointing, g._crouched = false, false, false
                elseif g._pointing then
                    local camPitch = GetGameplayCamRelativePitch()

                    if camPitch < -70.0 then
                        camPitch = -70.0
                    elseif camPitch > 42.0 then
                        camPitch = 42.0
                    end

                    camPitch = (camPitch + 70.0) / 112.0

                    local camHeading = GetGameplayCamRelativeHeading()
                    local cosCamHeading = Cos(camHeading)
                    local sinCamHeading = Sin(camHeading)

                    if camHeading < -180.0 then
                        camHeading = -180.0
                    elseif camHeading > 180.0 then
                        camHeading = 180.0
                    end

                    camHeading = (camHeading + 180.0) / 360.0 
                    local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
                    local rayHandle, blocked = GetShapeTestResult(StartShapeTestCapsule(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, PlayerPedId(), 7))

                    SetTaskMoveNetworkSignalFloat(PlayerPedId(), "Pitch", camPitch)
                    SetTaskMoveNetworkSignalFloat(PlayerPedId(), "Heading", (camHeading * -1.0) + 1.0)
                    SetTaskMoveNetworkSignalFloat(PlayerPedId(), "isBlocked", blocked)
                    SetTaskMoveNetworkSignalFloat(PlayerPedId(), "isFirstPerson", N_0xee778f8c7e1142e2(N_0x19cafa3c87f7c2ff()) == 4)
                end
            end 
        end
    end)
end

g = {
    _handsup = false,
    _pointing = false,
    _crouched = false
}

if pF5.Active.KeyPointing then
    Keys.Register(pF5.KeyPointing, "Pointings", "Pointer du doigts", function()
        if (DoesEntityExist(PlayerPedId())) and (not IsEntityDead(PlayerPedId())) and (IsPedOnFoot(PlayerPedId())) then
            if g._handsup then 
                g._handsup = false
            end

            g._pointing = not g._pointing

            if g._pointing then
                startPointing(PlayerPedId())
                CrouchAndPointing()
            else
                stopPointing(PlayerPedId())
                CrouchAndPointing()
            end
        end
    end)
end

if pF5.Active.KeyCrouched then
    Keys.Register(pF5.KeyCrouched, "Crouched", "S'accroupir", function()
        if (DoesEntityExist(PlayerPedId())) and (not IsEntityDead(PlayerPedId())) and (IsPedOnFoot(PlayerPedId())) then

            g._crouched = not g._crouched
            while g._crouched do
                Citizen.Wait(0)
                DisableControlAction(1, pF5.KeyCrouched, true)
                if g._crouched then
                    ESX.Streaming.RequestAnimSet('move_ped_crouched', function()
                        SetPedMovementClipset(PlayerPedId(), 'move_ped_crouched', 0.25)
                        RemoveAnimSet('move_ped_crouched')
                    end)
                else
                    ResetPedMovementClipset(PlayerPedId(), 0)
                end
                if not IsPedOnFoot(PlayerPedId()) then
                    ResetPedMovementClipset(PlayerPedId(), 0)
                    stopPointing()
                    g._handsup, g._pointing = false, false
                end
            end
        end
    end)
end

if pF5.Active.KeyRagdoll then
    Keys.Register(pF5.KeyRagdoll, "Ragdoll", "Dormir / Se réveiller", function()
        GoRagdoll()
    end)
end

function GoEngine()
    CreateThread(function()
        while toggleEngine do
            if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then
                SetVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId(), false), false, true, true)
                Citizen.Wait(100)
            else
                SetVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId(), false), true, true, true)
                toggleEngine = false
            end
        end
    end)
end

Citizen.CreateThread(function()
    while not ESX.PlayerLoaded do 
        Citizen.Wait(100) 
        print("Load...")
    end
    if pF5.pSim.Active then
        Load()
    end
    if pF5.pClothes.Active then
        GetAccess()
    end
    print("Active")
end)