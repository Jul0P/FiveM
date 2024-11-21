ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if not G_Sim.GKSPHONE then
	ESX.RegisterServerCallback("</G_Sim>(G):getItemAmount", function(source, cb, item)
		local xPlayer = ESX.GetPlayerFromId(source)
		local items = xPlayer.getInventoryItem(item)
		if items == nil then
			cb(0)
		else
			cb(items.count)
		end
	end)

	ESX.RegisterServerCallback("</G_Sim>(G):getData", function(source, cb)
		local xPlayer = ESX.GetPlayerFromId(source)
		MySQL.Async.fetchAll('SELECT * FROM g_sim WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		},
		function(data)
			cb(data)
		end)
	end)

	ESX.RegisterServerCallback("</G_Sim>(G):getData2", function(source, cb)
		local xPlayer = ESX.GetPlayerFromId(source)
		MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		},
		function(result)
			cb(result[1].phone_number)
		end)
	end)

	RegisterServerEvent("</G_Sim>(G):Use")
	AddEventHandler("</G_Sim>(G):Use", function(number)
		local xPlayer = ESX.GetPlayerFromId(source)
		MySQL.Async.execute('UPDATE users SET phone_number = @phone_number WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier,
			['@phone_number'] = number
		})
		TriggerClientEvent("esx:showNotification", source, "Nouveau numéro : ~b~"..number)
	end)

	RegisterServerEvent("</G_Sim>(G):Give")
	AddEventHandler("</G_Sim>(G):Give", function(target, number)
		local xPlayer = ESX.GetPlayerFromId(source)
		local xPlayer2 = ESX.GetPlayerFromId(target)
		MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		},
		function(result)
			if result[1].phone_number == number then
				MySQL.Async.execute('UPDATE users SET phone_number = @phone_number WHERE identifier = @identifier', {
					['@identifier'] = xPlayer.identifier,
					['@phone_number'] = ""
				})
			end
			MySQL.Async.execute('DELETE FROM g_sim WHERE identifier = @job AND number = @number', {
				['@job'] = xPlayer.identifier,
				['@number'] = number
			})
			MySQL.Async.execute('INSERT INTO g_sim (identifier, number, name) VALUES (@name, @number, @label)', {
				['@name'] = xPlayer.identifier,
				['@number'] = number,
				['@label'] = "SIM "..number
			},
			function(_)
			end)
			TriggerClientEvent("esx:showNotification", source, "Suppression de la carte SIM : ~r~"..number)
			TriggerClientEvent("esx:showNotification", target, "Ajout de la carte SIM : ~b~"..number)
		end)
	end)


	RegisterServerEvent("</G_Sim>(G):Rename")
	AddEventHandler("</G_Sim>(G):Rename", function(id, name)
		local xPlayer = ESX.GetPlayerFromId(source)
		MySQL.Async.execute('UPDATE g_sim SET name = @name WHERE id = @id', {
			['@id'] = id,
			['@name'] = name
		})
	end)

	RegisterServerEvent("</G_Sim>(G):Delete")
	AddEventHandler("</G_Sim>(G):Delete", function(number)
		local xPlayer = ESX.GetPlayerFromId(source)
		MySQL.Async.execute('UPDATE users SET phone_number = @phone_number WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier,
			['@phone_number'] = nil
		})
		MySQL.Async.execute('DELETE FROM g_sim WHERE identifier = @identifier AND number = @number', {
			['@identifier'] = xPlayer.identifier,
			['@number'] = number
		})
		TriggerClientEvent("esx:showNotification", source, "Suppression de la carte SIM : ~r~"..number)
	end)

	ESX.RegisterUsableItem("sim", function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem("sim", 1)
		number = GenerateUniquePhoneNumber()
		MySQL.Async.execute('INSERT INTO g_sim (identifier, number, name) VALUES (@identifier, @number, @name)', {
			['@identifier'] = xPlayer.identifier,
			['@number'] = number,
			['@name'] = "SIM ("..number..")"
		})
		TriggerClientEvent("esx:showNotification", source, "Nouvelle carte SIM : ~b~"..number)
	end)

	function GenerateUniquePhoneNumber()
		local running = true 
		local phone = nil
		if G_Sim.Language == "US" then
			while running do
				local rand = "555"..math.random(1000,9999)
				local count = MySQL.Sync.fetchScalar("SELECT COUNT(number) FROM g_sim WHERE number = @phone_number", { 
					["@phone_number"] = rand
				})
				if count < 1 then
					phone = rand 
					running = false
				end
			end
		elseif G_Sim.Language == "FR" then
			while running do
				local rand = "0"..math.random(600000000,699999999)
				local count = MySQL.Sync.fetchScalar("SELECT COUNT(number) FROM g_sim WHERE number = @phone_number", { 
					["@phone_number"] = rand
				})
				if count < 1 then
					phone = rand 
					running = false
				end
			end
		end
		return phone
	end
