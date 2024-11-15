ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('esx_phone:registerNumber', 'police', 'alerte police', true, true)
TriggerEvent('esx_society:registerSociety', 'police', 'Police', 'society_police', 'society_police', 'society_police', {type = 'public'})

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_phone:removeNumber', 'police')
	end
end)

ESX.RegisterServerCallback('G_policejob:getOtherPlayerData', function(source, cb, target, notify)
	local xPlayer = ESX.GetPlayerFromId(target)
	if notify then
		xPlayer.showNotification('being_searched')
	end
	if xPlayer then
		local data = {
			name = xPlayer.getName(),
			job = xPlayer.job.label,
			grade = xPlayer.job.grade_label,
			inventory = xPlayer.getInventory(),
			accounts = xPlayer.getAccounts(),
			weapons = xPlayer.getLoadout()
		}
			data.dob = xPlayer.get('dateofbirth')
			data.height = xPlayer.get('height')
			if xPlayer.get('sex') == 'm' then data.sex = 'male' else data.sex = 'female' end
		TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
			if status then
				data.drunk = ESX.Math.Round(status.percent)
			end
		end)
		cb(data)
	end
end)

RegisterNetEvent('G_policejob:confiscatePlayerItem')
AddEventHandler('G_policejob:confiscatePlayerItem', function(target, itemType, itemName, amount)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	if itemType == 'item_standard' then
		local targetItem = targetXPlayer.getInventoryItem(itemName)
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)
		if targetItem.count < amount then
			TriggerClientEvent("esx:showNotification", source, "Quantité Invalide")
		else
			targetXPlayer.removeInventoryItem(itemName, amount)
			sourceXPlayer.addInventoryItem(itemName, amount)
            TriggerClientEvent("esx:showNotification", source, "Vous avez confisqué ~b~x"..amount.." "..sourceItem.label.."")
            TriggerClientEvent("esx:showNotification", target, "L'agent vous à pris ~b~x"..amount.." "..sourceItem.label.."")
		end
	elseif itemType == 'item_account' then
		local targetAccount = targetXPlayer.getAccount(itemName)
		if targetAccount.money < amount then
			TriggerClientEvent("esx:showNotification", source, "Montant Invalide")
		else
			targetXPlayer.removeAccountMoney(itemName, amount)
			sourceXPlayer.addAccountMoney(itemName, amount)
			TriggerClientEvent("esx:showNotification", source, "Vous avez confisqué ~g~"..amount.."$")
			TriggerClientEvent("esx:showNotification", target, "L'agent vous à pris ~g~"..amount.."$")
		end
	elseif itemType == 'item_weapon' then
		if amount == nil then amount = 0 end
		if targetXPlayer.hasWeapon(itemName) then
			targetXPlayer.removeWeapon(itemName, amount)
			sourceXPlayer.addWeapon(itemName, amount)
            TriggerClientEvent("esx:showNotification", source, "Vous avez confisqué ~b~x"..amount.." "..ESX.GetWeaponLabel(itemName).."")
            TriggerClientEvent("esx:showNotification", target, "L'agent vous à pris ~b~x"..amount.." "..ESX.GetWeaponLabel(itemName).."")
		else
			TriggerClientEvent("esx:showNotification", source, "Quantité Invalide")
		end
	end
end)

RegisterServerEvent('G_policejob:drag')
AddEventHandler('G_policejob:drag', function(target)
  local _source = source
  TriggerClientEvent('G_policejob:drag', target, _source)
end)

RegisterServerEvent('G_policejob:handcuff')
AddEventHandler('G_policejob:handcuff', function(target)
  TriggerClientEvent('G_policejob:handcuff', target)
end)

RegisterServerEvent('G_policejob:putInVehicle')
AddEventHandler('G_policejob:putInVehicle', function(target)
  TriggerClientEvent('G_policejob:putInVehicle', target)
end)

RegisterServerEvent('G_policejob:OutVehicle')
AddEventHandler('G_policejob:OutVehicle', function(target)
    TriggerClientEvent('G_policejob:OutVehicle', target)
end)

