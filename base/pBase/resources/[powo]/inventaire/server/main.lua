function sendToDiscordWithSpecialURL(name, message, color, url)
    local DiscordWebHook = url
    -- Modify here your discordWebHook username = name, content = message,embeds = embeds
  
  local embeds = {
      {
		["color"] = color,
		["title"] = name,
		["description"] = message,
		["footer"] = {["text"] = os.date("%Y/%m/%d %H:%M:%S")}, 
      }
  }
    if message == nil or message == '' then
		return
	end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

ESX.RegisterServerCallback("esx_inventoryhud:getPlayerInventory", function(source, cb, target)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	if targetXPlayer ~= nil then
		if targetXPlayer ~= nil then
			cb({inventory = targetXPlayer.inventory, money = targetXPlayer.getMoney(), accounts = targetXPlayer.accounts, weapons = targetXPlayer.loadout, weight = targetXPlayer.getWeight(), maxWeight = targetXPlayer.maxWeight})
		else
			cb(nil)
		end
	end
end)

ESX.RegisterServerCallback("esx_inventoryhud:othersPlayerInventory", function(source, cb, target)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	if targetXPlayer ~= nil then
		MySQL.Async.fetchAll("SELECT * FROM vetement WHERE identifier = '" .. targetXPlayer.identifier .. "'", {}, function(result3)
			if targetXPlayer ~= nil then
				cb({inventory = targetXPlayer.inventory, money = targetXPlayer.getMoney(), accounts = targetXPlayer.accounts, weapons = targetXPlayer.loadout, weight = targetXPlayer.getWeight(), maxWeight = targetXPlayer.maxWeight})
			else
				cb(nil)
			end
		end)
	end
end)

RegisterNetEvent("esx_inventoryhud:tradePlayerItem")
AddEventHandler("esx_inventoryhud:tradePlayerItem",	function(from, target, type, itemName, itemCount)
	local _source = from

	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if type == "item_standard" then
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)
		local targetItem = targetXPlayer.getInventoryItem(itemName)

		if itemCount > 0 and sourceItem.count >= itemCount then
			if targetXPlayer.canCarryItem(itemName, itemCount) then

				sourceXPlayer.removeInventoryItem(itemName, itemCount)
				targetXPlayer.addInventoryItem(itemName, itemCount)
			else
				sourceXPlayer.showNotification('~r~Impossible~s~~n~l\'inventaire de l\'individu est plein.')
			end
		end
	elseif type == "item_money" then
		if itemCount > 0 and sourceXPlayer.getMoney() >= itemCount then
			sourceXPlayer.removeMoney(itemCount)
			targetXPlayer.addMoney(itemCount)
			sourceXPlayer.showNotification('Vous venez de donner ~g~'..itemCount.."$~s~.")
			targetXPlayer.showNotification('Vous avez reçu ~g~'..itemCount.."$~s~.")
		end
	elseif type == "item_account" then
		if itemCount > 0 and sourceXPlayer.getAccount(itemName).money >= itemCount then
			sourceXPlayer.removeAccountMoney(itemName, itemCount)
			targetXPlayer.addAccountMoney(itemName, itemCount)
		end
	elseif type == "item_weapon" then
		if not targetXPlayer.hasWeapon(itemName) then
			sourceXPlayer.removeWeapon(itemName)
			targetXPlayer.addWeapon(itemName, itemCount)
		end
	end
end)

RegisterNetEvent('getgps')
AddEventHandler('getgps', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local getgpsinventory = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "gps" then
            getgpsinventory = item.count
		end
	end
    
    if getgpsinventory > 0 then
		TriggerClientEvent('addgps', _source)
    end
end)

----- Vetement -----

ESX.RegisterServerCallback('GetTypeZed', function(source, cb)
	local identifier = ESX.GetPlayerFromId(source).identifier
	local masque = {}
	MySQL.Async.fetchAll('SELECT * FROM vetement WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(result) 
		for i = 1, #result, 1 do  
			table.insert(masque, {      
                type = result[i].type,  
				clothe = result[i].clothe,
				id = result[i].id,
				nom = result[i].nom,
				vie = result[i].vie,
				onPickup = result[i].onPickup
			})
		end  
		cb(masque) 
	end)  
end)

RegisterNetEvent('InsertVetement')
AddEventHandler('InsertVetement', function(type, name, Nom1, lunettes, Nom2, variation)
  local ident = ESX.GetPlayerFromId(source).identifier
  local xPlayer = ESX.GetPlayerFromId(source)
  maskx = {[Nom1]=tonumber(lunettes),[Nom2]=tonumber(variation)} 
	MySQL.Async.execute('INSERT INTO vetement (identifier, type, nom, clothe) VALUES (@identifier, @type, @nom, @clothe)', { 
		['@identifier']   = ident,
    	['@type']   = type,
    	['@nom']   = name,
    	['@clothe'] = json.encode(maskx)
	})
	identifiers = GetNumPlayerIdentifiers(source)
	for i = 0, identifiers + 1 do
		if GetPlayerIdentifier(source, i) ~= nil then
			if string.match(GetPlayerIdentifier(source, i), "discord") then
				discord = GetPlayerIdentifier(source, i)
			end
		end
	end
	sendToDiscordWithSpecialURL("Logger","ID: "..xPlayer.source.."\n[DiscordId: "..discord.."]\nAction : a acheté le vêtement "..name, 16711680, "")
end)

