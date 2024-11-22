ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('G_Clothes:getMoney', function(source, cb, prix)
    local xPlayer = ESX.GetPlayerFromId(source)
    if G_Clothes.NotLegacy then
        if xPlayer.getMoney() >= prix then
            cb(true)
        else
            cb(false)
        end
    else
        if xPlayer.getAccount("money").money >= prix then
            cb(true)
        else
            cb(false)
        end
    end
end)

RegisterServerEvent('G_Clothes:Save')
AddEventHandler('G_Clothes:Save', function(label, skin)
	local xPlayer = ESX.GetPlayerFromId(source)
    if G_Clothes.NotLegacy then
        if xPlayer.getMoney() >= G_Clothes.Clothes.Price then
            xPlayer.removeMoney(G_Clothes.Clothes.Price)
            TriggerClientEvent('esx:showNotification', source, "Retrait de ~g~"..G_Clothes.Clothes.Price.."$")
            MySQL.Async.execute('INSERT INTO g_clothes_outfit (identifier, label, data) VALUES(@identifier, @label, @skin)', {
                ['@label'] = label, 
                ['@skin'] = json.encode(skin), 
                ['@identifier'] = xPlayer.identifier
            })
        else 
            TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas assez d'argent")
        end
    else
        if xPlayer.getAccount("money").money >= G_Clothes.Clothes.Price then
            xPlayer.removeAccountMoney("money", G_Clothes.Clothes.Price)
            TriggerClientEvent('esx:showNotification', source, "Retrait de ~g~"..G_Clothes.Clothes.Price.."$")
            MySQL.Async.execute('INSERT INTO g_clothes_outfit (identifier, label, data) VALUES(@identifier, @label, @skin)', {
                ['@label'] = label, 
                ['@skin'] = json.encode(skin), 
                ['@identifier'] = xPlayer.identifier
            })
        else 
            TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas assez d'argent")
        end
    end
end)

ESX.RegisterServerCallback('G_Clothes:getData', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT * FROM g_clothes_outfit WHERE identifier = @identifier', {['@identifier'] = xPlayer.identifier}, function(result)
		cb(result)
	end)
end)

RegisterServerEvent('G_Clothes:Rename')
AddEventHandler('G_Clothes:Rename', function(id, label)
    MySQL.Async.execute('UPDATE g_clothes_outfit SET label = @label WHERE id = @id', {
        ['@id'] = id,
        ['@label'] = label
    })
    TriggerClientEvent("esx:showNotification", source, "Vous avez renommé votre tenue en ~b~"..label)
end)

RegisterServerEvent('G_Clothes:Delete')
AddEventHandler('G_Clothes:Delete', function(id, label)
    MySQL.Async.execute('DELETE FROM g_clothes_outfit WHERE id = @id', {
        ['@id'] = id
    })
    TriggerClientEvent("esx:showNotification", source, "Tenue Supprimée")
end)

RegisterServerEvent("G_Clothes:BuyItem")
AddEventHandler("G_Clothes:BuyItem", function(item, itemvariation, type, label, price)
    itemX = {item_1 = item, item_2 = itemvariation}
    local xPlayer = ESX.GetPlayerFromId(source)
    if G_Clothes.NotLegacy then
        if xPlayer.getMoney() >= price then
            xPlayer.removeMoney(price)
            MySQL.Async.execute('INSERT INTO g_clothes_item (identifier, item, type, label) VALUES(@identifier, @item, @type, @label)', {
                ['@item'] = json.encode(itemX),
                ['@type'] = type,
                ['@label'] = label,
                ['@identifier'] = xPlayer.identifier
            })
            TriggerClientEvent("G_ClothesItem:SyncAccess", source)
            TriggerClientEvent("esx:showNotification", source, "Vous avez reçu un/une nouveau/nouvelle "..type.." pour ~g~"..price.."$")
        else
            TriggerClientEvent("esx:showNotification", source, "Vous n'avez pas assez d'argent")
        end
    else
        if xPlayer.getAccount("money").money >= price then
            xPlayer.removeAccountMoney("money", price)
            MySQL.Async.execute('INSERT INTO g_clothes_item (identifier, item, type, label) VALUES(@identifier, @item, @type, @label)', {
                ['@item'] = json.encode(itemX),
                ['@type'] = type,
                ['@label'] = label,
                ['@identifier'] = xPlayer.identifier
            })
            TriggerClientEvent("G_ClothesItem:SyncAccess", source)
            TriggerClientEvent("esx:showNotification", source, "Vous avez reçu un/une nouveau/nouvelle "..type.." pour ~g~"..price.."$")
        else
            TriggerClientEvent("esx:showNotification", source, "Vous n'avez pas assez d'argent")
        end
    end
end)

ESX.RegisterServerCallback('G_ClothesItem:getData', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT * FROM g_clothes_item WHERE identifier = @identifier', {['@identifier'] = xPlayer.identifier}, function(result)
        cb(result)
    end)
end)

RegisterServerEvent("G_ClothesItem:Rename")
AddEventHandler("G_ClothesItem:Rename", function(id, txt, type)
    MySQL.Async.execute('UPDATE g_clothes_item SET label = @label WHERE id=@id', {
        ['@id'] = id,
        ['@label'] = txt
    })
    TriggerClientEvent("esx:showNotification", source, "Vous avez bien renommé votre "..type.." en "..txt)
end)

RegisterServerEvent('G_ClothesItem:Give')
AddEventHandler('G_ClothesItem:Give', function(target, id, label)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayer2 = ESX.GetPlayerFromId(target)
	MySQL.Async.execute('UPDATE g_clothes_item SET identifier = @identifier WHERE id = @id', {
		['@identifier'] = xPlayer2.identifier,
		['@id'] = id
	})
	TriggerClientEvent('esx:showNotification', source, "Vous venez de donner ~b~x1 "..label)
	TriggerClientEvent('esx:showNotification', target, "Vous venez de recevoir ~b~x1 "..label)
	TriggerClientEvent("G_ClothesItem:Sync", source)
	TriggerClientEvent("G_ClothesItem:Sync", target)
end)

RegisterServerEvent('G_ClothesItem:Delete')
AddEventHandler('G_ClothesItem:Delete', function(id, label, data)
	local xPlayer = ESX.GetPlayerFromId(source)	
	MySQL.Async.execute('DELETE FROM g_clothes_item where id = @id', {
		['@id'] = id,
	})
    TriggerClientEvent('esx:showNotification', source, "Vous venez de jeter ~b~x1 "..label)
    TriggerClientEvent("G_ClothesItem:Sync", source)
end)