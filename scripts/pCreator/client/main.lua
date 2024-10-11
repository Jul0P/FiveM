if Config.ESX == "new" then
	ESX = exports["es_extended"]:getSharedObject()
elseif Config.ESX == "old" then
	ESX = nil
	Citizen.CreateThread(function()
		while ESX == nil do
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
			Citizen.Wait(0)
		end
	end)
end

RegisterNetEvent('esx:playerLoaded')
RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:playerLoaded', function(xPlayer) ESX.PlayerData = xPlayer ESX.PlayerLoaded = true end)
AddEventHandler('esx:onPlayerLogout', function() ESX.PlayerLoaded = false ESX.PlayerData = {} end)

AddEventHandler('playerSpawned', function()
    Citizen.CreateThread(function()
        while not ESX.PlayerLoaded do Citizen.Wait(100) end
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
            if skin == nil then
                TriggerEvent('skinchanger:loadSkin', {sex = 0})
                Citizen.Wait(50)
                SublimeIndex.StartCharacterCreator()
            else
                TriggerEvent('skinchanger:loadSkin', skin)
                Wait(50)
                SublimeIndex.ReLoadSkin() --> Reload le skin ( en cas de bug )
            end
        end)
    end)
end)

function SublimeIndex.ReLoadSkin()
    Wait(1000)
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
end

function SetPlayerBuckets(val)
    TriggerServerEvent("pCreator:Buckets", val)
end

function SublimeIndex.StartCharacterCreator()
    DoScreenFadeOut(1)
    SublimeIndex.SetPlayerNaked()
    SetPlayerBuckets(true)
    SublimeIndex.CamsCharacterCreator()
    if Config.DisplayRadar then
        DisplayRadar(false)
    end
    TriggerEvent('instance:create', 'creator', {identifier = ESX.PlayerData.identifier})
    ESX.Game.Teleport(PlayerPedId(), {x = Config.FirstSpawn.x, y = Config.FirstSpawn.y, z = Config.FirstSpawn.z, heading = Config.FirstSpawn.h}, function()
        SublimeIndex.PlayAnimCharacterCreator()
    end)
    Citizen.Wait(2500)
    DoScreenFadeIn(5800)
    SublimeIndex.OpenIdentityCreator()
    SublimeIndex.PlayAnimCharacterCreator()
end

function SublimeIndex.EndCharacterCreator()
    DoScreenFadeOut(1500)
    Citizen.Wait(1500)
    DoScreenFadeIn(1500)
    ClearPedTasks(PlayerPedId())
    TriggerEvent('introCinematic:start')
end

function SublimeIndex.OnRenderCharacter()
    if IsControlJustPressed(0, Config.KeyCam.Default) then 
        SublimeIndex.CamsCharacterCreator()
    elseif IsControlJustPressed(0, Config.KeyCam.Head) then 
        SublimeIndex.CamsCharacterCreator_Head()
    elseif IsControlJustPressed(0, Config.KeyCam.Torso) then
        SublimeIndex.CamsCharacterCreator_Torso()
    elseif IsControlJustPressed(0, Config.KeyCam.Pant) then
        SublimeIndex.CamsCharacterCreator_Pants()
    elseif IsControlJustPressed(0, Config.KeyCam.Shoes) then
        SublimeIndex.CamsCharacterCreator_Shoes()
    end
end

function SublimeIndex.SetPlayerNaked()
    TriggerEvent('skinchanger:getSkin', function(skin)
        if skin.sex == 0 then
            TriggerEvent('skinchanger:loadClothes', skin, Config.Naked.Male)
        else
            TriggerEvent('skinchanger:loadClothes', skin, Config.Naked.Female)
        end
    end)
end

function SublimeIndex.ChangeSexeCreator(sexe)
    Citizen.CreateThread(function()
        TriggerEvent('skinchanger:getSkin', function(skin)
            if sexe == "Homme" then
                TriggerEvent('skinchanger:change', 'sex', 0)
                Citizen.Wait(100)
                SublimeIndex.SetPlayerNaked()
            else sexe = "Femme"
                TriggerEvent('skinchanger:change', 'sex', 1)
                Citizen.Wait(100)
                SublimeIndex.SetPlayerNaked()
            end
        end)
        Citizen.Wait(100)
        SublimeIndex.PlayAnimCharacterCreator()
    end)
end

function SublimeIndex.IsIdentityValid(String, Type)
    if Type == "Name" then
        if string.len(String) >= 3 then
            return true
        else
            ESX.ShowNotification("~r~Nom ou Prénom trop court")
        end
    elseif Type == "Date" then
        local str = tostring(String)
        if string.match(str, '(%d%d)/(%d%d)/(%d%d%d%d)') ~= nil then
            local d, m, y = string.match(str, '(%d+)/(%d+)/(%d+)')
            d = tonumber(d)
            m = tonumber(m)
            y = tonumber(y)
            if ((d > 0) and (d <= 31)) then
                if ((m > 0) and (m <= 12)) then
                    if ((y > 1920) and (y < 2015)) then
                        return true
                    else
                        ESX.ShowNotification("~r~Année Invalide")
                    end
                else
                    ESX.ShowNotification("~r~Mois Invalide")
                end
            else
                ESX.ShowNotification("~r~Jour Invalide")
            end
        else
            ESX.ShowNotification("~r~Date de naissance invalide")
        end
    end
end