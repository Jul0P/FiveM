if Config.ActivateSlashtires then
	RegisterNetEvent('pBase:slashTargetClient')
	AddEventHandler('pBase:slashTargetClient', function(client, tireIndex)
		TriggerClientEvent("pBase:slashClientTire", client, tireIndex)
	end)
end