else
	ESX.RegisterServerCallback("</G_Sim>(G):getItemAmount", function(source, cb, item)
		local xPlayer = ESX.GetPlayerFromId(source)
		local items = xPlayer.getInventoryItem(item)
		if items == nil then
			cb(0)
		else
			cb(items.count)
		end
	end)

	ESX.RegisterServerCallback("</G_Sim>(G):getData", function(source, cb)
		local xPlayer = ESX.GetPlayerFromId(source)
		MySQL.Async.fetchAll('SELECT * FROM user_sim WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		},
		function(data)
			cb(data)
		end)
	end)

	ESX.RegisterServerCallback("</G_Sim>(G):getData2", function(source, cb)
		local xPlayer = ESX.GetPlayerFromId(source)
		MySQL.Async.fetchAll('SELECT * FROM gksphone_settings WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		},
		function(result)
			cb(result[1].phone_number)
		end)
	end)

	RegisterServerEvent("</G_Sim>(G):Use")
	AddEventHandler("</G_Sim>(G):Use", function(number)
		local xPlayer = ESX.GetPlayerFromId(source)
		MySQL.Async.execute('UPDATE gksphone_settings SET phone_number = @phone_number WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier,
			['@phone_number'] = number
		})
		TriggerClientEvent("esx:showNotification", source, "Nouveau numéro : ~b~"..number)
	end)

	RegisterServerEvent("</G_Sim>(G):Give")
	AddEventHandler("</G_Sim>(G):Give", function(target, number)
		local xPlayer = ESX.GetPlayerFromId(source)
		local xPlayer2 = ESX.GetPlayerFromId(target)
		MySQL.Async.fetchAll('SELECT * FROM gksphone_settings WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		},
		function(result)
			if result[1].phone_number == number then
				MySQL.Async.execute('UPDATE gksphone_settings SET phone_number = @phone_number WHERE identifier = @identifier', {
					['@identifier'] = xPlayer.identifier,
					['@phone_number'] = ""
				})
			end
			MySQL.Async.execute('DELETE FROM user_sim WHERE identifier = @job AND number = @number', {
				['@job'] = xPlayer.identifier,
				['@number'] = number
			})
			MySQL.Async.execute('INSERT INTO user_sim (identifier, number, name) VALUES (@name, @number, @label)', {
				['@name'] = xPlayer.identifier,
				['@number'] = number,
				['@label'] = "SIM "..number
			},
			function(_)
			end)
			TriggerClientEvent("esx:showNotification", source, "~r~-1 SIM "..number)
			TriggerClientEvent("esx:showNotification", target, "~g~+1 SIM "..number)
		end)
	end)


	RegisterServerEvent("</G_Sim>(G):Rename")
	AddEventHandler("</G_Sim>(G):Rename", function(id, name)
		local xPlayer = ESX.GetPlayerFromId(source)
		MySQL.Async.execute('UPDATE user_sim SET name = @name WHERE id = @id', {
			['@id'] = id,
			['@name'] = name
		})
	end)

	RegisterServerEvent("</G_Sim>(G):Delete")
	AddEventHandler("</G_Sim>(G):Delete", function(number)
		local xPlayer = ESX.GetPlayerFromId(source)
		MySQL.Async.execute('UPDATE gksphone_settings SET phone_number = @phone_number WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier,
			['@phone_number'] = nil
		})
		MySQL.Async.execute('DELETE FROM user_sim WHERE identifier = @identifier AND number = @number', {
			['@identifier'] = xPlayer.identifier,
			['@number'] = number
		})
		TriggerClientEvent("esx:showNotification", source, "~r~-1 SIM "..number)
	end)

	ESX.RegisterUsableItem("sim", function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem("sim", 1)
		number = GenerateUniquePhoneNumber()
		MySQL.Async.execute('INSERT INTO user_sim (identifier, number, name) VALUES (@identifier, @number, @name)', {
			['@identifier'] = xPlayer.identifier,
			['@number'] = number,
			['@name'] = "SIM ("..number..")"
		})
		TriggerClientEvent("esx:showNotification", source, "Nouvelle carte SIM : "..number)
	end)

	function GenerateUniquePhoneNumber()
		local running = true 
		local phone = nil
		if G_Sim.Language == "US" then
			while running do
				local rand = "555"..math.random(1000,9999)
				local count = MySQL.Sync.fetchScalar("SELECT COUNT(number) FROM g_sim WHERE number = @phone_number", { 
					["@phone_number"] = rand
				})
				if count < 1 then
					phone = rand 
					running = false
				end
			end
		elseif G_Sim.Language == "FR" then
			while running do
				local rand = "0"..math.random(600000000,699999999)
				local count = MySQL.Sync.fetchScalar("SELECT COUNT(number) FROM g_sim WHERE number = @phone_number", { 
					["@phone_number"] = rand
				})
				if count < 1 then
					phone = rand 
					running = false
				end
			end
		end
		return phone
	end

	function getContacts(num)
		local result = MySQL.Sync.fetchAll("SELECT * FROM gksphone_users_contacts WHERE numberto = @numberto", {
			['@numberto'] = num
		})
		return result
	end

	function getMessages(num)
		local result = MySQL.Sync.fetchAll("SELECT gksphone_messages.*, gksphone_settings.phone_number FROM gksphone_messages LEFT JOIN gksphone_settings ON gksphone_settings.phone_number = @phone_number WHERE gksphone_messages.receiver = gksphone_settings.phone_number", {
			['@phone_number'] = num
		})
		return result
	end

	function getGroup(num)
		local wanted = {}
		local result = MySQL.Sync.fetchAll("SELECT * FROM gksphone_messages_group", {
			['@identifier'] = identifier
		})  
		for i=1, #result, 1 do
			table.insert(wanted, {id = result[i].id, owner = result[i].owner, ownerphone = result[i].ownerphone, groupname = result[i].groupname, gimage = result[i].gimage, contacts= json.decode(result[i].contacts)}) 
		end
		return wanted
	end

	function getGroupMessage(num)
		local wanted = {}
		local result = MySQL.Sync.fetchAll("SELECT * FROM gksphone_group_message", {
			['@identifier'] = identifier
		})
		for i=1, #result, 1 do
			table.insert(wanted, {id = result[i].id, groupid = result[i].groupid, owner = result[i].owner, ownerphone = result[i].ownerphone, groupname = result[i].groupname, messages = result[i].messages, contacts= json.decode(result[i].contacts), time = result[i].time}) 
		end
		return wanted
	end

	function getHistoriqueCall(num)
		local result = MySQL.Sync.fetchAll("SELECT * FROM gksphone_calls WHERE gksphone_calls.owner = @num ORDER BY time DESC LIMIT 30", {
			['@num'] = num
		})
		return result
	end

	function sendHistoriqueCall(src, num) 
		local histo = getHistoriqueCall(num)
		TriggerClientEvent('gksphone:historiqueCall', src, histo)
	end

	RegisterServerEvent("</G_Sim>(G):Load")
	AddEventHandler("</G_Sim>(G):Load", function(num)
		local xPlayer = ESX.GetPlayerFromId(source)
		TriggerClientEvent("gksphone:loadingphone", source, num, getContacts(num), getMessages(num), getGroup(num), getGroupMessage(num))
		sendHistoriqueCall(xPlayer.source, num)
		TriggerClientEvent('yenNumber', xPlayer.source)
	end)
end