ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local vehs_owned = {}
local veh_inventory = {}
local veh_openned = {}

function GetVehClassValue(class, model)
    if G_Coffre.custom[model] ~= nil then 
        return G_Coffre.custom[model]
    else
        if G_Coffre.config[class] ~= nil then 
            return G_Coffre.config[class] 
        else 
            return 20
        end
    end
end

function AddSourceToOpened(source, plate)
    if veh_openned[plate] == nil then 
        veh_openned[plate] = {}
    end
    veh_openned[plate][source] = true
end

function RemoveSourceFromOpened(source, plate)
    if veh_openned[plate][source] ~= nil then 
        veh_openned[plate][source] = nil 
        SaveVehInventory(plate)
    end
end

function GetSourceOpened(plate)
    return veh_openned[plate]
end

function AddToVehInv(source, model, vClasse, plate, type, amount, item, label, comp, mun, ammoOnly)
    CreateVehInvIfDontExist(plate, vClasse, model)
    local xPlayer = ESX.GetPlayerFromId(source)
    if type == "money" then
        local money = xPlayer.getMoney()        
        if veh_inventory[plate].limit.total + (amount / 1000) <= veh_inventory[plate].limit.limit then
            if money >= amount then
                xPlayer.removeMoney(amount)
                veh_inventory[plate].money.money = math.floor(veh_inventory[plate].money.money + amount)
            end
        end
    elseif type == "black_money" then
        local acc = xPlayer.getAccount("black_money")
        local money = acc.money        
        if veh_inventory[plate].limit.total + (amount / 1000) <= veh_inventory[plate].limit.limit then
            if money >= amount then
                xPlayer.removeAccountMoney("black_money", amount)
                veh_inventory[plate].money.black = math.floor(veh_inventory[plate].money.black + amount)
            end
        end
    elseif type == "item" then
        local iInfo = xPlayer.getInventoryItem(item)        
        if iInfo.count > 0 and iInfo.count >= amount then
            if veh_inventory[plate].limit.total + amount <= veh_inventory[plate].limit.limit then
                xPlayer.removeInventoryItem(item, amount)
                if veh_inventory[plate].items[item] == nil then
                    veh_inventory[plate].items[item] = {item = item, label = label, count = amount}
                else
                    veh_inventory[plate].items[item].count = veh_inventory[plate].items[item].count + amount
                end
            end
        end
    elseif type == "weapon" then
        local gotWeapon = xPlayer.hasWeapon(item) 
        if gotWeapon then
            if veh_inventory[plate].limit.total + 1 <= veh_inventory[plate].limit.limit then
                if not ammoOnly then
                    xPlayer.removeWeapon(item)
                    if veh_inventory[plate].weapons[item] == nil then
                        veh_inventory[plate].weapons[item] = {item = item, label = label, count = 1, ammo = mun, comp = comp}
                    else
                        veh_inventory[plate].weapons[item].count = veh_inventory[plate].weapons[item].count + 1
                        veh_inventory[plate].weapons[item].ammo = veh_inventory[plate].weapons[item].ammo + mun
                    end
                elseif ammoOnly then
                    if veh_inventory[plate].weapons[item] == nil then
                        veh_inventory[plate].weapons[item] = {item = item, label = label, count = 0, ammo = amount, comp = comp}
                    else
                        veh_inventory[plate].weapons[item].ammo = veh_inventory[plate].weapons[item].ammo + amount
                    end
                end
            end
        else    
        end
    end
    RefreshVehLimit(plate, vClasse, model)
    RefreshVehInventory(source, plate)
end

local waiting = false
function ScriptAddToVehInv(plate, amount, item, label)
    waiting = true
    CreateVehInvIfDontExist(plate)
    while waiting do 
        Wait(1) 
    end
    if veh_inventory[plate].items[item] == nil then
        veh_inventory[plate].items[item] = {item = item, label = label, count = amount}
    else
        veh_inventory[plate].items[item].count = veh_inventory[plate].items[item].count + amount
    end
end

