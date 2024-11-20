ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('esx_phone:registerNumber', 'ammunation', 'alert_ammunation', true, true)
TriggerEvent('esx_society:registerSociety', 'ammunation', 'Ammunation', 'society_ammunation', 'society_ammunation', 'society_ammunation', {type = 'public'})

RegisterServerEvent("G_AmmunationJob:Open")
AddEventHandler("G_AmmunationJob:Open", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("esx:showAdvancedNotification", xPlayers[i], "Ammunation", "Annonce", "Le Ammunation est désormais ~g~Ouvert", "CHAR_CHAT_CALL", 8)
    end
end)

RegisterServerEvent("G_AmmunationJob:Close")
AddEventHandler("G_AmmunationJob:Close", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("esx:showAdvancedNotification", xPlayers[i], "Ammunation", "Annonce", "Le Ammunation est désormais ~r~Fermé", "CHAR_CHAT_CALL", 8)
    end
end)

RegisterServerEvent("G_AmmunationJob:Perso")
AddEventHandler("G_AmmunationJob:Perso", function(msg)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("esx:showAdvancedNotification", xPlayers[i], "Ammunation", "Annonce", msg, "CHAR_CHAT_CALL", 8)
    end
end)

ESX.RegisterServerCallback("G_AmmunationJob:getInventoryItem", function(source, cb)
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

ESX.RegisterServerCallback("G_AmmunationJob:getCoffreItem", function(source, cb, society)
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

RegisterServerEvent("G_AmmunationJob:putCoffreItem")
AddEventHandler("G_AmmunationJob:putCoffreItem", function(name, count, society)
    local xPlayer = ESX.GetPlayerFromId(source)
    local getInventory = xPlayer.getInventoryItem(name).count
    TriggerEvent("esx_addoninventory:getSharedInventory", "society_"..society, function(inventory)
        if getInventory >= count and count > 0 then
            xPlayer.removeInventoryItem(name, count)
            inventory.addItem(name, count)
            TriggerClientEvent("esx:showNotification", xPlayer.source, "Vous venez de déposer ~y~x"..count.." ~b~"..name)
        else 
            TriggerClientEvent("esx:showNotification", xPlayer.source, "~r~Vous n'en avez pas assez")
        end
    end)
end)

RegisterServerEvent("G_AmmunationJob:putInventoryItem")
AddEventHandler("G_AmmunationJob:putInventoryItem", function(name, count, society)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerEvent("esx_addoninventory:getSharedInventory", "society_"..society, function(inventory)
        xPlayer.addInventoryItem(name, count)
        inventory.removeItem(name, count)
        TriggerClientEvent("esx:showNotification", xPlayer.source, "Vous venez de retiré ~y~x"..count.." ~b~"..name)
    end)
end)

RegisterServerEvent("G_AmmunationJob:BuyItem")
AddEventHandler("G_AmmunationJob:BuyItem", function(v)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
		if account.money >= v.price then
			account.removeMoney(v.price)
            xPlayer.addInventoryItem(v.name, 1)
            TriggerClientEvent("esx:showNotification", xPlayer.source, "Achat Confirmé\n~r~-"..v.price.."$~s~ d'argent de société\n~b~+1 "..v.label)
		else
            TriggerClientEvent("esx:showNotification", xPlayer.source, "La société ne possède pas assez d'argent pour effectuer l'achat")
		end
	end)
end)

RegisterServerEvent("G_AmmunationJob:BuyWeapon")
AddEventHandler("G_AmmunationJob:BuyWeapon", function(v)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
		if account.money >= v.price then
			account.removeMoney(v.price)
            xPlayer.addWeapon('weapon_'..v.name, 255)
            TriggerClientEvent("esx:showNotification", xPlayer.source, "Achat Confirmé\n~r~-"..v.price.."$~s~ d'argent de société\n~b~+1 "..v.label)
		else
            TriggerClientEvent("esx:showNotification", xPlayer.source, "La société ne possède pas assez d'argent pour effectuer l'achat")
		end
	end)
end)