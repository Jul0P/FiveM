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

local mainMenu = RageUI.CreateMenu(Config.Translate('mainMenuLabel'), Config.Translate('mainMenuDesc'))
local subMenu = RageUI.CreateSubMenu(mainMenu, "", "")
local subPanier = RageUI.CreateSubMenu(mainMenu, Config.Translate('shoppingcart_label'), Config.Translate('shoppingcart_desc'))
local methode = ""
local Index1, Index2 = 1, 1
local Panier = {}

mainMenu.Closed = function()
    open = false
    TriggerEvent('p2p_shop:clearPanier')
end

function shopMenu()
    if not open then open = true RageUI.Visible(mainMenu, true)
        Citizen.CreateThread(function()
            while open do
                RageUI.IsVisible(mainMenu, function()
                    RageUI.Button(Config.Translate('gotobasket'), nil, {RightLabel = "→"}, true, {}, subPanier)
                    RageUI.Line()
                    for k, v in pairs(Config.shop) do
                        RageUI.Button(v.label, v.desc, {RightLabel = "→"}, true, {
                            onActive = function()
                                contentList = v
                                subMenu:SetTitle(v.label)
                                subMenu:SetSubtitle(v.desc)
                            end
                        }, subMenu)
                    end
                end)
                RageUI.IsVisible(subMenu, function()
                    for k, v in pairs(contentList.content) do
                        RageUI.List(v.label.." - ~g~"..v.price.."$~s~", {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}, Index1, nil, {}, true, {
                            onListChange = function(list) 
                                Index1 = list 
                            end,
                            onSelected = function(list)
                                local items = {
                                    label = v.label,
                                    name = v.name,
                                    price = v.price,
                                    quantity = list
                                }
                                table.insert(Panier, items)
                            end
                        })
                    end
                end)
                RageUI.IsVisible(subPanier, function()
                    if #Panier >=1 then
                        RageUI.Button(Config.Translate('clear_basket'), nil, {RightBadge = RageUI.BadgeStyle.Alert, Color = {BackgroundColor = {255, 25, 0, 100}}}, true, {
                            onSelected = function()
                                Panier = {}
                            end
                        })
                        RageUI.Line()
                        for k, v in pairs(Panier) do
                            RageUI.Button(v.label.." - x"..v.quantity, nil, {RightLabel = "~g~"..(v.price * v.quantity).."$~s~"}, true, {})
                        end
                        RageUI.Line()
                        RageUI.List(Config.Translate('paiement'), {"~g~"..Config.Translate('money').."~s~", "~b~"..Config.Translate('bank').."~s~"}, Index2, nil, {}, true, {
                            onListChange = function(list) 
                                Index2 = list 
                                if list == 1 then
                                    methode = "liquide"
                                elseif list == 2 then
                                    methode = "banque"
                                end
                            end
                        })
                        RageUI.Button(Config.Translate('confirm'), false, {RightBadge = RageUI.BadgeStyle.Tick, Color = {BackgroundColor = {120, 255, 0, 100}}}, true, {
                            onSelected = function()
                                TriggerServerEvent('p2p_shop:buy_item', Panier, methode)
                                RageUI.GoBack()
                            end
                        })
                    else
                        RageUI.Separator("")
                        RageUI.Separator("~r~"..Config.Translate('shoppingcart_empty'))
                        RageUI.Separator("")
                    end
                end)
                Citizen.Wait(0)
            end
        end)
    end
end

RegisterNetEvent('p2p_shop:clearPanier')
AddEventHandler('p2p_shop:clearPanier', function()
    Panier = {}
end)

Citizen.CreateThread(function()
    for k, v in pairs(Config.position) do
        if Config.blip.active then
            local blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(blip, Config.blip.sprite)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, Config.blip.scale)
            SetBlipColour(blip, Config.blip.color)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(Config.Translate('blipLabel'))
            EndTextCommandSetBlipName(blip)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        local wait = 900
        for k, v in pairs(Config.position) do
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.x, v.y, v.z)
            if dist <= 2 then
                wait = 1
                DrawMarker(Config.marker.type, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, Config.marker.rotation.x, Config.marker.rotation.y, Config.marker.rotation.z, Config.marker.scale.x, Config.marker.scale.y, Config.marker.scale.z, Config.marker.color.r, Config.marker.color.g, Config.marker.color.b, Config.marker.color.a, Config.marker.jump, false, p19, Config.marker.rotate)
            end
            if dist <= 1.0 then
                wait = 1
                ESX.ShowHelpNotification(Config.Translate('markerLabel'))
                if IsControlJustPressed(1, 51) then
                    shopMenu()
                end
            end 
        end
        Citizen.Wait(wait)
    end
end)

Citizen.CreateThread(function()
    if Config.ped.active then
        local hash = GetHashKey(Config.ped.type)
        while not HasModelLoaded(hash) do 
            RequestModel(hash) 
            Citizen.Wait(20) 
        end
        for k, v in pairs(Config.ped.position) do
            local ped = CreatePed("PED_TYPE_CIVFEMALE", Config.ped.type, v.x, v.y, v.z, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(ped, true)
            FreezeEntityPosition(ped, true)
            SetEntityInvincible(ped, true)
        end
    end
end)
