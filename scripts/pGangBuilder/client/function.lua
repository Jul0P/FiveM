if not pGangBuilder.LastLegacy then
	ESX = nil
end

Citizen.CreateThread(function()
	if not pGangBuilder.LastLegacy then
		while ESX == nil do
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
			Citizen.Wait(5000)
		end	
	end
    WeaponList = ESX.GetWeaponList()
    for i = 1, #WeaponList, 1 do
        if WeaponList[i].name == "WEAPON_UNARMED" then
            WeaponList[i] = nil
        else
            WeaponList[i].hash = GetHashKey(WeaponList[i].name)
        end
    end
    all_items = {}
    for k,v in pairs(pGangBuilder.LocalWeight.Item) do
        all_items = k
    end
    all_weapons = {}
    for k,v in pairs(pGangBuilder.LocalWeight.Weapon) do
        all_weapons = k
    end
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
    ESX.PlayerData.job = job
end)

RegisterNetEvent("esx:setJob2")
AddEventHandler("esx:setJob2", function(job2)
    ESX.PlayerData.job2 = job2
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

getData = {
    Items = {},
    Gang = {},
    Employees = {},
    Grade = {}
}

function getDataItems()
    ESX.TriggerServerCallback("pGangBuilder:getItems", function(data)
        getData.Items = data
    end)    
end

function getDataGang()
    ESX.TriggerServerCallback("pGangBuilder:getGang", function(data)
        getData.Gang = data
    end)    
end

RegisterNetEvent('pGangBuilder:getDataGang')
AddEventHandler('pGangBuilder:getDataGang', function(nameupadate)
	ESX.TriggerServerCallback("pGangBuilder:getGang", function(data)
        getData.Gang = data
    end) 
	Wait(300)
	if nameupadate == "coffre" then
		data_coffre_items = {}
		data_coffre_weapons = {}
		for y,z in pairs(getData.Gang[CoffreIndex].coffre_data.items) do
			table.insert(data_coffre_items, {name = z.name, label = z.label, count = z.count})
		end
		for y,z in pairs(getData.Gang[CoffreIndex].coffre_data.weapons) do
			table.insert(data_coffre_weapons, {label = z.label, name = z.name, count = z.count, munition = z.munition})
		end
	elseif nameupadate == "garage" then
		data_garage = {}
		for y,z in pairs(getData.Gang[GarageIndex].garage_data) do
			table.insert(data_garage, {name = z.name, count = z.count, plate = z.plate, props = z.props})
		end
	elseif nameupadate == "vestiaire" then
		boss_data_clothes = {}
		for y,z in pairs(getData.Gang[VestiaireIndex].vestiaire_data) do
			table.insert(boss_data_clothes, {name = z.name, skin = z.skin})
		end
	end
end) 

function getDataEmployees(society)
    ESX.TriggerServerCallback("pGangBuilder:getSocietyEmployees", function(data)
        getData.Employees = data
    end, society)
end

function getDataGrade(society)
    ESX.TriggerServerCallback("pGangBuilder:getSocietyGrade", function(data)
        getData.Grade = data
    end, society)
end

function Xenon(vehicle)
    local props = {modXenon = 1}
    ESX.Game.SetVehicleProperties(vehicle, props)
end

function Custom(vehicle)
    local props = {modEngine = 3, modBrakes = 2, modTransmission = 2, modSuspension = 3, modArmor = 4, modTurbo = true}
    ESX.Game.SetVehicleProperties(vehicle, props)
end

function Vitres(vehicle)
    local props = {windowTint = 1}
    ESX.Game.SetVehicleProperties(vehicle, props)
end

function Color(vehicle, color)
    local props = {color1 = color, color2 = color}
    ESX.Game.SetVehicleProperties(vehicle, props)
end

function Load_Clothes()
    EnableControlAction(0, 82, true)  
    EnableControlAction(0, 47, true)                  
    if IsControlJustPressed(0, 22) then
        local back2 = GetEntityHeading(GetPlayerPed(-1))
        SetEntityHeading(GetPlayerPed(-1), back2+90)      
    end
    if IsControlJustPressed(0, 82) then
        pressed = not pressed
        if pressed then
            RenderScriptCams(0, 1, 1000, 1, 1)
            DestroyAllCams(true)
        else
            CreateMain()
        end
    end
    if IsDisabledControlPressed(0, 23) then
        SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())-1.5)
    elseif IsDisabledControlPressed(0, 47) then
        SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())+1.5)
    end
end

function CreateMain()
	local coords = GetEntityCoords(GetPlayerPed(-1))
    cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', coords.x-1.75, coords.y, coords.z, 0.0, 0.0, 0.0, 70.0, true, true)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z)
    RenderScriptCams(1, 1, 1500, 1, 1)
    local hcam = GetEntityHeading(cam)
    SetEntityHeading(GetPlayerPed(-1), hcam+90)
