local bank = false
local mainMenu = RageUI.CreateMenu("Banque", "MENU")
local subMenu = RageUI.CreateSubMenu(mainMenu, "Déposer", "MENU")
local subMenu2 = RageUI.CreateSubMenu(mainMenu, "Retirer", "MENU")
local subMenu3 = RageUI.CreateSubMenu(mainMenu, "Transférer", "MENU")
mainMenu.Closed = function() bank = false end 

portefeuille = 0
compte = 0
iban2 = nil
montant2 = nil

function Bank()
    if bank then bank = false RageUI.Visible(mainMenu, false) return else bank = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
            while bank do 
                RageUI.IsVisible(mainMenu, function()
                    RageUI.Button("Détenteur du compte :", nil, {RightLabel = ""..GetPlayerName(PlayerId())..""}, true, {})
                    RageUI.Button("IBAN (ID) :", nil, {RightLabel = ""..GetPlayerServerId(PlayerId())..""}, true, {})
                    RageUI.Separator("Portefeuille : ~g~"..portefeuille.."$")
                    RageUI.Separator("Compte : ~g~"..compte.."$")
                    RageUI.Button("Déposer", nil, {RightLabel = "→"}, true, {onSelected = function() end}, subMenu)
                    RageUI.Button("Retirer", nil, {RightLabel = "→"}, true, {onSelected = function() end}, subMenu2)
                    RageUI.Button("Transférer", nil, {RightLabel = "→"}, true, {onSelected = function() end}, subMenu3)
                end)
                RageUI.IsVisible(subMenu, function()
                    RageUI.Button("Montant Personnalisé", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            local depose = KeyboardInput("Montant à déposer :", "", 8)
                            depose = tonumber(depose)
                            TriggerServerEvent('deposer', depose)
                            TriggerServerEvent("G_Bank:pf", fct)
                            TriggerServerEvent("G_Bank:banque", fct)
                        end
                    })
                    RageUI.Button("Montant : ~g~1000$", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            depose = 1000
                            depose = tonumber(depose)
                            TriggerServerEvent('deposer', depose)
                            TriggerServerEvent("G_Bank:pf", fct)
                            TriggerServerEvent("G_Bank:banque", fct)
                        end
                    })
                    RageUI.Button("Montant : ~g~2500$", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            depose = 2500
                            depose = tonumber(depose)
                            TriggerServerEvent('deposer', depose)
                            TriggerServerEvent("G_Bank:pf", fct)
                            TriggerServerEvent("G_Bank:banque", fct)
                        end
                    })
                    RageUI.Button("Montant : ~g~5000$", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            depose = 5000
                            depose = tonumber(depose)
                            TriggerServerEvent('deposer', depose)
                            TriggerServerEvent("G_Bank:pf", fct)
                            TriggerServerEvent("G_Bank:banque", fct)
                        end
                    })
                end)
                RageUI.IsVisible(subMenu2, function()
                    RageUI.Button("Montant Personnalisé", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            local retire = KeyboardInput("Montant à retirer :", "", 8)
                            retire = tonumber(retire)
                            TriggerServerEvent('retirer', retire)
                            TriggerServerEvent("G_Bank:pf", fct)
                            TriggerServerEvent("G_Bank:banque", fct)
                        end
                    })
                    RageUI.Button("Montant : ~g~1000$", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            retire = 1000
                            retire = tonumber(retire)
                            TriggerServerEvent('retirer', retire)
                            TriggerServerEvent("G_Bank:pf", fct)
                            TriggerServerEvent("G_Bank:banque", fct)
                        end
                    })
                    RageUI.Button("Montant : ~g~2500$", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            retire = 2500
                            retire = tonumber(retire)
                            TriggerServerEvent('retirer', retire)
                            TriggerServerEvent("G_Bank:pf", fct)
                            TriggerServerEvent("G_Bank:banque", fct)
                        end
                    })
                    RageUI.Button("Montant : ~g~5000$", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            retire = 5000
                            retire = tonumber(retire)
                            TriggerServerEvent('retirer', retire)
                            TriggerServerEvent("G_Bank:pf", fct)
                            TriggerServerEvent("G_Bank:banque", fct)
                        end
                    })
                end)
                RageUI.IsVisible(subMenu3, function()
                    RageUI.Button("IBAN (ID)", nil, {RightLabel = ibanf}, true, {
                        onSelected = function()
                            local iban = KeyboardInput("IBAN (ID) du destinataire", "", 4)
                            if iban == nil then
                                ESX.ShowNotification("IBAN Invalide")
                            else
                                iban2 = tonumber(iban)
                                ibanf = "~b~"..iban2..""
                            end
                        end
                    })
                    RageUI.Button("Montant", nil, {RightLabel = montantf}, true, {
                        onSelected = function()
                            local montant = KeyboardInput("Montant à transférer", "", 8)
                            if montant == nil then
                                ESX.ShowNotification("Montant Invalide")
                            else
                                montant2 = tonumber(montant)
                                montantf = "~g~"..montant2.."$"
                            end
                        end
                    })
                    RageUI.Button('Valider', false, {RightBadge = RageUI.BadgeStyle.Tick}, true, {
                        onSelected = function()
                            TriggerServerEvent('transfere', iban2, montant2)
                            TriggerServerEvent("G_Bank:banque", fct)
                        end
                    })
                end)
            Wait(0)
            end
        end)
    end
