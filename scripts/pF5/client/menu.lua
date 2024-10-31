local mainMenu = RageUI.CreateMenu(pF5.Title, "Menu")  
local subMenu = RageUI.CreateSubMenu(mainMenu, "Sac à dos", "Menu")
local subMenu2 = RageUI.CreateSubMenu(mainMenu, "Portefeuille", "Menu")
local subMenu3 = RageUI.CreateSubMenu(mainMenu, "Gestion Véhicule", "Menu")
local subMenu4 = RageUI.CreateSubMenu(mainMenu, "Gestion Société", "Menu")
local subMenu5 = RageUI.CreateSubMenu(mainMenu, "Vêtements & Accessoires", "Menu")
local subMenu6 = RageUI.CreateSubMenu(mainMenu, "Facture", "Menu")
local subMenu7 = RageUI.CreateSubMenu(mainMenu, "Pub", "Menu")
local subMenu8 = RageUI.CreateSubMenu(mainMenu, "Divers", "Menu")
local subMenu9 = RageUI.CreateSubMenu(mainMenu, "Gestion Clés", "Liste des clés")
local subMenu10 = RageUI.CreateSubMenu(subMenu8, "Appeler un véhicule", "Menu")
local subMenu11 = RageUI.CreateSubMenu(subMenu8, "Animation d'Armes", "Menu")
local subMenu12 = RageUI.CreateSubMenu(subMenu11, "Animation de visée", "Menu")
local subMenu13 = RageUI.CreateSubMenu(subMenu11, "Animation d'holster", "Menu")
local subMenu14 = RageUI.CreateSubMenu(mainMenu, "Gestion Vêtements & Accessoires", "Liste des vêtements")
local subMenu15 = RageUI.CreateSubMenu(mainMenu, "Gestion Carte SIM", "Liste des cartes sims")

local mainMenu2 = RageUI.CreateSubMenu(subMenu3, "Informatios Véhicule", "Menu") 

local mainMenu3 = RageUI.CreateSubMenu(mainMenu, "Props", "Menu")
local SsubMenu = RageUI.CreateSubMenu(mainMenu3, "Suppression", "Menu")
local PsubMenu = RageUI.CreateSubMenu(mainMenu3, "Civil", "Menu")
local PsubMenu2 = RageUI.CreateSubMenu(mainMenu3, "LSPD", "Menu")
local PsubMenu3 = RageUI.CreateSubMenu(mainMenu3, "EMS", "Menu")
local PsubMenu4 = RageUI.CreateSubMenu(mainMenu3, "Mecano", "Menu")
local PsubMenu5 = RageUI.CreateSubMenu(mainMenu3, "Gang", "Menu")
local PsubMenu6 = RageUI.CreateSubMenu(mainMenu3, "Drogue", "Menu")
local PsubMenu7 = RageUI.CreateSubMenu(mainMenu3, "Armes", "Menu")

mainMenu.Closed = function() menuf5 = false end 

local List = {
    vinv = 1,
    vinv2 = 1,
    filter = 1,
    filter2 = 1,
    filter3 = 1,
    pfa = 1,
    pfas = 1,
    ci = 1,
    pc = 1,
    ppa = 1,
    limiteur = 1,
    porte = 1,
    window = 1,
    ev = 1,
    key = 1,
}

local Fct = {
    cpt_i = {},
    all_i = {},
    bill = {},
}

local fIndex = 1
local fIndex2 = 1
local fIndex3 = 1

local currentWeight = 0

local display = false
local AimAnim = GetResourceKvpString("AimAnim")
local HolsterAnim = GetResourceKvpString("HolsterAnim")

RegisterNetEvent('pF5:Weapon_addAmmoToPedC')
AddEventHandler('pF5:Weapon_addAmmoToPedC', function(value, quantity)
	local weaponHash = GetHashKey(value)
	if HasPedGotWeapon(PlayerPedId(), weaponHash, false) and value ~= 'WEAPON_UNARMED' then
		AddAmmoToPed(PlayerPedId(), value, quantity)
	end
end)

local iIndex = 1

result = {}

function GetAccess()
    ESX.TriggerServerCallback("pClothesItem:getData", function(data)
        result = data
    end)
end

RegisterNetEvent('pClothesItem:Sync')
AddEventHandler('pClothesItem:Sync', function()
    ESX.TriggerServerCallback("pClothesItem:getData", function(data)
        result = data
    end)
end)

local theIndex = 1
local theItem = {"Aucun", "Masque", "Lunette", "Sac", "Veste", "T-Shirt", "Pantalon", "Chaussure", "Chaine", "Casque", "Accessoire d'Oreille", "Montre", "Bracelet", "Gilet par balle"}

local ArrayIndex = 1

ArraySim = {}

function Load()
    ESX.TriggerServerCallback("pSim:getData", function(data)
        ArraySim = data
    end)
    ESX.TriggerServerCallback("pSim:getData2", function(data2)
        datanumber = data2
    end)
end

if not pF5.Weapon.Active and not pF5.pSim.FilterInventory and not pF5.pClothes.FilterInventory then
    filterInventory = {"Aucun", "Items"}
elseif pF5.Weapon.Active and not pF5.pSim.FilterInventory and not pF5.pClothes.FilterInventory then
    filterInventory = {"Aucun", "Items", "Armes"}
elseif pF5.Weapon.Active and pF5.pSim.FilterInventory and not pF5.pClothes.FilterInventory then
    filterInventory = {"Aucun", "Items", "Armes", "Carte Sim"}
elseif pF5.Weapon.Active and not pF5.pSim.FilterInventory and pF5.pClothes.FilterInventory then
    filterInventory = {"Aucun", "Items", "Armes", "Vêtements & Accessoires"}
elseif pF5.Weapon.Active and pF5.pSim.FilterInventory and pF5.pClothes.FilterInventory then
    filterInventory = {"Aucun", "Items", "Armes", "Carte Sim", "Vêtements & Accessoires"}
elseif not pF5.Weapon.Active and pF5.pSim.FilterInventory and not pF5.pClothes.FilterInventory then
    filterInventory = {"Aucun", "Items", "Carte Sim"}
elseif not pF5.Weapon.Active and pF5.pSim.FilterInventory and pF5.pClothes.FilterInventory then
    filterInventory = {"Aucun", "Items", "Carte Sim", "Vêtements & Accessoires"} 
elseif not pF5.Weapon.Active and not pF5.pSim.FilterInventory and pF5.pClothes.FilterInventory then
    filterInventory = {"Aucun", "Items", "Vêtements & Accessoires"}
end