end

function _PreviewBlip(pos, name, one, two)
	Citizen.CreateThread(function()
		if one == true then
			_blip = AddBlipForCoord(GetEntityCoords(PlayerPedId()).x+10.0, GetEntityCoords(PlayerPedId()).y+10.0, GetEntityCoords(PlayerPedId()).z)
			SetBlipSprite(_blip, BlipSprite)
			SetBlipScale (_blip, BlipScale)
			SetBlipColour(_blip, BlipColor)
			SetBlipAsShortRange(_blip, true)
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentSubstringPlayerName(name)
			EndTextCommandSetBlipName(_blip)
		end
		if two == true then 
			_blip2 = AddBlipForRadius(GetEntityCoords(PlayerPedId()).x+10.0, GetEntityCoords(PlayerPedId()).y+10.0, GetEntityCoords(PlayerPedId()).z, BlipScale2)
			SetBlipHighDetail(_blip2, true)
			SetBlipColour(_blip2, BlipColor2)
			SetBlipAlpha(_blip2, BlipOpacity)
		end
	end)
end

function edit__PreviewBlip(pos, name, one, two)
	Citizen.CreateThread(function()
		if one == true then
			edit__blip = AddBlipForCoord(GetEntityCoords(PlayerPedId()).x+10.0, GetEntityCoords(PlayerPedId()).y+10.0, GetEntityCoords(PlayerPedId()).z)
			SetBlipSprite(edit__blip, edit_BlipSprite)
			SetBlipScale (edit__blip, edit_BlipScale)
			SetBlipColour(edit__blip, edit_BlipColor)
			SetBlipAsShortRange(edit__blip, true)
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentSubstringPlayerName(name)
			EndTextCommandSetBlipName(edit__blip)
		end
		if two == true then 
			edit__blip2 = AddBlipForRadius(GetEntityCoords(PlayerPedId()).x+10.0, GetEntityCoords(PlayerPedId()).y+10.0, GetEntityCoords(PlayerPedId()).z, edit_BlipScale2)
			SetBlipHighDetail(edit__blip2, true)
			SetBlipColour(edit__blip2, edit_BlipColor2)
			SetBlipAlpha(edit__blip2, edit_BlipOpacity)
		end
	end)
end

function SpawnVehicle(vehicle, spawn)
	ESX.Game.SpawnVehicle(vehicle.model, {x = spawn.x, y = spawn.y, z = spawn.z}, spawn.w, function(xVehicle)
		ESX.Game.SetVehicleProperties(xVehicle, vehicle)
		SetVehRadioStation(xVehicle, "OFF")
		SetVehicleFixed(xVehicle)
		SetVehicleDeformationFixed(xVehicle)
		SetVehicleUndriveable(xVehicle, false)
		SetVehicleEngineOn(xVehicle, true, true)
		TaskWarpPedIntoVehicle(GetPlayerPed(-1), xVehicle, -1)
	end)
end

function ReturnVehicle(k, v)
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
        checkupvehicle(k, v, vehicleProps, vehicle)
	else
		ESX.ShowNotification("Aucun véhicule proche")
	end
    data_garage = {}
end

function checkupvehicle(k, v, vehiclex, target)
	for y,z in pairs(getData.Gang[k].garage_data) do
        if vehiclex.plate == z.props.plate and vehiclex.model == z.props.model and vehiclex.windowTint == z.props.windowTint and vehiclex.modTurbo == z.props.modTurbo and vehiclex.modSuspension == z.props.modSuspension and vehiclex.modXenon == z.props.modXenon and vehiclex.modTransmission == z.props.modTransmission and vehiclex.color1 == z.props.color1 and vehiclex.color2 == z.props.color2 then
            if z.count ~= -1 then  
                if z.count >= 0 then     
                    table.remove(data_garage, y)
                    table.insert(data_garage, y, {name = z.name, count = z.count + 1, plate = z.plate, props = z.props})
                    TriggerServerEvent("pGangBuilder:modifyGarage", v.id, data_garage)
					ESX.Game.DeleteVehicle(target)
					ESX.ShowNotification("Vous venez de ranger votre véhicule")
					Wait(200)
					getDataGang()
                    return
                end
            else
				ESX.Game.DeleteVehicle(target)
				ESX.ShowNotification("Vous venez de ranger votre véhicule")
				Wait(200)
				getDataGang()
                return
            end
        end
    end
	if v.pnj == "1" then
		table.insert(data_garage, {name = vehiclex.model, count = nil, plate = vehiclex.plate, props = vehiclex})
		TriggerServerEvent("pGangBuilder:modifyGarage", v.id, data_garage)
		ESX.Game.DeleteVehicle(target)
        ESX.ShowNotification("Vous venez de ranger votre véhicule")
        Wait(200)
        getDataGang()
	else
		ESX.ShowNotification("Ce garage n'accepte pas les véhicules de pnj")
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
    else Citizen.Wait(500) 
        blockinput = false 
        return nil
	end
