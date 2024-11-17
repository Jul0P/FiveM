function Alert(title, message, time, type)
	SendNUIMessage({action = 'open',title = title,type = type,message = message,time = time,})
end

RegisterNetEvent('G_notif:Alert')
AddEventHandler('G_notif:Alert', function(title, message, time, type)
	Alert(title, message, time, type)
end)

-- bleu
RegisterCommand('notif', function()
	exports['G_notif']:Alert("Jour de paye", "Votre salaire de <span style='color:#47cf73'>20$</span> vient d'être perçu, le virement a été effectué sur votre <span style='color:#2f83ff'>compte bancaire</span>.", 5000, 'notif') 
end)

-- rouge
RegisterCommand('notif2', function()
	exports['G_notif']:Alert("Intéraction", "Votre paiement a été <span style='color:#dc3545'>refusé</span>", 5000, 'notif2')
end)

-- vert
RegisterCommand('notif3', function()
	exports['G_notif']:Alert("Intéraction", "Votre paiement a été effectué avec <span style='color:#47cf73'>succès</span>", 5000, 'notif3')
end)