function RemoveFromVehInv(source, model, vClasse, plate, type, amount, item, countSee, ammoSee, ammoOnly)
    local xPlayer = ESX.GetPlayerFromId(source)
    if type == "money" then
        if veh_inventory[plate].money.money == countSee then
            if veh_inventory[plate].money.money >= amount then
                veh_inventory[plate].money.money = veh_inventory[plate].money.money - amount
                xPlayer.addMoney(amount)
            end
        end
    elseif type == "black_money" then
        if veh_inventory[plate].money.black == countSee then
            if veh_inventory[plate].money.black >= amount then
                veh_inventory[plate].money.black = veh_inventory[plate].money.black - amount
                xPlayer.addAccountMoney("black_money", amount)
            end
        end
    elseif type == "item" then
        if veh_inventory[plate].items[item] ~= nil then
            if veh_inventory[plate].items[item].count == countSee then
                if veh_inventory[plate].items[item].count >= amount then
                    if veh_inventory[plate].items[item].count - amount > 0 then
                        veh_inventory[plate].items[item].count = veh_inventory[plate].items[item].count - amount
                        xPlayer.addInventoryItem(item, amount)
                    else
                        veh_inventory[plate].items[item].count = veh_inventory[plate].items[item].count - amount
                        xPlayer.addInventoryItem(item, amount)
                        if veh_inventory[plate].items[item].count <= 0 then
                            veh_inventory[plate].items[item] = nil 
                        end
                    end
                end
            end
        end
    elseif type == "weapon" then
        if veh_inventory[plate].weapons[item] ~= nil then
            if veh_inventory[plate].weapons[item].count == countSee then
                if veh_inventory[plate].weapons[item].ammo == ammoSee then 
                    if not ammoOnly then 
                        if veh_inventory[plate].weapons[item].ammo > 255 then
                            veh_inventory[plate].weapons[item].ammo = veh_inventory[plate].weapons[item].ammo - 255
                            veh_inventory[plate].weapons[item].count = veh_inventory[plate].weapons[item].count - 1
                            xPlayer.addWeapon(item, 255)
                            for k,v in pairs(veh_inventory[plate].weapons[item].comp) do 
                                xPlayer.addWeaponComponent(item, v)
                            end
                        else
                            xPlayer.addWeapon(item, veh_inventory[plate].weapons[item].ammo)
                            for k,v in pairs(veh_inventory[plate].weapons[item].comp) do
                                xPlayer.addWeaponComponent(item, v)
                            end
                            veh_inventory[plate].weapons[item].ammo = 0
                            veh_inventory[plate].weapons[item].count = veh_inventory[plate].weapons[item].count - 1
                            if veh_inventory[plate].weapons[item].count <= 0 then 
                                veh_inventory[plate].weapons[item] = nil
                            end
                        end
                    else
                        local hasWeapon = xPlayer.hasWeapon(item)
                        if hasWeapon then
                            if veh_inventory[plate].weapons[item].ammo >= amount then
                                veh_inventory[plate].weapons[item].ammo = veh_inventory[plate].weapons[item].ammo - amount
                                xPlayer.addWeapon(item, amount)
                            end
                        end
                    end
                    
                end
            end
        end
    end
    RefreshVehLimit(plate, vClasse, model)
    RefreshVehInventory(source, plate)
end

function DoesItemExistInVehInv(plate, item, count)
    if veh_inventory[plate] ~= nil then
        if veh_inventory[plate].items[item] ~= nil then
            if veh_inventory[plate].items[item].count == count then
                veh_inventory[plate].items[item] = nil
                return true
            else
                return false
            end
        else
            return false
        end
    else
        return false
    end
end

function CreateVehInvIfDontExist(plate, class, model)
    if veh_inventory[plate] == nil then
        MySQL.Async.fetchAll('SELECT owned_vehicles.owner, owned_vehicles.inv FROM owned_vehicles WHERE plate = @plate', { ['@plate'] = plate }, function(result)
            if result[1] == nil then
                veh_inventory[plate] = {}
                veh_inventory[plate].limit = {limit = 0, total = 0}
                veh_inventory[plate].money = {}
                veh_inventory[plate].money.money = 0
                veh_inventory[plate].money.black = 0
                veh_inventory[plate].items = {}
                veh_inventory[plate].weapons = {}
                veh_inventory[plate].toSave = false
            else
                if result[1].inv == nil or result[1].inv == "{}" then
                    veh_inventory[plate] = {}
                    veh_inventory[plate].limit = {limit = 0, total = 0}
                    veh_inventory[plate].money = {}
                    veh_inventory[plate].money.money = 0
                    veh_inventory[plate].money.black = 0
                    veh_inventory[plate].items = {}
                    veh_inventory[plate].weapons = {}
                    veh_inventory[plate].toSave = true
                else
                    local inv = json.decode(result[1].inv)
                    if inv ~= nil then
                        veh_inventory[plate] = inv
                        veh_inventory[plate].toSave = true
                    else
                        veh_inventory[plate] = {}
                        veh_inventory[plate].limit = {limit = 0, total = 0}
                        veh_inventory[plate].money = {}
                        veh_inventory[plate].money.money = 0
                        veh_inventory[plate].money.black = 0
                        veh_inventory[plate].items = {}
                        veh_inventory[plate].weapons = {}
                        veh_inventory[plate].toSave = true
                    end
                end
            end
            if class ~= nil then 
                RefreshVehLimit(plate, class, model)
            end
            RefreshVehInventory(nil, plate)
            waiting = false
        end)
    else
        waiting = false
    end
