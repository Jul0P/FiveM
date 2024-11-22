if not pGangBuilder.LastLegacy then
    ESX = nil

    TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
end

ESX.RegisterServerCallback('pGangBuilder:getUserGroup', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local group = xPlayer.getGroup()
	cb(group)
end)

ESX.RegisterServerCallback("pGangBuilder:getItems", function(source, cb)
    local data = {}
    if pGangBuilder.LocalWeightActive then
        MySQL.Async.fetchAll('SELECT * FROM items', {}, function(result)
            for i = 1, #result, 1 do
                table.insert(data, {
                    label = result[i].label,
                    name = result[i].name,
                })
            end
            cb(data)
        end)
    end
    if pGangBuilder.WeightActive then
        MySQL.Async.fetchAll('SELECT * FROM items', {}, function(result)
            for i = 1, #result, 1 do
                table.insert(data, {
                    label = result[i].label,
                    name = result[i].name,
                    weight = result[i].weight,
                })
            end
            cb(data)
        end)
    end
end)

RegisterServerEvent("pGangBuilder:createGang")
AddEventHandler("pGangBuilder:createGang", function(name, label, society_pos, society_gestion, garage_pos, spawn_pos, return_pos, pnj, garage_data, coffre_pos, weight, coffre_data, vestiaire_pos, vestiaire_gestion, vestiaire_data, blips, markers, grade)
    MySQL.Async.insert("INSERT INTO pgangbuilder(name, label, society_pos, society_gestion, garage_pos, spawn_pos, return_pos, pnj, garage_data, coffre_pos, weight, coffre_data, vestiaire_pos, vestiaire_gestion, vestiaire_data, blips, markers) VALUES(@name, @label, @society_pos, @society_gestion, @garage_pos, @spawn_pos, @return_pos, @pnj, @garage_data, @coffre_pos, @weight, @coffre_data, @vestiaire_pos, @vestiaire_gestion, @vestiaire_data, @blips, @markers)", {
        ["@name"] = name,
        ["@label"] = label,
        ["@society_pos"] = json.encode(society_pos),
        ["@society_gestion"] = society_gestion,
        ["@garage_pos"] = json.encode(garage_pos),
        ["@spawn_pos"] = json.encode(spawn_pos),
        ["@return_pos"] = json.encode(return_pos),
        ["@pnj"] = pnj,
        ["@garage_data"] = json.encode(garage_data),
        ["@coffre_pos"] = json.encode(coffre_pos),
        ["@weight"] = weight,
        ["@coffre_data"] = json.encode(coffre_data),
        ["@vestiaire_pos"] = json.encode(vestiaire_pos),
        ["@vestiaire_gestion"] = vestiaire_gestion,
        ["@vestiaire_data"] = json.encode(vestiaire_data),
        ["@blips"] = json.encode(blips),
        ["@markers"] = json.encode(markers)
    })
    MySQL.Async.insert("INSERT INTO jobs(name, label) VALUES(@name, @label)", {
        ["@name"] = name,
        ["@label"] = label
    })
    for k,v in pairs(grade) do
        MySQL.Async.insert("INSERT INTO job_grades(job_name, grade, name, label, salary, skin_male, skin_female) VALUES(@job_name, @grade, @name, @label, @salary, @skin_male, @skin_female)", {
            ["@job_name"] = name,
            ["@grade"] = v.number,
            ["@name"] = v.name,
            ["@label"] = v.label,
            ["@salary"] = v.salary,
            ["@skin_male"] = '{}',
            ["@skin_female"] = '{}',
        })
    end
    Wait(500)
    TriggerEvent("esx:refreshJobs")
    refreshJobss()
    TriggerClientEvent('pGangBuilder:getDataGang', -1)
end)

