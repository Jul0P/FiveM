ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('G_catalogue:vehlist', function(source, cb, categoriesveh)
    local info = categoriesveh
    local listinfo = {}
    MySQL.Async.fetchAll('SELECT * FROM vehicles WHERE category = @category', {['@category'] = info}, function(result)
        for i = 1, #result, 1 do
            table.insert(listinfo, {name = result[i].name, model = result[i].model, price = result[i].price})
        end
        cb(listinfo)
    end)
end)

ESX.RegisterServerCallback('G_catalogue:categoriesveh', function(source, cb)
    local info = {}
    MySQL.Async.fetchAll('SELECT * FROM vehicle_categories', {}, function(result)
        for i = 1, #result, 1 do
            table.insert(info, {name = result[i].name, label = result[i].label})
        end
        cb(info)
    end)
end)