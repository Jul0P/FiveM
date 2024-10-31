if pF5.ESX == "new" then
	ESX = exports["es_extended"]:getSharedObject()
elseif pF5.ESX == "old" then
	ESX = nil
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

RegisterServerEvent('pF5:Weapon_addAmmoToPedS')
AddEventHandler('pF5:Weapon_addAmmoToPedS', function(plyId, value, quantity)
	--if #(GetEntityCoords(source, false) - GetEntityCoords(plyId, false)) <= 3.0 then
		TriggerClientEvent('pF5:Weapon_addAmmoToPedC', plyId, value, quantity)
	--end
end)

RegisterServerEvent("pF5:recruter")
AddEventHandler("pF5:recruter", function(target, job, grade)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	if sourceXPlayer.job.grade_name == 'boss' then
		targetXPlayer.setJob(job, grade)
        TriggerClientEvent('esx:showNotification', sourceXPlayer.source, "Action : ~o~Recruter~s~\nStatus : ~g~Abouti~s~\nSur : ~b~"..targetXPlayer.name.."\n~s~Par : ~b~"..sourceXPlayer.name.."")
        TriggerClientEvent('esx:showNotification', target, "Action : ~o~Recruter~s~\nStatus : ~g~Abouti~s~\nSur : ~b~"..targetXPlayer.name.."\n~s~Par : ~b~"..sourceXPlayer.name.."")
	end
end)

RegisterServerEvent("pF5:virer")
AddEventHandler("pF5:virer", function(target)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	if sourceXPlayer.job.grade_name == 'boss' and sourceXPlayer.job.name == targetXPlayer.job.name then
		targetXPlayer.setJob('unemployed', 0)
        TriggerClientEvent('esx:showNotification', sourceXPlayer.source, "Action : ~o~Virer~s~\nStatus : ~g~Abouti~s~\nSur : ~b~"..targetXPlayer.name.."\n~s~Par : ~b~"..sourceXPlayer.name.."")
        TriggerClientEvent('esx:showNotification', target, "Action : ~o~Virer~s~\nStatus : ~g~Abouti~s~\nSur : ~b~"..targetXPlayer.name.."\n~s~Par : ~b~"..sourceXPlayer.name.."")
	else
        TriggerClientEvent('esx:showNotification', sourceXPlayer.source, "Action : ~o~Virer~s~\nStatus : ~r~Échoué~s~\nRaison : ~b~Vous n'avez pas l'autorisation")
	end
end)

RegisterServerEvent("pF5:promouvoir")
AddEventHandler("pF5:promouvoir", function(target)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	if sourceXPlayer.job.grade_name == 'boss' and sourceXPlayer.job.name == targetXPlayer.job.name then
		targetXPlayer.setJob(targetXPlayer.job.name, tonumber(targetXPlayer.job.grade) + 1)
        TriggerClientEvent('esx:showNotification', sourceXPlayer.source, "Action : ~o~Promouvoir~s~\nStatus : ~g~Abouti~s~\nSur : ~b~"..targetXPlayer.name.."\n~s~Par : ~b~"..sourceXPlayer.name.."")
        TriggerClientEvent('esx:showNotification', target, "Action : ~o~Promouvoir~s~\nStatus : ~g~Abouti~s~\nSur : ~b~"..targetXPlayer.name.."\n~s~Par : ~b~"..sourceXPlayer.name.."")
	else
        TriggerClientEvent('esx:showNotification', sourceXPlayer.source, "Action : ~o~Promouvoir~s~\nStatus : ~r~Échoué~s~\nRaison : ~b~Vous n'avez pas l'autorisation")
	end
end)

RegisterServerEvent("pF5:destituer")
AddEventHandler("pF5:destituer", function(target)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	if (targetXPlayer.job.grade == 0) then
        TriggerClientEvent('esx:showNotification', sourceXPlayer.source, "Action : ~o~Promouvoir~s~\nStatus : ~r~Échoué~s~\nRaison : ~b~Vous ne pouvez pas destituer davantage")
	else
		if sourceXPlayer.job.grade_name == 'boss' and sourceXPlayer.job.name == targetXPlayer.job.name then
			targetXPlayer.setJob(targetXPlayer.job.name, tonumber(targetXPlayer.job.grade) - 1)
            TriggerClientEvent('esx:showNotification', sourceXPlayer.source, "Action : ~o~Destituer~s~\nStatus : ~g~Abouti~s~\nSur : ~b~"..targetXPlayer.name.."\n~s~Par : ~b~"..sourceXPlayer.name.."")
            TriggerClientEvent('esx:showNotification', target, "Action : ~o~Destituer~s~\nStatus : ~g~Abouti~s~\nSur : ~b~"..targetXPlayer.name.."\n~s~Par : ~b~"..sourceXPlayer.name.."")
		else
            TriggerClientEvent('esx:showNotification', sourceXPlayer.source, "Action : ~o~Destituer~s~\nStatus : ~r~Échoué~s~\nRaison : ~b~Vous n'avez pas l'autorisation")
		end
	end
end)