RegisterServerEvent("pGangBuilder:modifyGang")
AddEventHandler("pGangBuilder:modifyGang", function(id, name, label, society_pos, society_gestion, garage_pos, spawn_pos, return_pos, pnj, garage_data, coffre_pos, weight, coffre_data, vestiaire_pos, vestiaire_gestion, vestiaire_data, blips, markers, grade)
    MySQL.Async.insert("UPDATE pgangbuilder SET name = @name, label = @label, society_pos = @society_pos, society_gestion = @society_gestion, garage_pos = @garage_pos, spawn_pos = @spawn_pos, return_pos = @return_pos, pnj = @pnj, garage_data = @garage_data, coffre_pos = @coffre_pos, weight = @weight, coffre_data = @coffre_data, vestiaire_pos = @vestiaire_pos, vestiaire_gestion = @vestiaire_gestion, vestiaire_data = @vestiaire_data, blips = @blips, markers = @markers WHERE id = @id", {
        ["@id"] = id,
        ["@name"] = name,
        ["@label"] = label,
        ["@society_pos"] = json.encode(society_pos),
        ["@society_gestion"] = society_gestion,
        ["@garage_pos"] = json.encode(garage_pos),
        ["@spawn_pos"] = json.encode(spawn_pos),
        ["@return_pos"] = json.encode(return_pos),
        ["@pnj"] = pnj,
        ["@garage_data"] = json.encode(garage_data),
        ["@coffre_pos"] = json.encode(coffre_pos),
        ["@weight"] = weight,
        ["@coffre_data"] = json.encode(coffre_data),
        ["@vestiaire_pos"] = json.encode(vestiaire_pos),
        ["@vestiaire_gestion"] = vestiaire_gestion,
        ["@vestiaire_data"] = json.encode(vestiaire_data),
        ["@blips"] = json.encode(blips),
        ["@markers"] = json.encode(markers)
    })
    MySQL.Async.insert("INSERT INTO jobs(name, label) VALUES(@name, @label)", {
        ["@name"] = name,
        ["@label"] = label
    })
    for k,v in pairs(grade) do
        MySQL.Async.insert("INSERT INTO job_grades(job_name, grade, name, label, salary, skin_male, skin_female) VALUES(@job_name, @grade, @name, @label, @salary, @skin_male, @skin_female)", {
            ["@job_name"] = name,
            ["@grade"] = v.number,
            ["@name"] = v.name,
            ["@label"] = v.label,
            ["@salary"] = v.salary,
            ["@skin_male"] = '{}',
            ["@skin_female"] = '{}',
        })
    end
    Wait(500)
    TriggerEvent("esx:refreshJobs")
    refreshJobss()
    TriggerClientEvent('pGangBuilder:getDataGang', -1)
end)

RegisterServerEvent("pGangBuilder:deleteJobs")
AddEventHandler("pGangBuilder:deleteJobs", function(name, label)
    MySQL.Async.execute("DELETE FROM jobs WHERE name = @name", {
        ["@name"] = name
    })
    MySQL.Async.execute("DELETE FROM jobs WHERE label = @label", {
        ["@label"] = label
    })
end)

RegisterServerEvent("pGangBuilder:deleteJobsGrade")
AddEventHandler("pGangBuilder:deleteJobsGrade", function(name)
    MySQL.Async.execute("DELETE FROM job_grades WHERE job_name = @job_name", {
        ["@job_name"] = name
    })
end)

ESX.RegisterServerCallback("pGangBuilder:getGang", function(source, cb)
    local data = {}
    MySQL.Async.fetchAll('SELECT * FROM pgangbuilder', {}, function(result)
        for i = 1, #result, 1 do
            table.insert(data, {
                id = result[i].id,
                name = result[i].name,
                label = result[i].label,
                society_pos = json.decode(result[i].society_pos),
                society_gestion = result[i].society_gestion,
                garage_pos = json.decode(result[i].garage_pos),
                spawn_pos = json.decode(result[i].spawn_pos),
                return_pos = json.decode(result[i].return_pos),
                pnj = result[i].pnj,
                garage_data = json.decode(result[i].garage_data),
                coffre_pos = json.decode(result[i].coffre_pos),
                weight = result[i].weight,
                coffre_data = json.decode(result[i].coffre_data),
                vestiaire_pos = json.decode(result[i].vestiaire_pos),
                vestiaire_gestion = result[i].vestiaire_gestion,
                vestiaire_data = json.decode(result[i].vestiaire_data),
                blips = json.decode(result[i].blips),
                markers = json.decode(result[i].markers)
            })
        end
        cb(data)
    end)
end)

