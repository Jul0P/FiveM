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

data_coffre = {}

function GetCoffre()
    ESX.TriggerServerCallback("G_TabacJob:getCoffreItem", function(data) 
        data_coffre = data
    end, ESX.PlayerData.job.name)
end

data_inventory = {}

function GetInventory()
    ESX.TriggerServerCallback("G_TabacJob:getInventoryItem", function(data) 
        data_inventory = data
    end)
end

function RefreshMoney()
    ESX.TriggerServerCallback("esx_society:getSocietyMoney", function(money) 
        SocietyAccount = ESX.Math.GroupDigits(money)
    end, ESX.PlayerData.job.name)
end

function entreprise()
    local model = GetEntityModel(GetPlayerPed(-1))
    TriggerEvent("skinchanger:getSkin", function(skin)
        if model == GetHashKey("mp_m_freemode_01") then
            clothesSkin = {
                ['tshirt_1'] = G_TabacJob.Tenue.male.tshirt_1, ['tshirt_2'] = G_TabacJob.Tenue.male.tshirt_2,
                ['torso_1'] = G_TabacJob.Tenue.male.torso_1, ['torso_2'] = G_TabacJob.Tenue.male.torso_2,
                ['decals_1'] = G_TabacJob.Tenue.male.decals_1, ['decals_2'] = G_TabacJob.Tenue.male.decals_2,
                ['chain_1'] = G_TabacJob.Tenue.male.chain_1, ['chain_2'] = G_TabacJob.Tenue.male.chain_2,
                ['arms'] = G_TabacJob.Tenue.male.arms,
                ['pants_1'] = G_TabacJob.Tenue.male.pants_1, ['pants_2'] = G_TabacJob.Tenue.male.pants_2,
                ['shoes_1'] = G_TabacJob.Tenue.male.shoes_1, ['shoes_2'] = G_TabacJob.Tenue.male.shoes_2,
                ['helmet_1'] = G_TabacJob.Tenue.male.helmet_1, ['helmet_2'] = G_TabacJob.Tenue.male.helmet_2
            }
        else
            clothesSkin = {
                ['tshirt_1'] = G_TabacJob.Tenue.female.tshirt_1, ['tshirt_2'] = G_TabacJob.Tenue.female.tshirt_2,
                ['torso_1'] = G_TabacJob.Tenue.female.torso_1, ['torso_2'] = G_TabacJob.Tenue.female.torso_2,
                ['decals_1'] = G_TabacJob.Tenue.female.decals_1, ['decals_2'] = G_TabacJob.Tenue.female.decals_2,
                ['chain_1'] = G_TabacJob.Tenue.female.chain_1, ['chain_2'] = G_TabacJob.Tenue.female.chain_2,
                ['arms'] = G_TabacJob.Tenue.female.arms,
                ['pants_1'] = G_TabacJob.Tenue.female.pants_1, ['pants_2'] = G_TabacJob.Tenue.female.pants_2,
                ['shoes_1'] = G_TabacJob.Tenue.female.shoes_1, ['shoes_2'] = G_TabacJob.Tenue.female.shoes_2,
                ['helmet_1'] = G_TabacJob.Tenue.female.helmet_1, ['helmet_2'] = G_TabacJob.Tenue.female.helmet_2
            }
        end
        TriggerEvent("skinchanger:loadClothes", skin, clothesSkin)
    end)
end

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(G_TabacJob.Blip.Pos.x, G_TabacJob.Blip.Pos.y, G_TabacJob.Blip.Pos.z)
    SetBlipSprite(blip, G_TabacJob.Blip.Sprite)
    SetBlipDisplay(blip, G_TabacJob.Blip.Display)
    SetBlipScale(blip, G_TabacJob.Blip.Scale)
    SetBlipColour(blip, G_TabacJob.Blip.Colour)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(G_TabacJob.Blip.Title)
    EndTextCommandSetBlipName(blip)
end)