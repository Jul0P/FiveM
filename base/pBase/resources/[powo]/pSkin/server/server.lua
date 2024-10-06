if pSkin.ESX == "new" then
	ESX = exports["es_extended"]:getSharedObject()
elseif pSkin.ESX == "old" then
	ESX = nil
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

data = {}

Citizen.CreateThread(function()
	data = json.decode(LoadResourceFile('pSkin', 'data/skin.json'))
end)

RegisterServerEvent('pSkin:getData')
AddEventHandler('pSkin:getData', function()
	TriggerClientEvent("pSkin:getData", source, data)
end)

RegisterServerEvent('pSkin:setData')
AddEventHandler('pSkin:setData', function(type, value, target)
	if type == "save" then
		table.insert(data, value)
	elseif type == "share" then
		table.insert(data, value)
		TriggerClientEvent('pSkin:getData', target, data)
	elseif type == "edit" then
		table.remove(data, value.index)
		table.insert(data, value.index, value.skin)
	elseif type == "rename" then
		table.remove(data, value.index)
		table.insert(data, value.index, value.skin)
	elseif type == "delete" then
		table.remove(data, value)
	end
	SaveResourceFile('pSkin', 'data/skin.json', json.encode(data))
	TriggerClientEvent('pSkin:getData', source, data)
end)

ESX.RegisterServerCallback('pSkin:getUserGroup', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local group = xPlayer.getGroup()
	cb(group)
end)

ESX.RegisterServerCallback('pSkin:getUserIdentifier', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)
	local identifier = xPlayer.identifier
	cb(identifier)
end)


RegisterServerEvent('esx_skin:save')
AddEventHandler('esx_skin:save', function(skin)
	local xPlayer = ESX.GetPlayerFromId(source)

	if pSkin.Legacy then
		local defaultMaxWeight = ESX.GetConfig().MaxWeight
		local backpackModifier = pSkin.BackpackWeight[skin.bags_1]

		if backpackModifier then
			xPlayer.setMaxWeight(defaultMaxWeight + backpackModifier)
		else
			xPlayer.setMaxWeight(defaultMaxWeight)
		end
	end

	MySQL.Async.execute('UPDATE users SET skin = @skin WHERE identifier = @identifier', {
		['@skin'] = json.encode(skin),
		['@identifier'] = xPlayer.identifier
	})
end)

if pSkin.Legacy then
	RegisterServerEvent('esx_skin:setWeight')
	AddEventHandler('esx_skin:setWeight', function(skin)
		local xPlayer = ESX.GetPlayerFromId(source)

		if pSkin.ESX == "new" then
			if not ESX.GetConfig().OxInventory then
				local defaultMaxWeight = ESX.GetConfig().MaxWeight
				local backpackModifier = pSkin.BackpackWeight[skin.bags_1]

				if backpackModifier then
					xPlayer.setMaxWeight(defaultMaxWeight + backpackModifier)
				else
					xPlayer.setMaxWeight(defaultMaxWeight)
				end
			end
		else
			local defaultMaxWeight = ESX.GetConfig().MaxWeight
			local backpackModifier = pSkin.BackpackWeight[skin.bags_1]

			if backpackModifier then
				xPlayer.setMaxWeight(defaultMaxWeight + backpackModifier)
			else
				xPlayer.setMaxWeight(defaultMaxWeight)
			end
		end
	end)
end

RegisterServerEvent('esx_skin:responseSaveSkin')
AddEventHandler('esx_skin:responseSaveSkin', function(skin)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getGroup() == 'admin' then
		local file = io.open('resources/[non-esx]/G_skin/skins.txt', "a")

		file:write(json.encode(skin) .. "\n\n")
		file:flush()
		file:close()
	else
		print(('esx_skin: %s attempted saving skin to file'):format(xPlayer.getIdentifier()))
	end
end)

ESX.RegisterServerCallback('esx_skin:getPlayerSkin', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.query('SELECT skin FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(users)
		local user, skin = users[1]

		local jobSkin = {
			skin_male   = xPlayer.job.skin_male,
			skin_female = xPlayer.job.skin_female
		}

		if user.skin then
			skin = json.decode(user.skin)
		end

		cb(skin, jobSkin)
	end)
end)