end

function getMarkerItems(value, array)
    for k,v in pairs(array) do
        if v == value then
            return k
        end
    end
end

function getCoffreItems(value, array)
    for k,v in pairs(array) do
        if v.value == tonumber(value) then
            return k
        end
    end
end

function GetkTable(item)
    local i = 0
    for k,v in pairs(item) do
        i = i + 1
    end
    for k,v in pairs(item) do
        if k == i then
            return k
        end
    end
end

function GetValue(value)
    if value == true then
        return "Oui"
    else
        return "Non"
    end
end

function GetValueCount(value, count)
    if value == 1 then
        return "∞"
    else
        return count
    end
end

function startAnimAction(lib, anim)
	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, 1.0, -1, 49, 0, false, false, false)
		RemoveAnimDict(lib)
	end)
end

RegisterNetEvent('pGangBuilder:PutHandcuff')
AddEventHandler('pGangBuilder:PutHandcuff', function(playerheading, playercoords, playerlocation)
	playerPed = GetPlayerPed(-1)
	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) 
	SetPedCanPlayGestureAnims(playerPed, false)
	DisablePlayerFiring(playerPed, true)
	DisplayRadar(false)
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	Wait(500)
	SetEntityCoords(GetPlayerPed(-1), x, y, z)
	SetEntityHeading(GetPlayerPed(-1), playerheading)
	Wait(250)
	-- LoadAnimDict('mp_arrest_paired')
	-- TaskPlayAnim(GetPlayerPed(-1), 'mp_arrest_paired', 'crook_p2_back_right', 8.0, -8, 3750 , 2, 0, 0, 0, 0)
	Wait(3760)
	IsHandcuffed = true
	LoadAnimDict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
end)

RegisterNetEvent('pGangBuilder:AnimationHandcuff')
AddEventHandler('pGangBuilder:AnimationHandcuff', function()
	Wait(250)
	LoadAnimDict('mp_arrest_paired')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arrest_paired', 'cop_p2_back_right', 8.0, -8,3750, 2, 0, 0, 0, 0)
	Wait(3000)
end) 

RegisterNetEvent('pGangBuilder:PutHandcuffFreeze')
AddEventHandler('pGangBuilder:PutHandcuffFreeze', function(playerheading, playercoords, playerlocation)
	playerPed = GetPlayerPed(-1)
	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
	SetPedCanPlayGestureAnims(playerPed, false)
	DisablePlayerFiring(playerPed, true)
	DisplayRadar(false)
	local x, y, z   = table.unpack(playercoords + playerlocation)
	Wait(500)
	SetEntityCoords(GetPlayerPed(-1), x, y, z)
	SetEntityHeading(GetPlayerPed(-1), playerheading)
	Wait(250)
	-- LoadAnimDict('mp_arrest_paired')
	-- TaskPlayAnim(GetPlayerPed(-1), 'mp_arrest_paired', 'crook_p2_back_right', 8.0, -8, 3750 , 2, 0, 0, 0, 0)
	Wait(3760)
	IsHandcuffed = true
	LoadAnimDict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
    FreezeEntityPosition(playerPed, true)
end)

RegisterNetEvent('pGangBuilder:AnimationRemoveHandcuff')
AddEventHandler('pGangBuilder:AnimationRemoveHandcuff', function()
	Wait(250)
	LoadAnimDict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'a_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Wait(5500)
	ClearPedTasks(GetPlayerPed(-1))
end)

RegisterNetEvent('pGangBuilder:Escort')
AddEventHandler('pGangBuilder:Escort', function(copID)
	if not IsHandcuffed then
		return
	end
	DragStatus.IsDragged = not DragStatus.IsDragged
	DragStatus.CopId = tonumber(copID)
end)

