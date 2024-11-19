ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('G_Garage:VehicleArrayGarage', function(source, cb)
	local dataexport = {}
	local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND Type = @Type AND `stored` = @stored', { 
        ['@owner'] = xPlayer.identifier,
        ['@Type'] = 'car',
        ['@stored'] = true
    }, function(data)
        for _,v in pairs(data) do
            local vehicle = json.decode(v.vehicle)
            table.insert(dataexport, {vehicle = vehicle, stored = v.stored, plate = v.plate})
        end
        cb(dataexport)
    end)
end)

ESX.RegisterServerCallback('G_Garage:VehicleArrayPound', function(source, cb)
	local dataexport = {}
	local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND type = @type AND `stored` = @stored', {
        ['@owner'] = xPlayer.identifier,
        ['@type'] = 'car',
        ['@stored'] = false
    }, function(data)
        for _,v in pairs(data) do
            local vehicle = json.decode(v.vehicle)
            table.insert(dataexport, {vehicle = vehicle, stored = v.stored, plate = v.plate})
        end
        cb(dataexport)
    end)
end)

ESX.RegisterServerCallback('G_Garage:ReturnVehicle', function (source, cb, vehicleProps)
	local vehplate = vehicleProps.plate:match("^%s*(.-)%s*$")
	local vehiclemodel = vehicleProps.model
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
		['@owner'] = xPlayer.identifier,
		['@plate'] = vehicleProps.plate
	}, function (result)
		if result[1] ~= nil then
			local originalvehprops = json.decode(result[1].vehicle)
			if originalvehprops.model == vehiclemodel then
				MySQL.Async.execute('UPDATE owned_vehicles SET vehicle = @vehicle WHERE owner = @owner AND plate = @plate', {
					['@owner'] = xPlayer.identifier,
					['@vehicle'] = json.encode(vehicleProps),
					['@plate'] = vehicleProps.plate
				}, function (rowsChanged)
				    cb(true)
				end)
			else
				cb(false)
			end
		else
			cb(false)
		end
	end)
end)

RegisterServerEvent('G_Garage:VehicleStatue')
AddEventHandler('G_Garage:VehicleStatue', function(plate, state)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = @stored WHERE plate = @plate', {
		['@stored'] = state,
		['@plate'] = plate
	}, function(rowsChanged)
	end)
end)

ESX.RegisterServerCallback('G_Garage:Buy', function(source, cb)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getMoney() >= G_Garage.PoundPrice then
        xPlayer.removeMoney(G_Garage.PoundPrice)
        TriggerClientEvent('esx:showNotification', _source, "Vous avez payer ~g~250$")
        cb(true)
    else
        TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas suffisament d'argent")
        cb(false)
    end
end)