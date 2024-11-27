ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(5000)
	end
end)

local CurrentTest = nil
local CurrentCheckPoint = 0
local DriveErrors = 0
local LastCheckPoint = -1
local CurrentBlip = nil
local CurrentZoneType = nil
local IsAboveSpeedLimit = false
local VehicleHealth = nil
local success = false
local startedconduite = false
local CurrentTestType = nil
local permisencours = ""
local Licenses = {}

RegisterNetEvent('G_DrivingSchool:loadLicenses')
AddEventHandler('G_DrivingSchool:loadLicenses', function(licenses)
	Licenses = licenses
end)

function DriveErrorsS()
    return DriveErrors
end

function AutoEcole()
    local ownedLicenses = {}
    for i=1, #Licenses, 1 do
		ownedLicenses[Licenses[i].type] = true
	end
    local autoecole = false
    local mainMenu = RageUI.CreateMenu("Auto École", "MENU")
    local subMenu = RageUI.CreateSubMenu(mainMenu, "Examen - Code", "MENU")
    local subMenu2 = RageUI.CreateSubMenu(mainMenu, "Examen - Conduite", "MENU")
    local questMenu = RageUI.CreateSubMenu(subMenu, "Code - Question N°1", "MENU")
    local questMenu2 = RageUI.CreateSubMenu(subMenu, "Code - Question N°2", "MENU")
    local questMenu3 = RageUI.CreateSubMenu(subMenu, "Code - Question N°3", "MENU")
    local questMenu4 = RageUI.CreateSubMenu(subMenu, "Code - Question N°4", "MENU")
    local questMenu5 = RageUI.CreateSubMenu(subMenu, "Code - Question N°5", "MENU")
    local questMenu6 = RageUI.CreateSubMenu(subMenu, "Code - Question N°6", "MENU")
    local questMenu7 = RageUI.CreateSubMenu(subMenu, "Code - Question N°7", "MENU")
    local questMenu8 = RageUI.CreateSubMenu(subMenu, "Code - Question N°8", "MENU")
    local questMenu9 = RageUI.CreateSubMenu(subMenu, "Code - Question N°9", "MENU")
    local questMenu10 = RageUI.CreateSubMenu(subMenu, "Code - Question N°10", "MENU")
    local v_code,total,validation = true,0,false
    local d_quest,d_quest2,d_quest3,d_quest4,d_quest5,d_quest6,d_quest7,d_quest8,d_quest9,d_quest10 = "","","","","","","","","",""
    local p_quest,p_quest2,p_quest3,p_quest4,p_quest5,p_quest6,p_quest7,p_quest8,p_quest9,p_quest10 = "~r~","~r~","~r~","~r~","~r~","~r~","~r~","~r~","~r~","~r~"
    local v_quest,v_quest2,v_quest3,v_quest4,v_quest5,v_quest6,v_quest7,v_quest8,v_quest9,v_quest10,v_questfinal = true,false,false,false,false,false,false,false,false,false,false
    mainMenu.Closed = function() autoecole = false end
    if not autoecole then autoecole = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
		    while autoecole do               
                RageUI.IsVisible(mainMenu,function()
                    if not ownedLicenses['dmv'] then
                        RageUI.Button("Passer votre code", nil, {RightLabel = "~g~500$~s~ →"}, true, {
                            onSelected = function()
                                ESX.TriggerServerCallback("G_DrivingSchool:getMoney", function(result) 
                                    if result then
                                        ESX.ShowNotification("Vous venez de payer ~g~500$~s~ pour passer votre code")             
                                    else
                                        ESX.ShowNotification("Vous n'avez pas assez d'argent")
                                    end
                                end, 500)
                            end
                        }, subMenu)
                    else
                        RageUI.Button("Passer votre code", "Vous avez déjà votre code", {}, false, {}, subMenu)
                    end
                    RageUI.Button("Examen de conduite", nil, {RightLabel = "→"}, true, {}, subMenu2)
                end)
                RageUI.IsVisible(subMenu,function()
                    if v_code then
                        RageUI.Button("Question N°1", "Réponsé Sélectionnée : ~b~"..d_quest, {RightLabel = "→"}, v_quest, {}, questMenu)
                        RageUI.Button("Question N°2", "Réponsé Sélectionnée : ~b~"..d_quest2, {RightLabel = "→"}, v_quest2, {}, questMenu2)
                        RageUI.Button("Question N°3", "Réponsé Sélectionnée : ~b~"..d_quest3, {RightLabel = "→"}, v_quest3, {}, questMenu3)
                        RageUI.Button("Question N°4", "Réponsé Sélectionnée : ~b~"..d_quest4, {RightLabel = "→"}, v_quest4, {}, questMenu4)
                        RageUI.Button("Question N°5", "Réponsé Sélectionnée : ~b~"..d_quest5, {RightLabel = "→"}, v_quest5, {}, questMenu5)
                        RageUI.Button("Question N°6", "Réponsé Sélectionnée : ~b~"..d_quest6, {RightLabel = "→"}, v_quest6, {}, questMenu6)
                        RageUI.Button("Question N°7", "Réponsé Sélectionnée : ~b~"..d_quest7, {RightLabel = "→"}, v_quest7, {}, questMenu7)
                        RageUI.Button("Question N°8", "Réponsé Sélectionnée : ~b~"..d_quest8, {RightLabel = "→"}, v_quest8, {}, questMenu8)
                        RageUI.Button("Question N°9", "Réponsé Sélectionnée : ~b~"..d_quest9, {RightLabel = "→"}, v_quest9, {}, questMenu9)
                        RageUI.Button("Question N°10", "Réponsé Sélectionnée : ~b~"..d_quest10, {RightLabel = "→"}, v_quest10, {}, questMenu10)
                        RageUI.Button("Valider", nil, {RightLabel = "→", Color = {BackgroundColor = {0,140,0,160}}}, v_questfinal, {
                            onSelected = function()
                                v_code = false
                            end
                        })
                    else
                        RageUI.Separator("Votre score est de ~g~"..total.."~s~/~b~10")
                        if total >= G_DrivingSchool.MinimundeBonneReponse then 
                            RageUI.Separator("Félicitation, vous avez obtenu votre code")
                        else
                            RageUI.Separator("Dommage, il faudra le repasser une autre fois")
                        end
                        --RageUI.Button("1. Votre réponse : "..p_quest..""..d_quest, nil, {RightLabel = ""}, true, {})
                        --RageUI.Button("2. Votre réponse : "..p_quest2..""..d_quest2, nil, {RightLabel = ""}, true, {})
                        --RageUI.Button("3. Votre réponse : "..p_quest3..""..d_quest3, nil, {RightLabel = ""}, true, {})
                        --RageUI.Button("4. Votre réponse : "..p_quest4..""..d_quest4, nil, {RightLabel = ""}, true, {})
                        --RageUI.Button("5. Votre réponse : "..p_quest5..""..d_quest5, nil, {RightLabel = ""}, true, {})
                        --RageUI.Button("6. Votre réponse : "..p_quest6..""..d_quest6, nil, {RightLabel = ""}, true, {})
                        --RageUI.Button("7. Votre réponse : "..p_quest7..""..d_quest7, nil, {RightLabel = ""}, true, {})
                        --RageUI.Button("8. Votre réponse : "..p_quest8..""..d_quest8, nil, {RightLabel = ""}, true, {})
                        --RageUI.Button("9. Votre réponse : "..p_quest9..""..d_quest9, nil, {RightLabel = ""}, true, {})
                        --RageUI.Button("10. Votre réponse : "..p_quest10..""..d_quest10, nil, {RightLabel = ""}, true, {})
                        RageUI.Button("Valider", nil, {RightLabel = "→", Color = {BackgroundColor = {0,140,0,160}}}, v_questfinal, {
                            onSelected = function()
                                if total >= G_DrivingSchool.MinimundeBonneReponse then
                                    TriggerServerEvent('G_DrivingSchool:addLicense', 'dmv')
                                    ESX.ShowNotification("Vous venez de récupérer votre license de code")
                                end
                                v_code,total,validation = true,0,false
                                d_quest,d_quest2,d_quest3,d_quest4,d_quest5,d_quest6,d_quest7,d_quest8,d_quest9,d_quest10 = "","","","","","","","","",""
                                p_quest,p_quest2,p_quest3,p_quest4,p_quest5,p_quest6,p_quest7,p_quest8,p_quest9,p_quest10 = "~r~","~r~","~r~","~r~","~r~","~r~","~r~","~r~","~r~","~r~"
                                v_quest,v_quest2,v_quest3,v_quest4,v_quest5,v_quest6,v_quest7,v_quest8,v_quest9,v_quest10,v_questfinal = true,false,false,false,false,false,false,false,false,false,false
                                r_quest1_a,r_quest1_b,r_quest1_c,r_quest1_d = false,false,false,false
                                r_quest2_a,r_quest2_b,r_quest2_c,r_quest2_d = false,false,false,false
                                r_quest3_a,r_quest3_b,r_quest3_c,r_quest3_d = false,false,false,false
                                r_quest4_a,r_quest4_b,r_quest4_c,r_quest4_d = false,false,false,false
                                r_quest5_a,r_quest5_b,r_quest5_c,r_quest5_d = false,false,false,false
                                r_quest6_a,r_quest6_b,r_quest6_c,r_quest6_d = false,false,false,false
                                r_quest7_a,r_quest7_b,r_quest7_c,r_quest7_d = false,false,false,false
                                r_quest8_a,r_quest8_b,r_quest8_c,r_quest8_d = false,false,false,false
                                r_quest9_a,r_quest9_b,r_quest9_c,r_quest9_d = false,false,false,false
                                r_quest10_a,r_quest10_b,r_quest10_c,r_quest10_d = false,false,false,false
                                RageUI.CloseAll()
                                autoecole = false
                            end
                        })
                    end
                end)
                RageUI.IsVisible(questMenu,function() -- D
                    questMenu.Closable = false
                    RageUI.Separator("Avant chaque changement de file vous devez :")
                    RageUI.Checkbox("A. Vérifiez vos rétroviseurs", nil, r_quest1_a, {}, {
                        onChecked = function(index, items) d_quest = "A" r_quest1_a = true end, 
                        onUnChecked = function(index, items) r_quest1_a = false end
                    })   
                    RageUI.Checkbox("B. Vérifiez vos angles morts", nil, r_quest1_b, {}, {
                        onChecked = function(index, items) d_quest = "B" r_quest1_b = true end, 
                        onUnChecked = function(index, items) r_quest1_b = false end
                    })
                    RageUI.Checkbox("C. Signalez vos intentions", nil, r_quest1_c, {}, {
                        onChecked = function(index, items) d_quest = "C" r_quest1_c = true end, 
                        onUnChecked = function(index, items) r_quest1_c = false end
                    })
                    RageUI.Checkbox("D. Tout cela", nil, r_quest1_d, {}, {
                        onChecked = function(index, items) d_quest = "D" p_quest = "~g~" total = total + 1 r_quest1_d = true end, 
                        onUnChecked = function(index, items) r_quest1_d = false total = total - 1 end
                    }) 
                    RageUI.Button("Valider", false, {RightLabel = "→", Color = {BackgroundColor = {0,140,0,160}}}, true, {
                        onSelected = function()
                            questMenu.Closable = true
                            v_quest = false
                            v_quest2 = true
                            RageUI.GoBack()
                        end
                    })
                end)
                RageUI.IsVisible(questMenu2,function() -- A
                    questMenu2.Closable = false
                    RageUI.Separator("La vitesse dans une zone résidentielle est de :")
                    RageUI.Checkbox("A. 50 km/h", nil, r_quest2_a, {}, {
                        onChecked = function(index, items) d_quest2 = "A" p_quest2 = "~g~" total = total + 1 r_quest2_a = true end, 
                        onUnChecked = function(index, items) r_quest2_a = false total = total - 1 end
                    })   
                    RageUI.Checkbox("B. 55 km/h", nil, r_quest2_b, {}, {
                        onChecked = function(index, items) d_quest2 = "B" r_quest2_b = true end, 
                        onUnChecked = function(index, items) r_quest2_b = false end
                    })
                    RageUI.Checkbox("C. 65 km/h", nil, r_quest2_c, {}, {
                        onChecked = function(index, items) d_quest2 = "C" r_quest2_c = true end, 
                        onUnChecked = function(index, items) r_quest2_c = false end
                    })
                    RageUI.Checkbox("D. 70 km/h", nil, r_quest2_d, {}, {
                        onChecked = function(index, items) d_quest2 = "D" r_quest2_d = true end, 
                        onUnChecked = function(index, items) r_quest2_d = false end
                    })
                    RageUI.Button("Valider", false, {RightLabel = "→", Color = {BackgroundColor = {0,140,0,160}}}, true, {
                        onSelected = function()
                            questMenu2.Closable = true
                            v_quest2 = false
                            v_quest3 = true
                            RageUI.GoBack()
                        end
                    })
                end)
                RageUI.IsVisible(questMenu3,function() -- C
                    questMenu3.Closable = false
                    RageUI.Separator("Vous vous apprétez à tourner à droite au feu vert,")
                    RageUI.Separator("mais vous voyez un piéton qui traverse :")
                    RageUI.Checkbox("A. Vous passez avant le piéton", nil, r_quest3_a, {}, {
                        onChecked = function(index, items) d_quest3 = "A" r_quest3_a = true end, 
                        onUnChecked = function(index, items) r_quest3_a = false end
                    })   
                    RageUI.Checkbox("B. Vous contournez le piéton pour passer", nil, r_quest3_b, {}, {
                        onChecked = function(index, items) d_quest3 = "B" r_quest3_b = true end, 
                        onUnChecked = function(index, items) r_quest3_b = false end
                    })
                    RageUI.Checkbox("C. Vous attendez que le piéton est terminé", nil, r_quest3_c, {}, {
                        onChecked = function(index, items) d_quest3 = "C" p_quest3 = "~g~" total = total + 1 r_quest3_c = true end, 
                        onUnChecked = function(index, items) r_quest3_c = false total = total - 1 end
                    })
                    RageUI.Checkbox("D. Vous shoutez le piéton pour passer", nil, r_quest3_d, {}, {
                        onChecked = function(index, items) d_quest3 = "D" r_quest3_d = true end, 
                        onUnChecked = function(index, items) r_quest3_d = false end
                    })
                    RageUI.Button("Valider", false, {RightLabel = "→", Color = {BackgroundColor = {0,140,0,160}}}, true, {
                        onSelected = function()
                            questMenu3.Closable = true
                            v_quest3 = false
                            v_quest4 = true
                            RageUI.GoBack()
                        end
                    })
                end)
                RageUI.IsVisible(questMenu4,function() -- C
                    questMenu4.Closable = false
                    RageUI.Separator("Vous conduissez à 80km/h, vous approchez")
                    RageUI.Separator("lieu de résidence cela veut dire que :")
                    RageUI.Checkbox("A. Vous devez accélérer", nil, r_quest4_a, {}, {
                        onChecked = function(index, items) d_quest4 = "A" r_quest4_a = true end, 
                        onUnChecked = function(index, items) r_quest4_a = false end
                    })   
                    RageUI.Checkbox("B. Vous pouvez garder votre vitesse", nil, r_quest4_b, {}, {
                        onChecked = function(index, items) d_quest4 = "B" r_quest4_b = true end, 
                        onUnChecked = function(index, items) r_quest4_b = false end
                    })
                    RageUI.Checkbox("C. Vous devez ralentir", nil, r_quest4_c, {}, {
                        onChecked = function(index, items) d_quest4 = "C" p_quest4 = "~g~" total = total + 1 r_quest4_c = true end, 
                        onUnChecked = function(index, items) r_quest4_c = false total = total - 1 end
                    })
                    RageUI.Checkbox("D. Vous pouvez garder votre vitesse", nil, r_quest4_d, {}, {
                        onChecked = function(index, items) d_quest4 = "D" r_quest4_d = true end, 
                        onUnChecked = function(index, items) r_quest4_d = false end
                    })
                    RageUI.Button("Valider", false, {RightLabel = "→", Color = {BackgroundColor = {0,140,0,160}}}, true, {
                        onSelected = function()
                            questMenu4.Closable = true
                            v_quest4 = false
                            v_quest5 = true
                            RageUI.GoBack()
                        end
                    })
                end)
                RageUI.IsVisible(questMenu5,function() -- C
                    questMenu5.Closable = false
                    RageUI.Separator("Quel taux d'alcoolémie est classé comme")
                    RageUI.Separator("conduite en état d'ébriété ? :")
                    RageUI.Checkbox("A. 0.05%", nil, r_quest5_a, {}, {
                        onChecked = function(index, items) d_quest5 = "A" r_quest5_a = true end, 
                        onUnChecked = function(index, items) r_quest5_a = false end
                    })   
                    RageUI.Checkbox("B. 0.18%", nil, r_quest5_b, {}, {
                        onChecked = function(index, items) d_quest5 = "B" r_quest5_b = true end, 
                        onUnChecked = function(index, items) r_quest5_b = false end
                    })
                    RageUI.Checkbox("C. 0.08%", nil, r_quest5_c, {}, {
                        onChecked = function(index, items) d_quest5 = "C" p_quest5 = "~g~" total = total + 1 r_quest5_c = true end, 
                        onUnChecked = function(index, items) r_quest5_c = false total = total - 1 end
                    })
                    RageUI.Checkbox("D. 0.06%", nil, r_quest5_d, {}, {
                        onChecked = function(index, items) d_quest5 = "D" r_quest5_d = true end, 
                        onUnChecked = function(index, items) r_quest5_d = false end
                    })
                    RageUI.Button("Valider", false, {RightLabel = "→", Color = {BackgroundColor = {0,140,0,160}}}, true, {
                        onSelected = function()
                            questMenu5.Closable = true
                            v_quest5 = false
                            v_quest6 = true
                            RageUI.GoBack()
                        end
                    })
                end)
                RageUI.IsVisible(questMenu6,function() -- D
                    questMenu6.Closable = false
                    RageUI.Separator("Vous pouvez passer aux feux quand il ?")
                    RageUI.Checkbox("A. est Vert", nil, r_quest6_a, {}, {
                        onChecked = function(index, items) d_quest6 = "A" r_quest6_a = true end, 
                        onUnChecked = function(index, items) r_quest6_a = false end
                    })   
                    RageUI.Checkbox("B. n'y a personne sur l'intersection", nil, r_quest6_b, {}, {
                        onChecked = function(index, items) d_quest6 = "B" r_quest6_b = true end, 
                        onUnChecked = function(index, items) r_quest6_b = false end
                    })
                    RageUI.Checkbox("C. est positionné sur un croisement", nil, r_quest6_c, {}, {
                        onChecked = function(index, items) d_quest6 = "C" r_quest6_c = true end, 
                        onUnChecked = function(index, items) r_quest6_c = false end
                    })
                    RageUI.Checkbox("D. est vert/rouge et que vous tournez à droite", nil, r_quest6_d, {}, {
                        onChecked = function(index, items) d_quest6 = "D" p_quest6 = "~g~" total = total + 1  r_quest6_d = true end, 
                        onUnChecked = function(index, items) r_quest6_d = false total = total - 1 end
                    })
                    RageUI.Button("Valider", false, {RightLabel = "→", Color = {BackgroundColor = {0,140,0,160}}}, true, {
                        onSelected = function()
                            questMenu6.Closable = true
                            v_quest6 = false
                            v_quest7 = true
                            RageUI.GoBack()
                        end
                    })
                end)
                RageUI.IsVisible(questMenu7,function() -- D
                    questMenu7.Closable = false
                    RageUI.Separator("Un piéton est au feu rouge pour les piétons")
                    RageUI.Checkbox("A. Vous le laissez passer", nil, r_quest7_a, {}, {
                        onChecked = function(index, items) d_quest7 = "A" r_quest7_a = true end, 
                        onUnChecked = function(index, items) r_quest7_a = false end
                    })   
                    RageUI.Checkbox("B. Vous observez avant de continuer", nil, r_quest7_b, {}, {
                        onChecked = function(index, items) d_quest7 = "B" r_quest7_b = true end, 
                        onUnChecked = function(index, items) r_quest7_b = false end
                    })
                    RageUI.Checkbox("C. Vous lui faite un signe de la main", nil, r_quest7_c, {}, {
                        onChecked = function(index, items) d_quest7 = "C" r_quest7_c = true end, 
                        onUnChecked = function(index, items) r_quest7_c = false end
                    })
                    RageUI.Checkbox("D. Vous continuez car votre feu est vert", nil, r_quest7_d, {}, {
                        onChecked = function(index, items) d_quest7 = "D" p_quest7 = "~g~" total = total + 1 r_quest7_d = true end, 
                        onUnChecked = function(index, items) r_quest7_d = false total = total - 1 end
                    })
                    RageUI.Button("Valider", false, {RightLabel = "→", Color = {BackgroundColor = {0,140,0,160}}}, true, {
                        onSelected = function()
                            questMenu7.Closable = true
                            v_quest7 = false
                            v_quest8 = true
                            RageUI.GoBack()
                        end
                    })
                end)
                RageUI.IsVisible(questMenu8,function() -- D
                    questMenu8.Closable = false
                    RageUI.Separator("Qu'est ce qui est permit quand vous dépassez")
                    RageUI.Separator("un autre véhicule")
                    RageUI.Checkbox("A. Le suivre de près pour le doubler plus vite", nil, r_quest8_a, {}, {
                        onChecked = function(index, items) d_quest8 = "A" r_quest8_a = true end, 
                        onUnChecked = function(index, items) r_quest8_a = false end
                    })   
                    RageUI.Checkbox("B. Le doubler en quittant la route", nil, r_quest8_b, {}, {
                        onChecked = function(index, items) d_quest8 = "B" r_quest8_b = true end, 
                        onUnChecked = function(index, items) r_quest8_b = false end
                    })
                    RageUI.Checkbox("C. Conduire sur la route opposé", nil, r_quest8_c, {}, {
                        onChecked = function(index, items) d_quest8 = "C" r_quest8_c = true end, 
                        onUnChecked = function(index, items) r_quest8_c = false end
                    })
                    RageUI.Checkbox("D. Dépasser la vitesse limite", nil, r_quest8_d, {}, {
                        onChecked = function(index, items) d_quest8 = "D" p_quest8 = "~g~" total = total + 1 r_quest8_d = true end, 
                        onUnChecked = function(index, items) r_quest8_d = false total = total - 1 end
                    })
                    RageUI.Button("Valider", false, {RightLabel = "→", Color = {BackgroundColor = {0,140,0,160}}}, true, {
                        onSelected = function()
                            questMenu8.Closable = true
                            v_quest8 = false
                            v_quest9 = true
                            RageUI.GoBack()
                        end
                    })
                end)
                RageUI.IsVisible(questMenu9,function() -- D
                    questMenu9.Closable = false
                    RageUI.Separator("La vitesse maximum indiqué est de 110 km/h")
                    RageUI.Separator("La plupart du traffic roule à 120 km/h")
                    RageUI.Separator("alors vous ne devriez pas conduire plus vite que :")
                    RageUI.Checkbox("A. 80 km/h", nil, r_quest9_a, {}, {
                        onChecked = function(index, items) d_quest9 = "A" r_quest9_a = true end, 
                        onUnChecked = function(index, items) r_quest9_a = false end
                    })   
                    RageUI.Checkbox("B. 40 km/h", nil, r_quest9_b, {}, {
                        onChecked = function(index, items) d_quest9 = "B" r_quest9_b = true end, 
                        onUnChecked = function(index, items) r_quest9_b = false end
                    })
                    RageUI.Checkbox("C. 50 km/h", nil, r_quest9_c, {}, {
                        onChecked = function(index, items) d_quest9 = "C" r_quest9_c = true end, 
                        onUnChecked = function(index, items) r_quest9_c = false end
                    })
                    RageUI.Checkbox("D. 110 km/h", nil, r_quest9_d, {}, {
                        onChecked = function(index, items) d_quest9 = "D" p_quest9 = "~g~" total = total + 1 r_quest9_d = true end, 
                        onUnChecked = function(index, items) r_quest9_d = false total = total - 1 end
                    })
                    RageUI.Button("Valider", false, {RightLabel = "→", Color = {BackgroundColor = {0,140,0,160}}}, true, {
                        onSelected = function()
                            questMenu9.Closable = true
                            v_quest9 = false
                            v_quest10 = true
                            RageUI.GoBack()
                        end
                    })
                end)
                RageUI.IsVisible(questMenu10,function() -- D
                    questMenu10.Closable = false
                    RageUI.Separator("Quand vous êtes dépassé par un autre véhicule")
                    RageUI.Separator("il est important de ne pas :")
                    RageUI.Checkbox("A. Ralentir", nil, r_quest10_a, {}, {
                        onChecked = function(index, items) d_quest10 = "A" r_quest10_a = true end, 
                        onUnChecked = function(index, items) r_quest10_a = false end
                    })   
                    RageUI.Checkbox("B. Vérifiez vos rétroviseurs", nil, r_quest10_b, {}, {
                        onChecked = function(index, items) d_quest10 = "B" r_quest10_b = true end, 
                        onUnChecked = function(index, items) r_quest10_b = false end
                    })
                    RageUI.Checkbox("C. Regarder les autres conducteurs", nil, r_quest10_c, {}, {
                        onChecked = function(index, items) d_quest10 = "C" r_quest10_c = true end, 
                        onUnChecked = function(index, items) r_quest10_c = false end
                    })
                    RageUI.Checkbox("D. Augmenter votre vitesse", nil, r_quest10_d, {}, {
                        onChecked = function(index, items) d_quest10 = "D" p_quest10 = "~g~" total = total + 1 r_quest10_d = true end, 
                        onUnChecked = function(index, items) r_quest10_d = false total = total - 1 end
                    })
                    RageUI.Button("Valider", false, {RightLabel = "→", Color = {BackgroundColor = {0,140,0,160}}}, true, {
                        onSelected = function()
                            questMenu10.Closable = true
                            v_quest10 = false
                            v_questfinal = true
                            RageUI.GoBack()
                        end
                    })
                end)
                RageUI.IsVisible(subMenu2,function()
                    if ownedLicenses['dmv'] then
                        if not ownedLicenses['drive'] then    
                            RageUI.Button("Examen - Voiture", nil, {RightLabel = "~g~1000$ ~s~→"}, true, {
                                onSelected = function()
                                    ESX.TriggerServerCallback("G_DrivingSchool:getMoney", function(result) 
                                        if result then                                   
                                            ESX.ShowNotification("Vous venez de payer ~g~1000$~s~ pour passer votre permis voiture") 
                                            StartDriveTest()
                                        else
                                            ESX.ShowNotification("Vous n'avez pas assez d'argent")
                                        end
                                    end, 1000)
                                end
                            })
                        else
                            RageUI.Button("Examen - Voiture", "Vous avez déjà le permis voiture", {}, false, {})
                        end
                        if not ownedLicenses['drive_bike'] then
                            RageUI.Button("Examen - Moto", nil, {RightLabel = "~g~1500$ ~s~→"}, true, {
                                onSelected = function()
                                    ESX.TriggerServerCallback("G_DrivingSchool:getMoney", function(result) 
                                        if result then
                                            ESX.ShowNotification("Vous venez de payer ~g~1500$~s~ pour passer votre permis moto") 
                                            StartDriveTestMoto()
                                        else
                                            ESX.ShowNotification("Vous n'avez pas assez d'argent")
                                        end
                                    end, 1500)
                                end
                            })
                        else
                            RageUI.Button("Examen - Moto", "Vous avez déjà le permis moto", {}, false, {})
                        end
                        if not ownedLicenses['drive_truck'] then
                            RageUI.Button("Examen - Camion", nil, {RightLabel = "~g~2000$ ~s~→"}, true, {
                                onSelected = function()
                                    ESX.TriggerServerCallback("G_DrivingSchool:getMoney", function(result) 
                                        if result then
                                            ESX.ShowNotification("Vous venez de payer ~g~2000$~s~ pour passer votre camion") 
                                            StartDriveTestCamion()
                                        else
                                            ESX.ShowNotification("Vous n'avez pas assez d'argent")
                                        end
                                    end, 2000)
                                end
                            })
                        else
                            RageUI.Button("Examen - Camion", "Vous avez déjà le permis camion", {}, false, {})
                        end
                    else
                        RageUI.Separator("Vous devez avoir votre code avant cela")
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
        for k,v in pairs(G_DrivingSchool.AutoEcole.Coords) do
            local coords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(coords.x, coords.y, coords.z, v.x, v.y, v.z)
            if dist <= v.dist then 
                wait = 0
                DrawMarker(6, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 0, 0, 255, false, false, p19, false) 
                if dist <= v.dist then 
                    wait = 0 
                    ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir le ~b~Menu ~s~-~b~ Auto École")
                    if IsControlJustPressed(1,51) then 
                        TriggerServerEvent("G_DrivingSchool:reload")
                        Wait(300)            
                        AutoEcole()
                    end
                end
            end
        end
    Citizen.Wait(wait)
    end
end)

