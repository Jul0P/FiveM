ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('esx_phone:registerNumber', 'barber', 'alerte barber', true, true)
TriggerEvent('esx_society:registerSociety', 'barber', 'barber', 'society_barber', 'society_barber', 'society_barber', {type = 'public'})

RegisterServerEvent("G_BarberJob:Open")
AddEventHandler("G_BarberJob:Open", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Barbier', 'Annonce', 'Le barber est ~g~ouvert~s~, un barbier est actuellement disponible.', 'CHAR_BARBER', 9)
    end
end)

RegisterServerEvent("G_BarberJob:Close")
AddEventHandler("G_BarberJob:Close", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Barbier', 'Annonce', 'Le barber est ~r~fermé~s~, aucun barbier n\'est disponible.', 'CHAR_BARBER', 9)
	end
end)

RegisterServerEvent("G_BarberJob:Perso")
AddEventHandler("G_BarberJob:Perso", function(msg)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("esx:showAdvancedNotification", xPlayers[i], "Barbier", "Annonce", msg, "CHAR_BARBER", 0)
    end
end)

ESX.RegisterServerCallback("G_BarberJob:getInventoryItem", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local result = xPlayer.inventory
    local data = {}
    for _,v in pairs(result) do
        if v.count > 0 then
            table.insert(data, {label = v.label, name = v.name, count = v.count})
        end
    end
    cb(data)
end)

ESX.RegisterServerCallback("G_BarberJob:getCoffreItem", function(source, cb, society)
    local data = {}
    TriggerEvent("esx_addoninventory:getSharedInventory", "society_"..society, function(inventory)
        for _,v in pairs(inventory.items) do
            if v.count > 0 then
                table.insert(data, {label = v.label, name = v.name, count = v.count}) 
            end
        end 
    end)
    cb(data)
end)

RegisterServerEvent("G_BarberJob:putCoffreItem")
AddEventHandler("G_BarberJob:putCoffreItem", function(v, count, society)
    local xPlayer = ESX.GetPlayerFromId(source)
    local getInventory = xPlayer.getInventoryItem(v.name).count
    TriggerEvent("esx_addoninventory:getSharedInventory", "society_"..society, function(inventory)
        if getInventory >= count and count > 0 then
            xPlayer.removeInventoryItem(v.name, count)
            inventory.addItem(v.name, count)
            TriggerClientEvent("esx:showNotification", xPlayer.source, "Vous venez de déposer ~y~x"..count.." ~b~"..v.label)
        else 
            TriggerClientEvent("esx:showNotification", xPlayer.source, "~r~Vous n'en avez pas assez")
        end
    end)
end)

RegisterServerEvent("G_BarberJob:putInventoryItem")
AddEventHandler("G_BarberJob:putInventoryItem", function(v, count, society)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerEvent("esx_addoninventory:getSharedInventory", "society_"..society, function(inventory)
        xPlayer.addInventoryItem(v.name, count)
        inventory.removeItem(v.name, count)
        TriggerClientEvent("esx:showNotification", xPlayer.source, "Vous venez de retiré ~y~x"..count.." ~b~"..v.label)
    end)
end)

ESX.RegisterServerCallback('G_BarberJob:getClosestPlayerSkin', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)
  
	MySQL.Async.fetchAll('SELECT skin FROM users WHERE identifier = @identifier', {
	  ['@identifier'] = xPlayer.identifier
	}, function(users)
	  local user = users[1]
	  local skin = nil
  
	  if user.skin ~= nil then
		cl = json.decode(user.skin)
	  end
  
	  cb(cl)
	end)
end)

RegisterServerEvent('G_BarberJob:save')
AddEventHandler('G_BarberJob:save', function(target, skin)
  local _source = source
  local xPlayer = nil
  local xPlayertarget = ESX.GetPlayerFromId(target)
  MySQL.Async.execute('UPDATE users SET `skin` = @skin WHERE identifier = @identifier',
   	{
		['@skin']       = json.encode(skin),
		['@identifier'] = xPlayertarget.identifier
	},function(result)
     TriggerClientEvent('esx:showNotification', xPlayertarget.source, 'Votre nouvelle coupe est prête')
     TriggerClientEvent('skinchanger:loadSkin',xPlayertarget.source, skin)        
  end)
end)

