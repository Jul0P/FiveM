ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('esx_phone:registerNumber', 'banquier', 'alerte banquier', true, true)
TriggerEvent('esx_society:registerSociety', 'banquier', 'banquier', 'society_banquier', 'society_banquier', 'society_banquier', {type = 'public'})

RegisterServerEvent('open:banquier')
AddEventHandler('open:banquier', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Banquier', 'Annonce', 'La banque est ~g~ouverte~s~, un banquier est actuellement disponible.', 'CHAR_BANK_FLEECA', 9)
    end
end)

RegisterServerEvent('close:banquier')
AddEventHandler('close:banquier', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Banquier', 'Annonce', 'La banque est ~r~fermé~s~, aucun banquier n\'est disponible.', 'CHAR_BANK_FLEECA', 9)
	end
end) 

RegisterServerEvent('esx_banquierjob:getStockItem')
AddEventHandler('esx_banquierjob:getStockItem', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_banquier', function(inventory)
		local item = inventory.getItem(itemName)
		if count > 0 and item.count >= count then inventory.removeItem(itemName, count) xPlayer.addInventoryItem(itemName, count)
			TriggerClientEvent('esx:showNotification', source, "Vous avez retiré x~g~"..count.."~s~ "..item.label.."")
        else TriggerClientEvent('esx:showNotification', source, "quantité invalide")
		end
	end)
end)

ESX.RegisterServerCallback('esx_banquierjob:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_banquier', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterServerEvent('esx_banquierjob:putStockItems')
AddEventHandler('esx_banquierjob:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_banquier', function(inventory)
		local item = inventory.getItem(itemName)
		local playerItemCount = xPlayer.getInventoryItem(itemName).count
		if item.count >= 0 and count <= playerItemCount then xPlayer.removeInventoryItem(itemName, count) inventory.addItem(itemName, count)
        else TriggerClientEvent('esx:showNotification', source, "quantité invalide")
		end
		TriggerClientEvent('esx:showNotification', source, "Vous avez déposé ~g~x"..count.."~s~ "..item.label.."")
	end)
end)

ESX.RegisterServerCallback('esx_banquierjob:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items = xPlayer.inventory
	cb({items = items})
end)

RegisterNetEvent("G_Banquier:appel")
AddEventHandler("G_Banquier:appel", function()
	local xPlayers = ESX.GetPlayers()
	for i = 1, #xPlayers, 1 do
		local target = ESX.GetPlayerFromId(xPlayers[i])
		if target.job.name == 'banquier' then
			TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], "Appel Banquier", nil, "Une personne vient de faire un appel, un banquier est demandé à l'accueil", "CHAR_BANK_FLEECA", 9)
		end
	end
end)

RegisterNetEvent("G_Banquier:appelembed")
AddEventHandler("G_Banquier:appelembed", function(np, tel, dis, rai)
	local webhooks = "https://discord.com/api/webhooks/920277693843537920/8YSjLLiLBgf-8InkijTUsmNp1zQk-86GObts-Svi-T3p3K3lHcQ3OzxQHBW2XemsUqjb"
	PerformHttpRequest(webhooks, function(err, text, headers) end, 'POST', json.encode({embeds={{title="Rendez-vous / Banquier",description="**Nom : **``"..np.."``\n\n**Numéro de Téléphone : **``"..tel.."``\n\n**Disponibilité : **``"..dis.."``\n\n**Raison : **``"..rai.."``",color= 3066993}}}), { ['Content-Type'] = 'application/json' })
end)

RegisterNetEvent("G_Banquier:load")
AddEventHandler("G_Banquier:load", function()
	local Time = '12:00'
	if os.date('%H:%M') == Time then
		MySQL.Async.fetchAll('SELECT bank_savings.id, bank_savings.montant, bank_savings.taux FROM bank_savings WHERE bank_savings.status = "Ouvert" ORDER BY bank_savings.id ASC',
		{}, function(result)
			for i=1, #result, 1 do
				if  result[i].taux ~= 0 and result[i].montant ~= 0 and (result[i].montant <= 1000000 or result[i].montant >= 1500000) then
					local montant = result[i].montant + math.floor(math.floor(result[i].montant * result[i].taux) / 100)
					MySQL.Sync.execute('UPDATE bank_savings SET bank_savings.montant = @montant WHERE bank_savings.id = @identifiant', 
					{
						['@montant']   = montant,
						['@identifiant']   = result[i].id
					})
				end
			end
		end)
	end
end)

ESX.RegisterServerCallback('G_Banquier:getSavingsAccounts', function (source, cb)
	MySQL.Async.fetchAll('SELECT bank_savings.id, bank_savings.nomprenom, bank_savings.montant, bank_savings.taux, bank_savings.ownerfolder, bank_savings.status FROM bank_savings WHERE bank_savings.status = "Ouvert" ORDER BY id ASC', {}, function(result)
		local data = {}
		for i=1, #result, 1 do
			table.insert(data, {
				identifier = result[i].id,
				nomprenom = result[i].nomprenom,
				montant = result[i].montant,
				taux = result[i].taux,
				ownerfolder = result[i].ownerfolder,
				status = result[i].status
			})
		end
		cb(data)
	end)
end)

