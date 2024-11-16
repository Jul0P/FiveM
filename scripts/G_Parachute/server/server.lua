ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('G_Parachute:buy', function(source, cb, price)
	local xPlayer = ESX.GetPlayerFromId(source) 
	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)
        xPlayer.addWeapon('GADGET_PARACHUTE', 42)
		TriggerClientEvent('esx:showNotification', source, "Vous venez d'acheter ~b~x1 parachute ~s~pour ~g~100$")
		cb(true)
		Wait(1000)
		xPlayer.removeWeapon('GADGET_PARACHUTE')
	else
		TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez d'argent")
		cb(false)
	end
end)