function StopDriveTest(success)
	if success then
		TriggerServerEvent('G_DrivingSchool:addLicense', permisencours)
		RemoveBlip(CurrentBlip)
		ESX.ShowAdvancedNotification("Moniteur", '~g~Félicitation', 'Vous avez reçu votre permis', 'CHAR_JOSH')
		if DoesEntityExist(GetVehiclePedIsIn(PlayerPedId(), false)) then
			DeleteEntity(GetVehiclePedIsIn(PlayerPedId(), false))
			SetVehicleAsNoLongerNeeded(GetVehiclePedIsIn(PlayerPedId(), false))
		end
		if DoesEntityExist(pedssss) then
			DeleteEntity(pedssss)
		end
	else
		if DoesEntityExist(pedssss) then
			DeleteEntity(pedssss)
		end
		ESX.ShowAdvancedNotification("Moniteur", '~r~Malheureusement', 'Vous avez raté votre permis', 'CHAR_JOSH')			
		if DoesEntityExist(GetVehiclePedIsIn(PlayerPedId(), false)) then
			DeleteEntity(GetVehiclePedIsIn(PlayerPedId(), false))
			SetVehicleAsNoLongerNeeded(GetVehiclePedIsIn(PlayerPedId(), false))
		end
	end
	SetEntityCoords(pietonped, 394.12, -111.84, 65.23, false, false, false, true)
	SetEntityHeading(pietonped, 234.62)
	CurrentTest = nil