ESX.RegisterServerCallback('G_policejob:getVehicleInfos', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT owner, vehicle FROM owned_vehicles WHERE plate = @plate', {['@plate'] = plate}, function(result)
		local retrivedInfo = {plate = plate}
		if result[1] then
			MySQL.Async.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier',  {['@identifier'] = result[1].owner}, function(result2)
				retrivedInfo.owner = result2[1].firstname .. ' ' .. result2[1].lastname
				cb(retrivedInfo)
			end)
		else
			cb(retrivedInfo)
		end
	end)
end)

RegisterServerEvent('G_policejob:PriseEtFinservice')
AddEventHandler('G_policejob:PriseEtFinservice', function(PriseOuFin)
	local _source = source
	local _raison = PriseOuFin
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()
	local name = xPlayer.getName(_source)
	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'police' then
			TriggerClientEvent('G_policejob:InfoService', xPlayers[i], _raison, name)
		end
	end
end)

RegisterServerEvent('renfort')
AddEventHandler('renfort', function(coords, raison)
	local _source = source
	local _raison = raison
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()
	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'police' then
			TriggerClientEvent('renfort:setBlip', xPlayers[i], coords, _raison)
		end
	end
end)

RegisterServerEvent('police:armurerie')
AddEventHandler('police:armurerie', function(label)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addWeapon(label, 200)
end)

ESX.RegisterServerCallback('police:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterNetEvent('police:getStockItem')
AddEventHandler('police:getStockItem', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)
		local inventoryItem = inventory.getItem(itemName)
		if count == nil then	
			TriggerClientEvent('esx:showNotification', source, "Quantité invalide")
		else
			if count > 0 and inventoryItem.count >= count then
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', source, "Vous avez retiré ~b~x"..count.."~s~ "..inventoryItem.label.."")
			else
				TriggerClientEvent('esx:showNotification', source, "Quantité invalide")
			end
		end
	end)
end)

ESX.RegisterServerCallback('police:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory
	cb({items = items})
end)

RegisterNetEvent('police:putStockItems')
AddEventHandler('police:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)
		local inventoryItem = inventory.getItem(itemName)
		if count == nil then	
			TriggerClientEvent('esx:showNotification', source, "Quantité invalide")
		else
			if sourceItem.count >= count and count > 0 then
				xPlayer.removeInventoryItem(itemName, count)
				inventory.addItem(itemName, count)
				TriggerClientEvent('esx:showNotification', source, "Vous avez déposé ~b~x"..count.."~s~ "..inventoryItem.label.."")
			else
				TriggerClientEvent('esx:showNotification', source, "Quantité invalide")
			end
		end	
	end)
end)

RegisterNetEvent("police:appel")
AddEventHandler("police:appel", function()
	local xPlayers = ESX.GetPlayers()
	for i = 1, #xPlayers, 1 do
		local target = ESX.GetPlayerFromId(xPlayers[i])
		if target.job.name == 'police' then
			TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], "Appel Police", nil, "Une personne vient de faire un appel au commissariat, un agent est demandé à l'accueil", "CHAR_CALL911", 8)
		end
	end
end)

RegisterNetEvent("police:appelembed")
AddEventHandler("police:appelembed", function(nom, prenom, tel, dis, rai)
	local webhooks = "https://discord.com/api/webhooks/920277693843537920/8YSjLLiLBgf-8InkijTUsmNp1zQk-86GObts-Svi-T3p3K3lHcQ3OzxQHBW2XemsUqjb"
	PerformHttpRequest(webhooks, function(err, text, headers) end, 'POST', json.encode({embeds={{title="Rendez-vous / LSPD",description="**Nom : **``"..nom.."``\n\n**Prénom : **``"..prenom.."``\n\n**Numéro de Téléphone : **``"..tel.."``\n\n**Disponibilité : **``"..dis.."``\n\n**Raison : **``"..rai.."``",color= 3447003}}}), { ['Content-Type'] = 'application/json' })
end)

RegisterNetEvent("police:plainte")
AddEventHandler("police:plainte", function(np, ptel, motif)
	local webhooks = "https://discord.com/api/webhooks/920277693843537920/8YSjLLiLBgf-8InkijTUsmNp1zQk-86GObts-Svi-T3p3K3lHcQ3OzxQHBW2XemsUqjb"
	PerformHttpRequest(webhooks, function(err, text, headers) end, 'POST', json.encode({embeds={{title="Plainte / LSPD",description="**Nom & Prénom : **``"..np.."``\n\n**Numéro de Téléphone : **``"..ptel.."``\n\n**Motif : **``"..motif.."``",color= 3447003}}}), { ['Content-Type'] = 'application/json' })
end)

