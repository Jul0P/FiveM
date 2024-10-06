if Config.getSharedObject == "last" then
	ESX = exports["es_extended"]:getSharedObject()
elseif Config.getSharedObject == "old" then
	ESX = nil
	Citizen.CreateThread(function()
		while ESX == nil do
			TriggerEvent('esx:getSharedObject', function(obj) 
                ESX = obj 
            end)
			Citizen.Wait(0)
		end
	end)
end
 
local mainMenu = RageUI.CreateMenu(Config.Translate('menu_title', Config.job.label), Config.Translate('menu_desc'))
local subMenu = RageUI.CreateSubMenu(mainMenu, Config.Translate('menu_title', Config.job.label), Config.Translate('menu_desc'))
local basketMenu = RageUI.CreateMenu(Config.Translate('basket_title'), Config.Translate('basket_desc'))

mainMenu.Closed = function()
    ltd = false
end

basketMenu.Closed = function()
    basket = false
end

local indexMainMenu = 1
local indexSubMenu = 1
local indexBasket = 1 
local indexPaiement = 1

local arrayBasket = {}
local arrayInfoBasketRight = {}
local arrayInfoBasketLeft = {}

function getInfoBasket(arrayInfoBasket, indexLTD)
    arrayInfoBasketRight = {}
    arrayInfoBasketLeft = {}
    for k,v in pairs(arrayInfoBasket) do
        if v.ltd == Config.LTD[indexLTD].label then
            table.insert(arrayInfoBasketRight, v.label.." ~b~x"..v.count.."~s~")
            table.insert(arrayInfoBasketLeft, "~g~"..v.price * v.count.."$")     
        end
    end
end

-- function putBasket(arrayBasket, indexLTD, index, v)
--     local hashTable = {}
--     for i, item in ipairs(arrayBasket) do
--         hashTable[item.name] = i
--     end

--     local itemIndex = hashTable[v.name]
--     if itemIndex then
--         arrayBasket[itemIndex] = {ltd = Config.LTD[indexLTD].label, label = v.label, name = v.name, price = v.price, count = index}
--     else
--         table.insert(arrayBasket, {ltd = Config.LTD[indexLTD].label, label = v.label, name = v.name, price = v.price, count = index})
--     end

--     getInfoBasket(arrayBasket, indexLTD)
-- end

function putBasket(arrayBasket, indexLTD, index, v)
    if #arrayBasket == 0 then
        table.insert(arrayBasket, {ltd = Config.LTD[indexLTD].label, label = v.label, name = v.name, price = v.price, count = index})
    else
        local found = false
        for y,z in pairs(arrayBasket) do
            if z.name == v.name then
                table.remove(arrayBasket, y)
                table.insert(arrayBasket, y, {ltd = Config.LTD[indexLTD].label, label = v.label, name = v.name, price = v.price, count = index})     
                found = true
                break                                  
            end
        end
        if not found then
            table.insert(arrayBasket, {ltd = Config.LTD[indexLTD].label, label = v.label, name = v.name, price = v.price, count = index})
        end
    end
    getInfoBasket(arrayBasket, indexLTD)
end

function removeBasket(arrayBasket, indexLTD, index)
    table.remove(arrayBasket, index)
    getInfoBasket(arrayBasket, indexLTD)
end

function removeAllBasket(arrayBasket, indexLTD)
    for i = #arrayBasket, 1, -1 do
        if arrayBasket[i].ltd == Config.LTD[indexLTD].label then
            table.remove(arrayBasket, i)
        end
    end
    getInfoBasket(arrayBasket, indexLTD)
end

