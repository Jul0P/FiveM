data_coffre = {}

function GetCoffre()
    ESX.TriggerServerCallback("G_BarberJob:getCoffreItem", function(data) 
        data_coffre = data
    end, ESX.PlayerData.job.name)
end

data_inventory = {}

function GetInventory()
    ESX.TriggerServerCallback("G_BarberJob:getInventoryItem", function(data) 
        data_inventory = data
    end)
end

function RefreshMoney()
    ESX.TriggerServerCallback("esx_society:getSocietyMoney", function(money) 
        SocietyAccount = ESX.Math.GroupDigits(money)
    end, ESX.PlayerData.job.name)
end

function Main()
    local main = false
    local mainMenu = RageUI.CreateMenu("Menu Action", "MENU")
    local Coffre = RageUI.CreateSubMenu(mainMenu, "Coffre", "Barbier")
    local Inventory = RageUI.CreateSubMenu(mainMenu, "Inventaire", "Barbier")
    mainMenu.Closed = function() main = false end
    local fIndex = 1
    if not main then main = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
            while main do
                RageUI.IsVisible(mainMenu, function()
                    RageUI.List("Filtre :", {"Aucun", "Coffre", "Patron"}, fIndex, nil, {}, true, {
                        onListChange = function(Index)
                            fIndex = Index                        
                        end
                    })
                    if fIndex == 1 or fIndex == 2 then
                        RageUI.Separator("↓ Coffre ↓")
                        RageUI.Button("Retirer", nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                GetCoffre()
                            end
                        }, Coffre)
                        RageUI.Button("Déposer", nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                GetInventory()
                            end
                        }, Inventory)
                    end
                    if fIndex == 1 or fIndex == 3 then
                        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'barber' and ESX.PlayerData.job.grade_name == 'boss' then
                            RageUI.Separator("↓ Gestion Entreprise ↓")
                            if SocietyAccount ~= nil then
                                RageUI.Button("Argent de la société :", nil, {RightLabel = "~g~"..SocietyAccount.."$"}, true, {})
                            end
                            RageUI.Button("Retirer argent société", nil, {RightLabel = "→"}, true , {
                                onSelected = function()
                                    local amount = KeyboardInput("Retirer ", nil, 7)
                                    amount = tonumber(amount)
                                    if amount == nil or amount == "" then 
                                        ESX.ShowNotification("Montant Invalide")
                                    else
                                        TriggerServerEvent('esx_society:withdrawMoney', 'barber', amount)
                                        RefreshMoney()
                                    end
                                end
                            })
                            RageUI.Button("Déposer argent société", nil, {RightLabel = "→"}, true , {
                                onSelected = function()
                                    local amount = KeyboardInput("Déposer ", nil, 7)
                                    amount = tonumber(amount)
                                    if amount == nil or amount == "" then
                                        ESX.ShowNotification("Montant Invalide")
                                    else
                                        TriggerServerEvent('esx_society:depositMoney', 'barber', amount)
                                        RefreshMoney()
                                    end
                                end
                            })
                            RageUI.Button("Ouvrir le menu société", nil, {RightLabel = "→"}, true, {
                                onSelected = function()   
                                    bossdefault()
                                    RageUI.CloseAll()
                                    boss = false
                                end
                            })
                        else
                            RageUI.Separator("↓ Gestion Entreprise ↓")
                            RageUI.Separator("Vous n'êtes pas patron")
                        end
                    end
                end)
                RageUI.IsVisible(Coffre, function()
                    for _,v in pairs(data_coffre) do
                        RageUI.Button("[~b~"..v.count.."~s~] - "..v.label, nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                local amount = KeyboardInput("Nombre d'item que vous souhaitez déposer", nil, 5)
                                if amount == nil or amount == "" then
									ESX.ShowNotification("Veuillez rentrer une valeur valide")
								else
									TriggerServerEvent("G_BarberJob:putInventoryItem", v, tonumber(amount), ESX.PlayerData.job.name)
                                    GetCoffre()
								end	                              
                            end
                        })
                    end
                end)
                RageUI.IsVisible(Inventory, function()
                    for _,v in pairs(data_inventory) do
                        RageUI.Button("[~b~"..v.count.."~s~] - "..v.label, nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                local amount = KeyboardInput("Nombre d'item que vous souhaitez retirer", nil, 5)
                                if amount == nil or amount == "" then
									ESX.ShowNotification("Veuillez rentrer une valeur valide")
								else
                                    TriggerServerEvent("G_BarberJob:putCoffreItem", v, tonumber(amount), ESX.PlayerData.job.name)
                                    GetInventory()
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

function bossdefault()
    TriggerEvent('esx_society:openBossMenu', 'barber', function(data, menu)
        menu.close()
    end, {wash = false})
end

Citizen.CreateThread(function()
    while true do
        local wait = 900
        for k,v in pairs(G_Barber.Action) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'barber' then 
                local coords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(coords.x, coords.y, coords.z, v.x, v.y, v.z)
                if dist <= 2.0 then 
                    wait = 0 
                    DrawMarker(G_Barber.Marker.Type, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, G_Barber.Marker.rotX, G_Barber.Marker.rotY, G_Barber.Marker.rotZ, G_Barber.Marker.scaleX, G_Barber.Marker.scaleY, G_Barber.Marker.scaleZ, G_Barber.Marker.R, G_Barber.Marker.V, G_Barber.Marker.B, G_Barber.Marker.O, false, false, p19, false) 
                    if dist <= 1.0 then 
                        wait = 0 
                        ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir le ~o~Menu Action")
                        if IsControlJustPressed(1,51) then 
                            RefreshMoney()
                            Main()
                        end
                    end
                end
            end
        end
    Citizen.Wait(wait)
    end
end)