end

function RefreshVehLimit(plate, class, model)
    if veh_inventory[plate] == nil then 
        return 
    end
    local limit = GetVehClassValue(tonumber(class), model)
    veh_inventory[plate].limit.limit = limit
    local count = 0
    if veh_inventory[plate].money.money > 0 then 
        count = count + (veh_inventory[plate].money.money / 1000)
    end
    if veh_inventory[plate].money.black > 0 then 
        count = count + (veh_inventory[plate].money.black / 1000)
    end
    for k,v in pairs(veh_inventory[plate].items) do 
        count = count + v.count
    end
    for k,v in pairs(veh_inventory[plate].weapons) do 
        count = count + 1
    end
    veh_inventory[plate].limit.total = count
end

function SaveVehInventory(plate)
    if veh_inventory[plate].toSave then
        local inv = json.encode(veh_inventory[plate])
        MySQL.Async.execute("UPDATE owned_vehicles SET inv = @inv WHERE plate = @plate", {['@plate'] = plate, ["@inv"] = inv }, function(affectedRows)
        end)
    end
end

function RefreshVehInventory(source, plate)
    local toRefresh = GetSourceOpened(plate)
    if toRefresh ~= nil then 
        for k,v in pairs(toRefresh) do 
            TriggerClientEvent("veh:GetVehicleInventory", tonumber(k), veh_inventory[plate])
        end
    end
end

function AddOwnedVeh(plate)
    vehs_owned[plate] = {}
end

function IsVehOwned(plate)
    if vehs_owned[plate] ~= nil then
        return true
    else
        return false
    end
end

function GetVehicleInventory(plate, vClasse, model)
    if veh_inventory[plate] ~= nil then
        return veh_inventory[plate]
    else 
        CreateVehInvIfDontExist(plate, vClasse, model)
        return veh_inventory[plate]
    end
end

RegisterServerEvent("coffre:pf") 
AddEventHandler("coffre:pf", function(fct, amount) 
    TriggerClientEvent("coffre:argent", source, ESX.GetPlayerFromId(source).getMoney())
end)

RegisterNetEvent("veh:MarkVehAsOwnedToServer")
AddEventHandler("veh:MarkVehAsOwnedToServer", function(plate)
    AddOwnedVeh(plate)
end)

RegisterNetEvent("veh:GetVehicleInventory")
AddEventHandler("veh:GetVehicleInventory", function(plate, vClasse, model)
    RefreshVehLimit(plate, vClasse, model)
    local inv = GetVehicleInventory(plate, vClasse, model)
    AddSourceToOpened(source, plate)
    TriggerClientEvent("veh:GetVehicleInventory", source, inv)
end)

RegisterNetEvent("veh:CloseVehicleInventory")
AddEventHandler("veh:CloseVehicleInventory", function(plate)
    RemoveSourceFromOpened(source, plate)
end)

RegisterNetEvent("veh:AddSomethingToInventory")
AddEventHandler("veh:AddSomethingToInventory", function(vClasse, model, plate, type, amount, item, label, comp, mun, ammoOnly)
    AddToVehInv(source, model, vClasse, plate, type, amount, item, label, comp, mun, ammoOnly)
end)

RegisterNetEvent("veh:ScriptAddItemToVehInv")
AddEventHandler("veh:ScriptAddItemToVehInv", function(plate, amount, item, label)
    ScriptAddToVehInv(plate, amount, item, label)
end)

RegisterNetEvent("veh:RemoveSomethingFromVeh")
AddEventHandler("veh:RemoveSomethingFromVeh", function(vClasse, model, plate, type, amount, item, countSee, ammoSee, ammoOnly)
    RemoveFromVehInv(source, model, vClasse, plate, type, amount, item, countSee, ammoSee, ammoOnly)
end)