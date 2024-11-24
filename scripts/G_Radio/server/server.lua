ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('</G_Radio>:_getItemAmount_', function(source, cb, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local amount = xPlayer.getInventoryItem(item).count
    cb(amount)
end)

ESX.RegisterServerCallback('</G_Radio>:_Verify_', function(source, cb)
	cb(true)
end)