end

function StartConduite()
	startedconduite = true
	while startedconduite do
		Wait(0)
		if CurrentTest == 'drive' then
			local nextCheckPoint = CurrentCheckPoint + 1
			if G_DrivingSchool.AutoEcole.CheckPoints[nextCheckPoint] == nil then
				if DoesBlipExist(CurrentBlip) then
					RemoveBlip(CurrentBlip)
				end
				CurrentTest = nil
				while not IsPedheadshotReady(RegisterPedheadshot(PlayerPedId())) or not IsPedheadshotValid(RegisterPedheadshot(PlayerPedId())) do
					Wait(100)
				end
				BeginTextCommandThefeedPost("PS_UPDATE")
				AddTextComponentInteger(50)
				EndTextCommandThefeedPostStats("PSF_DRIVING", 14, 50, 25, false, GetPedheadshotTxdString(RegisterPedheadshot(PlayerPedId())), GetPedheadshotTxdString(RegisterPedheadshot(PlayerPedId())))			
				EndTextCommandThefeedPostTicker(false, true)			
				UnregisterPedheadshot(RegisterPedheadshot(PlayerPedId()))
			else
				if CurrentCheckPoint ~= LastCheckPoint then
					if DoesBlipExist(CurrentBlip) then
						RemoveBlip(CurrentBlip)
					end
					CurrentBlip = AddBlipForCoord(G_DrivingSchool.AutoEcole.CheckPoints[nextCheckPoint].Pos.x, G_DrivingSchool.AutoEcole.CheckPoints[nextCheckPoint].Pos.y, G_DrivingSchool.AutoEcole.CheckPoints[nextCheckPoint].Pos.z)
					SetBlipRoute(CurrentBlip, 1)
					LastCheckPoint = CurrentCheckPoint
				end
				local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), G_DrivingSchool.AutoEcole.CheckPoints[nextCheckPoint].Pos.x, G_DrivingSchool.AutoEcole.CheckPoints[nextCheckPoint].Pos.y, G_DrivingSchool.AutoEcole.CheckPoints[nextCheckPoint].Pos.z, true)
				if distance <= 90.0 then
					DrawMarker(36, G_DrivingSchool.AutoEcole.CheckPoints[nextCheckPoint].Pos.x, G_DrivingSchool.AutoEcole.CheckPoints[nextCheckPoint].Pos.y, G_DrivingSchool.AutoEcole.CheckPoints[nextCheckPoint].Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 204, 102, 100, false, true, 2, false, false, false, false)
				end
				if distance <= 3.0 then
					G_DrivingSchool.AutoEcole.CheckPoints[nextCheckPoint].Action(PlayerPedId(), SetZoneTypeVille)
					CurrentCheckPoint = CurrentCheckPoint + 1
				end
			end
			if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
				local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
				local speed = GetEntitySpeed(vehicle) * 3.6
				local tooMuchSpeed = false
				local GetSpeed = math.floor(GetEntitySpeed(vehicle) * 3.6)
				local speed_limit_residence = 80.0
				local speed_limit_ville = 50.0
				local speed_limit_otoroute = 120.0
				local DamageControl = 0
				if ErrorSpeed == 0 and GetSpeed >= speed_limit_residence then
					tooMuchSpeed = true
					DriveErrors = DriveErrors + 1
					IsAboveSpeedLimit = true
					ESX.ShowAdvancedNotification('Moniteur', '~r~Vous avez fait une erreur', "Vous roulez trop vite, vitesse limite : "..speed_limit_residence.." km/h~w~\n~r~Nombre d'erreurs " ..DriveErrors.. "/5", 'CHAR_JOSH')
					Wait(2000) 
				end
				if ErrorSpeed == 1 and GetSpeed >= speed_limit_ville then
					tooMuchSpeed = true
					DriveErrors = DriveErrors + 1
					IsAboveSpeedLimit = true
					ESX.ShowAdvancedNotification('Moniteur', '~r~Vous avez fait une erreur', "Vous roulez trop vite, vitesse limite : "..speed_limit_ville.." km/h~w~\n~r~Nombre d'erreurs " ..DriveErrors.. "/5", 'CHAR_JOSH')
					Wait(2000)
				end
				if ErrorSpeed == 2 and GetSpeed >= speed_limit_otoroute then
					tooMuchSpeed = true
					DriveErrors = DriveErrors + 1
					IsAboveSpeedLimit = true
					ESX.ShowAdvancedNotification('Moniteur', '~r~Vous avez fait une erreur', "Vous roulez trop vite, vitesse limite : "..speed_limit_otoroute.." km/h~w~\n~r~Nombre d'erreurs " ..DriveErrors.. "/5", 'CHAR_JOSH')
					Wait(2000)
				end
				if HasEntityCollidedWithAnything(vehicle) and DamageControl == 0 then
					DriveErrors = DriveErrors + 1
					ESX.ShowAdvancedNotification('Moniteur', '~r~Vous avez fait une erreur', "Votre vehicule c\'est pris des dégats\n~r~Nombre d'erreurs "..DriveErrors.."/5", 'CHAR_JOSH')
					Wait(2000)
				end
				if not tooMuchSpeed then
					IsAboveSpeedLimit = false
				end
				if GetEntityHealth(vehicle) < GetEntityHealth(vehicle) then
					DriveErrors = DriveErrors + 1
					ESX.ShowAdvancedNotification('Moniteur', '~r~Vous avez fait une erreur', "Votre vehicule c\'est pris des dégats\n~r~Nombre d'erreurs "..DriveErrors.."/5", 'CHAR_JOSH')		
					VehicleHealth = GetEntityHealth(vehicle)
					Wait(2000)
				end
				if DriveErrors >= 5 then
					CurrentCheckPoint = 10
					RemoveBlip(CurrentBlip)
					SetNewWaypoint(204.82, 377.133)
					DrawMarker(36, 204.82, 377.133, 107.24, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 204, 102, 100, false, true, 2, false, false, false, false)
					local dist = Vdist2(GetEntityCoords(PlayerPedId()), 204.82, 377.133, 107.24)
					if dist <= 2.5 then
						ESX.ShowHelpNotification("~INPUT_TALK~ pour rendre le véhicule")
						if IsControlJustPressed(0, 51) then
							StopDriveTest(false)
                            startedconduite = false
							DriveErrors = 0
							CurrentCheckPoint = 0
							RemoveBlip(CurrentBlip)
						end
					end
				end
			end
		else 
			Wait(500)
		end
	end