RegisterServerEvent("pGangBuilder:modifyCoffre")
AddEventHandler("pGangBuilder:modifyCoffre", function(id, data)
    MySQL.Async.execute('UPDATE pgangbuilder SET coffre_data = @coffre_data WHERE id = @id', {
        ['@coffre_data'] = json.encode(data),
        ['@id'] = id
    })
    TriggerClientEvent('pGangBuilder:getDataGang', -1, "coffre")
end)

RegisterServerEvent("pGangBuilder:giveMoneyCoffre")
AddEventHandler("pGangBuilder:giveMoneyCoffre", function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.addMoney(amount)
end) 

RegisterServerEvent("pGangBuilder:giveDirtyMoneyCoffre")
AddEventHandler("pGangBuilder:giveDirtyMoneyCoffre", function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.addAccountMoney(pGangBuilder.BlackMoney, amount)
end) 

RegisterServerEvent("pGangBuilder:giveItemCoffre")
AddEventHandler("pGangBuilder:giveItemCoffre", function(amount, name)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.addInventoryItem(name, amount)
end)    

ESX.RegisterServerCallback("pGangBuilder:hasWeapon", function(source, cb, name)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.hasWeapon(name) then
        cb(false)
    else
        cb(true)
    end
end)

RegisterServerEvent("pGangBuilder:giveWeaponCoffre")
AddEventHandler("pGangBuilder:giveWeaponCoffre", function(amount, name)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.addWeapon(name, amount)
end)  

RegisterServerEvent("pGangBuilder:removeMoneyCoffre")
AddEventHandler("pGangBuilder:removeMoneyCoffre", function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if pGangBuilder.NotLegacy then
        xPlayer.removeMoney(amount)
    else
        xPlayer.removeAccountMoney(pGangBuilder.Money, amount)
    end
end) 

RegisterServerEvent("pGangBuilder:removeDirtyMoneyCoffre")
AddEventHandler("pGangBuilder:removeDirtyMoneyCoffre", function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
     xPlayer.removeAccountMoney(pGangBuilder.BlackMoney, amount)
end) 

RegisterServerEvent("pGangBuilder:removeItemCoffre")
AddEventHandler("pGangBuilder:removeItemCoffre", function(amount, name)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeInventoryItem(name, amount)
end)  

RegisterServerEvent("pGangBuilder:removeWeaponCoffre")
AddEventHandler("pGangBuilder:removeWeaponCoffre", function(amount, name)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeWeapon(name, amount)
end) 

local Jobs = {}

MySQL.ready(function()
    local result = MySQL.Sync.fetchAll('SELECT * FROM jobs', {})
	for i=1, #result do
		Jobs[result[i].name] = result[i]
		Jobs[result[i].name].grades = {}
	end
	local result2 = MySQL.Sync.fetchAll('SELECT * FROM job_grades', {})
	for i=1, #result2 do
		if Jobs[result2[i].job_name] then
			Jobs[result2[i].job_name].grades[tostring(result2[i].grade)] = result2[i]
		else
			print(('[^4pGangBuilder^7] [^3WARNING^7] les grades du job "%s", est/sont invalide(s) car "%s" n\'est pas dans la table jobs'):format(result2[i].job_name, result2[i].job_name))
		end
	end
	for k,v in pairs(Jobs) do
		if next(v.grades) == nil then
			Jobs[v.name] = nil
			print(('[^4pGangBuilder^7] [^3WARNING^7] Nous détectons également que le job "%s" n\'a pas de grade lui étant associé'):format(v.name))
		end
	end
end)

function refreshJobss()
    local result = MySQL.Sync.fetchAll('SELECT * FROM jobs', {})
	for i=1, #result do
		Jobs[result[i].name] = result[i]
		Jobs[result[i].name].grades = {}
	end
	local result2 = MySQL.Sync.fetchAll('SELECT * FROM job_grades', {})
	for i=1, #result2 do
		if Jobs[result2[i].job_name] then
			Jobs[result2[i].job_name].grades[tostring(result2[i].grade)] = result2[i]
		else
			print(('[^4pGangBuilder^7] [^3WARNING^7] les grades du job "%s", est/sont invalide(s) car "%s" n\'est pas dans la table jobs'):format(result2[i].job_name, result2[i].job_name))
		end
	end
	for k,v in pairs(Jobs) do
		if next(v.grades) == nil then
			Jobs[v.name] = nil
			print(('[^4pGangBuilder^7] [^3WARNING^7] Nous détectons également que le job "%s" n\'a pas de grade lui étant associé'):format(v.name))
		end
	end