function OpenMenu()
    if not menuf5 then menuf5 = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
            while menuf5 do 
                RageUI.IsVisible(mainMenu,function()
                    if pF5.Active.Inventaire then
                        RageUI.Button("Inventaire", nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                if pF5.pClothes.Active and pF5.pClothes.FilterInventory then
                                    GetAccess()
                                end
                                if pF5.pSim.Active and pF5.pSim.FilterInventory then
                                    Load()
                                    ESX.TriggerServerCallback('pSim:getItemAmount', function(cb) 
                                        if cb > 0 then
                                            active = true
                                        else
                                            active = false
                                        end
                                    end, pF5.pSim.NamePhoneItem)
                                end
                            end
                        }, subMenu)
                    end
                    if pF5.Active.Portefeuille then
                        RageUI.Button("Portefeuille", nil, {RightLabel = "→"}, true, {}, subMenu2)
                    end 
                    if pF5.Active.Facture then
                        RageUI.Button("Facture", nil, {RightLabel = "→"}, true, {}, subMenu6)    
                    end 
                    if pF5.Active.VetementsAccessoires then               
                        RageUI.Button("Vêtements & Accessoires", nil, {RightLabel = "→"}, true, {}, subMenu5)
                    end
                    if pF5.Active.Pub then
                        RageUI.Button("Pub", nil, {RightLabel = "→"}, true, {}, subMenu7)
                    end
                    if pF5.Active.Props then
                        RageUI.Button("Props", nil, {RightLabel = "→"}, true, {}, mainMenu3)
                    end
                    if pF5.Active.Divers then
                        RageUI.Button("Divers", nil, {RightLabel = "→"}, true, {}, subMenu8)
                    end
                    if pF5.Active.GestionCles then
                        RageUI.Button("Gestion Clés", nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                Load_Key()
                            end
                        }, subMenu9)
                    end
                    if pF5.pSim.Active and not pF5.pSim.FilterInventory then
                        RageUI.Button("Gestion Carte SIM",  nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                Load()
                                ESX.TriggerServerCallback('pSim:getItemAmount', function(cb) 
                                    if cb > 0 then
                                        active = true
                                    else
                                        active = false
                                    end
                                end, pF5.pSim.NamePhoneItem)
                            end
                        }, subMenu15)
                    end
                    if pF5.pClothes.Active and not pF5.pClothes.FilterInventory then
                        RageUI.Button("Gestion Vêtements & Accessoires",  nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                GetAccess()
                            end
                        }, subMenu14)
                    end
                    if pF5.Active.GestionVehicule then
                        if IsPedSittingInAnyVehicle(PlayerPedId()) then
                            RageUI.Button("Gestion Véhicule", nil, {RightLabel = "→"}, true, {}, subMenu3)
                        else
                            RageUI.Button("Gestion Véhicule", nil, {RightLabel = "→"}, false, {}, subMenu3)
                        end
                    end
                    if pF5.Active.GestionSociete then
                        if ESX.PlayerData.job.grade_name == 'boss' or ESX.PlayerData.job2.grade_name == 'boss' then
                            RageUI.Button("Gestion Société", nil, {RightLabel = "→"}, true, {}, subMenu4)
                        else
                            RageUI.Button("Gestion Société", nil, {RightLabel = "→"}, false, {}, subMenu4)
                        end
                    end
                end)
                RageUI.IsVisible(subMenu,function()
                    RageUI.List("Filtre :", filterInventory, List.filter, nil, {}, true, {
                        onListChange = function(Index)
                            List.filter = Index
                            fIndex = Index                           
                        end
                    })
                    if filterInventory[fIndex] == "Items" or filterInventory[fIndex] == "Aucun" then
                        if not pF5.Weight then
                            ESX.PlayerData = ESX.GetPlayerData()
                            local currentWeight = 0
                            if pF5.LocalWeight.Active then
                                for k,v in ipairs(ESX.PlayerData.inventory) do
                                    if v.count > 0 then
                                        for y,z in pairs(pF5.LocalWeight.weight) do
                                            if y == v.name then
                                                currentWeight = currentWeight + (z * v.count)
                                            end
                                        end
                                    end
                                end
                                RageUI.Separator("Poids : "..currentWeight.." / "..pF5.LocalWeight.maxWeight.."Kg")
                            else
                                RageUI.Separator("↓ Inventaire ↓")
                            end
                            for i = 1, #ESX.PlayerData.inventory, 1 do
                                if ESX.PlayerData.inventory[i].count > 0 then
                                    local data = {}
                                    for i = 1, ESX.PlayerData.inventory[i].count, 1 do
                                        table.insert(data, i)
                                    end
                                    RageUI.List(ESX.PlayerData.inventory[i].label.." ~g~x"..ESX.PlayerData.inventory[i].count, {"Utiliser", "Donner", "Jeter"}, List.vinv, nil, {}, true, {
                                        onListChange = function(Index)
                                            List.vinv = Index
                                        end,
                                        onSelected = function(Index)
                                            Fct.cpt_i = ESX.PlayerData.inventory[i]
                                            Fct.all_i[ESX.PlayerData.inventory[i].name] = Index            
                                            if Index == 1 then
                                                if Fct.cpt_i.usable then
                                                    TriggerServerEvent('esx:useItem', Fct.cpt_i.name)
                                                else
                                                    ESX.ShowNotification("Item non utilisable")
                                                end
                                            elseif Index == 2 then
                                                local quantityd = KeyboardInput("Nombre d'item que vous souhaitez donner ", "", 5)
                                                if quantityd == nil or quantityd == "" then
                                                    ESX.ShowNotification("Veuillez rentrer une valeur valide")
                                                else 
                                                    quantityd = tonumber(quantityd)
                                                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                                    if closestDistance ~= -1 and closestDistance <= 3 then
                                                        if Fct.cpt_i.count >= quantityd then
                                                            PlayAnim("mp_common", "givetake1_a")
                                                            TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(closestPlayer), 'item_standard', Fct.cpt_i.name, quantityd)
                                                        else
                                                            ESX.ShowNotification("Vous ne pouvez pas en donner autant")
                                                        end
                                                    else
                                                        ESX.ShowNotification("Aucune personne à proximité")
                                                    end                                              
                                                end
                                            elseif Index == 3 then
                                                local quantityj = KeyboardInput("Nombre d'item que vous souhaitez jeter ", "", 5)
                                                if quantityj == nil or quantityj == "" then
                                                    ESX.ShowNotification("Veuillez rentrer une valeur valide")
                                                else 
                                                    quantityj = tonumber(quantityj)
                                                    if Fct.cpt_i.count >= quantityj then
                                                        TriggerServerEvent('esx:removeInventoryItem', 'item_standard', Fct.cpt_i.name, quantityj)
                                                    else
                                                        ESX.ShowNotification("Vous ne pouvez pas jeter autant")
                                                    end
                                                end
                                            end               
                                        end
                                    })
                                end
                            end
                        else
                            ESX.PlayerData = ESX.GetPlayerData()
                            local elements, currentWeight = {}, 0
                            local playerPed = PlayerPedId()
                            for k,v in ipairs(ESX.PlayerData.inventory) do
                                if v.count > 0 then
                                    currentWeight = currentWeight + (v.weight * v.count)
                                    table.insert(elements, {
                                        label = ('%s x%s'):format(v.label, v.count),
                                        count = v.count,
                                        type = 'item_standard',
                                        value = v.name,
                                        usable = v.usable,
                                        rare = v.rare,
                                        canRemove = v.canRemove
                                    })
                                end
                            end
                            RageUI.Separator("Poids : "..currentWeight.." / "..ESX.PlayerData.maxWeight.."Kg")
                            for i = 1, #ESX.PlayerData.inventory, 1 do
                                if ESX.PlayerData.inventory[i].count > 0 then
                                    RageUI.List("["..(ESX.PlayerData.inventory[i].count * ESX.PlayerData.inventory[i].weight).."Kg] - "..ESX.PlayerData.inventory[i].label.." ~g~x"..ESX.PlayerData.inventory[i].count.."", {"Utiliser", "Donner", "Jeter"}, List.vinv, nil, {}, true, {
                                        onListChange = function(Index)
                                            List.vinv = Index
                                        end,
                                        onSelected = function(Index)
                                            Fct.cpt_i = ESX.PlayerData.inventory[i]
                                            Fct.all_i[ESX.PlayerData.inventory[i].name] = Index            
                                            if Index == 1 then
                                                if Fct.cpt_i.usable then
                                                    TriggerServerEvent('esx:useItem', Fct.cpt_i.name)
                                                else
                                                    ESX.ShowNotification("Item non utilisable")
                                                end
                                            elseif Index == 2 then
                                                local quantityd = KeyboardInput("Nombre d'item que vous souhaitez donner ", "", 5)
                                                if quantityd == nil or quantityd == "" then
                                                    ESX.ShowNotification("Veuillez rentrer une valeur valide")
                                                else 
                                                    quantityd = tonumber(quantityd)
                                                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                                    if closestDistance ~= -1 and closestDistance <= 3 then
                                                        if Fct.cpt_i.count >= quantityd then
                                                            PlayAnim("mp_common", "givetake1_a")
                                                            TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(closestPlayer), 'item_standard', Fct.cpt_i.name, quantityd)
                                                        else
                                                            ESX.ShowNotification("Vous ne pouvez pas en donner autant")
                                                        end
                                                    else
                                                        ESX.ShowNotification("Aucune personne à proximité")
                                                    end
                                                end
                                            elseif Index == 3 then
                                                local quantityj = KeyboardInput("Nombre d'item que vous souhaitez jeter ", "", 5)
                                                if quantityj == nil or quantityj == "" then
                                                    ESX.ShowNotification("Veuillez rentrer une valeur valide")
                                                else 
                                                    quantityj = tonumber(quantityj)
                                                    if Fct.cpt_i.count >= quantityj then
                                                        TriggerServerEvent('esx:removeInventoryItem', 'item_standard', Fct.cpt_i.name, quantityj)
                                                    else
                                                        ESX.ShowNotification("Vous ne pouvez pas jeter autant")
                                                    end
                                                end
                                            end
                                        end
                                    })
                                end
                            end
                        end
                    end
                    if filterInventory[fIndex] == "Armes" or filterInventory[fIndex] == "Aucun" then
                        local WeaponListSeparator = false
                        for i = 1, #WeaponList, 1 do                             
                            if HasPedGotWeapon(PlayerPedId(), WeaponList[i].hash, false) then 
                                if not WeaponListSeparator then    
                                    RageUI.Separator("↓ Armes ↓")
                                    WeaponListSeparator = true
                                end
                            end
                        end
                        for i = 1, #WeaponList, 1 do                        
                            if HasPedGotWeapon(PlayerPedId(), WeaponList[i].hash, false) then                               
                                local ammo = GetAmmoInPedWeapon(PlayerPedId(), WeaponList[i].hash)
                                local value = WeaponList[i].name
                                local label = WeaponList[i].label      
                                RageUI.List(WeaponList[i].label.. " - [~g~x"..ammo.."~s~]", {"Donner", "Donner Munitions","Jeter"}, List.vinv2, nil, {}, true, {
                                    onListChange = function(Index)
                                        List.vinv2 = Index
                                    end,
                                    onSelected = function(Index)           
                                        if Index == 1 then
                                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                            if closestDistance ~= -1 and closestDistance <= 3 then 
                                                TriggerServerEvent("esx:giveInventoryItem", GetPlayerServerId(closestPlayer), "item_weapon", WeaponList[i].name, ammo)    
                                            else
                                                ESX.ShowNotification("Aucune personne à proximité")
                                            end
                                        elseif Index == 2 then 
                                            local quantity = KeyboardInput('Nombre de munitions', '', 8)
                                            if quantity == nil or quantity == "" then
                                                ESX.ShowNotification("Veuillez rentrer une valeur valide")
                                            else 
                                                quantity = tonumber(quantity)
                                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    
                                                if closestDistance ~= -1 and closestDistance <= 3 then
                                                    local closestPed = GetPlayerPed(closestPlayer)
                                                    local pPed = GetPlayerPed(-1)
                                                    local coords = GetEntityCoords(pPed)
                                                    local x,y,z = table.unpack(coords)
                                                    DrawMarker(2, x, y, z+1.5, 0, 0, 0, 180.0,nil,nil, 0.5, 0.5, 0.5, 0, 0, 255, 120, true, true, p19, true)
                    
                                                    if IsPedOnFoot(closestPed) then
                                                        local ammo = GetAmmoInPedWeapon(PlayerPedId(), WeaponList[i].hash)         
                                                        if ammo > 0 then
                                                            if quantity <= ammo and quantity >= 0 then
                                                                local finalAmmo = math.floor(ammo - quantity)
                                                                SetPedAmmo(PlayerPedId(), WeaponList[i].name, finalAmmo)
                                                                PlayAnim("mp_common", "givetake1_a")
                                                                TriggerServerEvent('pF5:Weapon_addAmmoToPedS', GetPlayerServerId(closestPlayer), WeaponList[i].name, quantity)
                                                                ESX.ShowNotification("Vous avez donné x"..quantity.." munitions à "..GetPlayerName(closestPlayer))
                                                            else
                                                                ESX.ShowNotification('Vous ne possédez pas autant de munitions')
                                                            end
                                                        else
                                                            ESX.ShowNotification("Vous n'avez pas de munition")
                                                        end
                                                    else
                                                        ESX.ShowNotification('Vous ne pouvez pas donner des munitions dans un véhicule')
                                                    end
                                                else
                                                    ESX.ShowNotification('Aucune personne à proximité')
                                                end
                                            end
                                        elseif Index == 3 then                             
                                            TriggerServerEvent("esx:removeInventoryItem", "item_weapon", WeaponList[i].name)
                                        end               
                                    end
                                })
                            end
                        end
                    end
                    if filterInventory[fIndex] == "Carte Sim" or filterInventory[fIndex] == "Aucun" and pF5.pSim.Active and pF5.pSim.FilterInventory then
                        RageUI.Separator("↓ Carte Sim ↓")
                        if not active then
                            RageUI.Separator("Vous n'avez pas de téléphone")
                        else
                            if datanumber == nil then
                                RageUI.Separator("Votre numéro actuel : ~b~Aucun")
                            else
                                RageUI.Separator("Votre numéro actuel : ~b~"..datanumber.."")
                            end 
                        end
                        for _,v in pairs(ArraySim) do
                            RageUI.List(v.name, {"Utiliser", "Donner", "Renommer", "Supprimer"}, ArrayIndex, "Numéro attribué à la carte SIM : ~b~"..v.number, {}, active, {
                                onListChange = function(Index)
                                    ArrayIndex = Index
                                end,
                                onSelected = function()
                                    if active then
                                        if ArrayIndex == 1 then
                                            TriggerServerEvent("pSim:Use", v.number)
                                            Wait(200)
                                            Load()
                                            TriggerServerEvent("pSim:Load")
                                        elseif ArrayIndex == 2 then
                                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                            local closestPed = GetPlayerPed(closestPlayer)
                                            if IsPedSittingInAnyVehicle(closestPed) then
                                                ESX.ShowNotification('~r~Vous ne pouvez pas donner quelque chose à quelqu\'un dans un véhicule')
                                                return
                                            end
                                            if closestPlayer ~= -1 and closestDistance < 3.0 then
                                                PlayAnim("mp_common", "givetake1_a")
                                                TriggerServerEvent("pSim:Give", GetPlayerServerId(closestPlayer), v.number)
                                                Wait(200)
                                                Load()
                                            else
                                                ESX.ShowNotification("Personne à proximité")
                                            end
                                        elseif ArrayIndex == 3 then
                                            newname = KeyboardInput("Choisissez un nouveau nom pour votre carte sim", v.name, 50)
                                            if not newname or newname == "" then
                                                ESX.ShowNotification("Veuillez entrer un nom valide")
                                            else
                                                TriggerServerEvent("pSim:Rename", v.id, newname)
                                                Wait(200)
                                                Load()
                                            end
                                        elseif ArrayIndex == 4 then
                                            TriggerServerEvent("pSim:Delete", v.number)
                                            Wait(200)
                                            Load()
                                        end
                                    end
                                end
                            })
                        end
                    end
                    if filterInventory[fIndex] == "Vêtements & Accessoires" or filterInventory[fIndex] == "Aucun" and pF5.pClothes.Active and pF5.pClothes.FilterInventory then
                        RageUI.Separator("↓ Vêtements & Accessoires ↓")
                        if #result == 0 then
                            RageUI.Separator("Vous n'avez aucun vêtements / accessoires")
                        else
                            RageUI.List("Filtre Vêtements & Accessoires :", theItem, theIndex, nil, {}, true, {
                                onListChange = function(Index)
                                    theIndex = Index
                                end
                            })
                            RageUI.Line()
                        end
                        for i = 1, #result, 1 do
                            if theItem[theIndex] == result[i].type or theItem[theIndex] == "Aucun" then
                                RageUI.List(result[i].label, {"Mettre", "Enlever", "Renommer", "Donner", "Jeter"}, iIndex, nil, {}, true, {
                                    onListChange = function(Index)
                                        iIndex = Index
                                    end,
                                    onSelected = function(Index)
                                        k = json.decode(result[i].item)
                                        ped = GetPlayerPed(-1)
                                        if Index == 1 then
                                            if result[i].type == "Masque" then   
                                                if ped then
                                                    RequestAnimDict('missfbi4')            
                                                    while not HasAnimDictLoaded('missfbi4') do
                                                        Citizen.Wait(0)
                                                    end           
                                                    TaskPlayAnim(PlayerPedId(), 'missfbi4', 'takeoff_mask', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                    Citizen.Wait(1000)
                                                    SetEntityCollision(GetPlayerPed(-1), true, true)
                                                    TriggerEvent("skinchanger:change", "mask_1", k.item_1-1)
                                                    TriggerEvent("skinchanger:change", "mask_2", k.item_2-1)
                                                    Citizen.Wait(200)
                                                    ClearPedTasks(GetPlayerPed(-1))
                                                    TriggerEvent('skinchanger:getSkin', function(skin)
                                                        TriggerServerEvent('esx_skin:save', skin)
                                                    end)  
                                                end
                                            elseif result[i].type == "Lunette" then            
                                                if ped then
                                                    RequestAnimDict('clothingspecs')           
                                                    while not HasAnimDictLoaded('clothingspecs') do
                                                        Citizen.Wait(0)
                                                    end         
                                                    TaskPlayAnim(PlayerPedId(), 'clothingspecs', 'try_glasses_positive_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                    Citizen.Wait(1000)
                                                    SetEntityCollision(GetPlayerPed(-1), true, true)
                                                    TriggerEvent("skinchanger:change", "glasses_1", k.item_1-1)
                                                    TriggerEvent("skinchanger:change", "glasses_2", k.item_2-1)
                                                    Citizen.Wait(200)
                                                    ClearPedTasks(GetPlayerPed(-1))
                                                    TriggerEvent('skinchanger:getSkin', function(skin)
                                                        TriggerServerEvent('esx_skin:save', skin)
                                                    end)  
                                                end
                                            elseif result[i].type == "Sac" then            
                                                if ped then
                                                    RequestAnimDict('clothingtie')           
                                                    while not HasAnimDictLoaded('clothingtie') do
                                                        Citizen.Wait(0)
                                                    end         
                                                    TaskPlayAnim(PlayerPedId(), 'clothingtie', 'try_tie_neutral_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                    Citizen.Wait(1000)
                                                    SetEntityCollision(GetPlayerPed(-1), true, true)
                                                    TriggerEvent("skinchanger:change", "bags_1", k.item_1-1)
                                                    TriggerEvent("skinchanger:change", "bags_2", k.item_2-1)
                                                    Citizen.Wait(200)
                                                    ClearPedTasks(GetPlayerPed(-1))
                                                    TriggerEvent('skinchanger:getSkin', function(skin)
                                                        TriggerServerEvent('esx_skin:save', skin)
                                                    end)  
                                                end
                                            elseif result[i].type == "Veste" then            
                                                if ped then
                                                    RequestAnimDict('clothingtie')           
                                                    while not HasAnimDictLoaded('clothingtie') do
                                                        Citizen.Wait(0)
                                                    end         
                                                    TaskPlayAnim(PlayerPedId(), 'clothingtie', 'try_tie_neutral_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                    Citizen.Wait(1000)
                                                    SetEntityCollision(GetPlayerPed(-1), true, true)
                                                    TriggerEvent("skinchanger:change", "torso_1", k.item_1-1)
                                                    TriggerEvent("skinchanger:change", "torso_2", k.item_2-1)
                                                    Citizen.Wait(200)
                                                    ClearPedTasks(GetPlayerPed(-1))
                                                    TriggerEvent('skinchanger:getSkin', function(skin)
                                                        TriggerServerEvent('esx_skin:save', skin)
                                                    end)  
                                                end 
                                            elseif result[i].type == "T-Shirt" then            
                                                if ped then
                                                    RequestAnimDict('clothingtie')           
                                                    while not HasAnimDictLoaded('clothingtie') do
                                                        Citizen.Wait(0)
                                                    end         
                                                    TaskPlayAnim(PlayerPedId(), 'clothingtie', 'try_tie_neutral_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                    Citizen.Wait(1000)
                                                    SetEntityCollision(GetPlayerPed(-1), true, true)
                                                    TriggerEvent("skinchanger:change", "tshirt_1", k.item_1-1)
                                                    TriggerEvent("skinchanger:change", "tshirt_2", k.item_2-1)
                                                    Citizen.Wait(200)
                                                    ClearPedTasks(GetPlayerPed(-1))
                                                    TriggerEvent('skinchanger:getSkin', function(skin)
                                                        TriggerServerEvent('esx_skin:save', skin)
                                                    end)  
                                                end  
                                            elseif result[i].type == "Pantalon" then            
                                                if ped then
                                                    RequestAnimDict('clothingtrousers')           
                                                    while not HasAnimDictLoaded('clothingtrousers') do
                                                        Citizen.Wait(0)
                                                    end         
                                                    TaskPlayAnim(PlayerPedId(), 'clothingtrousers', 'try_trousers_neutral_c', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                    Citizen.Wait(1000)
                                                    SetEntityCollision(GetPlayerPed(-1), true, true)
                                                    TriggerEvent("skinchanger:change", "pants_1", k.item_1-1)
                                                    TriggerEvent("skinchanger:change", "pants_2", k.item_2-1)
                                                    Citizen.Wait(200)
                                                    ClearPedTasks(GetPlayerPed(-1))
                                                    TriggerEvent('skinchanger:getSkin', function(skin)
                                                        TriggerServerEvent('esx_skin:save', skin)
                                                    end)  
                                                end
                                            elseif result[i].type == "Chaussure" then            
                                                if ped then
                                                    RequestAnimDict('clothingshoes')           
                                                    while not HasAnimDictLoaded('clothingshoes') do
                                                        Citizen.Wait(0)
                                                    end         
                                                    TaskPlayAnim(PlayerPedId(), 'clothingshoes', 'try_shoes_positive_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                    Citizen.Wait(1000)
                                                    SetEntityCollision(GetPlayerPed(-1), true, true)
                                                    TriggerEvent("skinchanger:change", "shoes_1", k.item_1-1)
                                                    TriggerEvent("skinchanger:change", "shoes_2", k.item_2-1)
                                                    Citizen.Wait(200)
                                                    ClearPedTasks(GetPlayerPed(-1))
                                                    TriggerEvent('skinchanger:getSkin', function(skin)
                                                        TriggerServerEvent('esx_skin:save', skin)
                                                    end)  
                                                end  
                                            elseif result[i].type == "Chaine" then            
                                                if ped then
                                                    RequestAnimDict('clothingtie')           
                                                    while not HasAnimDictLoaded('clothingtie') do
                                                        Citizen.Wait(0)
                                                    end         
                                                    TaskPlayAnim(PlayerPedId(), 'clothingtie', 'try_tie_positive_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                    Citizen.Wait(3000)
                                                    SetEntityCollision(GetPlayerPed(-1), true, true)
                                                    TriggerEvent("skinchanger:change", "chain_1", k.item_1-1)
                                                    TriggerEvent("skinchanger:change", "chain_2", k.item_2-1)
                                                    Citizen.Wait(200)
                                                    ClearPedTasks(GetPlayerPed(-1))
                                                    TriggerEvent('skinchanger:getSkin', function(skin)
                                                        TriggerServerEvent('esx_skin:save', skin)
                                                    end)  
                                                end          
                                            elseif result[i].type == "Casque" then           
                                                if ped then
                                                    RequestAnimDict('missheistdockssetup1hardhat@')           
                                                    while not HasAnimDictLoaded('missheistdockssetup1hardhat@') do
                                                        Citizen.Wait(0)
                                                    end           
                                                    TaskPlayAnim(PlayerPedId(), 'missheistdockssetup1hardhat@', 'put_on_hat', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                    Citizen.Wait(1000)
                                                    SetEntityCollision(GetPlayerPed(-1), true, true)
                                                    TriggerEvent("skinchanger:change", "helmet_1", k.item_1-2)
                                                    TriggerEvent("skinchanger:change", "helmet_2", k.item_2-1)
                                                    Citizen.Wait(200)
                                                    ClearPedTasks(GetPlayerPed(-1))
                                                    TriggerEvent('skinchanger:getSkin', function(skin)
                                                        TriggerServerEvent('esx_skin:save', skin)
                                                    end)  
                                                end
                                            elseif result[i].type == "Accessoire d'Oreille" then       
                                                if ped then
                                                    RequestAnimDict('mini@ears_defenders')           
                                                    while not HasAnimDictLoaded('mini@ears_defenders') do
                                                        Citizen.Wait(0)
                                                    end
                                                    TaskPlayAnim(PlayerPedId(), 'mini@ears_defenders', 'takeoff_earsdefenders_idle', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                    Citizen.Wait(1000)
                                                    SetEntityCollision(GetPlayerPed(-1), true, true)
                                                    TriggerEvent("skinchanger:change", "ears_1", k.item_1-2)
                                                    TriggerEvent("skinchanger:change", "ears_2", k.item_2-1)
                                                    Citizen.Wait(200)
                                                    ClearPedTasks(GetPlayerPed(-1))
                                                    TriggerEvent('skinchanger:getSkin', function(skin)
                                                        TriggerServerEvent('esx_skin:save', skin)
                                                    end)  
                                                end  
                                            elseif result[i].type == "Montre" then       
                                                if ped then
                                                    --RequestAnimDict('mini@ears_defenders')           
                                                    --while not HasAnimDictLoaded('mini@ears_defenders') do
                                                    --    Citizen.Wait(0)
                                                    --end
                                                    --TaskPlayAnim(PlayerPedId(), 'mini@ears_defenders', 'takeoff_earsdefenders_idle', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                    Citizen.Wait(1000)
                                                    SetEntityCollision(GetPlayerPed(-1), true, true)
                                                    TriggerEvent("skinchanger:change", "watches_1", k.item_1-2)
                                                    TriggerEvent("skinchanger:change", "watches_2", k.item_2-1)
                                                    Citizen.Wait(200)
                                                    ClearPedTasks(GetPlayerPed(-1))
                                                    TriggerEvent('skinchanger:getSkin', function(skin)
                                                        TriggerServerEvent('esx_skin:save', skin)
                                                    end)  
                                                end    
                                            elseif result[i].type == "Bracelet" then       
                                                if ped then
                                                    --RequestAnimDict('mini@ears_defenders')           
                                                    --while not HasAnimDictLoaded('mini@ears_defenders') do
                                                    --    Citizen.Wait(0)
                                                    --end
                                                    --TaskPlayAnim(PlayerPedId(), 'mini@ears_defenders', 'takeoff_earsdefenders_idle', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                    Citizen.Wait(1000)
                                                    SetEntityCollision(GetPlayerPed(-1), true, true)
                                                    TriggerEvent("skinchanger:change", "bracelets_1", k.item_1-2)
                                                    TriggerEvent("skinchanger:change", "bracelets_2", k.item_2-1)
                                                    Citizen.Wait(200)
                                                    ClearPedTasks(GetPlayerPed(-1))
                                                    TriggerEvent('skinchanger:getSkin', function(skin)
                                                        TriggerServerEvent('esx_skin:save', skin)
                                                    end)  
                                                end   
                                            elseif result[i].type == "Gilet par balle" then       
                                                if ped then
                                                    RequestAnimDict('clothingtie')           
                                                    while not HasAnimDictLoaded('clothingtie') do
                                                    Citizen.Wait(0)
                                                    end
                                                    TaskPlayAnim(PlayerPedId(), 'clothingtie', 'try_tie_neutral_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                    Citizen.Wait(1000)
                                                    SetEntityCollision(GetPlayerPed(-1), true, true)
                                                    TriggerEvent("skinchanger:change", "bproof_1", k.item_1-2)
                                                    TriggerEvent("skinchanger:change", "bproof_2", k.item_2-1)
                                                    Citizen.Wait(200)
                                                    ClearPedTasks(GetPlayerPed(-1))
                                                    TriggerEvent('skinchanger:getSkin', function(skin)
                                                        TriggerServerEvent('esx_skin:save', skin)
                                                    end)  
                                                end         
                                            end
                                        elseif Index == 2 then
                                            if result[i].type == "Masque" then   
                                                if ped then
                                                    RequestAnimDict('missfbi4')            
                                                    while not HasAnimDictLoaded('missfbi4') do
                                                        Citizen.Wait(0)
                                                    end           
                                                    TaskPlayAnim(PlayerPedId(), 'missfbi4', 'takeoff_mask', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                    Citizen.Wait(1000)
                                                    SetEntityCollision(GetPlayerPed(-1), true, true)
                                                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
                                                        if skina.sex == 1 then
                                                            TriggerEvent("skinchanger:change", "mask_1", pF5.Clothes.Female.mask_1)
                                                            TriggerEvent("skinchanger:change", "mask_2", pF5.Clothes.Female.mask_2)
                                                        else
                                                            TriggerEvent("skinchanger:change", "mask_1", pF5.Clothes.Male.mask_1)
                                                            TriggerEvent("skinchanger:change", "mask_2", pF5.Clothes.Male.mask_2)
                                                        end
                                                    end)
                                                    Citizen.Wait(200)
                                                    ClearPedTasks(GetPlayerPed(-1))
                                                    TriggerEvent('skinchanger:getSkin', function(skin)
                                                        TriggerServerEvent('esx_skin:save', skin)
                                                    end)  
                                                end
                                            elseif result[i].type == "Lunette" then            
                                                if ped then
                                                    RequestAnimDict('clothingspecs')           
                                                    while not HasAnimDictLoaded('clothingspecs') do
                                                        Citizen.Wait(0)
                                                    end         
                                                    TaskPlayAnim(PlayerPedId(), 'clothingspecs', 'try_glasses_positive_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                    Citizen.Wait(1000)
                                                    SetEntityCollision(GetPlayerPed(-1), true, true)
                                                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
                                                        if skina.sex == 1 then
                                                            TriggerEvent("skinchanger:change", "glasses_1", pF5.Clothes.Female.glasses_1)
                                                            TriggerEvent("skinchanger:change", "glasses_2", pF5.Clothes.Female.glasses_2)
                                                        else
                                                            TriggerEvent("skinchanger:change", "glasses_1", pF5.Clothes.Male.glasses_1)
                                                            TriggerEvent("skinchanger:change", "glasses_2", pF5.Clothes.Male.glasses_2)
                                                        end
                                                    end)
                                                    Citizen.Wait(200)
                                                    ClearPedTasks(GetPlayerPed(-1))
                                                    TriggerEvent('skinchanger:getSkin', function(skin)
                                                        TriggerServerEvent('esx_skin:save', skin)
                                                    end)  
                                                end
                                            elseif result[i].type == "Sac" then            
                                                if ped then
                                                    RequestAnimDict('clothingtie')           
                                                    while not HasAnimDictLoaded('clothingtie') do
                                                        Citizen.Wait(0)
                                                    end         
                                                    TaskPlayAnim(PlayerPedId(), 'clothingtie', 'try_tie_neutral_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                    Citizen.Wait(1000)
                                                    SetEntityCollision(GetPlayerPed(-1), true, true)
                                                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
                                                        if skina.sex == 1 then
                                                            TriggerEvent("skinchanger:change", "bags_1", pF5.Clothes.Female.bags_1)
                                                            TriggerEvent("skinchanger:change", "bags_2", pF5.Clothes.Female.bags_2)
                                                        else
                                                            TriggerEvent("skinchanger:change", "bags_1", pF5.Clothes.Male.bags_1)
                                                            TriggerEvent("skinchanger:change", "bags_2", pF5.Clothes.Male.bags_2)
                                                        end
                                                    end)
                                                    Citizen.Wait(200)
                                                    ClearPedTasks(GetPlayerPed(-1))
                                                    TriggerEvent('skinchanger:getSkin', function(skin)
                                                        TriggerServerEvent('esx_skin:save', skin)
                                                    end)  
                                                end
                                            elseif result[i].type == "Veste" then            
                                                if ped then
                                                    RequestAnimDict('clothingtie')           
                                                    while not HasAnimDictLoaded('clothingtie') do
                                                        Citizen.Wait(0)
                                                    end         
                                                    TaskPlayAnim(PlayerPedId(), 'clothingtie', 'try_tie_neutral_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                    Citizen.Wait(1000)
                                                    SetEntityCollision(GetPlayerPed(-1), true, true)
                                                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
                                                        if skina.sex == 1 then
                                                            TriggerEvent("skinchanger:change", "torso_1", pF5.Clothes.Female.torso_1)
                                                            TriggerEvent("skinchanger:change", "torso_2", pF5.Clothes.Female.torso_2)
                                                        else
                                                            TriggerEvent("skinchanger:change", "torso_1", pF5.Clothes.Male.torso_1)
                                                            TriggerEvent("skinchanger:change", "torso_2", pF5.Clothes.Male.torso_2)                                              
                                                        end
                                                    end)
                                                    Citizen.Wait(200)
                                                    ClearPedTasks(GetPlayerPed(-1))
                                                    TriggerEvent('skinchanger:getSkin', function(skin)
                                                        TriggerServerEvent('esx_skin:save', skin)
                                                    end)  
                                                end 
                                            elseif result[i].type == "T-Shirt" then            
                                                if ped then
                                                    RequestAnimDict('clothingtie')           
                                                    while not HasAnimDictLoaded('clothingtie') do
                                                        Citizen.Wait(0)
                                                    end         
                                                    TaskPlayAnim(PlayerPedId(), 'clothingtie', 'try_tie_neutral_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                    Citizen.Wait(1000)
                                                    SetEntityCollision(GetPlayerPed(-1), true, true)
                                                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
                                                        if skina.sex == 1 then
                                                            TriggerEvent("skinchanger:change", "tshirt_1", pF5.Clothes.Female.tshirt_1)
                                                            TriggerEvent("skinchanger:change", "tshirt_2", pF5.Clothes.Female.tshirt_2)
                                                        else
                                                            TriggerEvent("skinchanger:change", "tshirt_1", pF5.Clothes.Male.tshirt_1)
                                                            TriggerEvent("skinchanger:change", "tshirt_2", pF5.Clothes.Male.tshirt_2)
                                                        end
                                                    end)
                                                    Citizen.Wait(200)
                                                    ClearPedTasks(GetPlayerPed(-1))
                                                    TriggerEvent('skinchanger:getSkin', function(skin)
                                                        TriggerServerEvent('esx_skin:save', skin)
                                                    end)  
                                                end  
                                            elseif result[i].type == "Pantalon" then            
                                                if ped then
                                                    RequestAnimDict('clothingtrousers')           
                                                    while not HasAnimDictLoaded('clothingtrousers') do
                                                        Citizen.Wait(0)
                                                    end         
                                                    TaskPlayAnim(PlayerPedId(), 'clothingtrousers', 'try_trousers_neutral_c', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                    Citizen.Wait(1000)
                                                    SetEntityCollision(GetPlayerPed(-1), true, true)
                                                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
                                                        if skina.sex == 1 then
                                                            TriggerEvent("skinchanger:change", "pants_1", pF5.Clothes.Female.pants_1)
                                                            TriggerEvent("skinchanger:change", "pants_2", pF5.Clothes.Female.pants_2)
                                                        else
                                                            TriggerEvent("skinchanger:change", "pants_1", pF5.Clothes.Male.pants_1)
                                                            TriggerEvent("skinchanger:change", "pants_2", pF5.Clothes.Male.pants_2)
                                                        end
                                                    end)
                                                    Citizen.Wait(200)
                                                    ClearPedTasks(GetPlayerPed(-1))
                                                    TriggerEvent('skinchanger:getSkin', function(skin)
                                                        TriggerServerEvent('esx_skin:save', skin)
                                                    end)  
                                                end
                                            elseif result[i].type == "Chaussure" then            
                                                if ped then
                                                    RequestAnimDict('clothingshoes')           
                                                    while not HasAnimDictLoaded('clothingshoes') do
                                                        Citizen.Wait(0)
                                                    end         
                                                    TaskPlayAnim(PlayerPedId(), 'clothingshoes', 'try_shoes_positive_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                    Citizen.Wait(1000)
                                                    SetEntityCollision(GetPlayerPed(-1), true, true)
                                                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
                                                        if skina.sex == 1 then
                                                            TriggerEvent("skinchanger:change", "shoes_1", pF5.Clothes.Female.shoes_1)
                                                            TriggerEvent("skinchanger:change", "shoes_2", pF5.Clothes.Female.shoes_2)
                                                        else
                                                            TriggerEvent("skinchanger:change", "shoes_1", pF5.Clothes.Male.shoes_1)
                                                            TriggerEvent("skinchanger:change", "shoes_2", pF5.Clothes.Male.shoes_2)
                                                        end
                                                    end)
                                                    Citizen.Wait(200)
                                                    ClearPedTasks(GetPlayerPed(-1))
                                                    TriggerEvent('skinchanger:getSkin', function(skin)
                                                        TriggerServerEvent('esx_skin:save', skin)
                                                    end)  
                                                end  
                                            elseif result[i].type == "Chaine" then            
                                                if ped then
                                                    RequestAnimDict('clothingtie')           
                                                    while not HasAnimDictLoaded('clothingtie') do
                                                        Citizen.Wait(0)
                                                    end         
                                                    TaskPlayAnim(PlayerPedId(), 'clothingtie', 'try_tie_positive_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                    Citizen.Wait(3000)
                                                    SetEntityCollision(GetPlayerPed(-1), true, true)
                                                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
                                                        if skina.sex == 1 then
                                                            TriggerEvent("skinchanger:change", "chain_1", pF5.Clothes.Female.chain_1)
                                                            TriggerEvent("skinchanger:change", "chain_2", pF5.Clothes.Female.chain_2)
                                                        else
                                                            TriggerEvent("skinchanger:change", "chain_1", pF5.Clothes.Male.chain_1)
                                                            TriggerEvent("skinchanger:change", "chain_2", pF5.Clothes.Male.chain_2)
                                                        end
                                                    end)
                                                    Citizen.Wait(200)
                                                    ClearPedTasks(GetPlayerPed(-1))
                                                    TriggerEvent('skinchanger:getSkin', function(skin)
                                                        TriggerServerEvent('esx_skin:save', skin)
                                                    end)  
                                                end          
                                            elseif result[i].type == "Casque" then           
                                                if ped then
                                                    RequestAnimDict('missheistdockssetup1hardhat@')           
                                                    while not HasAnimDictLoaded('missheistdockssetup1hardhat@') do
                                                        Citizen.Wait(0)
                                                    end           
                                                    TaskPlayAnim(PlayerPedId(), 'missheistdockssetup1hardhat@', 'put_on_hat', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                    Citizen.Wait(1000)
                                                    SetEntityCollision(GetPlayerPed(-1), true, true)                
                                                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
                                                        if skina.sex == 1 then
                                                            TriggerEvent("skinchanger:change", "helmet_1", pF5.Clothes.Female.helmet_1)
                                                            TriggerEvent("skinchanger:change", "helmet_2", pF5.Clothes.Female.helmet_2)
                                                        else
                                                            TriggerEvent("skinchanger:change", "helmet_1", pF5.Clothes.Male.helmet_1)
                                                            TriggerEvent("skinchanger:change", "helmet_2", pF5.Clothes.Male.helmet_2)
                                                        end
                                                    end)
                                                    Citizen.Wait(200)
                                                    ClearPedTasks(GetPlayerPed(-1))
                                                    TriggerEvent('skinchanger:getSkin', function(skin)
                                                        TriggerServerEvent('esx_skin:save', skin)
                                                    end)  
                                                end
                                            elseif result[i].type == "Accessoire d'Oreille" then       
                                                if ped then
                                                    RequestAnimDict('mini@ears_defenders')           
                                                    while not HasAnimDictLoaded('mini@ears_defenders') do
                                                        Citizen.Wait(0)
                                                    end
                                                    TaskPlayAnim(PlayerPedId(), 'mini@ears_defenders', 'takeoff_earsdefenders_idle', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                    Citizen.Wait(1000)
                                                    SetEntityCollision(GetPlayerPed(-1), true, true)
                                                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
                                                        if skina.sex == 1 then
                                                            TriggerEvent("skinchanger:change", "ears_1", pF5.Clothes.Female.ears_1)
                                                            TriggerEvent("skinchanger:change", "ears_2", pF5.Clothes.Female.ears_2)
                                                        else
                                                            TriggerEvent("skinchanger:change", "ears_1", pF5.Clothes.Male.ears_1)
                                                            TriggerEvent("skinchanger:change", "ears_2", pF5.Clothes.Male.ears_2)
                                                        end
                                                    end)
                                                    Citizen.Wait(200)
                                                    ClearPedTasks(GetPlayerPed(-1))
                                                    TriggerEvent('skinchanger:getSkin', function(skin)
                                                        TriggerServerEvent('esx_skin:save', skin)
                                                    end)  
                                                end         
                                            elseif result[i].type == "Montre" then       
                                                if ped then
                                                    -- RequestAnimDict('mini@ears_defenders')           
                                                    -- while not HasAnimDictLoaded('mini@ears_defenders') do
                                                    --     Citizen.Wait(0)
                                                    -- end
                                                    -- TaskPlayAnim(PlayerPedId(), 'mini@ears_defenders', 'takeoff_earsdefenders_idle', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                    Citizen.Wait(1000)
                                                    SetEntityCollision(GetPlayerPed(-1), true, true)
                                                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
                                                        if skina.sex == 1 then
                                                            TriggerEvent("skinchanger:change", "watches_1", pF5.Clothes.Female.watches_1)
                                                            TriggerEvent("skinchanger:change", "watches_2", pF5.Clothes.Female.watches_2)
                                                        else
                                                            TriggerEvent("skinchanger:change", "watches_1", pF5.Clothes.Male.watches_1)
                                                            TriggerEvent("skinchanger:change", "watches_2", pF5.Clothes.Male.watches_2)
                                                        end
                                                    end)
                                                    Citizen.Wait(200)
                                                    ClearPedTasks(GetPlayerPed(-1))
                                                    TriggerEvent('skinchanger:getSkin', function(skin)
                                                        TriggerServerEvent('esx_skin:save', skin)
                                                    end)  
                                                end   
                                            elseif result[i].type == "Bracelet" then       
                                                if ped then
                                                    -- RequestAnimDict('mini@ears_defenders')           
                                                    -- while not HasAnimDictLoaded('mini@ears_defenders') do
                                                    --     Citizen.Wait(0)
                                                    -- end
                                                    -- TaskPlayAnim(PlayerPedId(), 'mini@ears_defenders', 'takeoff_earsdefenders_idle', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                    Citizen.Wait(1000)
                                                    SetEntityCollision(GetPlayerPed(-1), true, true)
                                                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
                                                        if skina.sex == 1 then
                                                            TriggerEvent("skinchanger:change", "bracelets_1", pF5.Clothes.Female.bracelets_1)
                                                            TriggerEvent("skinchanger:change", "bracelets_2", pF5.Clothes.Female.bracelets_2)
                                                        else
                                                            TriggerEvent("skinchanger:change", "bracelets_1", pF5.Clothes.Male.bracelets_1)
                                                            TriggerEvent("skinchanger:change", "bracelets_2", pF5.Clothes.Male.bracelets_2)
                                                        end
                                                    end)
                                                    Citizen.Wait(200)
                                                    ClearPedTasks(GetPlayerPed(-1))
                                                    TriggerEvent('skinchanger:getSkin', function(skin)
                                                        TriggerServerEvent('esx_skin:save', skin)
                                                    end)  
                                                end     
                                            elseif result[i].type == "Gilet par balle" then       
                                                if ped then
                                                    RequestAnimDict('clothingtie')           
                                                    while not HasAnimDictLoaded('clothingtie') do
                                                    Citizen.Wait(0)
                                                    end
                                                    TaskPlayAnim(PlayerPedId(), 'clothingtie', 'try_tie_neutral_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                    Citizen.Wait(1000)
                                                    SetEntityCollision(GetPlayerPed(-1), true, true)
                                                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
                                                        if skina.sex == 1 then
                                                            TriggerEvent("skinchanger:change", "bproof_1", pF5.Clothes.Female.bproof_1)
                                                            TriggerEvent("skinchanger:change", "bproof_2", pF5.Clothes.Female.bproof_2)
                                                        else
                                                            TriggerEvent("skinchanger:change", "bproof_1", pF5.Clothes.Male.bproof_1)
                                                            TriggerEvent("skinchanger:change", "bproof_2", pF5.Clothes.Male.bproof_2)
                                                        end
                                                    end)
                                                    Citizen.Wait(200)
                                                    ClearPedTasks(GetPlayerPed(-1))
                                                    TriggerEvent('skinchanger:getSkin', function(skin)
                                                        TriggerServerEvent('esx_skin:save', skin)
                                                    end)  
                                                end   
                                            end
                                        elseif Index == 3 then
                                            result[i].type = result[i].type
                                            local txt = KeyboardInput(result[i].label, "", 40)
                                            if txt then                                          
                                                TriggerServerEvent("pClothesItem:Rename", result[i].id, txt, result[i].type)
                                                result[i].label = txt
                                            else
                                                ESX.ShowNotification("Veuillez entrer un nom valide")
                                            end
                                        elseif Index == 4 then
                                            if result[i].index == 99 then
                                                SetPedComponentVariation(PlayerPedId(), 1, 0, 0, 2)
                                            else
                                                ClearPedProp(PlayerPedId(), result[i].index)
                                            end
                                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                            local closestPed = GetPlayerPed(closestPlayer)
                                            if IsPedSittingInAnyVehicle(closestPed) then
                                                ESX.ShowNotification('~r~Impossible de donner un objet dans un véhicule')
                                                return
                                            end
                                            if closestPlayer ~= -1 and closestDistance < 3.0 then
                                                TriggerServerEvent('pClothesItem:Give', GetPlayerServerId(closestPlayer), result[i].id, result[i].label)        
                                                table.remove(result, i)      
                                            else
                                                ESX.ShowNotification("~r~Aucun joueurs proche")           
                                            end
                                        elseif Index == 5 then
                                            TriggerServerEvent('pClothesItem:Delete', result[i].id, result[i].label,result[i])
                                            TriggerEvent('pClothesItem:Sync')
                                        end
                                    end
                                })
                            end
                        end
                    end
                end)
                RageUI.IsVisible(subMenu2,function()
                    ESX.PlayerData = ESX.GetPlayerData()
                    RageUI.Button("Métier :", nil, {RightLabel = ""..ESX.PlayerData.job.label.." - "..ESX.PlayerData.job.grade_label..""}, true, {})
                    RageUI.Button("Organisation :", nil, {RightLabel = ""..ESX.PlayerData.job2.label.." - "..ESX.PlayerData.job2.grade_label..""}, true, {})
                    if not pF5.Legacy then  
                        RageUI.List("Argent : ~g~"..ESX.Math.GroupDigits(ESX.PlayerData.money).."$", {"Donner", "Jeter"}, List.pfa, nil, {}, true, {
                            onListChange = function(Index)
                                List.pfa = Index
                            end,
                            onSelected = function(Index)             
                                if Index == 1 then
                                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                    local quantityad = KeyboardInput("Montant d'argent que vous souhaitez donner ", "", 10)
                                    if quantityad == nil or quantityad == "" then
                                        ESX.ShowNotification("Veuillez rentrer une valeur valide")
                                    else 
                                        quantityad = tonumber(quantityad)
                                        if closestDistance ~= -1 and closestDistance <= 3 then 
                                            PlayAnim("mp_common", "givetake1_a")
                                            TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(closestPlayer), 'item_money', 'money', quantityad)
                                        else
                                            ESX.ShowNotification("Aucune personne à proximité")
                                        end
                                    end
                                elseif Index == 2 then  
                                    local quantityaj = KeyboardInput("Montant d'argent que vous souhaitez jeter ", "", 10)
                                    if quantityaj == nil or quantityaj == "" then
                                        ESX.ShowNotification("Veuillez rentrer une valeur valide")
                                    else 
                                        quantityaj = tonumber(quantityaj)
                                        TriggerServerEvent('esx:removeInventoryItem', 'item_money', 'money', quantityaj)
                                    end                             
                                end               
                            end
                        })
                        RageUI.List("Argent Sale : ~r~"..ESX.Math.GroupDigits(ESX.PlayerData.accounts[2].money).."$", {"Donner", "Jeter"}, List.pfas, nil, {}, true, {
                            onListChange = function(Index)
                                List.pfas = Index
                            end,
                            onSelected = function(Index)             
                                if Index == 1 then
                                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                    local quantityasd = KeyboardInput("Montant d'argent sale que vous souhaitez donner ", "", 10)
                                    if quantityasd == nil or quantityasd == "" then
                                        ESX.ShowNotification("Veuillez rentrer une valeur valide")
                                    else
                                        quantityasd = tonumber(quantityasd)
                                        if closestDistance ~= -1 and closestDistance <= 3 then 
                                            PlayAnim("mp_common", "givetake1_a")
                                            TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(closestPlayer), 'item_account', 'black_money', quantityasd)
                                        else
                                            ESX.ShowNotification("Aucune personne à proximité")
                                        end
                                    end 
                                elseif Index == 2 then
                                    local quantityasj = KeyboardInput("Montant d'argent sale que vous souhaitez jeter ", "", 10)
                                    if quantityasj == nil or quantityasj == "" then
                                        ESX.ShowNotification("Veuillez rentrer une valeur valide")
                                    else
                                        quantityasj = tonumber(quantityasj)       
                                        TriggerServerEvent('esx:removeInventoryItem', 'item_account', 'black_money', quantityasj)     
                                    end                    
                                end               
                            end
                        })
                        RageUI.Button("Banque : ~b~"..ESX.Math.GroupDigits(ESX.PlayerData.accounts[1].money).."$", nil, {RightLabel = ""}, true, {})
                    else
                        for i = 1, #ESX.PlayerData.accounts, 1 do
                            if ESX.PlayerData.accounts[i].name == 'money' then
                                RageUI.List("Argent : ~g~"..ESX.Math.GroupDigits(ESX.PlayerData.accounts[i].money).."$", {"Donner", "Jeter"}, List.pfa, nil, {}, true, {
                                    onListChange = function(Index)
                                        List.pfa = Index
                                    end,
                                    onSelected = function(Index)             
                                        if Index == 1 then
                                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                            local quantityad = KeyboardInput("Montant d'argent que vous souhaitez donner ", "", 10)
                                            if quantityad == nil or quantityad == "" then
                                                ESX.ShowNotification("Veuillez rentrer une valeur valide")
                                            else 
                                                quantityad = tonumber(quantityad)
                                                if closestDistance ~= -1 and closestDistance <= 3 then 
                                                    PlayAnim("mp_common", "givetake1_a")
                                                    TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(closestPlayer), 'item_account', 'money', quantityad)
                                                else
                                                    ESX.ShowNotification("Aucune personne à proximité")
                                                end
                                            end
                                        elseif Index == 2 then  
                                            local quantityaj = KeyboardInput("Montant d'argent que vous souhaitez jeter ", "", 10)
                                            if quantityaj == nil or quantityaj == "" then
                                                ESX.ShowNotification("Veuillez rentrer une valeur valide")
                                            else 
                                                quantityaj = tonumber(quantityaj)
                                                TriggerServerEvent('esx:removeInventoryItem', 'item_account', 'money', quantityaj)
                                            end                             
                                        end               
                                    end
                                })
                            end
                            if ESX.PlayerData.accounts[i].name == 'black_money' then
                                RageUI.List("Argent Sale : ~r~"..ESX.Math.GroupDigits(ESX.PlayerData.accounts[i].money).."$", {"Donner", "Jeter"}, List.pfas, nil, {}, true, {
                                    onListChange = function(Index)
                                        List.pfas = Index
                                    end,
                                    onSelected = function(Index)             
                                        if Index == 1 then
                                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                            local quantityasd = KeyboardInput("Montant d'argent sale que vous souhaitez donner ", "", 10)
                                            if quantityasd == nil or quantityasd == "" then
                                                ESX.ShowNotification("Veuillez rentrer une valeur valide")
                                            else
                                                quantityasd = tonumber(quantityasd)
                                                if closestDistance ~= -1 and closestDistance <= 3 then 
                                                    PlayAnim("mp_common", "givetake1_a")
                                                    TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(closestPlayer), 'item_account', 'black_money', quantityasd)
                                                else
                                                    ESX.ShowNotification("Aucune personne à proximité")
                                                end
                                            end 
                                        elseif Index == 2 then
                                            local quantityasj = KeyboardInput("Montant d'argent sale que vous souhaitez jeter ", "", 10)
                                            if quantityasj == nil or quantityasj == "" then
                                                ESX.ShowNotification("Veuillez rentrer une valeur valide")
                                            else
                                                quantityasj = tonumber(quantityasj)       
                                                TriggerServerEvent('esx:removeInventoryItem', 'item_account', 'black_money', quantityasj)     
                                            end                    
                                        end               
                                    end
                                })
                            end
                            if ESX.PlayerData.accounts[i].name == 'bank' then
                                RageUI.Button("Banque : ~b~"..ESX.Math.GroupDigits(ESX.PlayerData.accounts[i].money).."$", nil, {RightLabel = ""}, true, {})
                            end
                        end
                    end
                    RageUI.List("Carte d\'identité", {"Regarder", "Montrer"}, List.ci, nil, {}, true, {
                        onListChange = function(Index)
                            List.ci = Index
                        end,
                        onSelected = function(Index)            
                            if Index == 1 then
                                TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
                            elseif Index == 2 then
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                if closestDistance ~= -1 and closestDistance <= 3.0 then
                                    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer))
                                else
                                    ESX.ShowNotification("Aucune personne à proximité")
                                end
                            end               
                        end
                    })
                    RageUI.List("Permis de conduire", {"Regarder", "Montrer"}, List.pc, nil, {}, true, {
                        onListChange = function(Index)
                            List.pc = Index
                        end,
                        onSelected = function(Index)            
                            if Index == 1 then
                                TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
                            elseif Index == 2 then
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                if closestDistance ~= -1 and closestDistance <= 3.0 then
                                    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer), 'driver')
                                else
                                    ESX.ShowNotification("Aucune personne à proximité")
                                end
                            end               
                        end
                    })
                    RageUI.List("Permis de port d'arme", {"Regarder", "Montrer"}, List.ppa, nil, {}, true, {
                        onListChange = function(Index)
                            List.ppa = Index
                        end,
                        onSelected = function(Index)            
                            if Index == 1 then
                                TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
                            elseif Index == 2 then
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                if closestDistance ~= -1 and closestDistance <= 3.0 then
                                    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer), 'weapon')
                                else
                                    ESX.ShowNotification("Aucune personne à proximité")
                                end
                            end               
                        end
                    })
                end)
                RageUI.IsVisible(subMenu3, function()
                    RageUI.Button("Informations Véhicules", nil, {RightLabel = "→"}, true, {}, mainMenu2)
                    RageUI.Checkbox("Éteindre le moteur", nil, moteur, {}, {
                        onChecked = function()
                            moteur = true
                            if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then
                                toggleEngine = not toggleEngine
                                GoEngine()
                            end
                        end,
                        onUnChecked = function()
                            moteur = false
                            if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then
                                toggleEngine = not toggleEngine
                                GoEngine()
                            end
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
                    RageUI.List("Ouvrir/Fermer Porte", {"Avant Gauche", "Avant Droite","Arrière Gauche","Arrière Droite"}, List.porte, nil, {}, true, {
                        onListChange = function(list) List.porte = list end,
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
                    RageUI.List("Ouvrir/Fermer Fenêtre", {"Avant Gauche", "Avant Droite","Arrière Gauche","Arrière Droite"}, List.window, nil, {}, true, {
                        onListChange = function(list) List.window = list end,
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
                    RageUI.List("Limitateur", {"Par Défaut","30","50","80","120","Personnalisé"}, List.limiteur, nil, {}, true, {
                        onListChange = function(list) List.limiteur = list end,
                        onSelected = function(list)
                            if list == 1 then
                                SetVehicleMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 0.0)
                            elseif list == 2 then
                                SetVehicleMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 8.1)
                            elseif list == 3 then
                                SetVehicleMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 13.7)
                            elseif list == 4 then
                                SetVehicleMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 22.0)
                            elseif list == 5 then
                                SetVehicleMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 33.2)
                            elseif list == 6 then
                                local perso = KeyboardInput("Choisissez votre vitesse :", "", 3)
                                if perso == nil then
                                    ESX.ShowNotification("Vitesse Invalide")
                                else
                                    SetVehicleMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), perso / 3.701)
                                end
                            end
                        end
                    })
                end)
                RageUI.IsVisible(subMenu4, function()
                    RageUI.List("Filtre :", {"Aucun", "Entreprise", "Organisation"}, List.filter2, nil, {}, true, {
                        onListChange = function(Index)
                            List.filter2 = Index
                            fIndex2 = Index
                        end
                    })
                    if fIndex2 == 2 or fIndex2 == 1 then
                        if ESX.PlayerData.job.grade_name == 'boss' then
                            RageUI.Separator("↓ Entreprise ↓") 
                            RageUI.Button("Coffre d'Entreprise :", nil, {RightLabel = "~g~"..societymoney.."$"}, true, {}) 
                            RageUI.Button("Recruter", nil, {RightLabel = "→"}, true, {
                                onSelected = function() 
                                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                    if closestDistance ~= -1 and closestDistance <= 3 then 
                                        TriggerServerEvent("pF5:recruter", GetPlayerServerId(closestPlayer), ESX.PlayerData.job.name, 0)
                                    else
                                        ESX.ShowNotification("Aucune personne à proximité")
                                    end
                                end
                            })
                            RageUI.Button("Virer", nil, {RightLabel = "→"}, true, {
                                onSelected = function()
                                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                    if closestDistance ~= -1 and closestDistance <= 3 then 
                                        TriggerServerEvent("pF5:virer", GetPlayerServerId(closestPlayer))
                                    else
                                        ESX.ShowNotification("Aucune personne à proximité")
                                    end
                                end
                            })
                            RageUI.Button("Promouvoir", nil, {RightLabel = "→"}, true, {
                                onSelected = function() 
                                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                    if closestDistance ~= -1 and closestDistance <= 3 then 
                                        TriggerServerEvent("pF5:promouvoir", GetPlayerServerId(closestPlayer))
                                    else
                                        ESX.ShowNotification("Aucune personne à proximité")
                                    end
                                end
                            })
                            RageUI.Button("Destituer", nil, {RightLabel = "→"}, true, {
                                onSelected = function() 
                                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                    if closestDistance ~= -1 and closestDistance <= 3 then 
                                        TriggerServerEvent("pF5:destituer", GetPlayerServerId(closestPlayer))
                                    else
                                        ESX.ShowNotification("Aucune personne à proximité")
                                    end
                                end
                            })
                        else
                            RageUI.Separator("Recherche d'Entreprise...")
                        end
                    end                   
                    if fIndex2 == 3 or fIndex2 == 1 then
                        RageUI.Separator("↓ Organisation ↓") 
                        if ESX.PlayerData.job2.grade_name == 'boss' then
                            RageUI.Button("Coffre d'Organisation :", nil, {RightLabel = "~g~"..societymoney2.."$"}, true, {}) 
                            RageUI.Button("Recruter", nil, {RightLabel = "→"}, true, {
                                onSelected = function() 
                                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                    if closestDistance ~= -1 and closestDistance <= 3 then 
                                        TriggerServerEvent("pF5:recruter2", GetPlayerServerId(closestPlayer), ESX.PlayerData.job2.name, 0)
                                    else
                                        ESX.ShowNotification("Aucune personne à proximité")
                                    end
                                end
                            })
                            RageUI.Button("Virer", nil, {RightLabel = "→"}, true, {
                                onSelected = function() 
                                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                    if closestDistance ~= -1 and closestDistance <= 3 then 
                                        TriggerServerEvent("pF5:virer2", GetPlayerServerId(closestPlayer))
                                    else
                                        ESX.ShowNotification("Aucune personne à proximité")
                                    end
                                end
                            })
                            RageUI.Button("Promouvoir", nil, {RightLabel = "→"}, true, {
                                onSelected = function() 
                                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                    if closestDistance ~= -1 and closestDistance <= 3 then 
                                        TriggerServerEvent("pF5:promouvoir2", GetPlayerServerId(closestPlayer))
                                    else
                                        ESX.ShowNotification("Aucune personne à proximité")
                                    end
                                end
                            })
                            RageUI.Button("Destituer", nil, {RightLabel = "→"}, true, {
                                onSelected = function() 
                                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                    if closestDistance ~= -1 and closestDistance <= 3 then 
                                        TriggerServerEvent("pF5:destituer2", GetPlayerServerId(closestPlayer))
                                    else
                                        ESX.ShowNotification("Aucune personne à proximité")
                                    end
                                end
                            })
                        else
                            RageUI.Separator("Recherche d'Organisation...")
                        end
                    end
                end)
                RageUI.IsVisible(subMenu5, function()
                    RageUI.List("Filtre :", {"Aucun", "Vêtements", "Accessoires"}, List.filter3, nil, {}, true, {
                        onListChange = function(Index)
                            List.filter3 = Index
                            fIndex3 = Index
                        end
                    })
                    RageUI.Button("Enlever/Mettre tous les Vêtements", nil, {RightLabel = "→"}, true, {
                        onSelected = function() 
                            DrawAnim()
                            Wait(5000)
                            ClearPedTasks(GetPlayerPed(-1))
                            removeallclothes()                       
                        end
                    })
                    if fIndex3 == 2 or fIndex3 == 1 then
                        RageUI.Separator("↓ Vêtements ↓")
                        RageUI.Button("Haut", nil, {RightBadge = RageUI.BadgeStyle.Clothes}, true, {
                            onSelected = function() 
                                TriggerEvent('pF5:actionhaut') 
                            end
                        })
                        RageUI.Button("Bas", nil, {RightBadge = RageUI.BadgeStyle.Clothes}, true, {
                            onSelected = function() 
                                TriggerEvent('pF5:actionpantalon') 
                            end
                        })
                        RageUI.Button("Chaussure", nil, {RightBadge = RageUI.BadgeStyle.Clothes}, true, {
                            onSelected = function() 
                                TriggerEvent('pF5:actionchaussure')
                            end
                        })
                        RageUI.Button("Sac", nil, {RightBadge = RageUI.BadgeStyle.Clothes}, true, {
                            onSelected = function() 
                                TriggerEvent('pF5:actionsac')
                            end
                        })
                        RageUI.Button("Gilet par balle", nil, {RightBadge = RageUI.BadgeStyle.Clothes}, true, {
                            onSelected = function() 
                                TriggerEvent('pF5:actiongiletparballe')
                            end
                        })
                    end
                    if fIndex3 == 3 or fIndex3 == 1 then
                        RageUI.Separator("↓ Accessoires ↓")
                        RageUI.Button("Lunette", nil, {RightBadge = RageUI.BadgeStyle.Mask}, true, {
                            onSelected = function() 
                                TriggerEvent('pF5:actionglasses')    
                            end
                        })
                        RageUI.Button("Boucle d'Oreille", nil, {RightBadge = RageUI.BadgeStyle.Mask}, true, {
                            onSelected = function() 
                                TriggerEvent('pF5:actionears') 
                            end
                        })
                        RageUI.Button("Casque", nil, {RightBadge = RageUI.BadgeStyle.Mask}, true, {
                            onSelected = function() 
                                TriggerEvent('pF5:actionhelmet') 
                            end
                        })
                        RageUI.Button("Chaine", nil, {RightBadge = RageUI.BadgeStyle.Mask}, true, {
                            onSelected = function() 
                                TriggerEvent('pF5:actionchain') 
                            end
                        })
                        RageUI.Button("Masque", nil, {RightBadge = RageUI.BadgeStyle.Mask}, true, {
                            onSelected = function() 
                                TriggerEvent('pF5:actionmask') 
                            end
                        })
                    end
                end)
                RageUI.IsVisible(subMenu6, function()
                    ESX.TriggerServerCallback('pF5:billing', function(bills) 
                        Fct.bill = bills 
                    end)
                    if #Fct.bill == 0 then
                        RageUI.Separator("Vous n'avez aucune facture")
                    end
                    for i = 1, #Fct.bill, 1 do
                        RageUI.Button(Fct.bill[i].label, nil, {RightLabel = '$' .. ESX.Math.GroupDigits(Fct.bill[i].amount)}, true, {
                            onSelected = function()
                                ESX.TriggerServerCallback('esx_billing:payBill', function()
                                    ESX.TriggerServerCallback('pF5:billing', function(bills) Fct.bill = bills end)
                                end, Fct.bill[i].id)
                            end
                        })
                    end
                end)
                RageUI.IsVisible(subMenu7, function()
                    if pF5.Active.PubJob then
                        for _,v in pairs(pF5.JobAuthorized) do
                            if v == ESX.PlayerData.job.name then
                                RageUI.Button("Faire une publicité pour le job : "..ESX.PlayerData.job.label, nil, {RightLabel = "→"}, true, {
                                    onSelected = function()
                                        local pub = KeyboardInput("Publicité Personnalisée", "", 99)
                                        if pub == nil or pub == "" then
                                            ESX.ShowNotification("Publicité annulée")
                                        else
                                            job = ESX.PlayerData.job.label
                                            TriggerServerEvent("pub:perso", pub, job)
                                        end
                                    end
                                }) 
                            end
                        end
                    end
                    if pF5.Active.PubTwitter then
                        RageUI.Button("Faire une publicité Twitter", nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                local twitter = KeyboardInput("Publicité Personnalisée", "", 99)
                                if twitter == nil or twitter == "" then
                                    ESX.ShowNotification("Publicité annulée")
                                else
                                    TriggerServerEvent("pub:twitter", twitter)
                                end
                            end
                        })   
                    end
                    if pF5.Active.PubTwitterAno then
                        RageUI.Button("Faire une publicité Twitter Anonyme", nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                local twitterano = KeyboardInput("Publicité Personnalisée", "", 99)
                                if twitterano == nil or twitterano == "" then
                                    ESX.ShowNotification("Publicité annulée")
                                else
                                    TriggerServerEvent("pub:ano", twitterano)
                                end
                            end
                        })  
                    end                  
                end)
                RageUI.IsVisible(subMenu8, function()
                    if pF5.Active.VehicleCall then
                        RageUI.Button("Appeler un véhicule", nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                Load_Key()
                            end
                        }, subMenu10)
                    end
                    if pF5.Active.WeaponAnimation then
                        RageUI.Button("Animation d'Armes", nil, {RightLabel = "→"}, true, {}, subMenu11)
                    end
                    if pF5.Active.VisualEffect then
                        RageUI.List("Effet Visuel", {"Normal", "Couleurs Amplifiées", "Vue & Lumières Amplifiées", "Noir & Blanc"}, List.ev, nil, {}, true, {
                            onListChange = function(Index)
                                List.ev = Index
                            end,
                            onSelected = function(Index)            
                                if Index == 1 then
                                    SetTimecycleModifier('')
                                elseif Index == 2 then
                                    SetTimecycleModifier('rply_saturation')
                                elseif Index == 3 then
                                    SetTimecycleModifier('tunnel')
                                elseif Index == 4 then
                                    SetTimecycleModifier('rply_saturation_neg')
                                end               
                            end
                        })
                    end
                    if pF5.Active.Cinematique then
                        RageUI.Checkbox("Cinématique", nil, cinema, {}, {
                            onChecked = function()
                                cinema = true
                                SendNUIMessage({openCinema = true})
                                TriggerEvent('es:setMoneyDisplay', 0.0)
                                TriggerEvent('esx_status:setDisplay', 0.0)
                                DisplayRadar(false)
                                TriggerEvent('ui:toggle', false)
                            end,
                            onUnChecked = function()
                                cinema = false
                                SendNUIMessage({openCinema = false})
                                TriggerEvent('es:setMoneyDisplay', 1.0)
                                TriggerEvent('esx_status:setDisplay', 1.0)
                                DisplayRadar(true)
                                TriggerEvent('ui:toggle', true)
                            end
                        })
                    end
                    if pF5.Active.ButtonRagdoll then
                        RageUI.Checkbox("Dormir / Se Réveiller", nil, _isInRagdoll, {}, {
                            onChecked = function()
                                _isInRagdoll = true
                                GoRagdoll()
                            end,
                            onUnChecked = function()
                                _isInRagdoll = false
                                GoRagdoll()
                            end
                        })
                    end
                    if pF5.Active.ButtonPorter then
                        RageUI.Button("Porter la personne", nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                ExecuteCommand("porter")
                            end
                        })
                    end
                    if pF5.Active.ButtonCarry then
                        RageUI.Button("Carry la personne", nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                ExecuteCommand("carry")
                            end
                        })
                    end
                    if pF5.Active.ButtonOtage then
                        RageUI.Button("Prendre en otage la personne", nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                ExecuteCommand("otage")
                            end
                        })
                    end
                end)
                RageUI.IsVisible(mainMenu3, function()
					RageUI.Button("Suppression", nil, {RightBadge = RageUI.BadgeStyle.Alert}, true, {}, SsubMenu)
					RageUI.Button("Civil", nil, {RightLabel = "→"}, true, {}, PsubMenu)
                    RageUI.Button("LSPD", nil, {RightLabel = "→"}, true, {}, PsubMenu2) 
					RageUI.Button("EMS", nil, {RightLabel = "→"}, true, {}, PsubMenu3)
					RageUI.Button("Mecano", nil, {RightLabel = "→"}, true, {}, PsubMenu4)
					RageUI.Button("Gang", nil, {RightLabel = "→"}, true, {}, PsubMenu5)
					RageUI.Button("Drogue", nil, {RightLabel = "→"}, true, {}, PsubMenu6)
					RageUI.Button("Armes", nil, {RightLabel = "→"}, true, {}, PsubMenu7)
                end)
				RageUI.IsVisible(SsubMenu, function()
					if #object > 0 then 
                        for k,v in pairs(object) do
                            local coord = GetEntityCoords(PlayerPedId())
                            local entity = NetworkGetEntityFromNetworkId(v.id)
                            local ObjCoords = GetEntityCoords(entity)
                            local dist = Vdist2(coord.x,coord.y,coord.z,ObjCoords.x, ObjCoords.y, ObjCoords.z)          
                            if GoodName(GetEntityModel(NetworkGetEntityFromNetworkId(v.id))) == 0 then table.remove(object, k) end                 
                            RageUI.Button("~b~["..k.."] ~s~"..v.name.."", nil, {RightLabel = "Distance : "..math.floor(dist)}, true, {
                                onActive = function()
                                    DrawMarker(20, ObjCoords.x, ObjCoords.y, ObjCoords.z+1.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, 0.2, 0.2, 0.2, 0, 0, 200, 170, 1, 0, 2, 1, nil, nil, 0)
                                end,
                                onSelected = function() 
                                    RemoveObj(v.id, k)
                                end
                            })
                        end
                    end
				end)  
				RageUI.IsVisible(PsubMenu, function()
					for k,v in pairs(pF5.Civil) do
						RageUI.Button(""..v.name.."", "Appuyez sur [~b~E~s~] pour placer l'~b~Objet", {RightLabel = "→"}, true, {
							onSelected = function() 
								SpawnObj(v.model, v.name)
							end
						})
					end
				end)
				RageUI.IsVisible(PsubMenu2, function()
					for k,v in pairs(pF5.LSPD) do
						RageUI.Button(""..v.name.."", "Appuyez sur [~b~E~s~] pour placer l'~b~Objet", {RightLabel = "→"}, true, {
							onSelected = function() 
								SpawnObj(v.model, v.name)
							end
						})
					end
				end)
				RageUI.IsVisible(PsubMenu3, function()
					for k,v in pairs(pF5.EMS) do
						RageUI.Button(""..v.name.."", "Appuyez sur [~b~E~s~] pour placer l'~b~Objet", {RightLabel = "→"}, true, {
							onSelected = function() 
								SpawnObj(v.model, v.name)
							end
						})
					end
				end)
				RageUI.IsVisible(PsubMenu4, function()
					for k,v in pairs(pF5.Mecano) do
						RageUI.Button(""..v.name.."", "Appuyez sur [~b~E~s~] pour placer l'~b~Objet", {RightLabel = "→"}, true, {
							onSelected = function() 
								SpawnObj(v.model, v.name)
							end
						})
					end
				end)
				RageUI.IsVisible(PsubMenu5, function()
					for k,v in pairs(pF5.Gang) do
						RageUI.Button(""..v.name.."", "Appuyez sur [~b~E~s~] pour placer l'~b~Objet", {RightLabel = "→"}, true, {
							onSelected = function() 
								SpawnObj(v.model, v.name)
							end
						})
					end
				end)
				RageUI.IsVisible(PsubMenu7, function()
					for k,v in pairs(pF5.Armes) do
						RageUI.Button(""..v.name.."", "Appuyez sur [~b~E~s~] pour placer l'~b~Objet", {RightLabel = "→"}, true, {
							onSelected = function() 
								SpawnObj(v.model, v.name)
							end
						})
					end
				end)
				RageUI.IsVisible(PsubMenu6, function()
					for k,v in pairs(pF5.Drogue) do
						RageUI.Button(""..v.name.."", "Appuyez sur [~b~E~s~] pour placer l'~b~Objet", {RightLabel = "→"}, true, {
							onSelected = function() 
								SpawnObj(v.model, v.name)
							end
						})
					end
				end)
                RageUI.IsVisible(mainMenu2, function()
                    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                    local vehe = GetVehicleEngineHealth(veh) / 10
                    local vehf = GetVehicleFuelLevel(veh)
                    local vehp = GetVehicleEngineTemperature(veh)
                    local veht = GetVehicleClass(veh)
                    local vehn = GetVehicleDoorLockStatus(veh)
                    if vehe == 10 then                      
                        RageUI.Button("État du véhicule :", nil, {RightLabel = "0 %"}, true, {})
                    else
                        RageUI.Button("État du véhicule :", nil, {RightLabel = math.ceil(vehe).."%"}, true, {})
                    end
                    RageUI.Button("Niveau d'essence :", nil, {RightLabel = math.ceil(vehf).."%"}, true, {})
                    RageUI.Button("Température du moteur :", nil, {RightLabel = math.ceil(vehp).."°C"}, true, {})
                    for k, v in pairs(Config.list) do
                        if veht == v.class then
                            RageUI.Button("Type du véhicule :", nil, {RightLabel = v.name}, true, {})
                        end
                    end
                    if vehn == 1 then
                        RageUI.Button("Status du véhicule :", nil, {RightLabel = "~g~Ouvert"}, true, {})
                    else
                        RageUI.Button("Status du véhicule :", nil, {RightLabel = "~r~Fermé"}, true, {})
                    end   
                end)
                RageUI.IsVisible(subMenu9, function()
                    if #data_key == 0 then
                        RageUI.Separator("Vous n'avez aucune clé")
                    end
                    for i = 1, #data_key, 1 do
                        RageUI.List(GetLabelText(GetDisplayNameFromVehicleModel(data_key[i].vehicle.model)).." - [~o~"..data_key[i].plate.."~s~]", {"Donner", "Supprimer"}, List.key, nil, {}, true, {
                            onListChange = function(Index)
                                List.key = Index                          
                            end,
                            onSelected = function()
                                if List.key == 1 then
                                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                    local closestPed = GetPlayerPed(closestPlayer)
                                    if IsPedSittingInAnyVehicle(closestPed) then
                                        ESX.ShowNotification('~r~Vous ne pouvez pas donner quelque chose à quelqu\'un dans un véhicule')
                                        return
                                    end
                                    if closestPlayer ~= -1 and closestDistance < 3.0 then
                                        PlayAnim("mp_common", "givetake1_a")
                                        TriggerServerEvent('pF5:GiveKey', GetPlayerServerId(closestPlayer), data_key[i].plate, GetLabelText(GetDisplayNameFromVehicleModel(data_key[i].vehicle.model)))
                                        Wait(100)
                                        Load_Key()
                                    else
                                        ESX.ShowNotification("Personne à proximité")
                                    end
                                elseif List.key == 2 then
                                    TriggerServerEvent('pF5:DeleteKey', data_key[i].plate, GetLabelText(GetDisplayNameFromVehicleModel(data_key[i].vehicle.model)))
                                    Wait(100)
                                    Load_Key()
                                end
                            end
                        })
                    end
                end)
                RageUI.IsVisible(subMenu10, function()
                    if #data_key == 0 then
                        RageUI.Separator("Vous n'avez aucun véhicule")
                    end
                    for i = 1, #data_key, 1 do
                        if data_key[i].stored == true then
                            RageUI.Button(GetLabelText(GetDisplayNameFromVehicleModel(data_key[i].vehicle.model)).." - [~o~"..data_key[i].vehicle.plate.."~s~]", nil, {RightLabel = "[~g~"..pF5.VehicleCallPrice.."$~s~]"}, true, {
                                onSelected = function()
                                    ESX.TriggerServerCallback('pF5:getMoney', function(getMoney)
                                        if getMoney then
                                            TriggerServerEvent('pF5:result', data_key[i].plate)
                                            local player = PlayerPedId()
                                            local playerPos = GetEntityCoords(player)                                    
                                            local driverhash = 1841036427                                                                              
                                            while not HasModelLoaded(driverhash) and RequestModel(driverhash) or not HasModelLoaded(data_key[i].vehicle.model) and RequestModel(data_key[i].vehicle.model) do
                                                RequestModel(driverhash)
                                                RequestModel(data_key[i].vehicle.model)
                                                Citizen.Wait(0)
                                            end
                                            local found, spawnPos, spawnHeading = GetClosestVehicleNodeWithHeading(playerPos.x + math.random(-100, 100), playerPos.y + math.random(-100, 100), playerPos.z, 0, 3, 0)
                                            ESX.Game.SpawnVehicle(data_key[i].vehicle.model, spawnPos, spawnHeading, function(callback_vehicle)
                                                ESX.Game.SetVehicleProperties(callback_vehicle, data_key[i].vehicle)
                                                local mechPos = GetEntityCoords(callback_vehicle)
                                                SetVehicleHasBeenOwnedByPlayer(callback_vehicle, true)
                                                SetEntityAsMissionEntity(callback_vehicle, true, true)
                                                ClearAreaOfVehicles(GetEntityCoords(callback_vehicle), 5000, false, false, false, false, false);  
                                                SetVehicleOnGroundProperly(callback_vehicle)
                                                mechPed = CreatePedInsideVehicle(callback_vehicle, 26, driverhash, -1, true, false)           	
                                                mechBlip = AddBlipForEntity(callback_vehicle)                                                        
                                                SetBlipFlashes(mechBlip, true)  
                                                SetBlipColour(mechBlip, 5)
                                                GoToTarget(playerPos.x, playerPos.y, playerPos.z, callback_vehicle, mechPed, GetPlayerPed(-1))
                                            end)
                                            ESX.ShowNotification("Vous allez recevoir votre véhicule pour ~g~"..pF5.VehicleCallPrice.."$")
                                            Wait(100)
                                            Load_Key()
                                        else
                                            ESX.ShowNotification("Vous n'avez pas assez d'argent")
                                        end
                                    end)
                                end
                            })
                        else
                            RageUI.Button(GetLabelText(GetDisplayNameFromVehicleModel(data_key[i].vehicle.model)).." - [~o~"..data_key[i].plate.."~s~]", "Véhicule hors du garage donc non disponible", {RightLabel = "[~g~"..pF5.VehicleCallPrice.."$~s~]"}, false, {})
                        end
                    end
                end)
                RageUI.IsVisible(subMenu11, function()
                    RageUI.Button("Animation de visée", nil, {RightLabel = "→"}, true, {}, subMenu12)
                    RageUI.Button("Animation de sortie", nil, {RightLabel = "→"}, true, {}, subMenu13)
                end)
                RageUI.IsVisible(subMenu12, function()
                    RageUI.Button("Par Défaut", nil, {RightLabel = "→"}, true, {
                        onActive = function()
                            RenderSprite("weapon_animation", "Aim-Default", pF5.MenuX, 258+36, 431, 200, 100)
                        end,
                        onSelected = function()
                            if aimanim then
                                GangsterAS()
                            end
                            if aimanim2 then
                                HillbillyAS()
                            end
                        end
                    })
                    RageUI.Button("Gangster", nil, {RightLabel = "→"}, true, {
                        onActive = function()
                            RenderSprite("weapon_animation", "Aim-Gangster", pF5.MenuX, 258+36, 431, 200, 100)
                        end,
                        onSelected = function()
                            if aimanim2 then
                                HillbillyAS()
                            end
                            GangsterAS()
                        end
                    })
                    RageUI.Button("Western", nil, {RightLabel = "→"}, true, {
                        onActive = function()
                            RenderSprite("weapon_animation", "Aim-HillBilly", pF5.MenuX, 258+36, 431, 200, 100)
                        end,
                        onSelected = function()
                            if aimanim then
                                GangsterAS()
                            end
                            HillbillyAS()
                        end
                    })
                    RageUI.Line()
                end)
                RageUI.IsVisible(subMenu13, function()
                    RageUI.Button("Par Défaut", nil, {RightLabel = "→"}, true, {
                        onActive = function()
                            RenderSprite("weapon_animation", "Holster-Default", pF5.MenuX, 372+36, 431, 200, 100)
                        end,
                        onSelected = function()
                            if holsteranim then
                                SideHolsterAnimation()
                            end
                            if holsteranim2 then
                                BackHolsterAnimation()
                            end
                            if holsteranim3 then
                                FrontHolsterAnimation()
                            end
                            if holsteranim4 then
                                AgressiveFrontHolsterAnimation()
                            end
                            if holsteranim5 then
                                SideLegHolsterAnimation()
                            end
                        end
                    })
                    RageUI.Button("Harnais", nil, {RightLabel = "→"}, true, {
                        onActive = function()
                            RenderSprite("weapon_animation", "Holster-Cop", pF5.MenuX, 372+36, 431, 200, 100)
                        end,
                        onSelected = function()
                            if holsteranim2 then
                                BackHolsterAnimation()
                            end
                            if holsteranim3 then
                                FrontHolsterAnimation()
                            end
                            if holsteranim4 then
                                AgressiveFrontHolsterAnimation()
                            end
                            if holsteranim5 then
                                SideLegHolsterAnimation()
                            end
                            SideHolsterAnimation()
                        end
                    })
                    RageUI.Button("Dos", nil, {RightLabel = "→"}, true, {
                        onActive = function()
                            RenderSprite("weapon_animation", "Holster-Back", pF5.MenuX, 372+36, 431, 200, 100)
                        end,
                        onSelected = function()
                            if holsteranim then
                                SideHolsterAnimation()
                            end
                            if holsteranim3 then
                                FrontHolsterAnimation()
                            end
                            if holsteranim4 then
                                AgressiveFrontHolsterAnimation()
                            end
                            if holsteranim5 then
                                SideLegHolsterAnimation()
                            end
                            BackHolsterAnimation()
                        end
                    })
                    RageUI.Button("Poche Avant", nil, {RightLabel = "→"}, true, {
                        onActive = function()
                            RenderSprite("weapon_animation", "Holster-Front", pF5.MenuX, 372+36, 431, 200, 100)
                        end,
                        onSelected = function()
                            if holsteranim then
                                SideHolsterAnimation()
                            end
                            if holsteranim2 then
                                BackHolsterAnimation()
                            end
                            if holsteranim4 then
                                AgressiveFrontHolsterAnimation()
                            end
                            if holsteranim5 then
                                SideLegHolsterAnimation()
                            end
                            FrontHolsterAnimation()
                        end
                    })
                    RageUI.Button("Poche Avant (aggressif)", nil, {RightLabel = "→"}, true, {
                        onActive = function()
                            RenderSprite("weapon_animation", "Holster-FrontAgressive", pF5.MenuX, 372+36, 431, 200, 100)
                        end,
                        onSelected = function()
                            if holsteranim then
                                SideHolsterAnimation()
                            end
                            if holsteranim2 then
                                BackHolsterAnimation()
                            end
                            if holsteranim3 then
                                FrontHolsterAnimation()
                            end
                            if holsteranim5 then
                                SideLegHolsterAnimation()
                            end
                            AgressiveFrontHolsterAnimation()
                        end
                    })
                    RageUI.Button("Jambe", nil, {RightLabel = "→"}, true, {
                        onActive = function()
                            RenderSprite("weapon_animation", "Holster-Leg", pF5.MenuX, 372+36, 431, 200, 100)
                        end,
                        onSelected = function()
                            if holsteranim then
                                SideHolsterAnimation()
                            end
                            if holsteranim2 then
                                BackHolsterAnimation()
                            end
                            if holsteranim3 then
                                FrontHolsterAnimation()
                            end
                            if holsteranim4 then
                                AgressiveFrontHolsterAnimation()
                            end
                            SideLegHolsterAnimation()
                        end
                    })
                    RageUI.Line()
                end)
                RageUI.IsVisible(subMenu14, function()
                    if #result == 0 then
                        RageUI.Separator("Vous n'avez aucun vêtements / accessoires")
                    else
                        RageUI.List("Filtre :", theItem, theIndex, nil, {}, true, {
                            onListChange = function(Index)
                                theIndex = Index
                            end
                        })
                        RageUI.Line()
                    end
                    for i = 1, #result, 1 do
                        if theItem[theIndex] == result[i].type or theItem[theIndex] == "Aucun" then
                            RageUI.List(result[i].label, {"Mettre", "Enlever", "Renommer", "Donner", "Jeter"}, iIndex, nil, {}, true, {
                                onListChange = function(Index)
                                    iIndex = Index
                                end,
                                onSelected = function(Index)
                                    k = json.decode(result[i].item)
                                    ped = GetPlayerPed(-1)
                                    if Index == 1 then
                                        if result[i].type == "Masque" then   
                                            if ped then
                                                RequestAnimDict('missfbi4')            
                                                while not HasAnimDictLoaded('missfbi4') do
                                                    Citizen.Wait(0)
                                                end           
                                                TaskPlayAnim(PlayerPedId(), 'missfbi4', 'takeoff_mask', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                TriggerEvent("skinchanger:change", "mask_1", k.item_1-1)
                                                TriggerEvent("skinchanger:change", "mask_2", k.item_2-1)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end
                                        elseif result[i].type == "Lunette" then            
                                            if ped then
                                                RequestAnimDict('clothingspecs')           
                                                while not HasAnimDictLoaded('clothingspecs') do
                                                    Citizen.Wait(0)
                                                end         
                                                TaskPlayAnim(PlayerPedId(), 'clothingspecs', 'try_glasses_positive_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                TriggerEvent("skinchanger:change", "glasses_1", k.item_1-1)
                                                TriggerEvent("skinchanger:change", "glasses_2", k.item_2-1)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end
                                        elseif result[i].type == "Sac" then            
                                            if ped then
                                                RequestAnimDict('clothingtie')           
                                                while not HasAnimDictLoaded('clothingtie') do
                                                    Citizen.Wait(0)
                                                end         
                                                TaskPlayAnim(PlayerPedId(), 'clothingtie', 'try_tie_neutral_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                TriggerEvent("skinchanger:change", "bags_1", k.item_1-1)
                                                TriggerEvent("skinchanger:change", "bags_2", k.item_2-1)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end
                                        elseif result[i].type == "Veste" then            
                                            if ped then
                                                RequestAnimDict('clothingtie')           
                                                while not HasAnimDictLoaded('clothingtie') do
                                                    Citizen.Wait(0)
                                                end         
                                                TaskPlayAnim(PlayerPedId(), 'clothingtie', 'try_tie_neutral_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                TriggerEvent("skinchanger:change", "torso_1", k.item_1-1)
                                                TriggerEvent("skinchanger:change", "torso_2", k.item_2-1)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end 
                                        elseif result[i].type == "T-Shirt" then            
                                            if ped then
                                                RequestAnimDict('clothingtie')           
                                                while not HasAnimDictLoaded('clothingtie') do
                                                    Citizen.Wait(0)
                                                end         
                                                TaskPlayAnim(PlayerPedId(), 'clothingtie', 'try_tie_neutral_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                TriggerEvent("skinchanger:change", "tshirt_1", k.item_1-1)
                                                TriggerEvent("skinchanger:change", "tshirt_2", k.item_2-1)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end  
                                        elseif result[i].type == "Pantalon" then            
                                            if ped then
                                                RequestAnimDict('clothingtrousers')           
                                                while not HasAnimDictLoaded('clothingtrousers') do
                                                    Citizen.Wait(0)
                                                end         
                                                TaskPlayAnim(PlayerPedId(), 'clothingtrousers', 'try_trousers_neutral_c', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                TriggerEvent("skinchanger:change", "pants_1", k.item_1-1)
                                                TriggerEvent("skinchanger:change", "pants_2", k.item_2-1)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end
                                        elseif result[i].type == "Chaussure" then            
                                            if ped then
                                                RequestAnimDict('clothingshoes')           
                                                while not HasAnimDictLoaded('clothingshoes') do
                                                    Citizen.Wait(0)
                                                end         
                                                TaskPlayAnim(PlayerPedId(), 'clothingshoes', 'try_shoes_positive_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                TriggerEvent("skinchanger:change", "shoes_1", k.item_1-1)
                                                TriggerEvent("skinchanger:change", "shoes_2", k.item_2-1)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end  
                                        elseif result[i].type == "Chaine" then            
                                            if ped then
                                                RequestAnimDict('clothingtie')           
                                                while not HasAnimDictLoaded('clothingtie') do
                                                    Citizen.Wait(0)
                                                end         
                                                TaskPlayAnim(PlayerPedId(), 'clothingtie', 'try_tie_positive_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(3000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                TriggerEvent("skinchanger:change", "chain_1", k.item_1-1)
                                                TriggerEvent("skinchanger:change", "chain_2", k.item_2-1)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end          
                                        elseif result[i].type == "Casque" then           
                                            if ped then
                                                RequestAnimDict('missheistdockssetup1hardhat@')           
                                                while not HasAnimDictLoaded('missheistdockssetup1hardhat@') do
                                                    Citizen.Wait(0)
                                                end           
                                                TaskPlayAnim(PlayerPedId(), 'missheistdockssetup1hardhat@', 'put_on_hat', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                TriggerEvent("skinchanger:change", "helmet_1", k.item_1-2)
                                                TriggerEvent("skinchanger:change", "helmet_2", k.item_2-1)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end
                                        elseif result[i].type == "Accessoire d'Oreille" then       
                                            if ped then
                                                RequestAnimDict('mini@ears_defenders')           
                                                while not HasAnimDictLoaded('mini@ears_defenders') do
                                                    Citizen.Wait(0)
                                                end
                                                TaskPlayAnim(PlayerPedId(), 'mini@ears_defenders', 'takeoff_earsdefenders_idle', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                TriggerEvent("skinchanger:change", "ears_1", k.item_1-2)
                                                TriggerEvent("skinchanger:change", "ears_2", k.item_2-1)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end  
                                        elseif result[i].type == "Montre" then       
                                            if ped then
                                                --RequestAnimDict('mini@ears_defenders')           
                                                --while not HasAnimDictLoaded('mini@ears_defenders') do
                                                --    Citizen.Wait(0)
                                                --end
                                                --TaskPlayAnim(PlayerPedId(), 'mini@ears_defenders', 'takeoff_earsdefenders_idle', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                TriggerEvent("skinchanger:change", "watches_1", k.item_1-2)
                                                TriggerEvent("skinchanger:change", "watches_2", k.item_2-1)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end    
                                        elseif result[i].type == "Bracelet" then       
                                            if ped then
                                                --RequestAnimDict('mini@ears_defenders')           
                                                --while not HasAnimDictLoaded('mini@ears_defenders') do
                                                --    Citizen.Wait(0)
                                                --end
                                                --TaskPlayAnim(PlayerPedId(), 'mini@ears_defenders', 'takeoff_earsdefenders_idle', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                TriggerEvent("skinchanger:change", "bracelets_1", k.item_1-2)
                                                TriggerEvent("skinchanger:change", "bracelets_2", k.item_2-1)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end   
                                        elseif result[i].type == "Gilet par balle" then       
                                            if ped then
                                                RequestAnimDict('clothingtie')           
                                                while not HasAnimDictLoaded('clothingtie') do
                                                Citizen.Wait(0)
                                                end
                                                TaskPlayAnim(PlayerPedId(), 'clothingtie', 'try_tie_neutral_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                TriggerEvent("skinchanger:change", "bproof_1", k.item_1-2)
                                                TriggerEvent("skinchanger:change", "bproof_2", k.item_2-1)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end         
                                        end
                                    elseif Index == 2 then
                                        if result[i].type == "Masque" then   
                                            if ped then
                                                RequestAnimDict('missfbi4')            
                                                while not HasAnimDictLoaded('missfbi4') do
                                                    Citizen.Wait(0)
                                                end           
                                                TaskPlayAnim(PlayerPedId(), 'missfbi4', 'takeoff_mask', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
                                                    if skina.sex == 1 then
                                                        TriggerEvent("skinchanger:change", "mask_1", pF5.Clothes.Female.mask_1)
                                                        TriggerEvent("skinchanger:change", "mask_2", pF5.Clothes.Female.mask_2)
                                                    else
                                                        TriggerEvent("skinchanger:change", "mask_1", pF5.Clothes.Male.mask_1)
                                                        TriggerEvent("skinchanger:change", "mask_2", pF5.Clothes.Male.mask_2)
                                                    end
                                                end)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end
                                        elseif result[i].type == "Lunette" then            
                                            if ped then
                                                RequestAnimDict('clothingspecs')           
                                                while not HasAnimDictLoaded('clothingspecs') do
                                                    Citizen.Wait(0)
                                                end         
                                                TaskPlayAnim(PlayerPedId(), 'clothingspecs', 'try_glasses_positive_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
                                                    if skina.sex == 1 then
                                                        TriggerEvent("skinchanger:change", "glasses_1", pF5.Clothes.Female.glasses_1)
                                                        TriggerEvent("skinchanger:change", "glasses_2", pF5.Clothes.Female.glasses_2)
                                                    else
                                                        TriggerEvent("skinchanger:change", "glasses_1", pF5.Clothes.Male.glasses_1)
                                                        TriggerEvent("skinchanger:change", "glasses_2", pF5.Clothes.Male.glasses_2)
                                                    end
                                                end)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end
                                        elseif result[i].type == "Sac" then            
                                            if ped then
                                                RequestAnimDict('clothingtie')           
                                                while not HasAnimDictLoaded('clothingtie') do
                                                    Citizen.Wait(0)
                                                end         
                                                TaskPlayAnim(PlayerPedId(), 'clothingtie', 'try_tie_neutral_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
                                                    if skina.sex == 1 then
                                                        TriggerEvent("skinchanger:change", "bags_1", pF5.Clothes.Female.bags_1)
                                                        TriggerEvent("skinchanger:change", "bags_2", pF5.Clothes.Female.bags_2)
                                                    else
                                                        TriggerEvent("skinchanger:change", "bags_1", pF5.Clothes.Male.bags_1)
                                                        TriggerEvent("skinchanger:change", "bags_2", pF5.Clothes.Male.bags_2)
                                                    end
                                                end)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end
                                        elseif result[i].type == "Veste" then            
                                            if ped then
                                                RequestAnimDict('clothingtie')           
                                                while not HasAnimDictLoaded('clothingtie') do
                                                    Citizen.Wait(0)
                                                end         
                                                TaskPlayAnim(PlayerPedId(), 'clothingtie', 'try_tie_neutral_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
                                                    if skina.sex == 1 then
                                                        TriggerEvent("skinchanger:change", "torso_1", pF5.Clothes.Female.torso_1)
                                                        TriggerEvent("skinchanger:change", "torso_2", pF5.Clothes.Female.torso_2)
                                                    else
                                                        TriggerEvent("skinchanger:change", "torso_1", pF5.Clothes.Male.torso_1)
                                                        TriggerEvent("skinchanger:change", "torso_2", pF5.Clothes.Male.torso_2)                                              
                                                    end
                                                end)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end 
                                        elseif result[i].type == "T-Shirt" then            
                                            if ped then
                                                RequestAnimDict('clothingtie')           
                                                while not HasAnimDictLoaded('clothingtie') do
                                                    Citizen.Wait(0)
                                                end         
                                                TaskPlayAnim(PlayerPedId(), 'clothingtie', 'try_tie_neutral_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
                                                    if skina.sex == 1 then
                                                        TriggerEvent("skinchanger:change", "tshirt_1", pF5.Clothes.Female.tshirt_1)
                                                        TriggerEvent("skinchanger:change", "tshirt_2", pF5.Clothes.Female.tshirt_2)
                                                    else
                                                        TriggerEvent("skinchanger:change", "tshirt_1", pF5.Clothes.Male.tshirt_1)
                                                        TriggerEvent("skinchanger:change", "tshirt_2", pF5.Clothes.Male.tshirt_2)
                                                    end
                                                end)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end  
                                        elseif result[i].type == "Pantalon" then            
                                            if ped then
                                                RequestAnimDict('clothingtrousers')           
                                                while not HasAnimDictLoaded('clothingtrousers') do
                                                    Citizen.Wait(0)
                                                end         
                                                TaskPlayAnim(PlayerPedId(), 'clothingtrousers', 'try_trousers_neutral_c', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
                                                    if skina.sex == 1 then
                                                        TriggerEvent("skinchanger:change", "pants_1", pF5.Clothes.Female.pants_1)
                                                        TriggerEvent("skinchanger:change", "pants_2", pF5.Clothes.Female.pants_2)
                                                    else
                                                        TriggerEvent("skinchanger:change", "pants_1", pF5.Clothes.Male.pants_1)
                                                        TriggerEvent("skinchanger:change", "pants_2", pF5.Clothes.Male.pants_2)
                                                    end
                                                end)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end
                                        elseif result[i].type == "Chaussure" then            
                                            if ped then
                                                RequestAnimDict('clothingshoes')           
                                                while not HasAnimDictLoaded('clothingshoes') do
                                                    Citizen.Wait(0)
                                                end         
                                                TaskPlayAnim(PlayerPedId(), 'clothingshoes', 'try_shoes_positive_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
                                                    if skina.sex == 1 then
                                                        TriggerEvent("skinchanger:change", "shoes_1", pF5.Clothes.Female.shoes_1)
                                                        TriggerEvent("skinchanger:change", "shoes_2", pF5.Clothes.Female.shoes_2)
                                                    else
                                                        TriggerEvent("skinchanger:change", "shoes_1", pF5.Clothes.Male.shoes_1)
                                                        TriggerEvent("skinchanger:change", "shoes_2", pF5.Clothes.Male.shoes_2)
                                                    end
                                                end)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end  
                                        elseif result[i].type == "Chaine" then            
                                            if ped then
                                                RequestAnimDict('clothingtie')           
                                                while not HasAnimDictLoaded('clothingtie') do
                                                    Citizen.Wait(0)
                                                end         
                                                TaskPlayAnim(PlayerPedId(), 'clothingtie', 'try_tie_positive_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(3000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
                                                    if skina.sex == 1 then
                                                        TriggerEvent("skinchanger:change", "chain_1", pF5.Clothes.Female.chain_1)
                                                        TriggerEvent("skinchanger:change", "chain_2", pF5.Clothes.Female.chain_2)
                                                    else
                                                        TriggerEvent("skinchanger:change", "chain_1", pF5.Clothes.Male.chain_1)
                                                        TriggerEvent("skinchanger:change", "chain_2", pF5.Clothes.Male.chain_2)
                                                    end
                                                end)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end          
                                        elseif result[i].type == "Casque" then           
                                            if ped then
                                                RequestAnimDict('missheistdockssetup1hardhat@')           
                                                while not HasAnimDictLoaded('missheistdockssetup1hardhat@') do
                                                    Citizen.Wait(0)
                                                end           
                                                TaskPlayAnim(PlayerPedId(), 'missheistdockssetup1hardhat@', 'put_on_hat', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)                
                                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
                                                    if skina.sex == 1 then
                                                        TriggerEvent("skinchanger:change", "helmet_1", pF5.Clothes.Female.helmet_1)
                                                        TriggerEvent("skinchanger:change", "helmet_2", pF5.Clothes.Female.helmet_2)
                                                    else
                                                        TriggerEvent("skinchanger:change", "helmet_1", pF5.Clothes.Male.helmet_1)
                                                        TriggerEvent("skinchanger:change", "helmet_2", pF5.Clothes.Male.helmet_2)
                                                    end
                                                end)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end
                                        elseif result[i].type == "Accessoire d'Oreille" then       
                                            if ped then
                                                RequestAnimDict('mini@ears_defenders')           
                                                while not HasAnimDictLoaded('mini@ears_defenders') do
                                                    Citizen.Wait(0)
                                                end
                                                TaskPlayAnim(PlayerPedId(), 'mini@ears_defenders', 'takeoff_earsdefenders_idle', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
                                                    if skina.sex == 1 then
                                                        TriggerEvent("skinchanger:change", "ears_1", pF5.Clothes.Female.ears_1)
                                                        TriggerEvent("skinchanger:change", "ears_2", pF5.Clothes.Female.ears_2)
                                                    else
                                                        TriggerEvent("skinchanger:change", "ears_1", pF5.Clothes.Male.ears_1)
                                                        TriggerEvent("skinchanger:change", "ears_2", pF5.Clothes.Male.ears_2)
                                                    end
                                                end)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end         
                                        elseif result[i].type == "Montre" then       
                                            if ped then
                                                -- RequestAnimDict('mini@ears_defenders')           
                                                -- while not HasAnimDictLoaded('mini@ears_defenders') do
                                                --     Citizen.Wait(0)
                                                -- end
                                                -- TaskPlayAnim(PlayerPedId(), 'mini@ears_defenders', 'takeoff_earsdefenders_idle', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
                                                    if skina.sex == 1 then
                                                        TriggerEvent("skinchanger:change", "watches_1", pF5.Clothes.Female.watches_1)
                                                        TriggerEvent("skinchanger:change", "watches_2", pF5.Clothes.Female.watches_2)
                                                    else
                                                        TriggerEvent("skinchanger:change", "watches_1", pF5.Clothes.Male.watches_1)
                                                        TriggerEvent("skinchanger:change", "watches_2", pF5.Clothes.Male.watches_2)
                                                    end
                                                end)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end   
                                        elseif result[i].type == "Bracelet" then       
                                            if ped then
                                                -- RequestAnimDict('mini@ears_defenders')           
                                                -- while not HasAnimDictLoaded('mini@ears_defenders') do
                                                --     Citizen.Wait(0)
                                                -- end
                                                -- TaskPlayAnim(PlayerPedId(), 'mini@ears_defenders', 'takeoff_earsdefenders_idle', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
                                                    if skina.sex == 1 then
                                                        TriggerEvent("skinchanger:change", "bracelets_1", pF5.Clothes.Female.bracelets_1)
                                                        TriggerEvent("skinchanger:change", "bracelets_2", pF5.Clothes.Female.bracelets_2)
                                                    else
                                                        TriggerEvent("skinchanger:change", "bracelets_1", pF5.Clothes.Male.bracelets_1)
                                                        TriggerEvent("skinchanger:change", "bracelets_2", pF5.Clothes.Male.bracelets_2)
                                                    end
                                                end)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end     
                                        elseif result[i].type == "Gilet par balle" then       
                                            if ped then
                                                RequestAnimDict('clothingtie')           
                                                while not HasAnimDictLoaded('clothingtie') do
                                                Citizen.Wait(0)
                                                end
                                                TaskPlayAnim(PlayerPedId(), 'clothingtie', 'try_tie_neutral_a', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                Citizen.Wait(1000)
                                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
                                                    if skina.sex == 1 then
                                                        TriggerEvent("skinchanger:change", "bproof_1", pF5.Clothes.Female.bproof_1)
                                                        TriggerEvent("skinchanger:change", "bproof_2", pF5.Clothes.Female.bproof_2)
                                                    else
                                                        TriggerEvent("skinchanger:change", "bproof_1", pF5.Clothes.Male.bproof_1)
                                                        TriggerEvent("skinchanger:change", "bproof_2", pF5.Clothes.Male.bproof_2)
                                                    end
                                                end)
                                                Citizen.Wait(200)
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent('esx_skin:save', skin)
                                                end)  
                                            end   
                                        end
                                    elseif Index == 3 then
                                        result[i].type = result[i].type
                                        local txt = KeyboardInput(result[i].label, "", 40)
                                        if txt then                                          
                                            TriggerServerEvent("pClothesItem:Rename", result[i].id, txt, result[i].type)
                                            result[i].label = txt
                                        else
                                            ESX.ShowNotification("Veuillez entrer un nom valide")
                                        end
                                    elseif Index == 4 then
                                        if result[i].index == 99 then
                                            SetPedComponentVariation(PlayerPedId(), 1, 0, 0, 2)
                                        else
                                            ClearPedProp(PlayerPedId(), result[i].index)
                                        end
                                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                        local closestPed = GetPlayerPed(closestPlayer)
                                        if IsPedSittingInAnyVehicle(closestPed) then
                                            ESX.ShowNotification('~r~Impossible de donner un objet dans un véhicule')
                                            return
                                        end
                                        if closestPlayer ~= -1 and closestDistance < 3.0 then
                                            TriggerServerEvent('pClothesItem:Give', GetPlayerServerId(closestPlayer), result[i].id, result[i].label)        
                                            table.remove(result, i)      
                                        else
                                            ESX.ShowNotification("~r~Aucun joueurs proche")           
                                        end
                                    elseif Index == 5 then
                                        TriggerServerEvent('pClothesItem:Delete', result[i].id, result[i].label,result[i])
                                        TriggerEvent('pClothesItem:Sync')
                                    end
                                end
                            })
                        end
                    end
                end)
                RageUI.IsVisible(subMenu15, function()
                    if not active then
                        RageUI.Separator("Vous n'avez pas de téléphone")
                    else
                        if datanumber == nil then
                            RageUI.Separator("Votre numéro actuel : ~b~Aucun")
                        else
                            RageUI.Separator("Votre numéro actuel : ~b~"..datanumber.."")
                        end 
                    end
                    for _,v in pairs(ArraySim) do
                        RageUI.List(v.name, {"Utiliser", "Donner", "Renommer", "Supprimer"}, ArrayIndex, "Numéro attribué à la carte SIM : ~b~"..v.number, {}, active, {
                            onListChange = function(Index)
                                ArrayIndex = Index
                            end,
                            onSelected = function()
                                if active then
                                    if ArrayIndex == 1 then
                                        TriggerServerEvent("pSim:Use", v.number)
                                        Wait(200)
                                        Load()
                                        TriggerServerEvent("pSim:Load")
                                    elseif ArrayIndex == 2 then
                                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                        local closestPed = GetPlayerPed(closestPlayer)
                                        if IsPedSittingInAnyVehicle(closestPed) then
                                            ESX.ShowNotification('~r~Vous ne pouvez pas donner quelque chose à quelqu\'un dans un véhicule')
                                            return
                                        end
                                        if closestPlayer ~= -1 and closestDistance < 3.0 then
                                            PlayAnim("mp_common", "givetake1_a")
                                            TriggerServerEvent("pSim:Give", GetPlayerServerId(closestPlayer), v.number)
                                            Wait(200)
                                            Load()
                                        else
                                            ESX.ShowNotification("Personne à proximité")
                                        end
                                    elseif ArrayIndex == 3 then
                                        newname = KeyboardInput("Choisissez un nouveau nom pour votre carte sim", v.name, 50)
                                        if not newname or newname == "" then
                                            ESX.ShowNotification("Veuillez entrer un nom valide")
                                        else
                                            TriggerServerEvent("pSim:Rename", v.id, newname)
                                            Wait(200)
                                            Load()
                                        end
                                    elseif ArrayIndex == 4 then
                                        TriggerServerEvent("pSim:Delete", v.number)
                                        Wait(200)
                                        Load()
                                    end
                                end
                            end
                        })
                    end
                end)
            Wait(0)
            end
        end)
    end
end

Keys.Register(pF5.Key, 'F5', 'Ouvrir le menu f5', function()
    if pF5.pSim.Active then
        Load()
    end
    if pF5.pClothes.Active then
        GetAccess()
    end
    Load_Key()
	OpenMenu()
end)

function UpdateSocietyMoney(money)
	societymoney = ESX.Math.GroupDigits(money)
end

function UpdateSociety2Money(money)
	societymoney2 = ESX.Math.GroupDigits(money)
end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

function DrawAnim()
    local ped = PlayerPedId()
    local ad = "clothingshirt"
    loadAnimDict(ad)
    RequestAnimDict(dict)
    TaskPlayAnim(ped, ad, "check_out_a", 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
    TaskPlayAnim(ped, ad, "check_out_b", 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
    TaskPlayAnim(ped, ad, "check_out_c", 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
    TaskPlayAnim(ped, ad, "intro", 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
    TaskPlayAnim(ped, ad, "outro", 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
    TaskPlayAnim(ped, ad, "try_shirt_base", 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
    TaskPlayAnim(ped, ad, "try_shirt_positive_a", 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
    TaskPlayAnim(ped, ad, "try_shirt_positive_b", 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
    TaskPlayAnim(ped, ad, "try_shirt_positive_c", 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
    TaskPlayAnim(ped, ad, "try_shirt_positive_d", 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
end

local _currentWeight_ = 0

Citizen.CreateThread(function()
    while not ESX.PlayerLoaded do 
        Citizen.Wait(100) 
    end
    if pF5.LocalWeight.Active then
        while true do
            Citizen.Wait(0)
            local _currentWeight = 0
            ESX.PlayerData = ESX.GetPlayerData()
            for k,v in ipairs(ESX.PlayerData.inventory) do
                if v.count > 0 then
                    for y,z in pairs(pF5.LocalWeight.weight) do
                        if y == v.name then
                            _currentWeight = _currentWeight + (z * v.count)
                        end
                    end
                end
            end
            _currentWeight_ = _currentWeight
            if _currentWeight_ > pF5.LocalWeight.maxWeight then
                SetPedMoveRateOverride(PlayerPedId(), 0.5)
                DisableControlAction(0, 22, true)
    
                if IsControlPressed(0, 21) then
                    DisableControlAction(0, 21, true)
                    ForcePedMotionState(PlayerPedId(), `motionstate_walk`, 0, 0, 0)
                end
            else
                Citizen.Wait(5000)
            end
        end
    elseif pF5.Weight then
        while true do
            Citizen.Wait(0)
            local _currentWeight = 0
            ESX.PlayerData = ESX.GetPlayerData()
            for k,v in ipairs(ESX.PlayerData.inventory) do
                if v.count > 0 then
                    _currentWeight = _currentWeight + (v.weight * v.count)
                end
            end
            _currentWeight_ = _currentWeight
            if _currentWeight_ > ESX.PlayerData.maxWeight then
                SetPedMoveRateOverride(PlayerPedId(), 0.5)
                DisableControlAction(0, 22, true)
    
                if IsControlPressed(0, 21) then
                    DisableControlAction(0, 21, true)
                    ForcePedMotionState(PlayerPedId(), `motionstate_walk`, 0, 0, 0)
                end
            else
                Citizen.Wait(5000)
            end
        end
    end
end)