end

function StartDriveTest()
    for k,v in pairs(G_DrivingSchool.AutoEcole.Voiture) do
        CurrentTest = 'drive'
        permisencours = "drive"
        startedconduite = true
        RequestModel(GetHashKey(v.name))
        while not HasModelLoaded(GetHashKey(v.name)) do
            Wait(100)
        end
        local veh = CreateVehicle(GetHashKey(v.name), v.Spawn, v.SpawnHeading, 1, 0)
        ESX.ShowNotification("Votre véhicule de conduite est prêt, il n'attend plus que vous, rejoingnez le parking")
        StartConduite()
    end
end

function StartDriveTestMoto()
    for k,v in pairs(G_DrivingSchool.AutoEcole.Moto) do
        CurrentTest = 'drive'
        permisencours = "drive_bike"
        startedconduite = true
        RequestModel(GetHashKey(v.name))  
        while not HasModelLoaded(GetHashKey(v.name)) do
            Wait(100)
        end 
        local veh = CreateVehicle(GetHashKey(v.name), v.Spawn, v.SpawnHeading, 1, 0)
        ESX.ShowNotification("Votre véhicule de conduite est prêt, il n'attend plus que vous, rejoingnez le parking")
        StartConduite()
    end
end

function StartDriveTestCamion()
    for k,v in pairs(G_DrivingSchool.AutoEcole.Camion) do
        CurrentTest = 'drive'
        permisencours = "drive_truck"
        startedconduite = true    
        RequestModel(GetHashKey(v.name))
        while not HasModelLoaded(GetHashKey(v.name)) do
            Wait(100)
        end
        local veh = CreateVehicle(GetHashKey(v.name), v.Spawn, v.SpawnHeading, 1, 0)
        ESX.ShowNotification("Votre véhicule de conduite est prêt, il n'attend plus que vous, rejoingnez le parking")
        StartConduite()
    end
end

