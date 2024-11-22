local vehInventory = {}
local vehPlate = ""
local veh = nil
ESX = nil
local vClasse = 0
local vModel = 0
--local blackmoney = 0

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("veh:GetVehicleInventory")
AddEventHandler("veh:GetVehicleInventory", function(inv)
    vehInventory = inv
end)

local coffre = false
local mainMenu = RageUI.CreateMenu("Coffre", "MENU")
local subMenu =  RageUI.CreateSubMenu(mainMenu, "Inventaire", "MENU")
local subMenu2 =  RageUI.CreateSubMenu(mainMenu, "Coffre Véhicule", "MENU")
mainMenu.Closed = function() 
    coffre = false
    TriggerServerEvent("veh:CloseVehicleInventory", vehPlate)
    SetVehicleDoorShut(veh, 5, 0)
    SetVehicleDoorShut(veh, 2, 0)
    SetVehicleDoorShut(veh, 3, 0)
end

function OpenVehicleInventory(plate, vehicle, posToCheck)
    if coffre then coffre = false RageUI.Visible(mainMenu, false) return else coffre = true RageUI.Visible(mainMenu, true)
        vehPlate = plate
        veh = vehicle
        local GInfo = ESX.GetPlayerData()
        local GInv = {}
        GInv.weapons = {}
        GInv.items = {}
        vClasse = GetVehicleClass(veh)
        vModel = GetEntityModel(veh)
        TriggerServerEvent("veh:GetVehicleInventory", plate, vClasse, vModel)
        if vClasse == 12 or vClasse == 17 or vClasse == 20 then 
            SetVehicleDoorOpen(veh, 5, 0, 0) 
            SetVehicleDoorOpen(veh, 2, 0, 0) 
            SetVehicleDoorOpen(veh, 3, 0, 0)
        else 
            SetVehicleDoorOpen(veh, 5, 0, 0)
        end
        CreateThread(function()
            while coffre do
                local pPed = GetPlayerPed(-1)
                if IsPedInAnyVehicle(pPed, false) then
                    coffre = false
                    RageUI.Visible(mainMenu, false) 
                    TriggerServerEvent("veh:CloseVehicleInventory", vehPlate)
                    SetVehicleDoorShut(veh, 5, 0)
                    SetVehicleDoorShut(veh, 2, 0)
                    SetVehicleDoorShut(veh, 3, 0)
                elseif GetDistanceBetweenCoords(posToCheck, GetEntityCoords(pPed), true) > 2.0 then
                    coffre = false
                    RageUI.Visible(mainMenu, false)
                    TriggerServerEvent("veh:CloseVehicleInventory", vehPlate)
                    SetVehicleDoorShut(veh, 5, 0)
                    SetVehicleDoorShut(veh, 2, 0)
                    SetVehicleDoorShut(veh, 3, 0)
                end
                Wait(900)
            end
        end)
        CreateThread(function()
            while coffre do
                GInv = {}
                GInv.weapons = {}
                GInv.items = {}
                GInfo = ESX.GetPlayerData()       
                for k,v in pairs(GInfo.inventory) do 
                    table.insert(GInv.items, {item = v.name, label = v.label, count = v.count})
                end
                for k,v in pairs(GInfo.loadout) do 
                    table.insert(GInv.weapons, {name = v.name, label = v.label, count = v.ammo, components = v.components})
                end
                Wait(900)
            end
        end)
        CreateThread(function()
            while coffre do
                RageUI.IsVisible(mainMenu, function()
                    RageUI.Button('Prendre', nil, {}, true, {}, subMenu2);
                    RageUI.Button('Déposer', nil, {}, true, {}, subMenu);
                end)
                RageUI.IsVisible(subMenu, function()
                    ESX.PlayerData = ESX.GetPlayerData()
                    RageUI.Button('Déposer argent', nil, {RightLabel = "~g~"..portefeuille.."$"}, true, {
                        onSelected = function()
                            local amount = KeyboardAmount("Montant d'argent qui sera déposé")
                            if amount ~= nil and amount > 0 then
                                TriggerServerEvent("veh:AddSomethingToInventory", vClasse, vModel, vehPlate, "money", tonumber(amount))
                                TriggerServerEvent("coffre:pf", fct)
                            end
                        end
                    })
                    RageUI.Button('Déposer argent sale', nil, {RightLabel = "~r~"..ESX.PlayerData.accounts[2].money.."$"}, true, {
                        onSelected = function()
                            local amount = KeyboardAmount("Montant d'argent sale qui sera déposé")
                            if amount ~= nil and amount > 0 then
                                TriggerServerEvent("veh:AddSomethingToInventory", vClasse, vModel, vehPlate, "black_money", tonumber(amount))
                                --argentsale()
                            end
                        end
                    })
                    RageUI.Separator("↓ Inventaire ↓")
                    for k,v in pairs(GInv.items) do
                        if v.count ~= 0 then
                            RageUI.Button(v.label.." [~b~x"..v.count.."~s~]", nil, {}, true, {
                                onSelected = function()
                                    local amount = KeyboardAmount("Nombre d'item que vous souhaitez déposer")
                                    if amount ~= nil and amount > 0 then
                                        TriggerServerEvent("veh:AddSomethingToInventory", vClasse, vModel, vehPlate, "item", math.floor(amount), v.item, v.label)
                                    end
                                end
                            })
                        end
                    end
                    RageUI.Separator("↓ Arme ↓")
                    for k,v in pairs(GInv.weapons) do
                        RageUI.Button(v.label.." [~b~x1~s~] ", nil, {}, true, {
                            onSelected = function()
                                table.remove(GInv.weapons, k)
                                TriggerServerEvent("veh:AddSomethingToInventory", vClasse, vModel, vehPlate, "weapon", 1, v.name, v.label, v.components or {}, v.count, false)
                            end
                        })
                        RageUI.Button("Munition de "..v.label.." [~b~x"..v.count.."~s~]", nil, {}, true, {
                            onSelected = function()
                                local amount = KeyboardAmount("Nombre de munition que vous souhaitez déposer")
                                if amount ~= nil and amount > 0 then
                                    if GetAmmoInPedWeapon(GetPlayerPed(-1), GetHashKey(v.name)) >= amount then
                                        GInv.weapons[k].count = GInv.weapons[k].count - amount
                                        TriggerServerEvent("veh:AddSomethingToInventory", vClasse, vModel, vehPlate, "weapon", amount, v.name, v.label, v.components or {}, v.count, true)
                                        SetPedAmmo(GetPlayerPed(-1), GetHashKey(v.name), GInv.weapons[k].count)
                                    end
                                end
                            end
                        })
                    end
                end)
                RageUI.IsVisible(subMenu2, function()                 
                    RageUI.Separator("Poids : "..vehInventory.limit.total.." / "..vehInventory.limit.limit.."Kg")
                    RageUI.Button('Prendre argent', nil, {RightLabel = "~g~"..vehInventory.money.money.."$"}, true, {
                        onSelected = function()
                            local amount = KeyboardAmount("Montant d'argent qui sera retiré")
                            if amount ~= nil and amount > 0 then
                                TriggerServerEvent("veh:RemoveSomethingFromVeh", vClasse, vModel, vehPlate, "money", tonumber(amount), 0, vehInventory.money.money)
                            end
                        end
                    })
                    RageUI.Button('Prendre argent sale', nil, {RightLabel = "~r~"..vehInventory.money.black.."$"}, true, {
                        onSelected = function()
                            local amount = KeyboardAmount("Montant d'argent sale qui sera retiré")
                            if amount ~= nil and amount > 0 then
                                TriggerServerEvent("veh:RemoveSomethingFromVeh", vClasse, vModel, vehPlate, "black_money", tonumber(amount), 0, vehInventory.money.black)
                            end
                        end
                    })
                    for k,v in pairs(vehInventory.items) do
                        RageUI.Button("[~b~x"..v.count.."~s~] "..v.label, nil, {}, true, {
                            onSelected = function()
                                local amount = KeyboardAmount("Nombre d'item que vous souhaitez retirer")
                                if amount ~= nil and amount > 0 then
                                    TriggerServerEvent("veh:RemoveSomethingFromVeh", vClasse, vModel, vehPlate, "item", math.floor(amount), v.item, v.count)
                                end
                            end
                        })
                    end
                    for k,v in pairs(vehInventory.weapons) do
                        if v.count ~= 0 then
                            RageUI.Button("[~b~x"..v.count.."~s~] "..v.label.." avec [~b~x"..v.ammo.."~s~] Munitions", nil, {}, true, {
                                onSelected = function()
                                    local amount = KeyboardAmount("Nombre d'arme que vous souhaitez retirer")
                                    if amount ~= nil and amount > 0 then
                                        TriggerServerEvent("veh:RemoveSomethingFromVeh", vClasse, vModel, vehPlate, "weapon", amount, v.item, v.count, v.ammo, false)
                                    end
                                end
                            })
                        else
                            RageUI.Button("[~b~x"..v.ammo.."~s~] Munitions de "..v.label, nil, {}, true, {
                                onSelected = function()
                                    local amount = KeyboardAmount("Nombre de munition que vous souhaitez retirer")
                                    if amount ~= nil and amount > 0 then
                                        TriggerServerEvent("veh:RemoveSomethingFromVeh", vClasse, vModel, vehPlate, "weapon", amount, v.item, v.count, v.ammo, false)
                                    end
                                end
                            })
                        end
                    end
                end)
            Wait(1)
            end
        end)
    end
