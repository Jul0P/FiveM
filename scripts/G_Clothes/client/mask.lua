Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(5000)
    end
end)

local mask,mask1 = {},1
local maskcolor,maskcolor1 = {},1
function GetIndex2()
    for i = 0, GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 1)-1, 1 do mask[i] = i end 
    maskcolor = {}
    
    for i = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 1, mask1-1), 1 do maskcolor[i] = i end
end

function GetSkinValue2()
    TriggerEvent('skinchanger:getSkin', function(skin)
        mask1 = skin.mask_1+1
        maskcolor1 = skin.mask_2+1
    end)
end

function Mask()  
    local masque = false
    local mainMenu = RageUI.CreateMenu("Magasin de masque", "Menu")
    local UnitMenu = RageUI.CreateSubMenu(mainMenu, "Achat unitaire", "Mon article")
    local BuyUnitMenu = RageUI.CreateSubMenu(UnitMenu, "Mon article", "Mon achat")
    mainMenu.Closed = function()
        masque = false
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
            TriggerEvent('skinchanger:loadSkin', skin)
        end)
        FreezeEntityPosition(GetPlayerPed(-1), false)
        RenderScriptCams(0, 1, 1000, 1, 1)
        DestroyAllCams(true)
    end
    UnitMenu.Closed = function()
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
            TriggerEvent('skinchanger:loadSkin', skin)
        end)
        FreezeEntityPosition(GetPlayerPed(-1), false)
        RenderScriptCams(0, 1, 1000, 1, 1)
        DestroyAllCams(true)
    end
    UnitMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 47, 0), [2] = "Tourner à Gauche"})
    UnitMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 23, 0), [2] = "Tourner à Droite"}) 
    UnitMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 82, 0), [2] = "Activer/Désactiver la Caméra"})
    UnitMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 22, 0), [2] = "Tourner 90°"})
    if not masque then masque = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
            while masque do         
                RageUI.IsVisible(mainMenu, function() 
                    mainMenu:UpdateInstructionalButtons(true)   
                    RageUI.Button("Masque", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            GetSkinValue2()
                            CreateMain() 
                            FreezeEntityPosition(GetPlayerPed(-1), true)
                        end
                    }, UnitMenu)
                end)
                RageUI.IsVisible(UnitMenu, function()  
                    GetIndex2()             
                    Load_Clothes()   
                    UnitMenu:UpdateInstructionalButtons(true)
                    RageUI.List("Masque", mask, mask1, nil, {}, true, {
                        onListChange = function(Index)
                            mask1 = Index
                            TriggerEvent("skinchanger:change", "mask_1", mask1-1)
                            maskcolor1 = 1
                            TriggerEvent("skinchanger:change", "mask_2", maskcolor1-1)
                        end
                    })
                    RageUI.List("Style de Masque", maskcolor, maskcolor1, nil, {}, true, {
                        onListChange = function(Index)
                            maskcolor1 = Index
                            TriggerEvent("skinchanger:change", "mask_2", maskcolor1-1)
                        end
                    })
                    RageUI.Button("Continuer mon achat", nil, {RightLabel = "→", Color = {BackgroundColor = {120,255,0,100}}}, true, {}, BuyUnitMenu)           
                end)
                RageUI.IsVisible(BuyUnitMenu, function()
                    BuyUnitMenu:UpdateInstructionalButtons(true)
                    RageUI.Separator("Catégorie de l'article : ~b~".."Masque")
                    RageUI.Separator("Numéro de l'article : ~o~N°"..mask1)
                    RageUI.Separator("Style de l'article : ~p~N°"..maskcolor1)
                    RageUI.Button("Valider mon achat", nil, {RightBadge = RageUI.BadgeStyle.Tick, Color = {BackgroundColor = {120,255,0,100}}}, true, {
                        onSelected = function()
                            ESX.TriggerServerCallback('G_Clothes:getMoney', function(money)
                                if money then                                                              
                                    TriggerServerEvent("G_Clothes:BuyItem", mask1, maskcolor1, "Masque", "Masque".." N°"..mask1, G_Clothes.Masque.Price)
                                else
                                    ESX.ShowNotification("Vous n'avez pas assez d'argent")
                                end                    
                            end, G_Clothes.Masque.Price) 
                        end
                    })
                    RageUI.Button("Annuler mon achat", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            RageUI.GoBack()
                        end
                    })                      
                end)
            Wait(0)
            end
        end)
    end
end

Citizen.CreateThread(function()
    for _, info in pairs(G_Clothes.Pos.Mask) do
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, G_Clothes.Blip.Mask.Sprite)
        SetBlipDisplay(info.blip, G_Clothes.Blip.Mask.Display)
        SetBlipScale(info.blip, G_Clothes.Blip.Mask.Scale)
        SetBlipColour(info.blip, G_Clothes.Blip.Mask.Colour)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(G_Clothes.Blip.Mask.Title)
        EndTextCommandSetBlipName(info.blip)
	end
end)

Citizen.CreateThread(function()
    while true do
        local wait = 900
        for k,v in pairs(G_Clothes.Pos.Mask) do
            local coords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(coords.x, coords.y, coords.z, v.x, v.y, v.z)
            if dist <= 1.8 then
                wait = 1
                DrawMarker(G_Clothes.Marker.Type, v.x, v.y, v.z-1.01, 0.0, 0.0, 0.0, G_Clothes.Marker.rotX, G_Clothes.Marker.rotY, G_Clothes.Marker.rotZ, G_Clothes.Marker.scaleX, G_Clothes.Marker.scaleY, G_Clothes.Marker.scaleZ, G_Clothes.Marker.R, G_Clothes.Marker.V, G_Clothes.Marker.B, G_Clothes.Marker.O, false, false, p19, false)
                if dist <= 1.8 then
                    wait = 1           
                    ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir le ~b~Magasin de Masque")
                    if IsControlJustPressed(1,51) then     
                        Mask()                                   
                    end              
                end
            end
        end
    Citizen.Wait(wait)
    end
end)