ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(5000)
	end
end)

function VerifyLicense()
    ESX.TriggerServerCallback('G_AmmunationShop:checkLicense', function(cb)            
        if cb then
            ppa = true 
        else 
            ppa = false   
        end
    end) 
    ESX.TriggerServerCallback('G_AmmunationShop:checkLicense2', function(cb2)            
        if cb2 then
            chasse = true 
        else 
            chasse = false   
        end
    end)
end

Citizen.CreateThread(function()
    for k,v in pairs(G_AmmunationShop.Coords) do
        local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, 110)
		SetBlipScale (blip, 0.5)
		SetBlipColour(blip, 1)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName('Armurerie')
		EndTextCommandSetBlipName(blip)
    end
end)

Citizen.CreateThread(function()
    local hash = GetHashKey("s_m_y_ammucity_01")
    while not HasModelLoaded(hash) do
        RequestModel(hash)
        Wait(20)
	end
	for k,v in pairs(G_AmmunationShop.Vendeur) do
        ped = CreatePed("PED_TYPE_CIVMALE", "s_m_y_ammucity_01", v.x, v.y, v.z, v.a, false, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
	end
end)