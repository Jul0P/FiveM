ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(5000)
	end
end)

function AmmunationShop()
    local ammunation_shop = false 
    local mainMenu = RageUI.CreateMenu("Ammunation", "Menu")
    local subMenu = RageUI.CreateSubMenu(mainMenu, "Ammunation", "Armes blanches")
    local subMenu2 = RageUI.CreateSubMenu(mainMenu, "Ammunation", "Armes létales")
    local subMenu3 = RageUI.CreateSubMenu(mainMenu, "Ammunation", "Accessoires")
    local subMenu4 = RageUI.CreateSubMenu(mainMenu, "Ammunation", "Armes de chasse")
    mainMenu.Closed = function()
        ammunation_shop = false
    end
    if not ammunation_shop then ammunation_shop = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
		    while ammunation_shop do 
                RageUI.IsVisible(mainMenu,function() 
                    RageUI.Button("Armes blanche", nil, {RightLabel = "→"}, true, {}, subMenu)
                    RageUI.Button("Accessoires", nil, {RightLabel = "→"}, true, {}, subMenu3)
                    RageUI.Separator("↓ Permis de port d'armes ↓")
                    if not ppa then 
                        RageUI.Button("Acheter le PPA", nil, {RightLabel = "~g~"..G_AmmunationShop.PriceWeaponLicense.."$ ~s~→"}, true, {
                            onSelected = function()
                                TriggerServerEvent('G_AmmunationShop:giveLicense', 'weapon', G_AmmunationShop.PriceWeaponLicense)
                                Wait(100)
                                VerifyLicense()
                            end
                        })
                        RageUI.Button("Armes létales", nil, {}, false, {})
                    else
                        RageUI.Button("Acheter le PPA", nil, {}, false, {})
                        RageUI.Button("Armes létales", nil, {RightLabel = "→"}, true, {}, subMenu2)
                    end
                    RageUI.Separator("↓ Permis de chasse ↓")
                    if not chasse then 
                        RageUI.Button("Acheter le PC", nil, {RightLabel = "~g~"..G_AmmunationShop.PriceHuntLicense.."$ ~s~→"}, true, {
                            onSelected = function()
                                TriggerServerEvent('G_AmmunationShop:giveLicense', 'hunt', G_AmmunationShop.PriceHuntLicense)
                                Wait(100)
                                VerifyLicense()
                            end
                        })
                        RageUI.Button("Armes de chasse", nil, {}, false, {})
                    else
                        RageUI.Button("Acheter le PC", nil, {}, false, {})
                        RageUI.Button("Armes de chasse", nil, {RightLabel = "→"}, true, {}, subMenu4)
                    end
                end)  
                RageUI.IsVisible(subMenu,function() 
                    for k,v in pairs(G_AmmunationShop.Content.MeleeWeapon) do
                        RageUI.Button(v.Label, nil, {RightLabel = "~g~"..v.Price.."$"}, true, {
                            onSelected = function()
                                TriggerServerEvent('G_AmmunationShop:giveWeapon', v)
                            end
                        })
                    end
                end)
                RageUI.IsVisible(subMenu2,function() 
                    for k,v in pairs(G_AmmunationShop.Content.OtherWeapon) do
                        RageUI.Button(v.Label, nil, {RightLabel = "~g~"..v.Price.."$"}, true, {
                            onSelected = function()
                                TriggerServerEvent('G_AmmunationShop:giveWeapon', v)
                            end
                        })
                    end
                end)
                RageUI.IsVisible(subMenu3,function() 
                    for k,v in pairs(G_AmmunationShop.Content.Accessories) do
                        RageUI.Button(v.Label, nil, {RightLabel = "~g~"..v.Price.."$"}, true, {
                            onSelected = function()
                                TriggerServerEvent('G_AmmunationShop:giveWeapon', v)
                            end
                        })
                    end
                end)
                RageUI.IsVisible(subMenu4,function() 
                    for k,v in pairs(G_AmmunationShop.Content.HuntWeapon) do
                        RageUI.Button(v.Label, nil, {RightLabel = "~g~"..v.Price.."$"}, true, {
                            onSelected = function()
                                TriggerServerEvent('G_AmmunationShop:giveWeapon', v)
                            end
                        })
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
        for k,v in pairs(G_AmmunationShop.Coords) do
            local coords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(coords.x, coords.y, coords.z, v.x, v.y, v.z)
            if dist <= 2.0 then 
                wait = 0
                DrawMarker(6, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 0, 0, 255, false, false, p19, false)    
                if dist <= 1.0 then 
                    wait = 0 
                    ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir l'~b~Ammunation Shop")
                    if IsControlJustPressed(1,51) then
                        VerifyLicense()
                        AmmunationShop()
                    end
                end
            end
        end
    Citizen.Wait(wait)
    end
end)

