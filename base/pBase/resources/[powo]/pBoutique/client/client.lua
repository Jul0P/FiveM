if pBoutique.ESX == "new" then
	ESX = exports["es_extended"]:getSharedObject()
elseif pBoutique.ESX == "old" then
	ESX = nil
	Citizen.CreateThread(function()
		while ESX == nil do
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
			Citizen.Wait(0)
		end
	end)
end

local mainMenu = RageUI.CreateMenu("Boutique", "MENU")
local subMenu = RageUI.CreateSubMenu(mainMenu, "Votre compte", "MENU")
local subMenu2 = RageUI.CreateSubMenu(mainMenu, "Véhicule", "MENU")
local subMenu3 = RageUI.CreateSubMenu(mainMenu, "Arme", "MENU")

mainMenu.Closed = function()
    boutiquemenu = false
end

function OpenBoutique()
    if not boutiquemenu then boutiquemenu = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
            while boutiquemenu do
                RageUI.IsVisible(mainMenu, function()
                    RageUI.Button("Votre compte", nil, {RightLabel = "→"}, true, {}, subMenu)
                    RageUI.Separator("↓ Liste des produits ↓")
                    RageUI.Button("Véhicule", nil, {RightLabel = "→"}, true, {}, subMenu2)
                    RageUI.Button("Arme", nil, {RightLabel = "→"}, true, {}, subMenu3)
                end)
                RageUI.IsVisible(subMenu, function()

                end)
                RageUI.IsVisible(subMenu2, function()
                    for k,v in pairs(pBoutique.Vehicle) do
                        RageUI.Button(v.label, nil, {RightLabel = "~g~"..v.price}, true, {
                            onSelected = function()
                                TriggerServerEvent("pBoutique:BuyVehicle", v)
                            end
                        })
                    end
                end)
                RageUI.IsVisible(subMenu3, function()

                end)
            Wait(0)
            end
        end)
    end
end

Keys.Register(pBoutique.Key, "openboutique", "Ouvrir le menu boutique", function()
    OpenBoutique()
end)    