RegisterServerEvent('G_BarberJob:cheveuxS')
AddEventHandler('G_BarberJob:cheveuxS', function(target, cheveux)
	TriggerClientEvent('G_BarberJob:cheveuxC', target, cheveux)
end)

RegisterServerEvent('G_BarberJob:cheveuxcolorS')
AddEventHandler('G_BarberJob:cheveuxcolorS', function(target, cheveuxcolor, cheveuxcolor2)
  	TriggerClientEvent('G_BarberJob:cheveuxcolorC', target, cheveuxcolor, cheveuxcolor2)
end)

RegisterServerEvent('G_BarberJob:cheveuxcolor2S')
AddEventHandler('G_BarberJob:cheveuxcolor2S', function(target, cheveuxcolor, cheveuxcolor2)
  	TriggerClientEvent('G_BarberJob:cheveuxcolor2C', target, cheveuxcolor, cheveuxcolor2)
end)

RegisterServerEvent('G_BarberJob:barbeS')
AddEventHandler('G_BarberJob:barbeS', function(target, barbe, opacity)
  	TriggerClientEvent('G_BarberJob:barbeC', target, barbe, opacity)
end)

RegisterServerEvent('G_BarberJob:barbecolorS')
AddEventHandler('G_BarberJob:barbecolorS', function(target, barbecolor, barbecolor2)
  	TriggerClientEvent('G_BarberJob:barbecolorC', target, barbecolor, barbecolor2)
end)

RegisterServerEvent('G_BarberJob:barbecolor2S')
AddEventHandler('G_BarberJob:barbecolor2S', function(target, barbecolor, barbecolor2)
  	TriggerClientEvent('G_BarberJob:barbecolor2C', target, barbecolor, barbecolor2)
end)

RegisterServerEvent('G_BarberJob:sourcilS')
AddEventHandler('G_BarberJob:sourcilS', function(target, sourcil, opacity)
  	TriggerClientEvent('G_BarberJob:sourcilC', target, sourcil, opacity)
end)

RegisterServerEvent('G_BarberJob:sourcilcolorS')
AddEventHandler('G_BarberJob:sourcilcolorS', function(target, sourcilcolor, sourcilcolor2)
  	TriggerClientEvent('G_BarberJob:sourcilcolorC', target, sourcilcolor, sourcilcolor2)
end)

RegisterServerEvent('G_BarberJob:sourcilcolor2S')
AddEventHandler('G_BarberJob:sourcilcolor2S', function(target, sourcilcolor, sourcilcolor2)
  	TriggerClientEvent('G_BarberJob:sourcilcolor2C', target, sourcilcolor, sourcilcolor2)
end)

RegisterServerEvent('G_BarberJob:maquillageS')
AddEventHandler('G_BarberJob:maquillageS', function(target, maquillage, opacity)
  	TriggerClientEvent('G_BarberJob:maquillageC', target, maquillage, opacity)
end)

RegisterServerEvent('G_BarberJob:maquillagecolorS')
AddEventHandler('G_BarberJob:maquillagecolorS', function(target, maquillagecolor, maquillagecolor2)
  	TriggerClientEvent('G_BarberJob:maquillagecolorC', target, maquillagecolor, maquillagecolor2)
end)

RegisterServerEvent('G_BarberJob:maquillagecolor2S')
AddEventHandler('G_BarberJob:maquillagecolor2S', function(target, maquillagecolor, maquillagecolor2)
  	TriggerClientEvent('G_BarberJob:maquillagecolor2C', target, maquillagecolor, maquillagecolor2)
end)

RegisterServerEvent('G_BarberJob:boucheS')
AddEventHandler('G_BarberJob:boucheS', function(target, bouche, opacity)
  	TriggerClientEvent('G_BarberJob:boucheC', target, bouche, opacity)
end)

RegisterServerEvent('G_BarberJob:bouchecolorS')
AddEventHandler('G_BarberJob:bouchecolorS', function(target, bouchecolor, bouchecolor2)
  	TriggerClientEvent('G_BarberJob:bouchecolorC', target, bouchecolor, bouchecolor2)
end)

RegisterServerEvent('G_BarberJob:bouchecolor2S')
AddEventHandler('G_BarberJob:bouchecolor2S', function(target, bouchecolor, bouchecolor2)
  	TriggerClientEvent('G_BarberJob:bouchecolor2C', target, bouchecolor, bouchecolor2)
end)