end

function hasCard(cb)
    if (ESX == nil) then 
        return 
        cb(0) 
    end
    ESX.TriggerServerCallback('G_Bank:getItemAmount', function(qtty)
        cb(qtty > 0)
    end, 'cartebancaire')
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do Citizen.Wait(0) end 
    if UpdateOnscreenKeyboard() ~= 2 then local result = GetOnscreenKeyboardResult() Citizen.Wait(500) blockinput = false return result else Citizen.Wait(500) blockinput = false return nil end
end

local pos = {
    {x = 149.85, y = -1040.81, z = 29.37},
    {x = 314.19, y = -279.15, z = 54.17},
    {x = -350.96, y = -49.96, z = 49.04},
    {x = -1212.59, y = -330.78, z = 37.78},
    {x = -2962.48, y = 482.92, z = 15.70},
    {x = 1175.02, y = 2706.89, z = 38.09},
    {x = -113.03, y = 6470.25, z = 31.62},
    {x = 243.20, y = 224.79, z = 106.28},
}

Citizen.CreateThread(function()
    while true do
        local wait = 900
        for k,v in pairs(pos) do
            local coords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(coords.x, coords.y, coords.z, v.x, v.y, v.z)
            if dist <= 1.5 then
                wait = 1
                DrawMarker(6, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 0, 0, 255, false, false, p19, false) 
            end
            if dist <= 0.7 then
                wait = 1
                ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir le ~b~Menu Banque")
                if IsControlJustPressed(1,51) then
                    hasCard(function(hasCard)
                        if hasCard then
                            TriggerServerEvent("G_Bank:pf", fct)
                            TriggerServerEvent("G_Bank:banque", fct)
					        Bank()
                        else
                            ESX.ShowNotification("Vous devez acheter une ~b~Carte Bancaire")
                        end
                    end)
                end
            end
        end
    Citizen.Wait(wait)
    end
end)

Citizen.CreateThread(function() 
	for k,v in pairs(pos) do 
		local blip = AddBlipForCoord(v.x, v.y, v.z) 
					 SetBlipSprite (blip, 500) 
					 SetBlipDisplay(blip, 4) 
					 SetBlipScale  (blip, 0.7) 
					 SetBlipColour (blip, 2) 
					 SetBlipAsShortRange(blip, true) 
					 BeginTextCommandSetBlipName('STRING') 
					 AddTextComponentSubstringPlayerName('Banque') 
					 EndTextCommandSetBlipName(blip) 
	end 
end)

RegisterNetEvent("G_Bank:portefeuille") AddEventHandler("G_Bank:portefeuille", function(money, cash) portefeuille = tonumber(money) end)
RegisterNetEvent("G_Bank:compte") AddEventHandler("G_Bank:compte", function(money, cash) compte = tonumber(money) end)