end


ESX.RegisterServerCallback("pGangBuilder:getSocietyEmployees", function(source, cb, society)
    MySQL.Async.fetchAll('SELECT firstname, lastname, identifier, job2, job2_grade FROM users WHERE job2 = @job2 ORDER BY job2_grade DESC', {['@job2'] = society}, function (results)
		local employees = {}
		local identity = nil
		for i=1, #results, 1 do
			if results[i].firstname == nil or results[i].lastname == nil then 
                identity = results[i].name 
            else 
                identity = results[i].firstname.. " " ..results[i].lastname 
            end
			table.insert(employees, {
				name = identity,
				identifier = results[i].identifier,
				job = {
					name = results[i].job2,
					label = Jobs[results[i].job2].label,
					grade = results[i].job2_grade,
					grade_name  = Jobs[results[i].job2].grades[tostring(results[i].job2_grade)].name,
					grade_label = Jobs[results[i].job2].grades[tostring(results[i].job2_grade)].label
				}
			})
		end
		cb(employees)
	end)
end)

getMaximumGrade = function(jobname)
	local queryDone, queryResult = false, nil

	MySQL.Async.fetchAll('SELECT * FROM job_grades WHERE job_name = @jobname ORDER BY `grade` DESC ;', {
		['@jobname'] = jobname
	}, function(result)
		queryDone, queryResult = true, result
	end)

	while not queryDone do
		Citizen.Wait(10)
	end

	if queryResult[1] then
		return queryResult[1].grade
	end

	return nil
end

RegisterServerEvent("pGangBuilder:recruter")
AddEventHandler("pGangBuilder:recruter", function(z)
    local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromIdentifier(z.identifier)
    MySQL.Async.execute('UPDATE users SET job2 = @job2, job2_grade = @job2_grade WHERE identifier = @identifier', {
        ['@job2'] = z.job.name,
        ['@job2_grade'] = 0,
        ['@identifier'] = z.identifier
    })
    xTarget.setJob2(z.job.name, 0)
    TriggerClientEvent('esx:showNotification', xPlayer.source, "Le joueur a été recruté")
    TriggerClientEvent('esx:showNotification', xTarget.source, "Vous avez été recruté")
end) 

RegisterServerEvent("pGangBuilder:proxyrecruter")
AddEventHandler("pGangBuilder:proxyrecruter", function(z, target)
    local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(target)
    MySQL.Async.execute('UPDATE users SET job2 = @job2, job2_grade = @job2_grade WHERE identifier = @identifier', {
        ['@job2'] = z.job.name,
        ['@job2_grade'] = 0,
        ['@identifier'] = xTarget.identifier
    }) 
    xTarget.setJob2(z.job.name, 0)
    TriggerClientEvent('esx:showNotification', xPlayer.source, "Le joueur a été recruté")
    TriggerClientEvent('esx:showNotification', target, "Vous avez été recruté")
end) 

RegisterServerEvent("pGangBuilder:virer")
AddEventHandler("pGangBuilder:virer", function(z)
    local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromIdentifier(z.identifier)
    MySQL.Async.execute('UPDATE users SET job2 = @job2, job2_grade = @job2_grade WHERE identifier = @identifier', {
        ['@job2'] = "unemployed2",
        ['@job2_grade'] = 0,
        ['@identifier'] = z.identifier
    })
    xTarget.setJob2("unemployed2", 0)
    TriggerClientEvent('esx:showNotification', xPlayer.source, "Le joueur a été viré")
    TriggerClientEvent('esx:showNotification', xTarget.source, "Vous avez été viré")
end) 

RegisterServerEvent("pGangBuilder:proxyvirer")
AddEventHandler("pGangBuilder:proxyvirer", function(z, target)
    local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(target)
    MySQL.Async.execute('UPDATE users SET job2 = @job2, job2_grade = @job2_grade WHERE identifier = @identifier', {
        ['@job2'] = "unemployed2",
        ['@job2_grade'] = 0,
        ['@identifier'] = xTarget.identifier
    })
    xTarget.setJob2("unemployed2", 0)
    TriggerClientEvent('esx:showNotification', xPlayer.source, "Le joueur a été viré")
    TriggerClientEvent('esx:showNotification', target, "Vous avez été viré")
end) 

