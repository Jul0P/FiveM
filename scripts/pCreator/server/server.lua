if Config.ESX == "new" then
	ESX = exports["es_extended"]:getSharedObject()
elseif Config.ESX == "old" then
	ESX = nil
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

RegisterServerEvent("pCreator:updateIdentity")
AddEventHandler("Creator:updateIdentity", function(args)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    MySQL.Sync.execute('UPDATE users SET firstname = @firstname, lastname = @lastname, dateofbirth = @dateofbirth, sex = @sex, height = @height WHERE identifier = @identifier', {
        ['@identifier']  = xPlayer.identifier,
        ['@firstname'] = args.firstName,
        ['@lastname'] = args.lastName,
        ['@dateofbirth'] = args.dateOfBirth,
        ['@sex'] = args.sex,
        ['@height'] = args.height
    })
    xPlayer.setName(('%s %s'):format(args.firstName, args.lastName))
    xPlayer.set('firstName', args.firstName)
    xPlayer.set('lastName', args.lastName)
    xPlayer.set('dateofbirth', args.dateOfBirth)
    xPlayer.set('sex', args.sex)
    xPlayer.set('height', args.height)
end)

RegisterServerEvent("pCreator:Buckets")
AddEventHandler("pCreator:Buckets", function(InOrOut)
    local _src = source
    if InOrOut then
        SetPlayerRoutingBucket(_src, GetPlayerIdentifier(_src))
    else
        SetPlayerRoutingBucket(_src, 0)
    end
end)