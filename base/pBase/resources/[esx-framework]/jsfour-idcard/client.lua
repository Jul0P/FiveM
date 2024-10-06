local open = false

RegisterNetEvent('jsfour-idcard:open')
AddEventHandler('jsfour-idcard:open', function( data, type )
	open = false
	SendNUIMessage({
		action = "open",
		array  = data,
		type   = type
	})
	Wait(100)
	TriggerEvent("pF5:GetJsFour-IdCard", open)
end)

RegisterCommand('jsfouridcardclose', function()
	open = true
	SendNUIMessage({
		action = "close"
	})
	Wait(100)
	TriggerEvent("pF5:GetJsFour-IdCard", open)
end, false)

RegisterKeyMapping("jsfouridcardclose", "Ranger la carte d'identité", "keyboard", "BACK")