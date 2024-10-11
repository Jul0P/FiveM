if pAscenseurBuilder.ESX == "new" then
	ESX = exports["es_extended"]:getSharedObject()
elseif pAscenseurBuilder.ESX == "old" then
	ESX = nil
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

ESX.RegisterServerCallback('pAscenseurBuilder:getUserGroup', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local group = xPlayer.getGroup()
	cb(group)
end)

ESX.RegisterServerCallback('pAscenseurBuilder:getDataJobs', function(source, cb)
    local Jobs = {}
    MySQL.Async.fetchAll('SELECT * FROM jobs', {}, function(result)
        for i = 1, #result, 1 do
            table.insert(Jobs, {
                name = result[i].name,
                label = result[i].label,
            })
        end
    cb(Jobs)
    end)
end)

ESX.RegisterServerCallback('pAscenseurBuilder:getDataUsers', function(source, cb)
    local Users = {}
    MySQL.Async.fetchAll('SELECT * FROM users', {}, function(result)
        for i = 1, #result, 1 do
            table.insert(Users, {
                identifier = result[i].identifier,
                firstname = result[i].firstname,
                lastname = result[i].lastname
            })
        end
        cb(Users)
    end)
end)

RegisterServerEvent("pAscenseurBuilder:createAscenseur")
AddEventHandler("pAscenseurBuilder:createAscenseur", function(label, teleport_data, job_data, user_data, blips_data, markers_data)
    MySQL.Async.insert("INSERT INTO pascenseurbuilder(label, teleport_data, job_data, user_data, blips_data, markers_data) VALUES(@label, @teleport_data, @job_data, @user_data, @blips_data, @markers_data)", {
        ["@label"] = label,
        ["@teleport_data"] = json.encode(teleport_data),
        ["@job_data"] = json.encode(job_data),
        ["@user_data"] = json.encode(user_data),
        ["@blips_data"] = json.encode(blips_data),
        ["@markers_data"] = json.encode(markers_data)
    })
end)

ESX.RegisterServerCallback("pAscenseurBuilder:getAscenseur", function(source, cb)
    local data = {}
    MySQL.Async.fetchAll('SELECT * FROM pascenseurbuilder', {}, function(result)
        for i = 1, #result, 1 do
            table.insert(data, {
                id = result[i].id,
                label = result[i].label,
                teleport_data = json.decode(result[i].teleport_data),
                job_data = json.decode(result[i].job_data),
                user_data = json.decode(result[i].user_data),
                blips_data = json.decode(result[i].blips_data),
                markers_data = json.decode(result[i].markers_data)
            })
        end
        cb(data)
    end)
end)

RegisterServerEvent("pAscenseurBuilder:modifyAscenseur")
AddEventHandler("pAscenseurBuilder:modifyAscenseur", function(id, label, teleport_data, job_data, user_data, blips_data, markers_data)
    MySQL.Async.insert("UPDATE pascenseurbuilder SET label = @label, teleport_data = @teleport_data, job_data = @job_data, user_data = @user_data, blips_data = @blips_data, markers_data = @markers_data WHERE id = @id", {
        ["@id"] = id,
        ["@label"] = label,
        ["@teleport_data"] = json.encode(teleport_data),
        ["@job_data"] = json.encode(job_data),
        ["@user_data"] = json.encode(user_data),
        ["@blips_data"] = json.encode(blips_data),
        ["@markers_data"] = json.encode(markers_data)
    })
end)

RegisterServerEvent("pAscenseurBuilder:deleteAscenseur")
AddEventHandler("pAscenseurBuilder:deleteAscenseur", function(id)
    MySQL.Async.insert("DELETE FROM pascenseurbuilder WHERE id = @id", {
        ["@id"] = id
    })
end)