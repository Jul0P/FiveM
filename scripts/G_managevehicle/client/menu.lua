ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local mainMenu = RageUI.CreateMenu("Gestion Véhicule", "MENU")
local subMenu = RageUI.CreateSubMenu(mainMenu, "Informations Véhicules", "MENU")
local limiteur,porte,window = 1,1,1

local vehicle = false 
mainMenu.Closed = function() vehicle = false end 

function Menu() 
    if vehicle then vehicle = false RageUI.Visible(mainMenu, false) return else vehicle = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
            while vehicle do 
                RageUI.IsVisible(mainMenu, function()
                    RageUI.Button("Informations Véhicules", nil, {RightLabel = "→"}, true, {}, subMenu)
                    RageUI.Checkbox("Éteindre le moteur", nil, moteur, {}, {
                        onChecked = function()
                            moteur = true 
                            SetVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId()), false, false, true)
                            SetVehicleUndriveable(GetVehiclePedIsIn(PlayerPedId()), false)
                        end,
                        onUnChecked = function()
                            moteur = false
                            SetVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId()), true, false, true)
                            SetVehicleUndriveable(GetVehiclePedIsIn(PlayerPedId()), true)
                        end
                    })
                    RageUI.Checkbox("Ouvrir/Fermer Capot", nil, capot, {}, {
                        onChecked = function()
                            capot = true
                            SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId()), 4, false, false)
                        end,
                        onUnChecked = function()
                            capot = false
                            SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId()), 4, false, false)
                        end
                    })
                    RageUI.Checkbox("Ouvrir/Fermer Coffre", nil, coffre, {}, {
                        onChecked = function()
                            coffre = true
                            SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId()), 5, false, false)
                        end,
                        onUnChecked = function()
                            coffre = false
                            SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId()), 5, false, false)
                        end
                    })
                    RageUI.List("Ouvrir/Fermer Porte", {"Avant Gauche", "Avant Droite","Arrière Gauche","Arrière Droite"}, porte, nil, {}, true, {
                        onListChange = function(list) porte = list end,
                        onSelected = function(list)
                            if list == 1 then
                                if not one then
                                    one = true
                                    SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId()), 0, false, false)
                                elseif one then
                                    one = false
                                    SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId()), 0, false, false)
                                end
                            elseif list == 2 then
                                if not two then
                                    two = true
                                    SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId()), 1, false, false)
                                elseif two then
                                    two = false
                                    SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId()), 1, false, false)
                                end
                            elseif list == 3 then
                                if not three then
                                    three = true
                                    SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId()), 2, false, false)
                                elseif three then
                                    three = false
                                    SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId()), 2, false, false)
                                end
                            elseif list == 4 then
                                if not four then
                                    four = true
                                    SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId()), 3, false, false)
                                elseif four then
                                    four = false
                                    SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId()), 3, false, false)
                                end
                            end
                        end
                    })
                    RageUI.List("Ouvrir/Fermer Fenêtre", {"Avant Gauche", "Avant Droite","Arrière Gauche","Arrière Droite"}, window, nil, {}, true, {
                        onListChange = function(list) window = list end,
                        onSelected = function(list)
                            if list == 1 then
                                if not ag then
                                    ag = true
                                    RollDownWindow(GetVehiclePedIsIn(PlayerPedId()), 0) 
                                elseif ag then
                                    ag = false
                                    RollUpWindow(GetVehiclePedIsIn(PlayerPedId()), 0) 
                                end
                            elseif list == 2 then
                                if not ad then
                                    ad = true
                                    RollDownWindow(GetVehiclePedIsIn(PlayerPedId()), 1) 
                                elseif ad then
                                    ad = false
                                    RollUpWindow(GetVehiclePedIsIn(PlayerPedId()), 1) 
                                end
                            elseif list == 3 then
                                if not arg then
                                    arg = true
                                    RollDownWindow(GetVehiclePedIsIn(PlayerPedId()), 2) 
                                elseif arg then
                                    arg = false
                                    RollUpWindow(GetVehiclePedIsIn(PlayerPedId()), 2) 
                                end
                            elseif list == 4 then
                                if not ard then
                                    ard = true
                                    RollDownWindow(GetVehiclePedIsIn(PlayerPedId()), 3) 
                                elseif ard then
                                    ard = false
                                    RollUpWindow(GetVehiclePedIsIn(PlayerPedId()), 3) 
                                end
                            end
                        end
                    })
                    RageUI.List("Limitateur", {"Personnaliser", "30","50","80","120","Désactiver"}, limiteur, nil, {}, true, {
                        onListChange = function(list) limiteur = list end,
                        onSelected = function(list)
                            if list == 1 then
                                local perso = KeyboardInput("Choisissez votre vitesse :", "", 3)
                                if perso == nil then
                                    ESX.ShowNotification("Vitesse Invalide")
                                else
                                    SetVehicleMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), perso / 3.701)
                                end
                            elseif list == 2 then
                                SetVehicleMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 8.1)
                            elseif list == 3 then
                                SetVehicleMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 13.7)
                            elseif list == 4 then
                                SetVehicleMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 22.0)
                            elseif list == 5 then
                                SetVehicleMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 33.2)
                            elseif list == 6 then
                                SetVehicleMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 0.0)
                            end
                        end
                    })
                end)
                RageUI.IsVisible(subMenu, function()
                    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                    local vehe = GetVehicleEngineHealth(veh) / 10
                    local vehf = GetVehicleFuelLevel(veh)
                    local vehp = GetVehicleEngineTemperature(veh)
                    local veht = GetVehicleClass(veh)
                    local vehn = GetVehicleDoorLockStatus(veh)
                    if vehe == 10 then
                        RageUI.Separator("État du véhicule : 0 %")
                    else
                        RageUI.Separator("État du véhicule : "..math.ceil(vehe).." %")
                    end
                    RageUI.Separator("Niveau d'essence : "..math.ceil(vehf).." %")
                    RageUI.Separator("Température du moteur : "..math.ceil(vehp).."°C")
                    for k, v in pairs(Config.list) do
                        if veht == v.class then
                            RageUI.Separator("Type du véhicule : "..(v.name).."")
                        end
                    end
                    if vehn == 1 then
                        RageUI.Separator("Status du véhicule : ~g~Ouvert")
                    else
                        RageUI.Separator("Status du véhicule : ~r~Fermé")
                    end
                end)
            Wait(0)
            end
        end)
    end
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do Citizen.Wait(0) end 
    if UpdateOnscreenKeyboard() ~= 2 then local result = GetOnscreenKeyboardResult() Citizen.Wait(500) blockinput = false return result else Citizen.Wait(500) blockinput = false return nil end
