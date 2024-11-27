ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(5000)
	end
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
    ESX.PlayerData.job = job
end)

local open = false

RegisterNetEvent('G_jsfour-idcard:open')
AddEventHandler('G_jsfour-idcard:open', function(data, type)
	open = true
	SendNUIMessage({
		action = "open",
		array  = data,
		type   = type
	})
end)

RegisterKeyMapping("jsfouridcardclose", "Ranger la carte d'identité", "keyboard", "ESCAPE")
RegisterKeyMapping("jsfouridcardclose2", "Ranger la carte d'identité 2", "keyboard", "BACK")
RegisterCommand('jsfouridcardclose', function()
	SendNUIMessage({
		action = "close"
	})
	open = false
end, false)
RegisterCommand('jsfouridcardclose2', function()
	SendNUIMessage({
		action = "close"
	})
	open = false
end, false)

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(G_DrivingSchool.Blip.Pos.x, G_DrivingSchool.Blip.Pos.y, G_DrivingSchool.Blip.Pos.z)
    SetBlipSprite(blip, G_DrivingSchool.Blip.Sprite)
    SetBlipDisplay(blip, G_DrivingSchool.Blip.Display)
    SetBlipScale(blip, G_DrivingSchool.Blip.Scale)
    SetBlipColour(blip, G_DrivingSchool.Blip.Colour)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(G_DrivingSchool.Blip.Title)
    EndTextCommandSetBlipName(blip)
end)

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

Citizen.CreateThread(function()
    local hash = GetHashKey(G_DrivingSchool.Ped.Hash)
    while not HasModelLoaded(hash) do
        RequestModel(hash)
        Wait(20)
	end
	ped = CreatePed(G_DrivingSchool.Ped.Type, G_DrivingSchool.Ped.Hash, G_DrivingSchool.Ped.Coords.x, G_DrivingSchool.Ped.Coords.y, G_DrivingSchool.Ped.Coords.z, G_DrivingSchool.Ped.Coords.w, false, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
end)

data_coffre = {}

function GetCoffre()
    ESX.TriggerServerCallback("G_DrivingSchoolJob:getCoffreItem", function(data) 
        data_coffre = data
    end, ESX.PlayerData.job.name)
end

data_inventory = {}

function GetInventory()
    ESX.TriggerServerCallback("G_DrivingSchoolJob:getInventoryItem", function(data) 
        data_inventory = data
    end)
end

function RefreshMoney()
    ESX.TriggerServerCallback("esx_society:getSocietyMoney", function(money) 
        SocietyAccount = ESX.Math.GroupDigits(money)
    end, ESX.PlayerData.job.name)
end

data_grade = {}

function RefreshGrade()
    ESX.TriggerServerCallback("G_DrivingSchoolJob:getSocietyGrade", function(data)
        data_grade = data
    end, ESX.PlayerData.job.name)
end

data_licenses = {}

function getDataLicense()
    ESX.TriggerServerCallback("G_DrivingSchool:getLicense", function(data)
        data_licenses = data
    end)
end

data_users = {}

function getDataUser()
    ESX.TriggerServerCallback("G_DrivingSchool:getUser", function(data)
        data_users = data
    end)
end

RegisterCommand("coords", function()
    print(GetEntityCoords(PlayerPedId()))
    print( GetEntityHeading(PlayerPedId()))
end)