RegisterServerEvent("pGangBuilder:promouvoir")
AddEventHandler("pGangBuilder:promouvoir", function(z)
    local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromIdentifier(z.identifier)
    if tonumber(z.job.grade) + 1 <= getMaximumGrade(z.job.name) then 
        MySQL.Async.execute('UPDATE users SET job2 = @job2, job2_grade = @job2_grade WHERE identifier = @identifier', {
            ['@job2'] = z.job.name,
            ['@job2_grade'] = z.job.grade + 1,
            ['@identifier'] = z.identifier
        })
        xTarget.setJob2(z.job.name, tonumber(z.job2.grade) + 1)
        TriggerClientEvent('esx:showNotification', xPlayer.source, "Le joueur a été promu")
        TriggerClientEvent('esx:showNotification', xTarget.source, "Vous avez été promu")
    end
end) 

RegisterServerEvent("pGangBuilder:proxypromouvoir")
AddEventHandler("pGangBuilder:proxypromouvoir", function(z, target)
    local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(target)
    if tonumber(z.job.grade) + 1 <= getMaximumGrade(z.job.name) then 
        if xPlayer.job2.name == xTarget.job2.name then
            MySQL.Async.execute('UPDATE users SET job2 = @job2, job2_grade = @job2_grade WHERE identifier = @identifier', {
                ['@job2'] = z.job.name,
                ['@job2_grade'] = xTarget.job.grade + 1,
                ['@identifier'] = xTarget.identifier
            })
            xTarget.setJob2(z.job.name, tonumber(xTarget.job2.grade) + 1)
            TriggerClientEvent('esx:showNotification', xPlayer.source, "Le joueur a été promu")
            TriggerClientEvent('esx:showNotification', target, "Vous avez été promu")
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, "Le joueur n'a pas le même job2 que vous")
        end
    end
end) 

RegisterServerEvent("pGangBuilder:destituer")
AddEventHandler("pGangBuilder:destituer", function(z)
    local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromIdentifier(z.identifier)
    if tonumber(z.job.grade) > 0 then
        MySQL.Async.execute('UPDATE users SET job2 = @job2, job2_grade = @job2_grade WHERE identifier = @identifier', {
            ['@job2'] = z.job.name,
            ['@job2_grade'] = z.job.grade - 1,
            ['@identifier'] = z.identifier
        })
        xTarget.setJob2(z.job.name, tonumber(z.job2.grade) - 1)
        TriggerClientEvent('esx:showNotification', xPlayer.source, "Le joueur a été rétrogradé")
        TriggerClientEvent('esx:showNotification', xTarget.source, "Vous avez été rétrogradé")
    end
end) 

RegisterServerEvent("pGangBuilder:proxydestituer")
AddEventHandler("pGangBuilder:proxydestituer", function(z, target)
    local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(target)
    if tonumber(xTarget.job.grade) > 0 then
        if xPlayer.job2.name == xTarget.job2.name then
            MySQL.Async.execute('UPDATE users SET job2 = @job2, job2_grade = @job2_grade WHERE identifier = @identifier', {
                ['@job2'] = z.job.name,
                ['@job2_grade'] = xTarget.job.grade - 1,
                ['@identifier'] = xTarget.identifier
            })
            xTarget.setJob2(z.job.name, tonumber(xTarget.job2.grade) - 1)
            TriggerClientEvent('esx:showNotification', xPlayer.source, "Le joueur a été rétrogradé")
            TriggerClientEvent('esx:showNotification', target, "Vous avez été rétrogradé")
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, "Le joueur n'a pas le même job2 que vous")
        end
    end
end) 

ESX.RegisterServerCallback("pGangBuilder:getSocietyGrade", function(source, cb, society)
    local data = {}
    MySQL.Async.fetchAll('SELECT * FROM job_grades WHERE job_name = @society', {['@society'] = society}, function(result)
        for i = 1, #result, 1 do
            table.insert(data, {
                job_name = result[i].job_name,
                grade = result[i].grade,
                name = result[i].name,
                label = result[i].label,
                salary = result[i].salary
            })
        end
        cb(data)
    end)
end)