RegisterServerEvent("pF5:recruter2")
AddEventHandler("pF5:recruter2", function(target, job2, grade2)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	if sourceXPlayer.job2.grade_name == 'boss' then
		targetXPlayer.setJob2(job2, grade2)
        TriggerClientEvent('esx:showNotification', sourceXPlayer.source, "Action : ~o~Recruter~s~\nStatus : ~g~Abouti~s~\nSur : ~b~"..targetXPlayer.name.."\n~s~Par : ~b~"..sourceXPlayer.name.."")
        TriggerClientEvent('esx:showNotification', target, "Action : ~o~Recruter~s~\nStatus : ~g~Abouti~s~\nSur : ~b~"..targetXPlayer.name.."\n~s~Par : ~b~"..sourceXPlayer.name.."")
	end
end)

RegisterServerEvent("pF5:virer2")
AddEventHandler("pF5:virer2", function(target)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	if sourceXPlayer.job2.grade_name == 'boss' and sourceXPlayer.job2.name == targetXPlayer.job2.name then
		targetXPlayer.setJob2('unemployed2', 0)
        TriggerClientEvent('esx:showNotification', sourceXPlayer.source, "Action : ~o~Virer~s~\nStatus : ~g~Abouti~s~\nSur : ~b~"..targetXPlayer.name.."\n~s~Par : ~b~"..sourceXPlayer.name.."")
        TriggerClientEvent('esx:showNotification', target, "Action : ~o~Virer~s~\nStatus : ~g~Abouti~s~\nSur : ~b~"..targetXPlayer.name.."\n~s~Par : ~b~"..sourceXPlayer.name.."")
	else
        TriggerClientEvent('esx:showNotification', sourceXPlayer.source, "Action : ~o~Virer~s~\nStatus : ~r~Échoué~s~\nRaison : ~b~Vous n'avez pas l'autorisation")
	end
end)

RegisterServerEvent("pF5:promouvoir2")
AddEventHandler("pF5:promouvoir2", function(target)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	if sourceXPlayer.job2.grade_name == 'boss' and sourceXPlayer.job2.name == targetXPlayer.job2.name then
		targetXPlayer.setJob2(targetXPlayer.job2.name, tonumber(targetXPlayer.job2.grade) + 1)
        TriggerClientEvent('esx:showNotification', sourceXPlayer.source, "Action : ~o~Promouvoir~s~\nStatus : ~g~Abouti~s~\nSur : ~b~"..targetXPlayer.name.."\n~s~Par : ~b~"..sourceXPlayer.name.."")
        TriggerClientEvent('esx:showNotification', target, "Action : ~o~Promouvoir~s~\nStatus : ~g~Abouti~s~\nSur : ~b~"..targetXPlayer.name.."\n~s~Par : ~b~"..sourceXPlayer.name.."")
	else
        TriggerClientEvent('esx:showNotification', sourceXPlayer.source, "Action : ~o~Promouvoir~s~\nStatus : ~r~Échoué~s~\nRaison : ~b~Vous n'avez pas l'autorisation")
	end
end)

RegisterServerEvent("pF5:destituer2")
AddEventHandler("pF5:destituer2", function(target)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	if (targetXPlayer.job2.grade == 0) then
        TriggerClientEvent('esx:showNotification', sourceXPlayer.source, "Action : ~o~Promouvoir~s~\nStatus : ~r~Échoué~s~\nRaison : ~b~Vous ne pouvez pas destituer davantage")
	else
		if sourceXPlayer.job2.grade_name == 'boss' and sourceXPlayer.job2.name == targetXPlayer.job2.name then
			targetXPlayer.setJob2(targetXPlayer.job2.name, tonumber(targetXPlayer.job2.grade) - 1)
            TriggerClientEvent('esx:showNotification', sourceXPlayer.source, "Action : ~o~Destituer~s~\nStatus : ~g~Abouti~s~\nSur : ~b~"..targetXPlayer.name.."\n~s~Par : ~b~"..sourceXPlayer.name.."")
            TriggerClientEvent('esx:showNotification', target, "Action : ~o~Destituer~s~\nStatus : ~g~Abouti~s~\nSur : ~b~"..targetXPlayer.name.."\n~s~Par : ~b~"..sourceXPlayer.name.."")
		else
            TriggerClientEvent('esx:showNotification', sourceXPlayer.source, "Action : ~o~Destituer~s~\nStatus : ~r~Échoué~s~\nRaison : ~b~Vous n'avez pas l'autorisation")
		end
	end
end)

