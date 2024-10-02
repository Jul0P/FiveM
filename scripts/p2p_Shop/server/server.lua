if Config.getSharedObject == "last" then
    ESX = exports["es_extended"]:getSharedObject()
elseif Config.getSharedObject == "old" then
    ESX = nil
	TriggerEvent('esx:getSharedObject', function(obj) 
        ESX = obj
    end)
end

RegisterNetEvent('p2p_shop:buy_item')
AddEventHandler('p2p_shop:buy_item', function(items, methode)
    local xPlayer = ESX.GetPlayerFromId(source)
    for k, v in pairs(items) do
        local canPurchase = false
        if methode == "liquide" then
            canPurchase = xPlayer.getMoney() >= (v.price * v.quantity)
        elseif methode == "banque" then
            canPurchase = xPlayer.getAccount('bank').money >= (v.price * v.quantity)
        end
        if canPurchase then
            if methode == "liquide" then
                xPlayer.removeMoney((v.price * v.quantity))
                color = "~g~"
            elseif methode == "banque" then
                xPlayer.removeAccountMoney('bank', (v.price * v.quantity))
                color = "~b~"
            end
            xPlayer.addInventoryItem(v.name, v.quantity)
            TriggerClientEvent('esx:showNotification', source, Config.Translate('you_paid').." "..color..""..(v.price * v.quantity).."$ ~s~: "..v.label)
            TriggerClientEvent('p2p_shop:clearPanier', source)
        else
            TriggerClientEvent('esx:showNotification', source, "~r~"..Config.Translate('no_money').." x"..v.quantity.." "..v.label)
        end
    end
end)