function LTD(indexLTD, arraySalePoint)
    getInfoBasket(arrayBasket, indexLTD)
    if not ltd then ltd = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
		    while ltd do
                RageUI.IsVisible(mainMenu, function()
                    for k,v in pairs(arraySalePoint.content) do
                        if type(k) == "string" then
                            RageUI.Button(k, nil, {}, true, {
                                onActive = function()
                                    key = k
                                end,
                                onSelected = function()
                                    subMenu:SetTitle(k)
                                end
                            }, subMenu)
                        else
                            RageUI.List(v.label.." - ~g~"..v.price.."$", {1,2,3,4,5,6,7,8,9,10}, indexMainMenu, nil, {}, true, {
                                onListChange = function(index, items)
                                    indexMainMenu = index
                                end,
                                onSelected = function()
                                    putBasket(arrayBasket, indexLTD, indexMainMenu, v)
                                end
                            })
                        end
                    end
                    if #arrayInfoBasketRight ~= 0 then
                        RageUI.Info("Votre panier", arrayInfoBasketRight, arrayInfoBasketLeft)
                    end
                end)
                RageUI.IsVisible(subMenu, function()
                    for k,v in pairs(arraySalePoint.content[key]) do
                        RageUI.List(v.label.." - ~g~"..v.price.."$", {1,2,3,4,5,6,7,8,9,10}, indexSubMenu, nil, {}, true, {
                            onListChange = function(index, items)
                                indexSubMenu = index
                            end,
                            onSelected = function()
                                putBasket(arrayBasket, indexLTD, indexSubMenu, v)
                            end
                        })
                    end
                    if #arrayInfoBasketRight ~= 0 then
                        RageUI.Info("Votre panier", arrayInfoBasketRight, arrayInfoBasketLeft)
                    end
                end)            
            Wait(0)
            end
        end)
    end
end

function Basket(indexLTD)
    if not basket then basket = true RageUI.Visible(basketMenu, true)
        CreateThread(function()
		    while basket do
                RageUI.IsVisible(basketMenu, function()
                    local active = false
                    local price = 0
                    for y,z in pairs(arrayBasket) do
                        if z.ltd == Config.LTD[indexLTD].label then
                            price = price + (z.price * z.count)
                        end
                    end
                    for k,v in pairs(arrayBasket) do
                        if v.ltd == Config.LTD[indexLTD].label then
                            active = true
                            RageUI.List(v.label.." ~b~x"..v.count.."~s~ - ~g~"..(v.price * v.count).."$", {"Modifier", "Supprimer"}, indexBasket, nil, {}, true, {
                                onListChange = function(index, items)
                                    indexBasket = index
                                end,
                                onSelected = function()
                                    if indexBasket == 1 then
                                        local input = KeyboardInput("Entrez le nombre de "..v.label.."", v.count, 2, "number")
                                        putBasket(arrayBasket, indexLTD, input, {ltd = v.ltd, label = v.label, name = v.name, price = v.price})
                                    elseif indexBasket == 2 then
                                        removeBasket(arrayBasket, indexLTD, k)
                                    end
                                end
                            })
                        end
                    end
                    if active then
                        RageUI.Line()
                        RageUI.List("Méthode de paiement", {"~g~Liquide~s~", "~b~Banque~s~"}, indexPaiement, nil, {}, true, {
                            onListChange = function(list) 
                                indexPaiement = list 
                            end
                        })
                        RageUI.Button("Vider mon panier", nil, {RightBadge = RageUI.BadgeStyle.Alert, Color = {BackgroundColor = {255, 25, 0, 100}}}, true, {
                            onSelected = function()
                                removeAllBasket(arrayBasket, indexLTD)                          
                            end
                        })
                        RageUI.Button("Valider et payer ".."("..price.."$)", nil, {RightBadge = RageUI.BadgeStyle.Tick, Color = {BackgroundColor = {120, 255, 0, 100}}}, true, {
                            onSelected = function()
                                ESX.TriggerServerCallback('p2p_LTD:buy', function(success)
                                    if success then
                                        removeAllBasket(arrayBasket, indexLTD)
                                    end
                                end, arrayBasket, indexLTD, indexPaiement, price)
                            end
                        })
                    else
                        RageUI.Separator("Votre panier est vide")
                    end
                end)
            Wait(0)
            end
        end)
    end
end

