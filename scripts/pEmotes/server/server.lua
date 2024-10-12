if pEmotes.ESX == "new" then
	ESX = exports["es_extended"]:getSharedObject()
elseif pEmotes.ESX == "old" then
	ESX = nil
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

RegisterServerEvent('pEmotes:syncAccepted')
AddEventHandler('pEmotes:syncAccepted', function(requester, id)
    local accepted = source
    TriggerClientEvent('pEmotes:playSynced', accepted, requester, id, 'Accepter')
    TriggerClientEvent('pEmotes:playSynced', requester, accepted, id, 'Requester')
end)

RegisterServerEvent('pEmotes:requestSynced')
AddEventHandler('pEmotes:requestSynced', function(target, id)
    local requester = source
    local xPlayer = ESX.GetPlayerFromId(requester)
    MySQL.single('SELECT firstname, lastname FROM users WHERE identifier = ?', {xPlayer.identifier}, function(result)
        TriggerClientEvent('pEmotes:syncRequest', target, requester, id, result.firstname.." "..result.lastname)
    end)
end)

ESX.RegisterServerCallback('pEmotes:getAnimations', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    animlist = {}
    MySQL.Async.fetchAll("SELECT * FROM pemote WHERE licence = @licence", {['@licence'] = xPlayer.identifier}, function(animations)
        for k,v in pairs(animations) do
            table.insert(animlist, {id = v.id, licence = v.licence, name = v.name, originalname = v.originalname, data = json.decode(v.data), type = v.type, keybind = v.keybind, favorite = v.favorite})
        end
        cb(animlist)
    end)
end)

RegisterServerEvent('pEmotes:saveemote')
AddEventHandler('pEmotes:saveemote', function(data, type, name, originalname, favorite)
    local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll("SELECT * FROM pemote WHERE originalname = @originalname AND licence = @licence", {['@originalname'] = originalname, ['@licence'] = xPlayer.identifier}, function(result)
		if result[1] then
            if result[1].favorite == nil then
                MySQL.Async.execute("UPDATE pemote SET favorite = @favorite WHERE originalname = @originalname AND licence = @licence", {['@favorite'] = favorite, ['@originalname'] = originalname, ['@licence'] = xPlayer.identifier})
                TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous venez de mettre en favoris l'emote ~b~"..name)
            else
			    TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous avez déjà mis en favoris l'emote ~b~"..name)
            end
		else
			MySQL.Async.execute("INSERT INTO pemote (licence, name, originalname, data, type, favorite) VALUES (@licence, @name, @originalname, @data, @type, @favorite)", {['@licence'] = xPlayer['identifier'], ['@name'] = name, ['@originalname'] = originalname, ['@data'] = json.encode(data), ['@type'] = type, ['@favorite'] = favorite})
			TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous venez de mettre en favoris l'emote ~b~"..name)
		end
    end)
end)

RegisterServerEvent('pEmotes:saveemotekeybind')
AddEventHandler('pEmotes:saveemotekeybind', function(data, type, name, originalname, keybind)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT * FROM pemote WHERE keybind = @keybind AND licence = @licence", {['@keybind'] = keybind, ['@licence'] = xPlayer.identifier}, function(result)
        if result[1] then
            TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous avez déjà mis en keybind l'emote ~b~"..result[1].name.."\n~s~Keybind ~b~"..keybind)
        else
            MySQL.Async.fetchAll("SELECT * FROM pemote WHERE originalname = @originalname AND licence = @licence", {['@originalname'] = originalname, ['@licence'] = xPlayer.identifier}, function(result2)
                if result2[1] then  
                    if result2[1].keybind == nil then
                        MySQL.Async.execute("UPDATE pemote SET keybind = @keybind WHERE originalname = @originalname AND licence = @licence", {['@keybind'] = keybind, ['@originalname'] = originalname, ['@licence'] = xPlayer.identifier})
                        TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous venez de mettre en keybind l'emote ~b~"..name.."\n~s~Keybind ~b~"..keybind)
                    else  
                        TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous avez déjà mis en keybind l'emote ~b~"..result2[1].name.."\n~s~Keybind ~b~"..result2[1].keybind)                 
                    end
                else
                    MySQL.Async.execute("INSERT INTO pemote (licence, name, originalname, data, type, keybind) VALUES (@licence, @name, @originalname, @data, @type, @keybind)", {['@licence'] = xPlayer['identifier'], ['@name'] = name, ['@originalname'] = originalname, ['@data'] = json.encode(data), ['@type'] = type, ['@keybind'] = keybind})
                    TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous venez de mettre en keybind l'emote ~b~"..originalname.."\n~s~Keybind ~b~"..keybind)
                end
            end)
        end
    end)
end)

RegisterServerEvent('pEmotes:removeAnimation')
AddEventHandler('pEmotes:removeAnimation', function(value, type)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT * FROM pemote WHERE id = @id", {['@id'] = value.id}, function(result)
		if result[1] then
            if result[1].keybind ~= nil and result[1].favorite ~= nil then
                if type == "keybind" then
                    MySQL.Async.execute("UPDATE pemote SET keybind = @keybind WHERE id = @id", {['@id'] = value.id, ['@keybind'] = nil})
                    TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous venez de supprimer l'emote ~b~"..value.name.." ~s~de la catégorie ~y~"..type)
                elseif type == "favorite" then
                    MySQL.Async.execute("UPDATE pemote SET favorite = @favorite WHERE id = @id", {['@id'] = value.id, ['@favorite'] = nil})
                    TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous venez de supprimer l'emote ~b~"..value.name.." ~s~de la catégorie ~y~"..type)
                end
            elseif result[1].keybind == nil then
                MySQL.Async.execute("DELETE FROM pemote WHERE id = @id", {['@id'] = value.id})
                TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous venez de supprimer l'emote ~b~"..value.name.." ~s~de la catégorie ~y~"..type)
            elseif result[1].favorite == nil then
                MySQL.Async.execute("DELETE FROM pemote WHERE id = @id", {['@id'] = value.id})
                TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous venez de supprimer l'emote ~b~"..value.name.." ~s~de la catégorie ~y~"..type)
            end
		end
    end)
end)

RegisterServerEvent('pEmotes:renameAnimation')
AddEventHandler('pEmotes:renameAnimation', function(id, name)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.execute("UPDATE pemote SET name = @name WHERE id = @id", {['@id'] = id, ['@name'] = name})
    TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous venez de renommer l'emote ~b~"..name)
end)

ESX.RegisterCommand('e', "user", function(xPlayer, args, showError)
	TriggerClientEvent("pEmotes:Command", xPlayer.source, args.emote)
end, true, {help = "Jouer une emote", validate = true, arguments = {
	{name = 'emote', help = "Nom de l'emote", type = 'string'}
}})