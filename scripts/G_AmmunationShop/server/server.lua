ESX = nil

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

RegisterServerEvent('G_AmmunationShop:giveLicense')
AddEventHandler('G_AmmunationShop:giveLicense', function(license, price)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerMoney = xPlayer.getMoney()
	if playerMoney >= price then
		MySQL.Async.execute('INSERT INTO user_licenses (type, owner) VALUES (@type, @owner)', {
			['@type'] = license,
			['@owner'] = xPlayer.identifier
		})
		xPlayer.removeMoney(price)
		TriggerClientEvent('esx:showNotification', source, "~o~Cash~s~\nVous venez d'acheter la license ~b~"..license.."~s~ pour la somme de ~g~"..price.."$")
	else
		if xPlayer.getAccount('bank').money >= price then
			MySQL.Async.execute('INSERT INTO user_licenses (type, owner) VALUES (@type, @owner)', {
				['@type'] = license,
				['@owner'] = xPlayer.identifier
			})
			xPlayer.removeAccountMoney('bank', price)
			TriggerClientEvent('esx:showNotification', source, "~o~Carte Bancaire~s~\nVous venez d'acheter la license ~b~"..license.."~s~ pour la somme de ~g~"..price.."$")
		else
			TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas assez d'argent sur vous ou sur votre compte")
		end
	end
end)

RegisterServerEvent('G_AmmunationShop:giveWeapon')
AddEventHandler('G_AmmunationShop:giveWeapon', function(item)
    local xPlayer = ESX.GetPlayerFromId(source)
	local playerMoney = xPlayer.getMoney()
    if not xPlayer.hasWeapon(item.Value) then
        if playerMoney >= (item.Price) then
            xPlayer.addWeapon(item.Value, G_AmmunationShop.DefaultBulletInWeapon)
            xPlayer.removeMoney(item.Price)
            TriggerClientEvent('esx:showNotification', source, "~o~Cash~s~\nVous venez d'acheter l'arme ~b~"..item.Label.."~s~ pour la somme de ~g~"..item.Price.."$")
        else
            if xPlayer.getAccount('bank').money >= (item.Price) then
                xPlayer.addWeapon(item.Value, G_AmmunationShop.DefaultBulletInWeapon)
                xPlayer.removeAccountMoney('bank', item.Price)
                TriggerClientEvent('esx:showNotification', source, "~o~Carte Bancaire~s~\nVous venez d'acheter l'arme ~b~"..item.Label.."~s~ pour la somme de ~g~"..item.Price.."$")
            else
                TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas assez d'argent sur vous ou sur votre compte")
            end
        end
    else
        TriggerClientEvent('esx:showNotification', source, 'Vous avez déjà cette arme sur vous')
    end
end)

RegisterNetEvent('G_AmmunationShop:giveItem')
AddEventHandler('G_AmmunationShop:giveItem', function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerMoney = xPlayer.getMoney()
	if playerMoney >= (item.Price) then
		xPlayer.addInventoryItem(item.Value, 1)
		xPlayer.removeMoney(item.Price)
		TriggerClientEvent('esx:showNotification', source, "~o~Carte Bancaire~s~\nVous venez d'acheter l'item ~b~"..item.Label.."~s~ pour la somme de ~g~"..item.Price.."$")
	else
		if xPlayer.getAccount('bank').money >= (item.Price) then
			xPlayer.addInventoryItem(item.Value, 1)
			xPlayer.removeAccountMoney('bank', item.Price)
			TriggerClientEvent('esx:showNotification', source, "~o~Carte Bancaire~s~\nVous venez d'acheter l'item ~b~"..item.Label.."~s~ pour la somme de ~g~"..item.Price.."$")
		else
			TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas assez d'argent sur vous ou sur votre compte")
		end
	end
end)

function CheckLicense(source, type, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = xPlayer.identifier
	MySQL.Async.fetchAll('SELECT COUNT(*) as count FROM user_licenses WHERE type = @type AND owner = @owner', {
		['@type']  = type,
		['@owner'] = identifier
	}, function(result)
		if tonumber(result[1].count) > 0 then
			cb(true)
		else
			cb(false)
		end
	end)
end

ESX.RegisterServerCallback('G_AmmunationShop:checkLicense', function(source, cb, type)
    CheckLicense(source, 'weapon', cb)
end)

ESX.RegisterServerCallback('G_AmmunationShop:checkLicense2', function(source, cb, type)
    CheckLicense(source, 'hunt', cb)
end)