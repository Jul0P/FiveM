ESX = nil

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
TriggerEvent('esx_phone:registerNumber', 'drivingdealer', 'drivingdealer', true, true)
TriggerEvent('esx_society:registerSociety', 'drivingdealer', 'Auto-École', 'society_drivingdealer', 'society_drivingdealer', 'society_drivingdealer', {type = 'public'})

RegisterServerEvent('G_jsfour-idcard:open')
AddEventHandler('G_jsfour-idcard:open', function(ID, targetID, type)
	local identifier = ESX.GetPlayerFromId(ID).identifier
	local _source 	 = ESX.GetPlayerFromId(targetID).source
	local show       = false

	MySQL.Async.fetchAll('SELECT firstname, lastname, dateofbirth, sex, height FROM users WHERE identifier = @identifier', {['@identifier'] = identifier},
	function (user)
		if (user[1] ~= nil) then
			MySQL.Async.fetchAll('SELECT type FROM user_licenses WHERE owner = @identifier', {['@identifier'] = identifier},
			function (licenses)
				if type ~= nil then
					for i=1, #licenses, 1 do
						if type == 'driver' then
							if licenses[i].type == 'drive' or licenses[i].type == 'drive_bike' or licenses[i].type == 'drive_truck' or licenses[i].type == 'drive_boat' or licenses[i].type == 'drive_plane' or licenses[i].type == 'drive_helico' then
								show = true
							end
						end
					end
				else
					show = true
				end
				if show then
					local array = {
						user = user,
						licenses = licenses
					}
					TriggerClientEvent('G_jsfour-idcard:open', _source, array, type)
				else
					TriggerClientEvent('esx:showNotification', _source, "Vous ne disposez pas de cette license")
				end
			end)
		end
	end)
end)

AddEventHandler('esx:playerLoaded', function(source)
	TriggerEvent('esx_license:getLicenses', source, function(licenses)
		TriggerClientEvent('G_DrivingSchool:loadLicenses', source, licenses)
	end)
end)

RegisterNetEvent('G_DrivingSchool:reload')
AddEventHandler('G_DrivingSchool:reload', function()
	local _source = source
	TriggerEvent('esx_license:getLicenses', _source, function(licenses)
		TriggerClientEvent('G_DrivingSchool:loadLicenses', _source, licenses)
	end)
end)

RegisterNetEvent('G_DrivingSchool:addLicense')
AddEventHandler('G_DrivingSchool:addLicense', function(types, target)
    if not target then
        target = source
    end
	TriggerEvent('esx_license:addLicense', target, types, function()
		TriggerEvent('esx_license:getLicenses', target, function(licenses)
			TriggerClientEvent('G_DrivingSchool:loadLicenses', target, licenses)
		end)
	end)
end)

ESX.RegisterServerCallback('G_DrivingSchool:getMoney', function(source, cb, price)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)
        cb(true)			
    else
        cb(false)
    end
end)

RegisterServerEvent("G_DrivingSchoolJob:Open")
AddEventHandler("G_DrivingSchoolJob:Open", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("esx:showAdvancedNotification", xPlayers[i], "Auto-École", "Annonce", "L'Auto-École est désormais ~g~Ouverte", "CHAR_CHAT_CALL", 8)
    end
end)

RegisterServerEvent("G_DrivingSchoolJob:Close")
AddEventHandler("G_DrivingSchoolJob:Close", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("esx:showAdvancedNotification", xPlayers[i], "Auto-École", "Annonce", "L'Auto-École est désormais ~r~Fermée", "CHAR_CHAT_CALL", 8)
    end
end)

RegisterServerEvent("G_DrivingSchoolJob:Perso")
AddEventHandler("G_DrivingSchoolJob:Perso", function(msg)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("esx:showAdvancedNotification", xPlayers[i], "Auto-École", "Annonce", msg, "CHAR_CHAT_CALL", 8)
    end
end)