RegisterNetEvent('InsertTenue')
AddEventHandler('InsertTenue', function(type, name, clothe)
  local ident = ESX.GetPlayerFromId(source).identifier
	MySQL.Async.execute('INSERT INTO vetement (identifier, type, nom, clothe) VALUES (@identifier, @type, @nom, @clothe)',
	{
		['@identifier'] = ident,
    	['@type'] = type,
    	['@nom'] = name,
    	['@clothe'] = json.encode(clothe)
		}, function(rowsChanged) 
	end)
end)

RegisterNetEvent('DeleteVetement')
AddEventHandler('DeleteVetement', function(supprimer)
    MySQL.Async.execute('DELETE FROM vetement WHERE id = @id', { 
        ['@id'] = supprimer 
    }) 
end)

RegisterNetEvent("marketPaiement")
AddEventHandler("marketPaiement", function(price, itemSelect, itemLabelSelect, quantity)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getMoney() >= price then
        if xPlayer.canCarryItem(itemSelect, quantity) then
            xPlayer.removeMoney(price)
            xPlayer.addInventoryItem(itemSelect, quantity)
            xPlayer.showNotification('Vous avez ~g~effectué~s~ un ~g~paiement~s~ de ~g~'..price..'$~s~ pour '..quantity..' ~b~'..itemLabelSelect..'')  			
        else
            xPlayer.showNotification('Vous n\'avez pas assez de place.')
        end
    else
        xPlayer.showNotification('~r~Vous n\'avez pas assez d\'argent ~g~('..price..'$)')
    end
end)

RegisterNetEvent('VetementPickupOn')
AddEventHandler('VetementPickupOn', function(supprimer)
    MySQL.Async.execute('UPDATE vetement SET onPickup = @onPickup WHERE id = @id', { 
        ['@id'] = supprimer,
		['@onPickup'] = true 
    }) 
end)

RegisterNetEvent('VetementPickupOff')
AddEventHandler('VetementPickupOff', function(supprimer)
    MySQL.Async.execute('UPDATE vetement SET onPickup = @onPickup WHERE id = @id', { 
        ['@id'] = supprimer,
		['@onPickup'] = false 
    }) 
end)


RegisterNetEvent('VetementPickupIdentifier')
AddEventHandler('VetementPickupIdentifier', function(supprimer, identifier)
    MySQL.Async.execute('UPDATE vetement SET identifier = @identifier WHERE id = @id', { 
        ['@id'] = supprimer,
		['@identifier'] = identifier 
    }) 
end)

RegisterNetEvent('ModifNom')
AddEventHandler('ModifNom', function(id, Actif)   
	MySQL.Sync.execute('UPDATE vetement SET nom = @nom WHERE id = @id', {
		['@id'] = id,   
		['@nom'] = Actif        
	})
end)

RegisterNetEvent('Vetement:giveitem')
AddEventHandler('Vetement:giveitem', function(id, personne, name)   
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayerT = ESX.GetPlayerFromId(personne)
	MySQL.Sync.execute('UPDATE vetement SET identifier = @identifier WHERE id = @id', {
		['@id'] = id,   
		['@identifier'] = xPlayerT.identifier     
	})
	xPlayerT.showNotification("Vous avez reçu un(e) ~b~"..name)
	identifiers = GetNumPlayerIdentifiers(xPlayer.source)
	for i = 0, identifiers + 1 do
		if GetPlayerIdentifier(xPlayer.source, i) ~= nil then
			if string.match(GetPlayerIdentifier(xPlayer.source, i), "discord") then
				discord = GetPlayerIdentifier(xPlayer.source, i)
			end
		end
	end
	sendToDiscordWithSpecialURL("Logger","ID: "..xPlayer.source.."\n[DiscordId: "..discord.."]\nAction : a donné un vêtement à ", 16711680, "")
end)

RegisterNetEvent('Malette')
AddEventHandler('Malette', function(type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local defaultMaxWeight = ESX.GetConfig().MaxWeight
	if type == 1 then
		xPlayer.setMaxWeight(defaultMaxWeight + 2000)
		xPlayer.showNotification("~r~Informations~s~\nVous avez maintenant une capacité en plus de : "..(math.floor(2000/1000)).."KG")
	elseif type == 2 then
		xPlayer.setMaxWeight(defaultMaxWeight + 3000)
		xPlayer.showNotification("~r~Informations~s~\nVous avez maintenant une capacité en plus de : "..(math.floor(3000/1000)).."KG")
	elseif type == 3 then
		xPlayer.setMaxWeight(defaultMaxWeight)
	end
end)

ESX.RegisterUsableItem('handcuff', function(source)
    TriggerClientEvent('MenotterPlayer', source)
end)

RegisterNetEvent("MenotterPly")
AddEventHandler("MenotterPly", function(Target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(Target)

    if xPlayer.job.name == "police" or xPlayer.job.name == "lssd" or xPlayer.job.name == "usss" then
        if xPlayer.getInventoryItem("handcuff").count > 0 then
            if xTarget then
                if #(GetEntityCoords(GetPlayerPed(xPlayer.source))-GetEntityCoords(GetPlayerPed(xTarget.source))) < 5 then
                    TriggerClientEvent('HandCuffUse', xTarget.source, source)
                end
            end
        end
    end
end)
