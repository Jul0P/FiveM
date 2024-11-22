Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(5000)
    end
end)

local veste,veste1 = {},1
local vestecolor,vestecolor1 = {},1
local tshirt,tshirt1 = {},1
local tshirtcolor,tshirtcolor1 = {},1
local pantalon,pantalon1 = {},1
local pantaloncolor,pantaloncolor1 = {},1
local chaussure,chaussure1 = {},1
local chaussurecolor,chaussurecolor1 = {},1
local bras,bras1 = {},1
local calque,calque1 = {},1
local calquecolor,calquecolor1 = {},1
local chaine,chaine1 = {},1
local chainecolor,chainecolor1 = {},1
local casque,casque1 = {},1
local casquecolor,casquecolor1 = {},1
local lunette,lunette1 = {},1
local lunettecolor,lunettecolor1 = {},1
local oreille,oreille1 = {},1
local oreillecolor,oreillecolor1 = {},1
local montre,montre1 = {},1
local montrecolor,montrecolor1 = {},1
local bracelet,bracelet1 = {},1
local braceletcolor,braceletcolor1 = {},1
local sac,sac1 = {},1
local saccolor,saccolor1 = {},1
local giletparballe,giletparballe1 = {},1
local giletparballecolor,giletparballecolor1 = {},1

local oArray = {}
local oIndex = 1

function GetIndex()
    for i = 0, GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 11)-1, 1 do veste[i] = i end 
    for i = 0, GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 8)-1, 1 do tshirt[i] = i end
    for i = 0, GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 4)-1, 1 do pantalon[i] = i end
    for i = 0, GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 6)-1, 1 do chaussure[i] = i end
    for i = 0, GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 3)-1, 1 do bras[i] = i end
    for i = 0, GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 10)-1, 1 do calque[i] = i end
    for i = 0, GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 7)-1, 1 do chaine[i] = i end
    for i = 0, GetNumberOfPedPropDrawableVariations(GetPlayerPed(-1), 0)-1, 1 do casque[i] = i end
    for i = 0, GetNumberOfPedPropDrawableVariations(GetPlayerPed(-1), 1)-1, 1 do lunette[i] = i end
    for i = 0, GetNumberOfPedPropDrawableVariations(GetPlayerPed(-1), 2)-1, 1 do oreille[i] = i end
    for i = 0, GetNumberOfPedPropDrawableVariations(GetPlayerPed(-1), 6)-1, 1 do montre[i] = i end
    for i = 0, GetNumberOfPedPropDrawableVariations(GetPlayerPed(-1), 7)-1, 1 do bracelet[i] = i end
    for i = 0, GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 5)-1, 1 do sac[i] = i end
    for i = 0, GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 9)-1, 1 do giletparballe[i] = i end

    vestecolor,tshirtcolor,pantaloncolor,chaussurecolor,calquecolor,chainecolor,casquecolor,lunettecolor,oreillecolor,montrecolor,braceletcolor,saccolor,giletparballecolor = {},{},{},{},{},{},{},{},{},{},{},{},{}
    for i = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 11, veste1-1), 1 do vestecolor[i] = i end
    for i = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 8, tshirt1-1), 1 do tshirtcolor[i] = i end
    for i = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 4, pantalon1-1), 1 do pantaloncolor[i] = i end
    for i = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 6, chaussure1-1), 1 do chaussurecolor[i] = i end
    for i = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 10, calque1-1), 1 do calquecolor[i] = i end
    for i = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 7, chaine1-1), 1 do chainecolor[i] = i end
    for i = 0, GetNumberOfPedPropTextureVariations(PlayerPedId(), 0, casque1-2), 1 do casquecolor[i] = i end
    for i = 0, GetNumberOfPedPropTextureVariations(PlayerPedId(), 1, lunette1-2), 1 do lunettecolor[i] = i end
    for i = 0, GetNumberOfPedPropTextureVariations(PlayerPedId(), 2, oreille1-3), 1 do oreillecolor[i] = i end
    for i = 0, GetNumberOfPedPropTextureVariations(PlayerPedId(), 6, montre1-2), 1 do montrecolor[i] = i end
    for i = 0, GetNumberOfPedPropTextureVariations(PlayerPedId(), 7, bracelet1-2), 1 do braceletcolor[i] = i end
    for i = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 5, sac1-1), 1 do saccolor[i] = i end
    for i = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 9, giletparballe1-1), 1 do giletparballecolor[i] = i end

    -- ## A Enlever si jamais BUG
    if GetNumberOfPedPropTextureVariations(PlayerPedId(), 0, casque1-2) == 0 then
        casquecolor = {1}
    end
    if GetNumberOfPedPropTextureVariations(PlayerPedId(), 1, lunette1-2) == 0 then
        lunettecolor = {1}  
    end 
    if GetNumberOfPedPropTextureVariations(PlayerPedId(), 2, oreille1-3) == 0 then
        oreillecolor = {1}
    end
    if GetNumberOfPedPropTextureVariations(PlayerPedId(), 6, montre1-2) == 0 then
        montrecolor = {1}
    end
    if GetNumberOfPedPropTextureVariations(PlayerPedId(), 7, bracelet1-2) == 0 then
        braceletcolor = {1}
    end
end