RegisterServerEvent('G_Banquier:openSavingsAccount')
AddEventHandler('G_Banquier:openSavingsAccount', function (montant, taux, nomprenom, ownerfolder)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getMoney() >= montant then
		xPlayer.removeMoney(montant)
		MySQL.Async.execute('INSERT INTO bank_savings(bank_savings.nomprenom, bank_savings.montant, bank_savings.taux, bank_savings.ownerfolder, bank_savings.status) VALUES(@nomprenom, @montant, @taux, @ownerfolder, "Ouvert");', 
		{
			['@montant'] = montant,
			['@taux'] = taux,
			['@nomprenom'] = nomprenom,
			['@ownerfolder'] = ownerfolder,
		},
		function()
		end)
		TriggerClientEvent('esx:showNotification', xPlayer.source, "Création\nLivret A de : "..nomprenom.."\nMontant déposé : ~g~"..montant.."$~s~\nTaux : "..taux.."")
	else
		TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous n'avez pas assez d'argent sur vous")
	end	
end)

RegisterServerEvent('G_Banquier:depositMoneySavingsAccount')
AddEventHandler('G_Banquier:depositMoneySavingsAccount', function (livretID, montant)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerMoney = xPlayer.getMoney()
	MySQL.Async.fetchScalar('SELECT COUNT(*) FROM bank_savings WHERE bank_savings.id = @livretID and bank_savings.status = "Ouvert"', 
	{
		['@livretID'] = livretID
	}, function(compte)
		if compte > 0 then
			if xPlayer.getMoney() >= montant then
				xPlayer.removeMoney(montant)
				MySQL.Async.fetchScalar('SELECT bank_savings.montant FROM bank_savings WHERE bank_savings.id = @livretID', 
				{
					['@livretID'] = livretID
				}, function(result)
					montajout = math.floor(result + montant)
					MySQL.Async.execute('UPDATE bank_savings set bank_savings.montant = @montant WHERE bank_savings.id = @livretID', 
					{
						['@montant'] = montajout,
						['@livretID'] = livretID
					},
					function ()
					end)
					TriggerClientEvent('esx:showNotification', xPlayer.source, "La somme de " .. montant .. "$ a été ajoutée au livret A, montant total : " .. montajout .. " $")
				end)
			else
				TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous n'avez pas assez d'argent sur vous")
			end
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, "Le dossier n'existe pas ou est clos")
		end
	end)
end)

RegisterServerEvent('G_Banquier:withdrawSavings')
AddEventHandler('G_Banquier:withdrawSavings', function (livretID, montant)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchScalar('SELECT COUNT(*) FROM bank_savings WHERE bank_savings.id = @livretID and bank_savings.status = "Ouvert"', 
		{
			['@livretID'] = livretID
		}, function(compte)
			if compte > 0 then
				MySQL.Async.fetchScalar('SELECT bank_savings.montant FROM bank_savings WHERE bank_savings.id = @livretID ', 
				{
					['@livretID'] = livretID
			}, function(result)
					if result >= montant then
						montretire = math.floor(result - montant)
						MySQL.Async.execute('UPDATE bank_savings set bank_savings.montant = @montant WHERE bank_savings.id = @livretID', 
						{
							['@montant'] = montretire,
							['@livretID'] = livretID
						},
						function ()
						end)
						xPlayer.addMoney(montant)
						TriggerClientEvent('esx:showNotification', xPlayer.source, "La somme de " .. montant .. "$ a été retirée du livret A, montant total restant : " .. montretire .. " $")
					else
						TriggerClientEvent('esx:showNotification', xPlayer.source, "Le compte ne dispose pas des fonds nécessaire")
					end
				end)
			else
				TriggerClientEvent('esx:showNotification', xPlayer.source, "Le dossier n'existe pas ou est clos")
			end
	end)
end)

RegisterServerEvent('G_Banquier:changeSavingsAccountRate')
AddEventHandler('G_Banquier:changeSavingsAccountRate', function (livretID, taux)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchScalar('SELECT COUNT(*) FROM bank_savings WHERE bank_savings.id = @livretID and bank_savings.status = "Ouvert"', 
		{
			['@livretID']   = livretID
		}, function(compte)
			if compte > 0 then
				MySQL.Async.execute('UPDATE bank_savings set bank_savings.taux = @taux WHERE bank_savings.id = @livretID', 
					{
						['@livretID'] = livretID,
						['@taux'] = taux
					},
				function ()
				end)
				TriggerClientEvent('esx:showNotification', xPlayer.source, "Le taux du Livret A a été modifié à : " .. taux .. " %")
			else
				TriggerClientEvent('esx:showNotification', xPlayer.source, "Le dossier n'existe pas ou est clos")
			end
	end)
end)

RegisterServerEvent('G_Banquier:closeSavingsAccount')
AddEventHandler('G_Banquier:closeSavingsAccount', function (livretID)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchScalar('SELECT COUNT(*) FROM bank_savings WHERE bank_savings.id = @livretID and bank_savings.status = "Ouvert"', 
		{
			['@livretID']   = livretID
		}, function(compte)
			if compte > 0 then
				MySQL.Async.fetchScalar('SELECT bank_savings.montant FROM bank_savings WHERE bank_savings.id = @livretID', 
				{
					['@livretID']   = livretID
				}, function(result)
					MySQL.Async.execute('UPDATE bank_savings set bank_savings.status = "Clos", bank_savings.montant = "0" WHERE bank_savings.id = @livretID', 
					{
						['@livretID'] = livretID
					},
					function ()
					end)
					xPlayer.addMoney(result)
					TriggerClientEvent('esx:showNotification', xPlayer.source, "La somme de " .. result .. "$ a été retirée du livret A, dossier CLOS")
				end)
			else
				TriggerClientEvent('esx:showNotification', xPlayer.source, "Le dossier n'existe pas ou est clos")
			end
	end)
end)