Citizen.CreateThread(function()
	local playerPed
	local targetPed
	while true do
		Wait(1)
        if IsHandcuffed then
            playerPed = PlayerPedId()
			DisableControlAction(0, 1, true) 
			DisableControlAction(0, 2, true)
			DisableControlAction(0, 24, true) 
			DisableControlAction(0, 257, true) 
			DisableControlAction(0, 25, true) 
			DisableControlAction(0, 263, true) 
			DisableControlAction(0, 45, true) 
			DisableControlAction(0, 22, true)
			DisableControlAction(0, 44, true) 
			DisableControlAction(0, 37, true) 
			DisableControlAction(0, 23, true) 
			DisableControlAction(0, 288,  true) 
			DisableControlAction(0, 289, true)
			DisableControlAction(0, 170, true) 
			DisableControlAction(0, 167, true) 
			DisableControlAction(0, 0, true) 
			DisableControlAction(0, 26, true) 
			DisableControlAction(0, 73, true) 
			DisableControlAction(2, 199, true) 
			DisableControlAction(0, 59, true) 
			DisableControlAction(0, 71, true) 
			DisableControlAction(0, 72, true) 
			DisableControlAction(2, 36, true)
			DisableControlAction(0, 47, true) 
			DisableControlAction(0, 264, true) 
			DisableControlAction(0, 257, true) 
			DisableControlAction(0, 140, true) 
			DisableControlAction(0, 141, true) 
			DisableControlAction(0, 142, true) 
			DisableControlAction(0, 143, true) 
			DisableControlAction(0, 75, true)  
			DisableControlAction(27, 75, true) 
			if DragStatus.IsDragged then
				targetPed = GetPlayerPed(GetPlayerFromServerId(DragStatus.CopId))
				if not IsPedSittingInAnyVehicle(targetPed) then
					AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
				else
					DragStatus.IsDragged = false
					DetachEntity(playerPed, true, false)
				end
			else
				DetachEntity(playerPed, true, false)
			end
		else
			Wait(900)
		end
	end
end)

RegisterNetEvent('pGangBuilder:RemoveHandcuff')
AddEventHandler('pGangBuilder:RemoveHandcuff', function(playerheading, playercoords, playerlocation)
	local x, y, z   = table.unpack(playercoords + playerlocation)
	SetEntityCoords(GetPlayerPed(-1), x, y, z)
	FreezeEntityPosition(playerPed, false)
	SetEntityHeading(GetPlayerPed(-1), playerheading)
	SetPedCanPlayGestureAnims(playerPed, true)
	DisablePlayerFiring(playerPed, false)
	DisplayRadar(true)
	Wait(250)
	LoadAnimDict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'b_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Wait(5500)
	IsHandcuffed = false
	ClearPedTasks(GetPlayerPed(-1))
end)

RegisterNetEvent('pGangBuilder:putInVehicle')
AddEventHandler('pGangBuilder:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	if not IsHandcuffed then
		return
	end
	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		if DoesEntityExist(vehicle) then
			local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
			local freeSeat = nil
			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end
			if freeSeat ~= nil then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
				DragStatus.IsDragged = false
			end
		end
	end
end)

RegisterNetEvent('pGangBuilder:OutVehicle')
AddEventHandler('pGangBuilder:OutVehicle', function()
	local playerPed = PlayerPedId()
	if not IsPedSittingInAnyVehicle(playerPed) then
		return
	end
	local vehicle = GetVehiclePedIsIn(playerPed, false)
	TaskLeaveVehicle(playerPed, vehicle, 16)
end)

function LoadAnimDict(dictname)
	if not HasAnimDictLoaded(dictname) then
		RequestAnimDict(dictname) 
		while not HasAnimDictLoaded(dictname) do 
			Citizen.Wait(1)
		end
	end
end

function getDataBlips(value)
    if value == true then
        for k,v in pairs(getData.Gang) do
            if v.blips.name ~= "" or v.blips.pos ~= "" then
                SetBlip1 = AddBlipForCoord(v.blips.pos.x, v.blips.pos.y, v.blips.pos.z)
                SetBlipSprite(SetBlip1, v.blips.sprite)
                SetBlipScale (SetBlip1, v.blips.scale)
                SetBlipColour(SetBlip1, v.blips.color)
                SetBlipAsShortRange(SetBlip1, true)
                BeginTextCommandSetBlipName('STRING')
                AddTextComponentSubstringPlayerName(v.blips.name)
                EndTextCommandSetBlipName(SetBlip1)
                SetBlip2 = AddBlipForRadius(v.blips.pos.x, v.blips.pos.y, v.blips.pos.z, v.blips.scale2)
                SetBlipHighDetail(SetBlip2, true)
                SetBlipColour(SetBlip2, v.blips.color2)
                SetBlipAlpha(SetBlip2, v.blips.opacity)
            end
        end
    else
        RemoveBlip(SetBlip1)
        RemoveBlip(SetBlip2)
    end
end

Citizen.CreateThread(function()
    while not ESX.PlayerLoaded do 
        Citizen.Wait(100) 
        print("Load...")
    end
	getDataItems()
	getDataGang()
	Wait(500)
    getDataBlips(true)
    print("Active")
end)
