if Config.getSharedObject == "last" then
	ESX = exports["es_extended"]:getSharedObject()
elseif Config.getSharedObject == "old" then
	ESX = nil
	TriggerEvent('esx:getSharedObject', function(obj) 
		ESX = obj
	end)
end

ESX.RegisterServerCallback('p2p_TattooShop:GetPlayerTattoos', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		MySQL.Async.fetchAll('SELECT tattoos FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		}, function(result)
			if result[1].tattoos then
				cb(json.decode(result[1].tattoos))
			else
				cb()
			end
		end)
	else
		cb()
	end
end)

ESX.RegisterServerCallback('p2p_TattooShop:PurchaseTattoo', function(source, cb, tattooList, price, tattoo, tattooName)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)
		table.insert(tattooList, tattoo)
		MySQL.Async.execute('UPDATE users SET tattoos = @tattoos WHERE identifier = @identifier', {
			['@tattoos'] = json.encode(tattooList),
			['@identifier'] = xPlayer.identifier
		})
		TriggerClientEvent('esx:showNotification', source, Config.Translate('purchase_success', tattooName, price))
		cb(true)
	else
		TriggerClientEvent('esx:showNotification', source, Config.Translate('pruchase_error'))
		cb(false)
	end
end)

RegisterServerEvent('p2p_TattooShop:RemoveTattoo')
AddEventHandler('p2p_TattooShop:RemoveTattoo', function(tattooList)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.execute('UPDATE users SET tattoos = @tattoos WHERE identifier = @identifier', {
		['@tattoos'] = json.encode(tattooList),
		['@identifier'] = xPlayer.identifier
	})
end)