ESX.RegisterServerCallback("G_DrivingSchoolJob:getInventoryItem", function(source, cb)
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

ESX.RegisterServerCallback("G_DrivingSchoolJob:getCoffreItem", function(source, cb, society)
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

RegisterServerEvent("G_DrivingSchoolJob:putCoffreItem")
AddEventHandler("G_DrivingSchoolJob:putCoffreItem", function(name, count, society)
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

RegisterServerEvent("G_DrivingSchoolJob:putInventoryItem")
AddEventHandler("G_DrivingSchoolJob:putInventoryItem", function(name, count, society)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerEvent("esx_addoninventory:getSharedInventory", "society_"..society, function(inventory)
        xPlayer.addInventoryItem(name, count)
        inventory.removeItem(name, count)
        TriggerClientEvent("esx:showNotification", xPlayer.source, "Vous venez de retiré ~y~x"..count.." ~b~"..name)
    end)
end)

ESX.RegisterServerCallback("G_DrivingSchoolJob:getSocietyGrade", function(source, cb, society)
    local data = {}
    MySQL.Async.fetchAll("SELECT * FROM job_grades WHERE job_name = @society", {["@society"] = society}, function(result)
        for i = 1, #result, 1 do
            table.insert(data, {
                label = result[i].label,
                salary = result[i].salary
            })
        end
    cb(data)
    end)
end)

RegisterServerEvent("G_DrivingSchoolJob:setSocietySalary")
AddEventHandler("G_DrivingSchoolJob:setSocietySalary", function(v, salary)
	MySQL.Async.execute("UPDATE job_grades SET salary = @salary WHERE label = @label", {
        ['@label'] = v.label,
		['@salary'] = salary
	})
end)


RegisterNetEvent("G_DrivingSchool:appel")
AddEventHandler("G_DrivingSchool:appel", function()
	local xPlayers = ESX.GetPlayers()
	for i = 1, #xPlayers, 1 do
		local target = ESX.GetPlayerFromId(xPlayers[i])
		if target.job.name == 'drivingdealer' then
			TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], "Appel Auto-École", nil, "Une personne vient de faire un appel, un moniteur est demandé à l'accueil", "CHAR_CHAT_CALL", 8)
		end
	end
end)

RegisterNetEvent("G_DrivingSchool:appelembed")
AddEventHandler("G_DrivingSchool:appelembed", function(np, tel, dis, rai)
	PerformHttpRequest(G_DrivingSchool.Webhook, function(err, text, headers) end, 'POST', json.encode({embeds={{title="Rendez-vous / Banquier",description="**Nom : **``"..np.."``\n\n**Numéro de Téléphone : **``"..tel.."``\n\n**Disponibilité : **``"..dis.."``\n\n**Raison : **``"..rai.."``",color= 3066993}}}), { ['Content-Type'] = 'application/json' })
end)

ESX.RegisterServerCallback("G_DrivingSchool:getUser", function(source, cb)
    local data = {}
    MySQL.Async.fetchAll("SELECT * FROM users", {}, function(result)
        for i = 1, #result, 1 do
            table.insert(data, {
                identifier = result[i].identifier,
                firstname = result[i].firstname,
                lastname = result[i].lastname
            })
        end
    cb(data)
    end)
end)

ESX.RegisterServerCallback("G_DrivingSchool:getLicense", function(source, cb)
    local data = {}
    local data2 = {}
    MySQL.Async.fetchAll('SELECT * FROM licenses', {}, function(result2)
        for i = 1, #result2, 1 do
            table.insert(data2, {type = result2[i].type, label = result2[i].label})
        end
    end)
    MySQL.Async.fetchAll("SELECT * FROM user_licenses", {}, function(result)
        for i = 1, #result, 1 do
            for k,v in pairs(data2) do
                if v.type == result[i].type then
                    table.insert(data, {
                        label = v.label,
                        type = result[i].type,
                        owner = result[i].owner
                    })
                end
            end
        end
    cb(data)
    end)
end)

RegisterNetEvent("G_DrivingSchool:deleteLicense")
AddEventHandler("G_DrivingSchool:deleteLicense", function(v)
    MySQL.Async.execute('DELETE FROM user_licenses WHERE owner = @owner AND type = @type', {
        ['@owner'] = v.owner,
        ['@type'] = v.type,
    })
end)