RegisterServerEvent("pGangBuilder:modifySociety")
AddEventHandler("pGangBuilder:modifySociety", function(types, value, z)
    if types == "label" then
        MySQL.Async.execute('UPDATE job_grades SET label = @label WHERE job_name = @job_name AND name = @name AND grade = @grade', {
            ['@label'] = value,
            ['@job_name'] = z.job_name,
            ['@name'] = z.name,
            ['@grade'] = z.grade
        })
    elseif types == "name" then
        MySQL.Async.execute('UPDATE job_grades SET name = @name WHERE job_name = @job_name AND label = @label AND grade = @grade', {
            ['@name'] = value,
            ['@job_name'] = z.job_name,
            ['@label'] = z.label,
            ['@grade'] = z.grade
        })
    elseif types == "salary" then
        MySQL.Async.execute('UPDATE job_grades SET salary = @salary WHERE job_name = @job_name AND label = @label AND grade = @grade AND name = @name', {
            ['@salary'] = value,
            ['@job_name'] = z.job_name,
            ['@label'] = z.label,
            ['@grade'] = z.grade,
            ['@name'] = z.name,
        })
    elseif types == "grade" then
        MySQL.Async.execute('UPDATE job_grades SET grade = @grade WHERE job_name = @job_name AND label = @label AND salary = @salary AND name = @name', {
            ['@salary'] = z.salary,
            ['@job_name'] = z.job_name,
            ['@label'] = z.label,
            ['@grade'] = value,
            ['@name'] = z.name,
        })
    elseif types == "delete" then
        MySQL.Async.execute('DELETE FROM job_grades WHERE job_name = @job_name AND label = @label AND grade = @grade AND name = @name', {
            ['@job_name'] = z.job_name,
            ['@label'] = z.label,
            ['@grade'] = z.grade,
            ['@name'] = z.name,
        })
    elseif types == "add" then 
        MySQL.Async.insert("INSERT INTO job_grades(job_name, grade, name, label, salary) VALUES(@job_name, @grade, @name, @label, @salary)", {
            ["@job_name"] = z,
            ["@grade"] = value.grade,
            ["@name"] = value.name,
            ["@label"] = value.label,
            ["@salary"] = value.salary,
        })
    end
end)

RegisterServerEvent("pGangBuilder:modifyGarage")
AddEventHandler("pGangBuilder:modifyGarage", function(id, data)
    MySQL.Async.execute('UPDATE pgangbuilder SET garage_data = @garage_data WHERE id = @id', {
        ['@garage_data'] = json.encode(data),
        ['@id'] = id
    })
    TriggerClientEvent('pGangBuilder:getDataGang', -1, "garage")
end)

RegisterServerEvent("pGangBuilder:deleteGang")
AddEventHandler("pGangBuilder:deleteGang", function(id)
    MySQL.Async.execute('DELETE FROM pgangbuilder WHERE id = @id', {
        ['@id'] = id
    })
    TriggerClientEvent('pGangBuilder:getDataGang', -1)
end)

RegisterServerEvent("pGangBuilder:saveNewClothes")
AddEventHandler("pGangBuilder:saveNewClothes", function(id, data)
    MySQL.Async.execute('UPDATE pgangbuilder SET vestiaire_data = @vestiaire_data WHERE id = @id', {
        ['@vestiaire_data'] = json.encode(data),
        ['@id'] = id
    })
    TriggerClientEvent('pGangBuilder:getDataGang', -1, "vestiaire")
end)

ESX.RegisterServerCallback('pGangBuilder:getOtherPlayerData', function(source, cb, target, notify)
    local xPlayer = ESX.GetPlayerFromId(target)
    TriggerClientEvent("esx:showNotification", target, "Vous êtes entrain de vous faire fouiller")
    if xPlayer then
        local data = {
            name = xPlayer.getName(),
            job = xPlayer.job.label,
            grade = xPlayer.job.grade_label,
            inventory = xPlayer.getInventory(),
            accounts = xPlayer.getAccounts(),
            weapons = xPlayer.getLoadout(),
            money = xPlayer.getMoney()
        }
        cb(data)
    end
end)