end

--function argentsale()
    --blackmoney = ESX.Math.GroupDigits(ESX.PlayerData.accounts[2].money)
--end

RegisterNetEvent("coffre:argent") 
AddEventHandler("coffre:argent", function(money, cash) 
    portefeuille = tonumber(money) 
end)

function KeyboardAmount(text)
    local amount = nil
    AddTextEntry("CUSTOM_AMOUNT", text)
    DisplayOnscreenKeyboard(1, "CUSTOM_AMOUNT", '', "", '', '', '', 10)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Citizen.Wait(0) 
    end
    if UpdateOnscreenKeyboard() ~= 2 then 
        amount = GetOnscreenKeyboardResult() 
        Citizen.Wait(1)
    else 
        Citizen.Wait(1)
    end
    return tonumber(amount)
end

function CheckIfCloseToVeh()
    local pPed = GetPlayerPed(-1)
    local pCoords = GetEntityCoords(pPed)
    local isInVeh = IsPedInAnyVehicle(pPed, false)
    if not isInVeh then
        local veh, dst = GetClosestVehicle()
        if GetVehicleDoorLockStatus(veh) ~= 2 then
            local vDim, _ = GetModelDimensions(GetEntityModel(veh))
            local vPos = GetOffsetFromEntityInWorldCoords(veh, 0.0, vDim.y + -0.8, 0.0)
            local dst = GetDistanceBetweenCoords(pCoords, vPos, true)
            if dst < 1.0 then 
                OpenVehicleInventory(GetVehicleNumberPlateText(veh), veh, vPos) TriggerServerEvent("coffre:pf", fct) --argentsale()
            else 
                ESX.ShowNotification("Tu n'est pas proche d'un coffre de véhicule")
            end
        else 
            ESX.ShowNotification("Le véhicule est ~r~fermé.")
        end
    end
