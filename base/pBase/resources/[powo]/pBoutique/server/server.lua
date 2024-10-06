if pBoutique.ESX == "new" then
	ESX = exports["es_extended"]:getSharedObject()
elseif pBoutique.ESX == "old" then
	ESX = nil
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

RegisterServerEvent("pBoutique:BuyVehicle")
AddEventHandler("pBoutique:BuyVehicle", function(v)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.single('SELECT pcoin FROM users WHERE identifier = ?', {xPlayer.identifier}, function(result)
        if result.pcoin then
            if tonumber(result.pcoin) >= v.price then            
                
            end
        end
    end)
end)