Citizen.CreateThread(function()
    while true do
        local wait = 900
        for k,v in pairs(Config.LTD) do
            local coords = GetEntityCoords(PlayerPedId(), false)
            local markerX, markerY, markerZ = createMarkerAtEntityHeading(v.position.x, v.position.y, v.position.z, v.position.h)
            local dist = Vdist(coords.x, coords.y, coords.z, markerX, markerY, markerZ)
            if dist <= 1.5 then
                wait = 0
                DrawMarker(Config.job.markerbasket.type, markerX, markerY, markerZ+1, 0.0, 0.0, 0.0, Config.job.markerbasket.rotation.x, Config.job.markerbasket.rotation.y, Config.job.markerbasket.rotation.z, Config.job.markerbasket.scale.x, Config.job.markerbasket.scale.y, Config.job.markerbasket.scale.z, Config.job.markerbasket.color.r, Config.job.markerbasket.color.g, Config.job.markerbasket.color.b, Config.job.markerbasket.color.a, Config.job.markerbasket.jump, false, p19, Config.job.markerbasket.rotate)
                ESX.ShowHelpNotification(Config.Translate('menu_marker_title', v.label))
                if IsControlJustPressed(1,51) then
                    basketMenu:SetSubtitle(Config.job.label.." - "..v.label)
                    Basket(k)
                end
            elseif dist > 1.5 and dist < 1.6 and basket == true then
                RageUI.CloseAll()
                basket = false
            else
                for y,z in pairs(v.salepoint) do
                    local coords = GetEntityCoords(PlayerPedId(), false)
                    local dist2 = Vdist(coords.x, coords.y, coords.z, z.position.x, z.position.y, z.position.z)
                    if dist2 <= 1.5 then
                        wait = 0
                        DrawMarker(Config.job.marker.type, z.position.x, z.position.y, z.position.z, 0.0, 0.0, 0.0, Config.job.marker.rotation.x, Config.job.marker.rotation.y, Config.job.marker.rotation.z, Config.job.marker.scale.x, Config.job.marker.scale.y, Config.job.marker.scale.z, Config.job.marker.color.r, Config.job.marker.color.g, Config.job.marker.color.b, Config.job.marker.color.a, Config.job.marker.jump, false, p19, Config.job.marker.rotate)
                        ESX.ShowHelpNotification(Config.Translate('menu_marker_title', z.label))
                        if IsControlJustPressed(1,51) then
                            mainMenu:SetTitle(z.label)
                            mainMenu:SetSubtitle(Config.job.label.." - "..v.label)
                            subMenu:SetSubtitle(Config.job.label.." - "..v.label)
                            LTD(k, z)
                        end
                    elseif dist2 > 1.5 and dist2 < 1.6 and ltd == true then
                        RageUI.CloseAll()
                        ltd = false
                    end
                end
            end
        end
    Citizen.Wait(wait)
    end
end)

Citizen.CreateThread(function()
    for k,v in pairs(Config.LTD) do
        local blip = AddBlipForCoord(v.position.x, v.position.y, v.position.z)
        SetBlipSprite(blip, Config.job.blip.sprite)
        SetBlipScale(blip, Config.job.blip.scale)
        SetBlipColour(blip, Config.job.blip.colour)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(Config.Translate('blip_label', Config.job.label, v.label))
        EndTextCommandSetBlipName(blip)
    end
end)

function createMarkerAtEntityHeading(x, y, z, h)
    local headingRad = math.rad(h)
    local xOffset = -1.5 * math.sin(headingRad)
    local yOffset = -1.5 * math.cos(headingRad)
    local markerX = x + xOffset
    local markerY = y - yOffset
    local markerZ = z
    return markerX, markerY, markerZ
end

Citizen.CreateThread(function()
    if Config.job.ped.active then
        local hash = GetHashKey(Config.job.ped.type)
        while not HasModelLoaded(hash) do 
            RequestModel(hash) 
            Citizen.Wait(20) 
        end
        for k,v in pairs(Config.LTD) do
            local ped = CreatePed("PED_TYPE_CIVFEMALE", Config.job.ped.type, v.position.x, v.position.y, v.position.z, v.position.h, false, true)
            SetBlockingOfNonTemporaryEvents(ped, true)
            FreezeEntityPosition(ped, true)
            SetEntityInvincible(ped, true)       
        end
    end
end)

function KeyboardInput(label, entry, maxStringLength, format)
    AddTextEntry('FMMC_KEY_TIP1', label)
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", entry, "", "", "", maxStringLength)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end
    if UpdateOnscreenKeyboard() ~= 2 then 
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        if format == "number" then
            return tonumber(result) and tonumber(result) or tostring(result) and 0
        elseif format == "string" then
            return tostring(result)
        else
            return nil
        end
    else
        Citizen.Wait(500)
        return format == "number" and 0 or format == "string" and "" or nil
    end
end