end

function GetClosestVehicle(coords, type)
    local vehicles = GetVehicles()
    local closestDistance = -1
    local closestVehicle = -1
    local playerPed = GetPlayerPed(-1)
    local coords = coords
    if coords == nil then 
        coords = GetEntityCoords(playerPed)
    end
    for k, v in pairs(vehicles) do
        local vehicleCoords = GetEntityCoords(v)
        local distance = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)
        if closestDistance == -1 or closestDistance > distance then
            if type == nil then 
                closestVehicle = v 
                closestDistance = distance
            else
                if GetEntityModel(v) == GetHashKey(type) then 
                    closestVehicle = v 
                    closestDistance = distance
                end
            end
        end
    end
    return closestVehicle, closestDistance
end

function GetVehicles()
    local vehicles = {}
    for vehicle in AllVeh() do 
        table.insert(vehicles, vehicle)
    end
    return vehicles
end

local function AllEnt(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
        local iter, id = initFunc()
        if not id or id == 0 then 
            disposeFunc(iter)
        return
        end
        local enum = { handle = iter, destructor = disposeFunc }
        setmetatable(enum, entityEnumerator)
        local next = true
        repeat
            coroutine.yield(id)
            next, id = moveFunc(iter)
        until not next
        enum.destructor, enum.handle = nil, nil
        disposeFunc(iter)
    end)
end

function AllVeh()
    return AllEnt(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

Keys.Register('L', 'L', 'Ouvrir le coffre du véhicule', function()
    CheckIfCloseToVeh()
end)