ESX.RegisterServerCallback('pF5:billing', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local bills = {}
	MySQL.Async.fetchAll('SELECT * FROM billing WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		for i = 1, #result, 1 do
			table.insert(bills, {
				id = result[i].id,
				label = result[i].label,
				amount = result[i].amount
			})
		end
		cb(bills)
	end)
end)

ESX.RegisterServerCallback('pF5:key', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local vehicles = {}
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		for i = 1, #result, 1 do
			table.insert(vehicles, {
				owner = result[i].owner,
				plate = result[i].plate,
				vehicle = json.decode(result[i].vehicle),
				stored = result[i].stored
			})
		end
		cb(vehicles)
	end)
end)

ESX.RegisterServerCallback('pF5:getMoney', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getAccount('bank').money >= pF5.VehicleCallPrice then
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('pF5:result')
AddEventHandler('pF5:result', function(plate)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeAccountMoney('bank', pF5.VehicleCallPrice)
	MySQL.Async.execute('UPDATE owned_vehicles SET stored = @stored WHERE plate = @plate', {
		['@stored'] = 0,
		['@plate'] = plate
	})
end)

RegisterServerEvent("pF5:GiveKey")
AddEventHandler("pF5:GiveKey", function(target, plate, name)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayer2 = ESX.GetPlayerFromId(target)
	MySQL.Async.execute('UPDATE owned_vehicles SET owner = @identifier WHERE plate = @plate', {
		['@identifier'] = xPlayer2.identifier,
		['@plate'] = plate
	})
	TriggerClientEvent("esx:showNotification", source, "Clé Donné\nPlaque : ~b~"..plate.."\n~s~Nom : ~b~"..name)
	TriggerClientEvent("esx:showNotification", target, "Clé Reçu\nPlaque : ~b~"..plate.."\n~s~Nom : ~b~"..name)
end)

RegisterServerEvent("pF5:DeleteKey")
AddEventHandler("pF5:DeleteKey", function(plate, name)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.execute('DELETE FROM owned_vehicles WHERE owner = @identifier AND plate = @plate', {
		['@identifier'] = xPlayer.identifier,
		['@plate'] = plate
	})
	TriggerClientEvent("esx:showNotification", source, "Clé jeté\nPlaque : ~b~"..plate.."\n~s~Nom : ~b~"..name)
end)

RegisterNetEvent("pub:perso")
AddEventHandler("pub:perso", function(pub, job)
    local _source = source
	if player ~= false then
        local name = GetPlayerName(source)
        local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			TriggerClientEvent("esx:showAdvancedNotification", xPlayers[i], "Annonce", ""..job.."", ""..pub.."", "CHAR_LIFEINVADER")
		end
	end
end, false)

RegisterNetEvent("pub:twitter")
AddEventHandler("pub:twitter", function(pub)
    local src = source
    if player ~= false then
        local name = GetPlayerName(source)
        local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Twitter', ''..name..'', ''..pub..'', 'CHAR_STRETCH')
        end
    end
end, false)

RegisterNetEvent("pub:ano")
AddEventHandler("pub:ano", function(pub)
    local src = source
    if player ~= false then
        local name = GetPlayerName(source)
        local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Twitter', 'Anonyme', ''..pub..'', 'CHAR_STRETCH')
        end
    end
end, false)

RegisterNetEvent('pF5:tryTackle')
AddEventHandler('pF5:tryTackle', function(target)
	TriggerClientEvent('pF5:getTackled', target, source)
	TriggerClientEvent('pF5:playTackle', source)
end)

RegisterNetEvent('pF5:carry')
AddEventHandler('pF5:carry', function(targetSrc, animationLib, animation, animation2, distans, distans2, height, length, spin, controlFlagSrc, controlFlagTarget, animFlagTarget)
	TriggerClientEvent('pF5:carryTarget', targetSrc, source, animationLib, animation2, distans, distans2, height, length, spin, controlFlagTarget, animFlagTarget)
	TriggerClientEvent('pF5:carrySync', source, animationLib, animation, length, controlFlagSrc, animFlagTarget)
end)

RegisterNetEvent('pF5:carryStop')
AddEventHandler('pF5:carryStop', function(targetSrc)
	if targetSrc ~= nil and targetSrc > 0 then
		TriggerClientEvent('pF5:carryStopTarget', targetSrc, source)
	end
end)

RegisterNetEvent('pF5:anim:sync')
AddEventHandler('pF5:anim:sync', function(target, animationLib,animationLib2, animation, animation2, distans, distans2, height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget,attachFlag)
	TriggerClientEvent('pF5:anim:syncTarget', targetSrc, source, animationLib2, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget,attachFlag)
	TriggerClientEvent('pF5:anim:syncMe', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
end)

RegisterNetEvent('pF5:anim:stop')
AddEventHandler('pF5:anim:stop', function(targetSrc)
	TriggerClientEvent('pF5:anim:cl_stop', targetSrc)
end)