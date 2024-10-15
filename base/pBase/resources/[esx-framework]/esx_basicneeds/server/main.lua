CreateThread(function()
	for k,v in pairs(Config.Items) do
		ESX.RegisterUsableItem(k, function(source)
			local xPlayer = ESX.GetPlayerFromId(source)
			if v.remove then
				xPlayer.removeInventoryItem(k,1)
			end
			if v.type == "food" then
				TriggerClientEvent("esx_status:add", source, "hunger", v.status)
				TriggerClientEvent('esx_basicneeds:onUse', source, v.type)
				xPlayer.showNotification(TranslateCap('used_food', ESX.GetItemLabel(k)))
			elseif v.type == "drink" then
				TriggerClientEvent("esx_status:add", source, "thirst", v.status)
				TriggerClientEvent('esx_basicneeds:onUse', source, v.type)
				xPlayer.showNotification(TranslateCap('used_drink', ESX.GetItemLabel(k)))
			elseif v.type == "drunk" then
				TriggerClientEvent("esx_status:add", source, "drunk", v.status)
				TriggerClientEvent('esx_basicneeds:onUse', source, v.type)
				xPlayer.showNotification(TranslateCap('used_drunk', ESX.GetItemLabel(k)))
			else
				print(string.format('^1[ERROR]^0 %s has no correct type defined.', k))
			end
		end)
	end 
end)

ESX.RegisterCommand('heal', 'admin', function(xPlayer, args, showError)
	if args.playerId then
		args.playerId.triggerEvent('esx_basicneeds:healPlayer')
		args.playerId.showNotification(TranslateCap('got_healed'))
	else
		xPlayer.triggerEvent('esx_basicneeds:healPlayer')
		xPlayer.showNotification(TranslateCap('got_healed'))
	end
end, true, {help = 'Heal a player, or yourself - restores thirst, hunger and health.', validate = false, arguments = {
	{name = 'playerId', help = 'the player id', type = 'player'}
}})

AddEventHandler('txAdmin:events:healedPlayer', function(eventData)
	if GetInvokingResource() ~= "monitor" or type(eventData) ~= "table" or type(eventData.id) ~= "number" then
		return
	end

	TriggerClientEvent('esx_basicneeds:healPlayer', eventData.id)
end)