function GetSkinValue()
    TriggerEvent('skinchanger:getSkin', function(skin)
        veste1 = skin.torso_1+1
        vestecolor1 = skin.torso_2+1
        tshirt1 = skin.tshirt_1+1
        tshirtcolor1 = skin.tshirt_2+1
        pantalon1 = skin.pants_1+1
        pantaloncolor1 = skin.pants_2+1
        chaussure1 = skin.shoes_1+1
        chaussurecolor1 = skin.shoes_2+1
        bras1 = skin.arms+1
        calque1 = skin.decals_1+1
        calquecolor1 = skin.decals_2+1
        chaine1 = skin.chain_1+1
        chainecolor1 = skin.chain_2+1
        casque1 = skin.helmet_1+2
        casquecolor1 = skin.helmet_2+1
        lunette1 = skin.glasses_1+1
        lunettecolor1 = skin.glasses_2+1
        oreille1 = skin.ears_1+2
        oreillecolor1 = skin.ears_2+1
        montre1 = skin.watches_1+2
        montrecolor1 = skin.watches_2+1
        bracelet1 = skin.bracelets_1+2
        braceletcolor1 = skin.bracelets_2+1
        sac1 = skin.bags_1+1
        saccolor1 = skin.bags_2+1
        giletparballe1 = skin.bproof_1+1
        giletparballecolor1 = skin.bproof_2+1
    end)
end