end

Config = {}

Config.list = {
    {class = 0, name = 'Compacts'},
    {class = 1, name = 'Sedans'},
    {class = 2, name = 'SUVs'},
    {class = 3, name = 'Coupes'},
    {class = 4, name = 'Muscle'},
    {class = 5, name = 'Sports Classics'},
    {class = 6, name = 'Sports'},
    {class = 7, name = 'Super'},
    {class = 8, name = 'Motorcycles'},
    {class = 9, name = 'Off-road'},
    {class = 10, name = 'Industrial'},
    {class = 11, name = 'Utility'},
    {class = 12, name = 'Vans'},
    {class = 13, name = 'Cycles'},
    {class = 14, name = 'Boats'},
    {class = 15, name = 'Helicopters'},
    {class = 16, name = 'Planes'},
    {class = 17, name = 'Service'},
    {class = 18, name = 'Emergency'},
    {class = 19, name = 'Military'},
    {class = 20, name = 'Commercial'},
    {class = 21, name = 'Trains'},
}

Keys.Register('F1', 'F1', 'ouvrir le menu gestion véhicule', function()
    if IsPedSittingInAnyVehicle(PlayerPedId()) then
        Menu()
    else
        ESX.ShowNotification("Vous devez être dans un véhicule")
    end
end)