ESX.RegisterServerCallback('G_policejob:GetCJ', function (source, cb)
	MySQL.Async.fetchAll('SELECT g_police_casier.id, g_police_casier.nomprenom, g_police_casier.montant, g_police_casier.raison, g_police_casier.ownerfolder, g_police_casier.status FROM g_police_casier WHERE g_police_casier.status = "Ouvert" ORDER BY id ASC', {}, function(result)
		local data = {}
		for i=1, #result, 1 do
			table.insert(data, {
				identifier = result[i].id,
				nomprenom = result[i].nomprenom,
				montant = result[i].montant,
				raison = result[i].raison,
				ownerfolder = result[i].ownerfolder,
				status = result[i].status
			})
		end
		cb(data)
	end)
end)

RegisterServerEvent('G_policejob:InsertCJ')
AddEventHandler('G_policejob:InsertCJ', function (montant, raison, nomprenom, ownerfolder)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.execute('INSERT INTO g_police_casier(g_police_casier.nomprenom, g_police_casier.montant, g_police_casier.raison, g_police_casier.ownerfolder, g_police_casier.status) VALUES(@nomprenom, @montant, @raison, @ownerfolder, "Ouvert");', 
	{
		['@montant'] = montant,
		['@raison'] = raison,
		['@nomprenom'] = nomprenom,
		['@ownerfolder'] = ownerfolder,
	},
	function()
	end)
	TriggerClientEvent('esx:showNotification', xPlayer.source, "Création de Casier\n- de : ~b~"..nomprenom.."~s~\n- Amende Total : ~g~"..montant.."$~s~\n- Raison : ~o~"..raison.."")
end)

RegisterServerEvent('G_policejob:changemontant')
AddEventHandler('G_policejob:changemontant', function(ID, mont2)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.execute('UPDATE g_police_casier set g_police_casier.montant = @montant WHERE g_police_casier.id = @ID', {['@ID'] = ID, ['@montant'] = mont2}, function() end)
	TriggerClientEvent('esx:showNotification', xPlayer.source, "Le montant du casier judiciaire a été modifié à : ~g~" .. mont2 .. "$")
end)

RegisterServerEvent('G_policejob:changeraison')
AddEventHandler('G_policejob:changeraison', function(ID, rais)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.execute('UPDATE g_police_casier set g_police_casier.raison = @raison WHERE g_police_casier.id = @ID', {['@ID'] = ID, ['@raison'] = rais}, function() end)
	TriggerClientEvent('esx:showNotification', xPlayer.source, "Les raisons du casier judiciaire ont bien été modifiées")
end)

RegisterServerEvent('G_policejob:closcasier')
AddEventHandler('G_policejob:closcasier', function(ID)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.execute('UPDATE g_police_casier set g_police_casier.status = "Clos" WHERE g_police_casier.id = @ID', {['@ID'] = ID}, function() end)
	TriggerClientEvent('esx:showNotification', xPlayer.source, "Casier Judiciaire ~g~ré-ouvert~s~")
end)

ESX.RegisterServerCallback('G_policejob:GetCJF', function (source, cb)
	MySQL.Async.fetchAll('SELECT g_police_casier.id, g_police_casier.nomprenom, g_police_casier.montant, g_police_casier.raison, g_police_casier.ownerfolder, g_police_casier.status FROM g_police_casier WHERE g_police_casier.status = "Clos" ORDER BY id ASC', {}, function(result)
		local data2 = {}
		for i=1, #result, 1 do
			table.insert(data2, {
				identifier = result[i].id,
				nomprenom = result[i].nomprenom,
				montant = result[i].montant,
				raison = result[i].raison,
				ownerfolder = result[i].ownerfolder,
				status = result[i].status
			})
		end
		cb(data2)
	end)
end)

RegisterServerEvent('G_policejob:opencasier')
AddEventHandler('G_policejob:opencasier', function(ID)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.execute('UPDATE g_police_casier set g_police_casier.status = "Ouvert" WHERE g_police_casier.id = @ID', {['@ID'] = ID}, function() end)
	TriggerClientEvent('esx:showNotification', xPlayer.source, "Casier Judiciaire ~g~ré-ouvert~s~")
end)