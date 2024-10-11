if pAscenseurBuilder.ESX == "new" then
	ESX = exports["es_extended"]:getSharedObject()
elseif pAscenseurBuilder.ESX == "old" then
	ESX = nil
	Citizen.CreateThread(function()
		while ESX == nil do
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
			Citizen.Wait(0)
		end
	end)
end

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
    Ascenseur = {},
    Jobs = {},
    Users = {}
}

function getDataAscenseur()
    ESX.TriggerServerCallback("pAscenseurBuilder:getAscenseur", function(data)
        getData.Ascenseur = data
    end)    
end

function getDataJobs()
    ESX.TriggerServerCallback("pAscenseurBuilder:getDataJobs", function(data)
        getData.Jobs = data
    end)    
end

function getDataUsers()
    ESX.TriggerServerCallback("pAscenseurBuilder:getDataUsers", function(data)
        getData.Users = data
    end)    
end

function _PreviewBlip(name, one)
	Citizen.CreateThread(function()
		if one == true then
			_blip = AddBlipForCoord(GetEntityCoords(PlayerPedId()).x+10.0, GetEntityCoords(PlayerPedId()).y+10.0, GetEntityCoords(PlayerPedId()).z)
			SetBlipSprite(_blip, BlipSprite)
            SetBlipDisplay(_blip, 5)
			SetBlipScale (_blip, BlipScale)
			SetBlipColour(_blip, BlipColor)
			SetBlipAsShortRange(_blip, true)
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentSubstringPlayerName(name)
			EndTextCommandSetBlipName(_blip)
		end
	end)
end

function edit__PreviewBlip(name, one)
	Citizen.CreateThread(function()
		if one == true then
			edit__blip = AddBlipForCoord(GetEntityCoords(PlayerPedId()).x+10.0, GetEntityCoords(PlayerPedId()).y+10.0, GetEntityCoords(PlayerPedId()).z)
			SetBlipSprite(edit__blip, edit_BlipSprite)
            SetBlipDisplay(edit__blip, 5)
			SetBlipScale (edit__blip, edit_BlipScale)
			SetBlipColour(edit__blip, edit_BlipColor)
			SetBlipAsShortRange(edit__blip, true)
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentSubstringPlayerName(name)
			EndTextCommandSetBlipName(edit__blip)
		end
	end)
end

function getMarkerItems(value, array)
    for k,v in pairs(array) do
        if v == value then
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

function getDataBlips(value)
    if value == true then
        for k,v in pairs(getData.Ascenseur) do
            if v.blips_data.name ~= "" then
                for y,z in pairs(v.teleport_data) do 
                    SetBlip1 = AddBlipForCoord(z.coords.x, z.coords.y, z.coords.z)
                    SetBlipSprite(SetBlip1, v.blips_data.sprite)
                    SetBlipDisplay(SetBlip1, 5)
                    SetBlipScale (SetBlip1, v.blips_data.scale)
                    SetBlipColour(SetBlip1, v.blips_data.color)
                    SetBlipAsShortRange(SetBlip1, true)
                    BeginTextCommandSetBlipName('STRING')
                    AddTextComponentSubstringPlayerName(v.blips_data.name.." ("..z.label..")")
                    EndTextCommandSetBlipName(SetBlip1)
                end
            end
        end
    else
        RemoveBlip(SetBlip1)
    end
end

Citizen.CreateThread(function()
    while not ESX.PlayerLoaded do 
        Citizen.Wait(100) 
        print("Load...")
    end
    getDataUsers()
    getDataJobs()
	getDataAscenseur()
	Wait(500)
    getDataBlips(true)
    print("Active")
end)