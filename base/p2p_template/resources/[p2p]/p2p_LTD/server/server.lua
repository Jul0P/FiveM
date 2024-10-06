if Config.getSharedObject == "last" then
	ESX = exports["es_extended"]:getSharedObject()
elseif Config.getSharedObject == "old" then
	ESX = nil
	TriggerEvent('esx:getSharedObject', function(obj) 
		ESX = obj 
	end)
end

ESX.RegisterServerCallback('p2p_LTD:buy', function(source, cb, arrayBasket, indexLTD, indexPaiement, price)
	local xPlayer = ESX.GetPlayerFromId(source)
	if indexPaiement == 1 then
    	local xMoney = xPlayer.getMoney()
		if xMoney >= price then
			for k,v in pairs(arrayBasket) do
				if v.ltd == Config.LTD[indexLTD].label then
					xPlayer.addInventoryItem(v.name, v.count)
				end
			end
			xPlayer.removeMoney(price)
			TriggerClientEvent('esx:showNotification', source, Config.Translate('notif_buy', "~g~"..price))
			cb(true)
		else
			TriggerClientEvent('esx:showNotification', source, Config.Translate('notif_nomoney'))
			cb(false)
		end
	elseif indexPaiement == 2 then
		local xMoney = xPlayer.getAccount('bank').money
		if xMoney >= price then
			for k,v in pairs(arrayBasket) do
				if v.ltd == Config.LTD[indexLTD].label then
					xPlayer.addInventoryItem(v.name, v.count)
				end
			end
			xPlayer.removeAccountMoney('bank', price)
			TriggerClientEvent('esx:showNotification', source, Config.Translate('notif_buy', "~b~"..price))
			cb(true)
		else
			TriggerClientEvent('esx:showNotification', source, Config.Translate('notif_nomoney'))
			cb(false)
		end
	end
end)