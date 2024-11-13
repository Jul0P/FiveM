ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('esx_phone:registerNumber', 'tabac', 'alert_tabac', true, true)
TriggerEvent('esx_society:registerSociety', 'tabac', 'Tabac', 'society_tabac', 'society_tabac', 'society_tabac', {type = 'public'})

RegisterServerEvent("G_TabacJob:Open")
AddEventHandler("G_TabacJob:Open", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("esx:showAdvancedNotification", xPlayers[i], "Tabac", "Annonce", "Le Tabac est désormais ~g~Ouvert", "CHAR_CHAT_CALL", 8)
    end
end)

RegisterServerEvent("G_TabacJob:Close")
AddEventHandler("G_TabacJob:Close", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("esx:showAdvancedNotification", xPlayers[i], "Tabac", "Annonce", "Le Tabac est désormais ~r~Fermé", "CHAR_CHAT_CALL", 8)
    end
end)

RegisterServerEvent("G_TabacJob:Perso")
AddEventHandler("G_TabacJob:Perso", function(msg)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("esx:showAdvancedNotification", xPlayers[i], "Tabac", "Annonce", msg, "CHAR_CHAT_CALL", 8)
    end
end)

ESX.RegisterServerCallback("G_TabacJob:getInventoryItem", function(source, cb)
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

ESX.RegisterServerCallback("G_TabacJob:getCoffreItem", function(source, cb, society)
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

RegisterServerEvent("G_TabacJob:putCoffreItem")
AddEventHandler("G_TabacJob:putCoffreItem", function(name, count, society)
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

RegisterServerEvent("G_TabacJob:putInventoryItem")
AddEventHandler("G_TabacJob:putInventoryItem", function(name, count, society)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerEvent("esx_addoninventory:getSharedInventory", "society_"..society, function(inventory)
        xPlayer.addInventoryItem(name, count)
        inventory.removeItem(name, count)
        TriggerClientEvent("esx:showNotification", xPlayer.source, "Vous venez de retiré ~y~x"..count.." ~b~"..name)
    end)
end)

RegisterServerEvent("G_TabacJob:recolte")
AddEventHandler("G_TabacJob:recolte", function(item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local result = xPlayer.getInventoryItem(item).count
    if result >= 50 then
        TriggerClientEvent("esx:showNotification", source, "Vous ne pouvez pas en porter d'avantage")
    else
        xPlayer.addInventoryItem(item, 1)
        TriggerClientEvent("esx:showNotification", source, "Récolte en cours...")
    end
end)

RegisterServerEvent("G_TabacJob:traitement")
AddEventHandler("G_TabacJob:traitement", function(item, xitem)
    local xPlayer = ESX.GetPlayerFromId(source)
    local result = xPlayer.getInventoryItem(item).count
    local xresult = xPlayer.getInventoryItem(xitem).count
    if xresult > 50 then
        TriggerClientEvent("esx:showNotification", source, "Vous ne pouvez pas en porter d'avantage")
    elseif result < 5 then
        TriggerClientEvent("esx:showNotification", source, "Vous n'avez plus assez de ~b~"..item.."~s~ pour traiter")
    else
        xPlayer.removeInventoryItem(item, 5)
        xPlayer.addInventoryItem(xitem, 1)
    end
end)

RegisterServerEvent("G_TabacJob:vente")
AddEventHandler("G_TabacJob:vente", function(item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local result = xPlayer.getInventoryItem(item).count
    if result > 0 then
        xPlayer.removeInventoryItem(item, 1)
        xPlayer.addMoney(G_TabacJob.SellPrice)
        TriggerClientEvent("esx:showNotification", source, "Vous venez de gagner ~g~"..G_TabacJob.SellPrice.."$")
    else
        TriggerClientEvent("esx:showNotification", source, "Vous n'avez plus rien à vendre")
    end
end)