function Vetement()  
    local vetement = false
    local mainMenu = RageUI.CreateMenu("Magasin de vêtement", "Menu")
    local subMenu = RageUI.CreateSubMenu(mainMenu, "Créer sa tenue", "Liste des vêtements")
    local subMenu2 = RageUI.CreateSubMenu(mainMenu, "Mon dressing", "Mes tenues")
    local subMenu3 = RageUI.CreateSubMenu(mainMenu, "Achat d'articles", "Liste des catégories")
    local AchatMenu = RageUI.CreateSubMenu(subMenu, "Mon panier", "Mon achat")
    local UnitMenu = RageUI.CreateSubMenu(subMenu3, "Achat unitaire", "Mon article")
    local BuyUnitMenu = RageUI.CreateSubMenu(UnitMenu, "Mon article", "Mon achat")
    mainMenu.Closed = function()
        vetement = false
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
            TriggerEvent('skinchanger:loadSkin', skin)
        end)
        FreezeEntityPosition(GetPlayerPed(-1), false)
        RenderScriptCams(0, 1, 1000, 1, 1)
        DestroyAllCams(true)
    end
    subMenu.Closed = function()
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
    subMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 47, 0), [2] = "Tourner à Gauche"})
    subMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 23, 0), [2] = "Tourner à Droite"}) 
    subMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 82, 0), [2] = "Activer/Désactiver la Caméra"})
    subMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 22, 0), [2] = "Tourner 90°"})
    UnitMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 47, 0), [2] = "Tourner à Gauche"})
    UnitMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 23, 0), [2] = "Tourner à Droite"}) 
    UnitMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 82, 0), [2] = "Activer/Désactiver la Caméra"})
    UnitMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 22, 0), [2] = "Tourner 90°"})
    if not vetement then vetement = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
            while vetement do         
                RageUI.IsVisible(mainMenu, function() 
                    mainMenu:UpdateInstructionalButtons(true)     
                    RageUI.Button("Création de tenue", nil, {RightLabel = "→"}, true, {
                        onSelected = function() 
                            GetSkinValue() 
                            CreateMain() 
                            Wait(100) 
                            FreezeEntityPosition(GetPlayerPed(-1), true) 
                        end
                    }, subMenu)
                    RageUI.Button("Acheter des vêtements", nil, {RightLabel = "→"}, true, {
                        onSelected = function() 
                            GetSkinValue()  
                        end
                    }, subMenu3)
                    RageUI.Button("Mon dressing", nil, {RightLabel = "→"}, true, {}, subMenu2)
                end)
                RageUI.IsVisible(subMenu, function()
                    subMenu:UpdateInstructionalButtons(true)   
                    GetIndex() 
                    Load_Clothes()                                        
                    RageUI.Button("Continuer mon achat", nil, G_Clothes.RightLabel, true, {}, AchatMenu) 
                    if G_Clothes.Clothes.SubActive.Torse then              
                        RageUI.List("Veste", veste, veste1, nil, {}, true, {
                            onListChange = function(Index)
                                veste1 = Index                          
                                TriggerEvent("skinchanger:change", "torso_1", veste1-1)
                                vestecolor1 = 1                         
                                TriggerEvent("skinchanger:change", "torso_2", vestecolor1-1) 
                            end                      
                        })
                        RageUI.List("Style de Veste", vestecolor, vestecolor1, nil, {}, true, {
                            onListChange = function(Index)
                                vestecolor1 = Index
                                TriggerEvent("skinchanger:change", "torso_2", vestecolor1-1)
                            end
                        })
                    end
                    if G_Clothes.Clothes.SubActive.TShirt then
                        RageUI.List("T-Shirt", tshirt, tshirt1, nil, {}, true, {
                            onListChange = function(Index)
                                tshirt1 = Index
                                TriggerEvent("skinchanger:change", "tshirt_1", tshirt1-1)
                                tshirtcolor1 = 1
                                TriggerEvent("skinchanger:change", "tshirt_2", tshirtcolor1-1)
                            end  
                        })
                        RageUI.List("Style de T-Shirt", tshirtcolor, tshirtcolor1, nil, {}, true, {
                            onListChange = function(Index)
                                tshirtcolor1 = Index
                                TriggerEvent("skinchanger:change", "tshirt_2", tshirtcolor1-1)                            
                            end
                        })
                    end
                    if G_Clothes.Clothes.SubActive.Pantalon then
                        RageUI.List("Pantalon", pantalon, pantalon1, nil, {}, true, {
                            onListChange = function(Index)
                                pantalon1 = Index
                                TriggerEvent("skinchanger:change", "pants_1", pantalon1-1)
                                pantaloncolor1 = 1
                                TriggerEvent("skinchanger:change", "pants_2", pantaloncolor1-1)
                            end
                        })
                        RageUI.List("Style de Pantalon", pantaloncolor, pantaloncolor1, nil, {}, true, {
                            onListChange = function(Index)
                                pantaloncolor1 = Index
                                TriggerEvent("skinchanger:change", "pants_2", pantaloncolor1-1)
                            end
                        })
                    end
                    if G_Clothes.Clothes.SubActive.Chaussure then
                        RageUI.List("Chaussure", chaussure, chaussure1, nil, {}, true, {
                            onListChange = function(Index)
                                chaussure1 = Index
                                TriggerEvent("skinchanger:change", "shoes_1", chaussure1-1)
                                chaussurecolor1 = 1
                                TriggerEvent("skinchanger:change", "shoes_2", chaussurecolor1-1)
                            end
                        })
                        RageUI.List("Style de Chaussure", chaussurecolor, chaussurecolor1, nil, {}, true, {
                            onListChange = function(Index)
                                chaussurecolor1 = Index
                                TriggerEvent("skinchanger:change", "shoes_2", chaussurecolor1-1)
                            end
                        })
                    end
                    if G_Clothes.Clothes.SubActive.Bras then
                        RageUI.List("Bras", bras, bras1, nil, {}, true, {
                            onListChange = function(Index)
                                bras1 = Index
                                TriggerEvent("skinchanger:change", "arms", bras1-1)
                            end
                        })
                    end
                    if G_Clothes.Clothes.SubActive.Calque then
                        RageUI.List("Calque", calque, calque1, nil, {}, true, {
                            onListChange = function(Index)
                                calque1 = Index
                                TriggerEvent("skinchanger:change", "decals_1", calque1-1)
                                calquecolor1 = 1
                                TriggerEvent("skinchanger:change", "decals_2", calquecolor1-1)
                            end
                        })
                        RageUI.List("Style de Calque", calquecolor, calquecolor1, nil, {}, true, {
                            onListChange = function(Index)
                                calquecolor1 = Index
                                TriggerEvent("skinchanger:change", "decals_2", calquecolor1-1)
                            end,
                            onSelected = function()
                                ESX.ShowNotification("Cet article n'est pas achetable seul")
                            end
                        })
                    end
                    if G_Clothes.Clothes.SubActive.Chaine then
                        RageUI.List("Chaine", chaine, chaine1, nil, {}, true, {
                            onListChange = function(Index)
                                chaine1 = Index
                                TriggerEvent("skinchanger:change", "chain_1", chaine1-1)
                                chainecolor1 = 1
                                TriggerEvent("skinchanger:change", "chain_2", chainecolor1-1)
                            end
                        })
                        RageUI.List("Style de Chaine", chainecolor, chainecolor1, nil, {}, true, {
                            onListChange = function(Index)
                                chainecolor1 = Index
                                TriggerEvent("skinchanger:change", "chain_2", chainecolor1-1)
                            end
                        })
                    end
                    if G_Clothes.Clothes.SubActive.Casque then
                        RageUI.List("Casque", casque, casque1, nil, {}, true, {
                            onListChange = function(Index)
                                casque1 = Index
                                TriggerEvent("skinchanger:change", "helmet_1", casque1-2)
                                casquecolor1 = 1
                                TriggerEvent("skinchanger:change", "helmet_2", casquecolor1-1)
                            end
                        })
                        RageUI.List("Style de Casque", casquecolor, casquecolor1, nil, {}, true, {
                            onListChange = function(Index)
                                casquecolor1 = Index
                                TriggerEvent("skinchanger:change", "helmet_2", casquecolor1-1)
                            end,
                            onSelected = function()
                                ESX.ShowNotification("Cet article n'est pas achetable seul")
                            end
                        })
                    end
                    if G_Clothes.Clothes.SubActive.Lunette then
                        RageUI.List("Lunette", lunette, lunette1, nil, {}, true, {
                            onListChange = function(Index)
                                lunette1 = Index
                                TriggerEvent("skinchanger:change", "glasses_1", lunette1-1)
                                lunettecolor1 = 1
                                TriggerEvent("skinchanger:change", "glasses_2", lunettecolor1-1)
                            end
                        })
                        RageUI.List("Style de Lunette", lunettecolor, lunettecolor1, nil, {}, true, {
                            onListChange = function(Index)
                                lunettecolor1 = Index
                                TriggerEvent("skinchanger:change", "glasses_2", lunettecolor1-1)
                            end
                        })
                    end
                    if G_Clothes.Clothes.SubActive.Oreille then
                        RageUI.List("Accessoire d'Oreille", oreille, oreille1, nil, {}, true, {
                            onListChange = function(Index)
                                oreille1 = Index
                                TriggerEvent("skinchanger:change", "ears_1", oreille1-2)
                                oreillecolor1 = 1
                                TriggerEvent("skinchanger:change", "ears_2", oreillecolor1-1)
                            end
                        })
                        RageUI.List("Style d'Accessoire d'Oreille", oreillecolor, oreillecolor1, nil, {}, true, {
                            onListChange = function(Index)
                                oreillecolor1 = Index
                                TriggerEvent("skinchanger:change", "ears_2", oreillecolor1-1)
                            end
                        })
                    end
                    if G_Clothes.Clothes.SubActive.Montre then
                        RageUI.List("Montre", montre, montre1, nil, {}, true, {
                            onListChange = function(Index)
                                montre1 = Index
                                TriggerEvent("skinchanger:change", "watches_1", montre1-2)
                                montrecolor1 = 1
                                TriggerEvent("skinchanger:change", "watches_2", montrecolor1-1)
                            end
                        })
                        RageUI.List("Style de Montre", montrecolor, montrecolor1, nil, {}, true, {
                            onListChange = function(Index)
                                montrecolor1 = Index
                                TriggerEvent("skinchanger:change", "watches_2", montrecolor1-1)
                            end
                        })
                    end
                    if G_Clothes.Clothes.SubActive.Bracelet then
                        RageUI.List("Bracelet", bracelet, bracelet1, nil, {}, true, {
                            onListChange = function(Index)
                                bracelet1 = Index
                                TriggerEvent("skinchanger:change", "bracelets_1", bracelet1-2)
                                braceletcolor1 = 1
                                TriggerEvent("skinchanger:change", "bracelets_2", braceletcolor1-1)
                            end
                        })
                        RageUI.List("Style de Bracelet", braceletcolor, braceletcolor1, nil, {}, true, {
                            onListChange = function(Index)
                                braceletcolor1 = Index
                                TriggerEvent("skinchanger:change", "bracelets_2", braceletcolor1-1)
                            end
                        })
                    end
                    if G_Clothes.Clothes.SubActive.Sac then
                        RageUI.List("Sac", sac, sac1, nil, {}, true, {
                            onListChange = function(Index)
                                sac1 = Index
                                TriggerEvent("skinchanger:change", "bags_1", sac1-1)
                                saccolor1 = 1
                                TriggerEvent("skinchanger:change", "bags_2", saccolor1-1)
                            end
                        })
                        RageUI.List("Style de Sac", saccolor, saccolor1, nil, {}, true, {
                            onListChange = function(Index)
                                saccolor1 = Index
                                TriggerEvent("skinchanger:change", "bags_2", saccolor1-1)
                            end
                        })
                    end
                    if G_Clothes.Clothes.SubActive.GiletParBalle then
                        RageUI.List("Gilet par balle", giletparballe, giletparballe1, nil, {}, true, {
                            onListChange = function(Index)
                                giletparballe1 = Index
                                TriggerEvent("skinchanger:change", "bproof_1", giletparballe1-1)
                                giletparballecolor1 = 1
                                TriggerEvent("skinchanger:change", "bproof_2", giletparballecolor1-1)
                            end
                        })
                        RageUI.List("Style de Gilet par balle", giletparballecolor, giletparballecolor1, nil, {}, true, {
                            onListChange = function(Index)
                                giletparballecolor1 = Index
                                TriggerEvent("skinchanger:change", "bproof_2", giletparballecolor1-1)
                            end
                        })
                    end
                end)
                RageUI.IsVisible(subMenu2, function()
                    subMenu2:UpdateInstructionalButtons(true) 
                    ESX.TriggerServerCallback('G_Clothes:getData', function(skin)
                        oArray = skin
                    end)
                    if #oArray == 0 then
                        RageUI.Separator("Vous n'avez pas de tenue enregistrée")
                    end
                    for i = 1, #oArray, 1 do
                        RageUI.List(oArray[i].label, {"Mettre", "Renommer", "Supprimer"}, oIndex, nil, {}, true, {
                            onListChange = function(Index)
                                oIndex = Index
                            end,
                            onSelected = function()
                                clothes = oArray[i].data
                                if oIndex == 1 then   
                                    startAnimAction('missmic4', 'michael_tux_fidget')
                                    Citizen.Wait(4500)
                                    ClearPedTasks(PlayerPedId()) 
                                    TriggerEvent('skinchanger:getSkin', function(skin)
                                        TriggerEvent('skinchanger:loadClothes', skin, json.decode(clothes))
                                        TriggerEvent('skinchanger:getSkin', function(skin)
                                            TriggerServerEvent('esx_skin:save', skin)
                                        end)
                                    end)
                                    RageUI.CloseAll()
                                    vetement = false                                                           
                                elseif oIndex == 2 then 
                                    local newname = KeyboardInput("Choisissez le nouveau nom de votre tenue : "..oArray[i].label.." ", "", 20)
                                    if not newname or newname == "" then
                                        ESX.ShowNotification("Veuillez entrer un nom de tenue valide") 
                                    else
                                        TriggerServerEvent('G_Clothes:Rename', oArray[i].id, newname)
                                    end
                                elseif oIndex == 3 then
                                    TriggerServerEvent('G_Clothes:Delete', oArray[i].id)
                                end
                            end
                        })
                    end
                end)
                RageUI.IsVisible(subMenu3, function()  
                    subMenu3:UpdateInstructionalButtons(true)
                    if G_Clothes.Torse.Active then 
                        RageUI.Button("Veste", nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                _type = "Veste"
                                CreateMain() 
                            end
                        }, UnitMenu)
                    end
                    if G_Clothes.TShirt.Active then
                        RageUI.Button("T-Shirt", nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                _type = "T-Shirt"
                                CreateMain() 
                            end  
                        }, UnitMenu)
                    end
                    if G_Clothes.Pantalon.Active then
                        RageUI.Button("Pantalon", nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                _type = "Pantalon"
                                CreateMain() 
                            end 
                        }, UnitMenu)
                    end
                    if G_Clothes.Chaussure.Active then
                        RageUI.Button("Chaussure", nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                _type = "Chaussure"
                                CreateMain() 
                            end 
                        }, UnitMenu)
                    end
                    if G_Clothes.Chaine.Active then
                        RageUI.Button("Chaine", nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                _type = "Chaine"
                                CreateMain() 
                            end
                        }, UnitMenu)
                    end
                    if G_Clothes.Casque.Active then
                        RageUI.Button("Casque", nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                _type = "Casque"
                                CreateMain() 
                            end
                        }, UnitMenu)
                    end
                    if G_Clothes.Lunette.Active then
                        RageUI.Button("Lunette", nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                _type = "Lunette"
                                CreateMain() 
                            end
                        }, UnitMenu)
                    end
                    if G_Clothes.Oreille.Active then
                        RageUI.Button("Accessoire d'Oreille", nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                _type = "Accessoire d'Oreille"
                                CreateMain() 
                            end
                        }, UnitMenu)
                    end
                    if G_Clothes.Montre.Active then
                        RageUI.Button("Montre", nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                _type = "Montre"
                                CreateMain() 
                            end
                        }, UnitMenu)
                    end
                    if G_Clothes.Bracelet.Active then
                        RageUI.Button("Bracelet", nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                _type = "Bracelet"
                                CreateMain() 
                            end
                        }, UnitMenu)
                    end
                    if G_Clothes.Sac.Active then
                        RageUI.Button("Sac", nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                _type = "Sac"
                                CreateMain() 
                            end
                        }, UnitMenu)
                    end
                    if G_Clothes.GiletParBalle.Active then
                        RageUI.Button("Gilet par balle", nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                _type = "Gilet par balle"
                                CreateMain() 
                            end
                        }, UnitMenu)
                    end
                end)
                RageUI.IsVisible(AchatMenu, function()
                    AchatMenu:UpdateInstructionalButtons(true)   
                    RageUI.Button("Valider mon achat pour ~g~"..G_Clothes.Clothes.Price.."$", nil, {RightBadge = RageUI.BadgeStyle.Tick, Color = {BackgroundColor = {120,255,0,100}}}, true, {
                        onSelected = function()
                            ESX.TriggerServerCallback('G_Clothes:getMoney', function(money)
                                if money then                                                              
                                    local nomtenue = KeyboardInput("Choisissez le nom de votre tenue ", "", 20)
                                    if not nomtenue or nomtenue == "" then     
                                        ESX.ShowNotification("Veuillez entrer un nom de tenue valide")                                 
                                    else                                         
                                        AchatMenu.Closable = false    
                                        startAnimAction('missmic4', 'michael_tux_fidget')
                                        Citizen.Wait(4500)
                                        ClearPedTasks(PlayerPedId())  
                                        TriggerEvent('skinchanger:getSkin', function(skin)
                                            TriggerServerEvent('G_Clothes:Save', nomtenue, skin)
                                            TriggerEvent('skinchanger:loadClothes', skin, skin)
                                            TriggerEvent('skinchanger:getSkin', function(skin)
                                                TriggerServerEvent('esx_skin:save', skin)
                                            end)    
                                            ESX.ShowNotification("Votre tenue à bien était enregistrée")                                                                                                   
                                        end)
                                        RageUI.CloseAll()
                                        vetement = false
                                        FreezeEntityPosition(GetPlayerPed(-1), false)
                                        RenderScriptCams(0, 1, 1000, 1, 1)
                                        DestroyAllCams(true)
                                        AchatMenu.Closable = true                                      
                                    end
                                else
                                    ESX.ShowNotification("Vous n'avez pas assez d'argent")
                                end                    
                            end, G_Clothes.Clothes.Price) 
                        end
                    })
                    RageUI.Button("Annulé mon achat", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            RageUI.GoBack()
                        end
                    })
                end)
                RageUI.IsVisible(UnitMenu, function()  
                    UnitMenu:UpdateInstructionalButtons(true)
                    GetIndex()             
                    Load_Clothes()   
                    if _type == "Veste" then
                        RageUI.List("Veste", veste, veste1, nil, {}, true, {
                            onListChange = function(Index)
                                veste1 = Index                          
                                TriggerEvent("skinchanger:change", "torso_1", veste1-1)
                                vestecolor1 = 1                         
                                TriggerEvent("skinchanger:change", "torso_2", vestecolor1-1) 
                            end                      
                        })
                        RageUI.List("Style de Veste", vestecolor, vestecolor1, nil, {}, true, {
                            onListChange = function(Index)
                                vestecolor1 = Index
                                TriggerEvent("skinchanger:change", "torso_2", vestecolor1-1)
                            end
                        })
                        RageUI.Button("Continuer mon achat", nil, G_Clothes.RightLabel, true, {
                            onActive = function()
                                g = {itemtype = _type, item1 = veste1, item2 = vestecolor1, price = G_Clothes.Torse.Price}    
                            end
                        }, BuyUnitMenu)
                    elseif _type == "T-Shirt" then
                        RageUI.List("T-Shirt", tshirt, tshirt1, nil, {}, true, {
                            onListChange = function(Index)
                                tshirt1 = Index
                                TriggerEvent("skinchanger:change", "tshirt_1", tshirt1-1)
                                tshirtcolor1 = 1
                                TriggerEvent("skinchanger:change", "tshirt_2", tshirtcolor1-1)
                            end  
                        })
                        RageUI.List("Style de T-Shirt", tshirtcolor, tshirtcolor1, nil, {}, true, {
                            onListChange = function(Index)
                                tshirtcolor1 = Index
                                TriggerEvent("skinchanger:change", "tshirt_2", tshirtcolor1-1)                            
                            end
                        })
                        RageUI.Button("Continuer mon achat", nil, G_Clothes.RightLabel, true, {
                            onActive = function()
                                g = {itemtype = _type, item1 = tshirt1, item2 = tshirtcolor1, price = G_Clothes.TShirt.Price}    
                            end
                        }, BuyUnitMenu)
                    elseif _type == "Pantalon" then
                        RageUI.List("Pantalon", pantalon, pantalon1, nil, {}, true, {
                            onListChange = function(Index)
                                pantalon1 = Index
                                TriggerEvent("skinchanger:change", "pants_1", pantalon1-1)
                                pantaloncolor1 = 1
                                TriggerEvent("skinchanger:change", "pants_2", pantaloncolor1-1)
                            end
                        })
                        RageUI.List("Style de Pantalon", pantaloncolor, pantaloncolor1, nil, {}, true, {
                            onListChange = function(Index)
                                pantaloncolor1 = Index
                                TriggerEvent("skinchanger:change", "pants_2", pantaloncolor1-1)
                            end
                        })
                        RageUI.Button("Continuer mon achat", nil, G_Clothes.RightLabel, true, {
                            onActive = function()
                                g = {itemtype = _type, item1 = pantalon1, item2 = pantaloncolor1, price = G_Clothes.Pantalon.Price}    
                            end
                        }, BuyUnitMenu)
                    elseif _type == "Chaussure" then
                        RageUI.List("Chaussure", chaussure, chaussure1, nil, {}, true, {
                            onListChange = function(Index)
                                chaussure1 = Index
                                TriggerEvent("skinchanger:change", "shoes_1", chaussure1-1)
                                chaussurecolor1 = 1
                                TriggerEvent("skinchanger:change", "shoes_2", chaussurecolor1-1)
                            end
                        })
                        RageUI.List("Style de Chaussure", chaussurecolor, chaussurecolor1, nil, {}, true, {
                            onListChange = function(Index)
                                chaussurecolor1 = Index
                                TriggerEvent("skinchanger:change", "shoes_2", chaussurecolor1-1)
                            end
                        })
                        RageUI.Button("Continuer mon achat", nil, G_Clothes.RightLabel, true, {
                            onActive = function()
                                g = {itemtype = _type, item1 = chaussure1, item2 = chaussurecolor1, price = G_Clothes.Chaussure.Price}    
                            end
                        }, BuyUnitMenu)
                    elseif _type == "Chaine" then
                        RageUI.List("Chaine", chaine, chaine1, nil, {}, true, {
                            onListChange = function(Index)
                                chaine1 = Index
                                TriggerEvent("skinchanger:change", "chain_1", chaine1-1)
                                chainecolor1 = 1
                                TriggerEvent("skinchanger:change", "chain_2", chainecolor1-1)
                            end
                        })
                        RageUI.List("Style de Chaine", chainecolor, chainecolor1, nil, {}, true, {
                            onListChange = function(Index)
                                chainecolor1 = Index
                                TriggerEvent("skinchanger:change", "chain_2", chainecolor1-1)
                            end
                        })
                        RageUI.Button("Continuer mon achat", nil, G_Clothes.RightLabel, true, {
                            onActive = function()
                                g = {itemtype = _type, item1 = chaine1, item2 = chainecolor1, price = G_Clothes.Chaine.Price}    
                            end
                        }, BuyUnitMenu)
                    elseif _type == "Casque" then
                        RageUI.List("Casque", casque, casque1, nil, {}, true, {
                            onListChange = function(Index)
                                casque1 = Index
                                TriggerEvent("skinchanger:change", "helmet_1", casque1-2)
                                casquecolor1 = 1
                                TriggerEvent("skinchanger:change", "helmet_2", casquecolor1-1)
                            end
                        })
                        RageUI.List("Style de Casque", casquecolor, casquecolor1, nil, {}, true, {
                            onListChange = function(Index)
                                casquecolor1 = Index
                                TriggerEvent("skinchanger:change", "helmet_2", casquecolor1-1)
                            end,
                            onSelected = function()
                                ESX.ShowNotification("Cet article n'est pas achetable seul")
                            end
                        })
                        RageUI.Button("Continuer mon achat", nil, G_Clothes.RightLabel, true, {
                            onActive = function()
                                g = {itemtype = _type, item1 = casque1, item2 = casquecolor1, price = G_Clothes.Casque.Price}    
                            end
                        }, BuyUnitMenu)
                    elseif _type == "Lunette" then
                        RageUI.List("Lunette", lunette, lunette1, nil, {}, true, {
                            onListChange = function(Index)
                                lunette1 = Index
                                TriggerEvent("skinchanger:change", "glasses_1", lunette1-1)
                                lunettecolor1 = 1
                                TriggerEvent("skinchanger:change", "glasses_2", lunettecolor1-1)
                            end
                        })
                        RageUI.List("Style de Lunette", lunettecolor, lunettecolor1, nil, {}, true, {
                            onListChange = function(Index)
                                lunettecolor1 = Index
                                TriggerEvent("skinchanger:change", "glasses_2", lunettecolor1-1)
                            end
                        })
                        RageUI.Button("Continuer mon achat", nil, G_Clothes.RightLabel, true, {
                            onActive = function()
                                g = {itemtype = _type, item1 = lunette1, item2 = lunettecolor1, price = G_Clothes.Lunette.Price}    
                            end
                        }, BuyUnitMenu)
                    elseif _type == "Accessoire d'Oreille" then
                        RageUI.List("Accessoire d'Oreille", oreille, oreille1, nil, {}, true, {
                            onListChange = function(Index)
                                oreille1 = Index
                                TriggerEvent("skinchanger:change", "ears_1", oreille1-2)
                                oreillecolor1 = 1
                                TriggerEvent("skinchanger:change", "ears_2", oreillecolor1-1)
                            end
                        })
                        RageUI.List("Style d'Accessoire d'Oreille", oreillecolor, oreillecolor1, nil, {}, true, {
                            onListChange = function(Index)
                                oreillecolor1 = Index
                                TriggerEvent("skinchanger:change", "ears_2", oreillecolor1-1)
                            end
                        })
                        RageUI.Button("Continuer mon achat", nil, G_Clothes.RightLabel, true, {
                            onActive = function()
                                g = {itemtype = _type, item1 = oreille1, item2 = oreillecolor1, price = G_Clothes.Oreille.Price}    
                            end
                        }, BuyUnitMenu)
                    elseif _type == "Montre" then
                        RageUI.List("Montre", montre, montre1, nil, {}, true, {
                            onListChange = function(Index)
                                montre1 = Index
                                TriggerEvent("skinchanger:change", "watches_1", montre1-2)
                                montrecolor1 = 1
                                TriggerEvent("skinchanger:change", "watches_2", montrecolor1-1)
                            end
                        })
                        RageUI.List("Style de Montre", montrecolor, montrecolor1, nil, {}, true, {
                            onListChange = function(Index)
                                montrecolor1 = Index
                                TriggerEvent("skinchanger:change", "watches_2", montrecolor1-1)
                            end
                        })
                        RageUI.Button("Continuer mon achat", nil, G_Clothes.RightLabel, true, {
                            onActive = function()
                                g = {itemtype = _type, item1 = montre1, item2 = montrecolor1, price = G_Clothes.Montre.Price}    
                            end
                        }, BuyUnitMenu)
                    elseif _type == "Bracelet" then
                        RageUI.List("Bracelet", bracelet, bracelet1, nil, {}, true, {
                            onListChange = function(Index)
                                bracelet1 = Index
                                TriggerEvent("skinchanger:change", "bracelets_1", bracelet1-2)
                                braceletcolor1 = 1
                                TriggerEvent("skinchanger:change", "bracelets_2", braceletcolor1-1)
                            end
                        })
                        RageUI.List("Style de Bracelet", braceletcolor, braceletcolor1, nil, {}, true, {
                            onListChange = function(Index)
                                braceletcolor1 = Index
                                TriggerEvent("skinchanger:change", "bracelets_2", braceletcolor1-1)
                            end
                        })
                        RageUI.Button("Continuer mon achat", nil, G_Clothes.RightLabel, true, {
                            onActive = function()
                                g = {itemtype = _type, item1 = bracelet1, item2 = braceletcolor1, price = G_Clothes.Bracelet.Price}    
                            end
                        }, BuyUnitMenu)
                    elseif _type == "Sac" then
                        RageUI.List("Sac", sac, sac1, nil, {}, true, {
                            onListChange = function(Index)
                                sac1 = Index
                                TriggerEvent("skinchanger:change", "bags_1", sac1-1)
                                saccolor1 = 1
                                TriggerEvent("skinchanger:change", "bags_2", saccolor1-1)
                            end
                        })
                        RageUI.List("Style de Sac", saccolor, saccolor1, nil, {}, true, {
                            onListChange = function(Index)
                                saccolor1 = Index
                                TriggerEvent("skinchanger:change", "bags_2", saccolor1-1)
                            end
                        })
                        RageUI.Button("Continuer mon achat", nil, G_Clothes.RightLabel, true, {
                            onActive = function()
                                g = {itemtype = _type, item1 = sac1, item2 = saccolor1, price = G_Clothes.Sac.Price}    
                            end
                        }, BuyUnitMenu)
                    elseif _type == "Gilet par balle" then
                        RageUI.List("Gilet par balle", giletparballe, giletparballe1, nil, {}, true, {
                            onListChange = function(Index)
                                giletparballe1 = Index
                                TriggerEvent("skinchanger:change", "bproof_1", giletparballe1-1)
                                giletparballecolor1 = 1
                                TriggerEvent("skinchanger:change", "bproof_2", giletparballecolor1-1)
                            end
                        })
                        RageUI.List("Style de Gilet par balle", giletparballecolor, giletparballecolor1, nil, {}, true, {
                            onListChange = function(Index)
                                giletparballecolor1 = Index
                                TriggerEvent("skinchanger:change", "bproof_2", giletparballecolor1-1)
                            end
                        })
                        RageUI.Button("Continuer mon achat", nil, G_Clothes.RightLabel, true, {
                            onActive = function()
                                g = {itemtype = _type, item1 = giletparballe1, item2 = giletparballecolor1, price = G_Clothes.GiletParBalle.Price}    
                            end
                        }, BuyUnitMenu)
                    end        
                end)
                RageUI.IsVisible(BuyUnitMenu, function()
                    BuyUnitMenu:UpdateInstructionalButtons(true)   
                    RageUI.Separator("Catégorie de l'article : ~b~"..g.itemtype)
                    RageUI.Separator("Numéro de l'article : ~o~N°"..g.item1)
                    RageUI.Separator("Style de l'article : ~p~N°"..g.item2)
                    RageUI.Button("Valider mon achat", nil, {RightBadge = RageUI.BadgeStyle.Tick, Color = {BackgroundColor = {120,255,0,100}}}, true, {
                        onSelected = function()
                            ESX.TriggerServerCallback('G_Clothes:getMoney', function(money)
                                if money then                                                              
                                    TriggerServerEvent("G_Clothes:BuyItem", g.item1, g.item2, g.itemtype, g.itemtype.." N°"..g.item1, g.price)
                                else
                                    ESX.ShowNotification("Vous n'avez pas assez d'argent")
                                end                    
                            end, g.price) 
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
    for _, info in pairs(G_Clothes.Pos.Clothes) do
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, G_Clothes.Blip.Clothes.Sprite)
        SetBlipDisplay(info.blip, G_Clothes.Blip.Clothes.Display)
        SetBlipScale(info.blip, G_Clothes.Blip.Clothes.Scale)
        SetBlipColour(info.blip, G_Clothes.Blip.Clothes.Colour)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(G_Clothes.Blip.Clothes.Title)
        EndTextCommandSetBlipName(info.blip)
	end
end)

Citizen.CreateThread(function()
    while true do
        local wait = 900
        for k,v in pairs(G_Clothes.Pos.Clothes) do
            local coords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(coords.x, coords.y, coords.z, v.x, v.y, v.z)
            if dist <= 1.8 then
                wait = 1
                DrawMarker(G_Clothes.Marker.Type, v.x, v.y, v.z-1.01, 0.0, 0.0, 0.0, G_Clothes.Marker.rotX, G_Clothes.Marker.rotY, G_Clothes.Marker.rotZ, G_Clothes.Marker.scaleX, G_Clothes.Marker.scaleY, G_Clothes.Marker.scaleZ, G_Clothes.Marker.R, G_Clothes.Marker.V, G_Clothes.Marker.B, G_Clothes.Marker.O, false, false, p19, false) 
                if dist <= 1.8 then
                    wait = 1           
                    ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir le ~b~Magasin de Vêtement")
                    if IsControlJustPressed(1,51) then                
                        Vetement()                                   
                    end              
                end
            end
        end
    Citizen.Wait(wait)
    end
end)

function CreateMain()
	local coords = GetEntityCoords(GetPlayerPed(-1))
    cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', coords.x-1.75, coords.y, coords.z, 0.0, 0.0, 0.0, 70.0, true, true)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z)
    RenderScriptCams(1, 1, 1500, 1, 1)
    local hcam = GetEntityHeading(cam)
    SetEntityHeading(GetPlayerPed(-1), hcam+90)
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLength) 
    AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength) 
    blockinput = true 
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Citizen.Wait(0) 
    end 
    if UpdateOnscreenKeyboard() ~= 2 then 
        local result = GetOnscreenKeyboardResult() 
        Citizen.Wait(500) 
        blockinput = false 
        return result 
    else 
        Citizen.Wait(500) 
        blockinput = false 
        return nil 
    end 
end

function Load_Clothes()
    EnableControlAction(0, 82, true)  
    EnableControlAction(0, 47, true)                  
    if IsControlJustPressed(0, 22) then
        local back2 = GetEntityHeading(GetPlayerPed(-1))
        SetEntityHeading(GetPlayerPed(-1), back2+90)      
    end
    if IsControlJustPressed(0, 82) then
        pressed = not pressed
        if pressed then
            RenderScriptCams(0, 1, 1000, 1, 1)
            DestroyAllCams(true)
        else
            CreateMain()
        end
    end
    if IsDisabledControlPressed(0, 23) then
        SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())-1.5)
    elseif IsDisabledControlPressed(0, 47) then
        SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())+1.5)
    end
end

function startAnimAction(lib, anim)
	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, 1.0, -1, 49, 0, false, false, false)
		RemoveAnimDict(lib)
	end)
end