RegisterNetEvent('pGangBuilder:confiscatePlayerItem')
AddEventHandler('pGangBuilder:confiscatePlayerItem', function(target, itemType, itemName, amount)
    local _source = source
    local sourceXPlayer = ESX.GetPlayerFromId(_source)
    local targetXPlayer = ESX.GetPlayerFromId(target)
    if itemType == 'item_standard' then
        local targetItem = targetXPlayer.getInventoryItem(itemName)
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)
        targetXPlayer.removeInventoryItem(itemName, amount)
        sourceXPlayer.addInventoryItem(itemName, amount)
        TriggerClientEvent("esx:showNotification", source, "Vous avez pris ~y~x"..amount.." ~b~"..sourceItem.label)
        TriggerClientEvent("esx:showNotification", target, "Quelqu'un vous à pris ~y~x"..amount.." ~b~"..sourceItem.label)
    elseif itemType == 'item_money' then
        targetXPlayer.removeMoney(amount)
        sourceXPlayer.addMoney(amount)
        TriggerClientEvent("esx:showNotification", source, "Vous avez pris ~g~"..amount.."$ ~s~d'argent propre")
        TriggerClientEvent("esx:showNotification", target, "Quelqu'un vous à pris ~g~"..amount.."$ ~s~d'argent propre")
    elseif itemType == 'item_account' then
        targetXPlayer.removeAccountMoney(itemName, amount)
        sourceXPlayer.addAccountMoney(itemName, amount)
        TriggerClientEvent("esx:showNotification", source, "Vous avez pris ~r~"..amount.."$ ~s~d'argent sale")
        TriggerClientEvent("esx:showNotification", target, "Quelqu'un vous à pris ~r~"..amount.."$ ~s~d'argent sale")
    elseif itemType == 'item_weapon' then
        if amount == nil then amount = 0 end
        targetXPlayer.removeWeapon(itemName, amount)
        sourceXPlayer.addWeapon(itemName, amount)
        TriggerClientEvent("esx:showNotification", source, "Vous avez pris ~y~x1 ~b~"..ESX.GetWeaponLabel(itemName).."~s~ avec ~o~x"..amount.."~s~ balle")
        TriggerClientEvent("esx:showNotification", target, "Quelqu'un vous à pris ~y~x1 ~b~"..ESX.GetWeaponLabel(itemName).."~s~ avec ~o~x"..amount.."~s~ balle")
    end
    if sourceXPlayer > targetXPlayer then
        TriggerClientEvent("esx:showNotification", source, "Valeur Invalide")
    end
end)

RegisterServerEvent('pGangBuilder:PutHandcuff')
AddEventHandler('pGangBuilder:PutHandcuff', function(targetid, playerheading, playerCoords,  playerlocation)
    local _source = source
    TriggerClientEvent('pGangBuilder:PutHandcuff', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('pGangBuilder:AnimationRemoveHandcuff', _source)
end)

RegisterServerEvent('pGangBuilder:PutHandcuffFreeze')
AddEventHandler('pGangBuilder:PutHandcuffFreeze', function(targetid, playerheading, playerCoords,  playerlocation)
    local _source = source
    TriggerClientEvent('pGangBuilder:PutHandcuffFreeze', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('pGangBuilder:AnimationRemoveHandcuff', _source)
end)

RegisterServerEvent('pGangBuilder:RemoveHandcuff')
AddEventHandler('pGangBuilder:RemoveHandcuff', function(targetid, playerheading, playerCoords,  playerlocation)
    local _source = source
    TriggerClientEvent('pGangBuilder:RemoveHandcuff', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('pGangBuilder:AnimationRemoveHandcuff', _source)
end)

RegisterServerEvent('pGangBuilder:Escort')
AddEventHandler('pGangBuilder:Escort', function(target)
	local _source = source
	TriggerClientEvent('pGangBuilder:Escort', target, _source)
end)

RegisterNetEvent('pGangBuilder:putInVehicle')
AddEventHandler('pGangBuilder:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job2.name ~= 'unemployed2' then
		TriggerClientEvent('pGangBuilder:putInVehicle', target)
	else
	end
end)

RegisterNetEvent('pGangBuilder:OutVehicle')
AddEventHandler('pGangBuilder:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job2.name ~= 'unemployed2' then
		TriggerClientEvent('pGangBuilder:OutVehicle', target)
	else
	end
end)