Citizen.CreateThread(function()
	while ESX == nil do 
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
        Citizen.Wait(10) 
    end
    while ESX.GetPlayerData().job == nil do 
        Citizen.Wait(10) 
    end
    if ESX.IsPlayerLoaded() then 
        ESX.PlayerData = ESX.GetPlayerData() 
    end
end)

RegisterNetEvent('esx:playerLoaded') 
AddEventHandler('esx:playerLoaded', function(xPlayer) 
    ESX.PlayerData = xPlayer 
end)

RegisterNetEvent('esx:setJob') 
AddEventHandler('esx:setJob', function(job) 
    ESX.PlayerData.job = job 
end)

function Job()
    local job = false 
    local mainMenu = RageUI.CreateMenu('Barbier', 'Menu')
    mainMenu.Closed = function() job = false end
    mainMenu.EnableMouse = true
    mainMenu.Display.Header = true 
	if not job then job = true RageUI.Visible(mainMenu, true)
		CreateThread(function()
		    while job do 
		        RageUI.IsVisible(mainMenu,function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()  
                    if closestPlayer ~= -1 and closestDistance <= 1.0 then                    
                        RageUI.List("Cheveux", G_Barber.List.Cheveux, G_Barber.Index.Cheveux, nil, {}, true, {
                            onListChange = function(i) 
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()  
                                if closestPlayer ~= -1 and closestDistance <= 1.0 then                          
                                    G_Barber.Index.Cheveux = i 
                                    local target = GetPlayerServerId(closestPlayer)
                                    --SetPedComponentVariation(closestPlayer, 2, G_Barber.Index.Cheveux, 0, 0)                   
                                    TriggerServerEvent('G_BarberJob:cheveuxS', target, G_Barber.Index.Cheveux)
                                    chev = tonumber(G_Barber.Index.Cheveux)
                                end
                            end,
                        })
                        RageUI.List("Barbes", G_Barber.List.Barbe, G_Barber.Index.Barbe, nil, {}, true, {                       
                            onListChange = function(i) 
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()  
                                if closestPlayer ~= -1 and closestDistance <= 1.0 then                          
                                    G_Barber.Index.Barbe = i 
                                    local target = GetPlayerServerId(closestPlayer)
                                    --SetPedHeadOverlay(closestPlayer, 2, G_Barber.Index.Barbe, G_Barber.Index.OpaciteBarbe)                  
                                    TriggerServerEvent('G_BarberJob:barbeS', target, G_Barber.Index.Barbe, G_Barber.Index.OpaciteBarbe)
                                    barb = tonumber(G_Barber.Index.Barbe)
                                    opabarb = tonumber(G_Barber.Index.OpaciteBarbe * 10)
                                end
                            end,
                        })
                        RageUI.List("Sourcils", G_Barber.List.Sourcil, G_Barber.Index.Sourcil, nil, {}, true, {                       
                            onListChange = function(i) 
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()  
                                if closestPlayer ~= -1 and closestDistance <= 1.0 then                           
                                    G_Barber.Index.Sourcil = i 
                                    local target = GetPlayerServerId(closestPlayer)
                                    --SetPedHeadOverlay(closestPlayer, 2, G_Barber.Index.Sourcil-1, G_Barber.Index.OpaciteSourcil)                  
                                    TriggerServerEvent('G_BarberJob:sourcilS', target, G_Barber.Index.Sourcil, G_Barber.Index.OpaciteSourcil)
                                    sourc = tonumber(G_Barber.Index.Sourcil)
                                    opasourc = tonumber(G_Barber.Index.OpaciteSourcil * 10) 
                                end
                            end,
                        })
                        RageUI.List("Maquillages", G_Barber.List.Maquillage, G_Barber.Index.Maquillage, nil, {}, true, {                       
                            onListChange = function(i) 
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()  
                                if closestPlayer ~= -1 and closestDistance <= 1.0 then                           
                                    G_Barber.Index.Maquillage = i
                                    local target = GetPlayerServerId(closestPlayer)
                                    --SetPedHeadOverlay(closestPlayer, 4, G_Barber.Index.Maquillage, G_Barber.Index.OpaciteMaquillage)                  
                                    TriggerServerEvent('G_BarberJob:maquillageS', target, G_Barber.Index.Maquillage, G_Barber.Index.OpaciteMaquillage)
                                    maquil = tonumber(G_Barber.Index.Maquillage)
                                    opamaquil = tonumber(G_Barber.Index.OpaciteMaquillage * 10)
                                end
                            end,
                        })
                        RageUI.List("Bouche", G_Barber.List.Bouche, G_Barber.Index.Bouche, nil, {}, true, {                       
                            onListChange = function(i) 
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()  
                                if closestPlayer ~= -1 and closestDistance <= 1.0 then                           
                                    G_Barber.Index.Bouche = i
                                    local target = GetPlayerServerId(closestPlayer)
                                    --SetPedHeadOverlay(closestPlayer, 8, G_Barber.Index.Bouche, G_Barber.Index.OpaciteBouche)                  
                                    TriggerServerEvent('G_BarberJob:boucheS', target, G_Barber.Index.Bouche, G_Barber.Index.OpaciteBouche)
                                    bouch = tonumber(G_Barber.Index.Bouche)
                                    opabouch = tonumber(G_Barber.Index.OpaciteBouche * 10)
                                end
                            end,
                        })
                        RageUI.Button("Valider", false, {RightBadge = RageUI.BadgeStyle.Tick, Color = {BackgroundColor = {120,255,0,100}}}, true, {
                            onSelected = function()
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                if closestPlayer ~= -1 and closestDistance <= 2.5 then
                                    ESX.TriggerServerCallback('G_BarberJob:getClosestPlayerSkin', function(cb)
                                        comp = cb  

                                        Hair_1 = chev 
                                        Beard_1 = barb
                                        Eyebrows_1 = sourc 
                                        Makeup_1 = maquil 
                                        Lipstick_1 = bouch 

                                        Beard_2 = opabarb
                                        Eyebrows_2 = opasourc
                                        Makeup_2 = opamaquil
                                        Lipstick_2 = opabouch
                                
                                        Hair_3 = chevcolor1
                                        Beard_3 = barbcolor1
                                        Eyebrows_3 = sourccolor1 
                                        Makeup_3 = maquilcolor1
                                        Lipstick_3 = bouchcolor1 

                                        Hair_4 = chevcolor2
                                        Beard_4 = barbcolor2
                                        Eyebrows_4 = sourccolor2
                                        Makeup_4 = maquilcolor2
                                        Lipstick_4 = bouchcolor2

                                        if Hair_1 ~= nil then
                                            if Hair_1 >= 1 then
                                                comp.hair_1 = 'hair_1'
                                                comp.hair_1 = nil
                                                comp.hair_1 = Hair_1-1
                                            end
                                        end
                                        if Hair_3 ~= nil then
                                            if Hair_3 >= 1 then
                                                comp.hair_color_1 = 'hair_color_1'
                                                comp.hair_color_1 = nil
                                                comp.hair_color_1 = Hair_3
                                            end
                                        end                                                
                                        if Hair_4 ~= nil then
                                            if Hair_4 >= 1 then
                                                comp.hair_color_2 = 'hair_color_2'
                                                comp.hair_color_2 = nil
                                                comp.hair_color_2 = Hair_4
                                            end
                                        end	                             
                                        if Beard_1 ~= nil then
                                            if Beard_1 >= 1 then 
                                                comp.beard_1 = 'beard_1'
                                                comp.beard_1 = nil
                                                comp.beard_1 = Beard_1
                                            end
                                        end	                            
                                        if Beard_2 ~= nil then
                                            if Beard_2 >= 0 then 
                                                comp.beard_2 = 'beard_2'
                                                comp.beard_2 = nil
                                                comp.beard_2 = Beard_2
                                            end
                                        end
                                        if Beard_3 ~= nil then
                                            if Beard_3 >= 1 then 
                                                comp.beard_3 = 'beard_3'
                                                comp.beard_3 = nil
                                                comp.beard_3 = Beard_3
                                            end
                                        end
                                        if Beard_4 ~= nil then
                                            if Beard_4 >= 1 then 
                                                comp.beard_4 = 'beard_4'
                                                comp.beard_4 = nil
                                                comp.beard_4 = Beard_4
                                            end
                                        end
                                        if Eyebrows_1 ~= nil then
                                            if Eyebrows_1 >= 1 then 
                                                comp.eyebrows_1 = 'eyebrows_1'
                                                comp.eyebrows_1 = nil
                                                comp.eyebrows_1 = Eyebrows_1
                                            end
                                        end
                                        if Eyebrows_2 ~= nil then
                                            if Eyebrows_2 >= 0 then 
                                                comp.eyebrows_2 = 'eyebrows_2'
                                                comp.eyebrows_2 = nil
                                                comp.eyebrows_2 = Eyebrows_2
                                            end
                                        end
                                        if Eyebrows_3 ~= nil then
                                            if Eyebrows_3 >= 1 then 
                                                comp.eyebrows_3 = 'eyebrows_3'
                                                comp.eyebrows_3 = nil
                                                comp.eyebrows_3 = Eyebrows_3
                                            end
                                        end
                                        if Eyebrows_4 ~= nil then
                                            if Eyebrows_4 >= 1 then 
                                                comp.eyebrows_4 = 'eyebrows_4'
                                                comp.eyebrows_4 = nil
                                                comp.eyebrows_4 = Eyebrows_4
                                            end
                                        end
                                        if Makeup_1 ~= nil then
                                            if Makeup_1 >= 1 then 
                                                comp.makeup_1 = 'makeup_1'
                                                comp.makeup_1 = nil
                                                comp.makeup_1 = Makeup_1
                                            end
                                        end
                                        if Makeup_2 ~= nil then
                                            if Makeup_2 >= 0 then 
                                                comp.makeup_2 = 'makeup_2'
                                                comp.makeup_2 = nil
                                                comp.makeup_2 = Makeup_2 
                                            end
                                        end
                                        if Makeup_3 ~= nil then
                                            if Makeup_3 >= 1 then 
                                                comp.makeup_3 = 'makeup_3'
                                                comp.makeup_3 = nil
                                                comp.makeup_3 = Makeup_3
                                            end
                                        end
                                        if Makeup_4 ~= nil then
                                            if Makeup_4 >= 1 then 
                                                comp.makeup_4 = 'makeup_4'
                                                comp.makeup_4 = nil
                                                comp.makeup_4 = Makeup_4
                                            end
                                        end
                                        if Lipstick_1 ~= nil then
                                            if Lipstick_1 >= 1 then 
                                                comp.lipstick_1 = 'lipstick_1'
                                                comp.lipstick_1 = nil
                                                comp.lipstick_1 = Lipstick_1
                                            end
                                        end
                                        if Lipstick_2 ~= nil then
                                            if Lipstick_2 >= 0 then 
                                                comp.lipstick_2 = 'lipstick_2'
                                                comp.lipstick_2 = nil
                                                comp.lipstick_2 = Lipstick_2
                                            end
                                        end
                                        if Lipstick_3 ~= nil then
                                            if Lipstick_3 >= 1 then 
                                                comp.lipstick_3 = 'lipstick_3'
                                                comp.lipstick_3 = nil
                                                comp.lipstick_3 = Lipstick_3
                                            end
                                        end
                                        if Lipstick_4 ~= nil then
                                            if Lipstick_4 >= 1 then 
                                                comp.lipstick_4 = 'lipstick_4'
                                                comp.lipstick_4 = nil
                                                comp.lipstick_4 = Lipstick_4
                                            end
                                        end
                                        TriggerServerEvent('G_BarberJob:save',GetPlayerServerId(closestPlayer), comp)
                                        ESX.ShowNotification('~g~Coupe Validé')
                                    end, GetPlayerServerId(closestPlayer))
                                end
                                ciseau = CreateObject(GetHashKey("prop_cs_scissors"), 0, 0, 0, true, true, true) 
		                        AttachEntityToEntity(ciseau, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.08, 0.01, -0.04, -90.0, -90.0, 140.0, true, true, false, true, 1, true)
                                local coords = GetEntityCoords(GetPlayerPed(-1), false)
                                TaskGoStraightToCoord(PlayerPedId(), coords.x+0.45, coords.y+0.53, coords.z, 1.0, 1000, 230.25466, 5)
                                Wait(500)
                                local coords2 = GetEntityCoords(GetPlayerPed(-1), false)
                                TaskGoStraightToCoord(PlayerPedId(), coords2.x+0.60, coords2.y-0.53, coords2.z, 1.0, 1000, 230.25466, 5)
                                Wait(500)
                                PlayAnim()  
                                Wait(7500)
                                DeleteEntity(ciseau)                       
                                RageUI.CloseAll()
                                job = false
                                G_Barber.Index.Cheveux = 1
                                G_Barber.Index.Barbe = 1
                                G_Barber.Index.Sourcil = 1
                                G_Barber.Index.Maquillage = 1
                                G_Barber.Index.Bouche = 1
                                G_Barber.Index.CouleurCheveuxPrimaire = {1, 1}
                                G_Barber.Index.CouleurBarbePrimaire = {1, 1}
                                G_Barber.Index.CouleurSourcilPrimaire = {1, 1}
                                G_Barber.Index.CouleurMaquillagePrimaire = {1, 1}
                                G_Barber.Index.CouleurBouchePrimaire = {1, 1}
                                G_Barber.Index.CouleurCheveuxSecondaire = {1, 1}
                                G_Barber.Index.CouleurBarbeSecondaire = {1, 1}
                                G_Barber.Index.CouleurSourcilSecondaire = {1, 1}
                                G_Barber.Index.CouleurMaquillageSecondaire = {1, 1}
                                G_Barber.Index.CouleurBoucheSecondaire = {1, 1}
                                G_Barber.Index.OpaciteBarbe = 0
                                G_Barber.Index.OpaciteSourcil = 0
                                G_Barber.Index.OpaciteMaquillage = 0
                                G_Barber.Index.OpaciteBouche = 0
                            end
                        });
                        RageUI.ColourPanel("Couleur Cheveux", RageUI.PanelColour.HairCut, G_Barber.Index.CouleurCheveuxPrimaire[1], G_Barber.Index.CouleurCheveuxPrimaire[2], {
                            onColorChange = function(MinimumIndex, CurrentIndex)
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()  
                                if closestPlayer ~= -1 and closestDistance <= 1.0 then                          
                                    G_Barber.Index.CouleurCheveuxPrimaire[1] = MinimumIndex
                                    G_Barber.Index.CouleurCheveuxPrimaire[2] = CurrentIndex
                                    local target = GetPlayerServerId(closestPlayer)  
                                    --SetPedHairColor(closestPlayer, G_Barber.Index.CouleurCheveuxPrimaire[2], 0)      
                                    TriggerServerEvent('G_BarberJob:cheveuxcolorS', target, G_Barber.Index.CouleurCheveuxPrimaire[2], G_Barber.Index.CouleurCheveuxSecondaire[2]) 
                                    chevcolor1 = tonumber(G_Barber.Index.CouleurCheveuxPrimaire[2])
                                    chevcolor2 = tonumber(G_Barber.Index.CouleurCheveuxSecondaire[2])                      
                                end
                            end
                        }, 1);
                        RageUI.ColourPanel("Nacrage Cheveux", RageUI.PanelColour.HairCut, G_Barber.Index.CouleurCheveuxSecondaire[1], G_Barber.Index.CouleurCheveuxSecondaire[2], {
                            onColorChange = function(MinimumIndex, CurrentIndex)
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()  
                                if closestPlayer ~= -1 and closestDistance <= 1.0 then                          
                                    G_Barber.Index.CouleurCheveuxSecondaire[1] = MinimumIndex
                                    G_Barber.Index.CouleurCheveuxSecondaire[2] = CurrentIndex
                                    local target = GetPlayerServerId(closestPlayer)  
                                    --SetPedHairColor(closestPlayer, 0, G_Barber.Index.CouleurCheveuxSecondaire[2])       
                                    TriggerServerEvent('G_BarberJob:cheveuxcolor2S', target, G_Barber.Index.CouleurCheveuxPrimaire[2], G_Barber.Index.CouleurCheveuxSecondaire[2])
                                    chevcolor1 = tonumber(G_Barber.Index.CouleurCheveuxPrimaire[2])
                                    chevcolor2 = tonumber(G_Barber.Index.CouleurCheveuxSecondaire[2])    
                                end
                            end
                        }, 1);
                        RageUI.PercentagePanel(G_Barber.Index.OpaciteBarbe, 'Opacité', '0%', '100%', {
                            onProgressChange = function(i)
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()  
                                if closestPlayer ~= -1 and closestDistance <= 1.0 then                           
                                    G_Barber.Index.OpaciteBarbe = i
                                    local target = GetPlayerServerId(closestPlayer)
                                    --SetPedHeadOverlay(closestPlayer, 2, G_Barber.Index.Barbe, G_Barber.Index.OpaciteBarbe)                  
                                    TriggerServerEvent('G_BarberJob:barbeS', target, G_Barber.Index.Barbe, G_Barber.Index.OpaciteBarbe)
                                    barb = tonumber(G_Barber.Index.Barbe)
                                    opabarb = tonumber(G_Barber.Index.OpaciteBarbe * 10)
                                end
                            end
                        }, 2);
                        RageUI.ColourPanel("Couleur Barbe", RageUI.PanelColour.HairCut, G_Barber.Index.CouleurBarbePrimaire[1], G_Barber.Index.CouleurBarbePrimaire[2], {
                            onColorChange = function(MinimumIndex, CurrentIndex)
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()  
                                if closestPlayer ~= -1 and closestDistance <= 1.0 then                           
                                    G_Barber.Index.CouleurBarbePrimaire[1] = MinimumIndex
                                    G_Barber.Index.CouleurBarbePrimaire[2] = CurrentIndex
                                    local target = GetPlayerServerId(closestPlayer)  
                                    --SetPedHeadOverlayColor(closestPlayer, 1, 1, G_Barber.Index.CouleurBarbePrimaire[2], G_Barber.Index.CouleurBarbeSecondaire[2])               
                                    TriggerServerEvent('G_BarberJob:barbecolorS', target, G_Barber.Index.CouleurBarbePrimaire[2], G_Barber.Index.CouleurBarbeSecondaire[2])
                                    barbcolor1 = tonumber(G_Barber.Index.CouleurBarbePrimaire[2]) 
                                    barbcolor2 = tonumber(G_Barber.Index.CouleurBarbeSecondaire[2])
                                end
                            end
                        }, 2);
                        RageUI.ColourPanel("Nacrage Barbe", RageUI.PanelColour.HairCut, G_Barber.Index.CouleurBarbeSecondaire[1], G_Barber.Index.CouleurBarbeSecondaire[2], {
                            onColorChange = function(MinimumIndex, CurrentIndex)
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()  
                                if closestPlayer ~= -1 and closestDistance <= 1.0 then                           
                                    G_Barber.Index.CouleurBarbeSecondaire[1] = MinimumIndex
                                    G_Barber.Index.CouleurBarbeSecondaire[2] = CurrentIndex
                                    local target = GetPlayerServerId(closestPlayer)  
                                    --SetPedHeadOverlayColor(closestPlayer, 1, 1, G_Barber.Index.CouleurBarbePrimaire[2], G_Barber.Index.CouleurBarbeSecondaire[2])               
                                    TriggerServerEvent('G_BarberJob:barbecolor2S', target, G_Barber.Index.CouleurBarbePrimaire[2], G_Barber.Index.CouleurBarbeSecondaire[2])
                                    barbcolor1 = tonumber(G_Barber.Index.CouleurBarbePrimaire[2]) 
                                    barbcolor2 = tonumber(G_Barber.Index.CouleurBarbeSecondaire[2])
                                end
                            end
                        }, 2);
                        RageUI.PercentagePanel(G_Barber.Index.OpaciteSourcil, 'Opacité', '0%', '100%', {
                            onProgressChange = function(i)
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()  
                                if closestPlayer ~= -1 and closestDistance <= 1.0 then                           
                                    G_Barber.Index.OpaciteSourcil = i
                                    local target = GetPlayerServerId(closestPlayer)
                                    --SetPedHeadOverlay(closestPlayer, 2, G_Barber.Index.Sourcil, G_Barber.Index.OpaciteSourcil)                  
                                    TriggerServerEvent('G_BarberJob:sourcilS', target, G_Barber.Index.Sourcil, G_Barber.Index.OpaciteSourcil)
                                    sourc = tonumber(G_Barber.Index.Sourcil)
                                    opasourc = tonumber(G_Barber.Index.OpaciteSourcil * 10)
                                end
                            end
                        }, 3);
                        RageUI.ColourPanel("Couleur Sourcil", RageUI.PanelColour.HairCut, G_Barber.Index.CouleurSourcilPrimaire[1], G_Barber.Index.CouleurSourcilPrimaire[2], {
                            onColorChange = function(MinimumIndex, CurrentIndex)
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()  
                                if closestPlayer ~= -1 and closestDistance <= 1.0 then                           
                                    G_Barber.Index.CouleurSourcilPrimaire[1] = MinimumIndex
                                    G_Barber.Index.CouleurSourcilPrimaire[2] = CurrentIndex
                                    local target = GetPlayerServerId(closestPlayer)  
                                    --SetPedHeadOverlayColor(closestPlayer, 2, 1, G_Barber.Index.CouleurSourcilPrimaire[2], G_Barber.Index.CouleurSourcilSecondaire[2])               
                                    TriggerServerEvent('G_BarberJob:sourcilcolorS', target, G_Barber.Index.CouleurSourcilPrimaire[2], G_Barber.Index.CouleurSourcilSecondaire[2])
                                    sourccolor1 = tonumber(G_Barber.Index.CouleurSourcilPrimaire[2]) 
                                    sourccolor2 = tonumber(G_Barber.Index.CouleurSourcilSecondaire[2])
                                end
                            end
                        }, 3);
                        RageUI.ColourPanel("Nacrage Sourcil", RageUI.PanelColour.HairCut, G_Barber.Index.CouleurSourcilSecondaire[1], G_Barber.Index.CouleurSourcilSecondaire[2], {
                            onColorChange = function(MinimumIndex, CurrentIndex)
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()  
                                if closestPlayer ~= -1 and closestDistance <= 1.0 then                           
                                    G_Barber.Index.CouleurSourcilSecondaire[1] = MinimumIndex
                                    G_Barber.Index.CouleurSourcilSecondaire[2] = CurrentIndex
                                    local target = GetPlayerServerId(closestPlayer)  
                                    --SetPedHeadOverlayColor(closestPlayer, 2, 1, G_Barber.Index.CouleurSourcilPrimaire[2], G_Barber.Index.CouleurSourcilSecondaire[2])               
                                    TriggerServerEvent('G_BarberJob:sourcilcolor2S', target, G_Barber.Index.CouleurSourcilPrimaire[2], G_Barber.Index.CouleurSourcilSecondaire[2])
                                    sourccolor1 = tonumber(G_Barber.Index.CouleurSourcilPrimaire[2]) 
                                    sourccolor2 = tonumber(G_Barber.Index.CouleurSourcilSecondaire[2])
                                end
                            end
                        }, 3);
                        RageUI.PercentagePanel(G_Barber.Index.OpaciteMaquillage, 'Opacité', '0%', '100%', {
                            onProgressChange = function(i)
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()  
                                if closestPlayer ~= -1 and closestDistance <= 1.0 then                           
                                    G_Barber.Index.OpaciteMaquillage = i
                                    local target = GetPlayerServerId(closestPlayer)
                                    --SetPedHeadOverlay(closestPlayer, 4, G_Barber.Index.Maquillage, G_Barber.Index.OpaciteMaquillage)                  
                                    TriggerServerEvent('G_BarberJob:maquillageS', target, G_Barber.Index.Maquillage, G_Barber.Index.OpaciteMaquillage)
                                    maquil = tonumber(G_Barber.Index.Maquillage)
                                    opamaquil = tonumber(G_Barber.Index.OpaciteMaquillage * 10)
                                end
                            end
                        }, 4);
                        RageUI.ColourPanel("Couleur Maquillage", RageUI.PanelColour.HairCut, G_Barber.Index.CouleurMaquillagePrimaire[1], G_Barber.Index.CouleurMaquillagePrimaire[2], {
                            onColorChange = function(MinimumIndex, CurrentIndex)
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()  
                                if closestPlayer ~= -1 and closestDistance <= 1.0 then                           
                                    G_Barber.Index.CouleurMaquillagePrimaire[1] = MinimumIndex
                                    G_Barber.Index.CouleurMaquillagePrimaire[2] = CurrentIndex
                                    local target = GetPlayerServerId(closestPlayer)  
                                    --SetPedHeadOverlayColor(closestPlayer, 4, 1, G_Barber.Index.CouleurMaquillagePrimaire[2], G_Barber.Index.CouleurMaquillageSecondaire[2])               
                                    TriggerServerEvent('G_BarberJob:maquillagecolorS', target, G_Barber.Index.CouleurMaquillagePrimaire[2], G_Barber.Index.CouleurMaquillageSecondaire[2])
                                    maquilcolor1 = tonumber(G_Barber.Index.CouleurMaquillagePrimaire[2]) 
                                    maquilcolor2 = tonumber(G_Barber.Index.CouleurMaquillageSecondaire[2])
                                end
                            end
                        }, 4);
                        RageUI.ColourPanel("Nacrage Maquillage", RageUI.PanelColour.HairCut, G_Barber.Index.CouleurMaquillageSecondaire[1], G_Barber.Index.CouleurMaquillageSecondaire[2], {
                            onColorChange = function(MinimumIndex, CurrentIndex)
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()  
                                if closestPlayer ~= -1 and closestDistance <= 1.0 then                           
                                    G_Barber.Index.CouleurMaquillageSecondaire[1] = MinimumIndex
                                    G_Barber.Index.CouleurMaquillageSecondaire[2] = CurrentIndex
                                    local target = GetPlayerServerId(closestPlayer)  
                                    --SetPedHeadOverlayColor(closestPlayer, 4, 1, G_Barber.Index.CouleurMaquillagePrimaire[2], G_Barber.Index.CouleurMaquillageSecondaire[2])               
                                    TriggerServerEvent('G_BarberJob:maquillagecolor2S', target, G_Barber.Index.CouleurMaquillagePrimaire[2], G_Barber.Index.CouleurMaquillageSecondaire[2])
                                    maquilcolor1 = tonumber(G_Barber.Index.CouleurMaquillagePrimaire[2]) 
                                    maquilcolor2 = tonumber(G_Barber.Index.CouleurMaquillageSecondaire[2])
                                end
                            end
                        }, 4);
                        RageUI.PercentagePanel(G_Barber.Index.OpaciteBouche, 'Opacité', '0%', '100%', {
                            onProgressChange = function(i)
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()  
                                if closestPlayer ~= -1 and closestDistance <= 1.0 then                           
                                    G_Barber.Index.OpaciteBouche = i
                                    local target = GetPlayerServerId(closestPlayer)
                                    --SetPedHeadOverlay(closestPlayer, 8, G_Barber.Index.Bouche, G_Barber.Index.OpaciteBouche)                  
                                    TriggerServerEvent('G_BarberJob:boucheS', target, G_Barber.Index.Bouche, G_Barber.Index.OpaciteBouche)
                                    bouch = tonumber(G_Barber.Index.Bouche)
                                    opabouch = tonumber(G_Barber.Index.OpaciteBouche * 10)
                                end
                            end
                        }, 5);
                        RageUI.ColourPanel("Couleur Bouche", RageUI.PanelColour.HairCut, G_Barber.Index.CouleurBouchePrimaire[1], G_Barber.Index.CouleurBouchePrimaire[2], {
                            onColorChange = function(MinimumIndex, CurrentIndex)
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()  
                                if closestPlayer ~= -1 and closestDistance <= 1.0 then                           
                                    G_Barber.Index.CouleurBouchePrimaire[1] = MinimumIndex
                                    G_Barber.Index.CouleurBouchePrimaire[2] = CurrentIndex
                                    local target = GetPlayerServerId(closestPlayer)  
                                    --SetPedHeadOverlayColor(closestPlayer, 8, 1, G_Barber.Index.CouleurBouchePrimaire[2], G_Barber.Index.CouleurBoucheSecondaire[2])               
                                    TriggerServerEvent('G_BarberJob:bouchecolorS', target, G_Barber.Index.CouleurBouchePrimaire[2], G_Barber.Index.CouleurBoucheSecondaire[2])
                                    bouchcolor1 = tonumber(G_Barber.Index.CouleurBouchePrimaire[2]) 
                                    bouchcolor2 = tonumber(G_Barber.Index.CouleurBoucheSecondaire[2])
                                end
                            end
                        }, 5);
                        RageUI.ColourPanel("Nacrage Bouche", RageUI.PanelColour.HairCut, G_Barber.Index.CouleurBoucheSecondaire[1], G_Barber.Index.CouleurBoucheSecondaire[2], {
                            onColorChange = function(MinimumIndex, CurrentIndex)
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()  
                                if closestPlayer ~= -1 and closestDistance <= 1.0 then                           
                                    G_Barber.Index.CouleurBoucheSecondaire[1] = MinimumIndex
                                    G_Barber.Index.CouleurBoucheSecondaire[2] = CurrentIndex
                                    local target = GetPlayerServerId(closestPlayer)  
                                    --SetPedHeadOverlayColor(closestPlayer, 8, 1, G_Barber.Index.CouleurBouchePrimaire[2], G_Barber.Index.CouleurBoucheSecondaire[2])               
                                    TriggerServerEvent('G_BarberJob:bouchecolorS', target, G_Barber.Index.CouleurBouchePrimaire[2], G_Barber.Index.CouleurBoucheSecondaire[2])
                                    bouchcolor1 = tonumber(G_Barber.Index.CouleurBouchePrimaire[2]) 
                                    bouchcolor2 = tonumber(G_Barber.Index.CouleurBoucheSecondaire[2])
                                end
                            end                           
                        }, 5);
                    else
                        RageUI.Separator("")
                        RageUI.Separator("Personne aux alentours...")
                        RageUI.Separator("")
                    end
		        end)
		    Wait(0)
		    end
	    end)
    end
end

function PlayAnim()
    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        FreezeEntityPosition(GetPlayerPed(-1), true)
        RequestAnimDict('misshair_shop@barbers') 
        while not HasAnimDictLoaded('misshair_shop@barbers') do       
            Citizen.Wait(1)
        end   
        TaskPlayAnim(playerPed, 'misshair_shop@barbers', 'keeper_idle_b', 1.0, -1.0, 6000, 0.0, 0.0, GetEntityCoords(GetPlayerPed(-1)))
        Citizen.Wait(6000)
        FreezeEntityPosition(GetPlayerPed(-1), false)
    end)
end

Citizen.CreateThread(function()
    while true do
        local wait = 900
        for k,v in pairs(G_Barber.Coords) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'barber' then 
                local coords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(coords.x, coords.y, coords.z, v.x, v.y, v.z)
                if dist <= 1.0 then 
                    wait = 0
                    DrawMarker(G_Barber.Marker.Type, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, G_Barber.Marker.rotX, G_Barber.Marker.rotY, G_Barber.Marker.rotZ, G_Barber.Marker.scaleX, G_Barber.Marker.scaleY, G_Barber.Marker.scaleZ, G_Barber.Marker.R, G_Barber.Marker.V, G_Barber.Marker.B, G_Barber.Marker.O, false, false, p19, false) 
                    if dist <= 1.0 then 
                        wait = 0 
                        ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir le ~o~Menu Coiffeur")
                        if IsControlJustPressed(1,51) then                     
                            Job()
                        end
                    end
                end
            end
        end
    Citizen.Wait(wait)
    end
end)

local anim = true

Citizen.CreateThread(function()
    while true do
        local wait = 900
        for k,v in pairs(G_Barber.Sit) do
            local coords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(coords.x, coords.y, coords.z, v.x, v.y, v.z)
            if dist <= 1.0 and anim == true then 
                wait = 0
                DrawMarker(G_Barber.Marker.Type, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, G_Barber.Marker.rotX, G_Barber.Marker.rotY, G_Barber.Marker.rotZ, G_Barber.Marker.scaleX, G_Barber.Marker.scaleY, G_Barber.Marker.scaleZ, G_Barber.Marker.R, G_Barber.Marker.V, G_Barber.Marker.B, G_Barber.Marker.O, false, false, p19, false)
                if dist <= 1.0 and anim == true then 
                    wait = 0 
                    ESX.ShowHelpNotification("~INPUT_TALK~ pour vous ~o~Asseoir")
                    if IsControlJustPressed(1,51) then         
                        anim = false
                        SetEntityHeading(PlayerPedId(), v.w2)
                        SetEntityCoordsNoOffset(GetPlayerPed(-1), v.x2, v.y2, v.z2, false, false, false, true)
                        Wait(500)
                        TaskStartScenarioAtPosition(GetPlayerPed(-1), "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER", v.x2, v.y2, v.z2, v.w2, 0, 1, false)
                        ESX.ShowHelpNotification("~INPUT_DETONATE~ pour vous ~o~Lever")                       
                    end
                end
            end
        end
    Citizen.Wait(wait)
    end
end)

Keys.Register("G", "G", "Arrêter l'animation", function()
    if anim == false then
        ClearPedTasks(PlayerPedId())
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
            TriggerEvent('skinchanger:loadSkin', skin)
        end)
        anim = true
    end
end)

RegisterNetEvent('G_BarberJob:cheveuxC')
AddEventHandler('G_BarberJob:cheveuxC', function(cheveux)
   SetPedComponentVariation(GetPlayerPed(-1), 2, cheveux-1) 
end)

RegisterNetEvent('G_BarberJob:cheveuxcolorC')
AddEventHandler('G_BarberJob:cheveuxcolorC', function(cheveuxcolor, cheveuxcolor2)
    SetPedHairColor(GetPlayerPed(-1), cheveuxcolor, cheveuxcolor2) 
end)

RegisterNetEvent('G_BarberJob:cheveuxcolor2C')
AddEventHandler('G_BarberJob:cheveuxcolor2C', function(cheveuxcolor, cheveuxcolor2)
    SetPedHairColor(GetPlayerPed(-1), cheveuxcolor, cheveuxcolor2) 
end)

RegisterNetEvent('G_BarberJob:barbeC')
AddEventHandler('G_BarberJob:barbeC', function(barbe, opacity)    
    SetPedHeadOverlay(GetPlayerPed(-1), 1, barbe, opacity)
end)

RegisterNetEvent('G_BarberJob:barbecolorC')
AddEventHandler('G_BarberJob:barbecolorC', function(barbecolor, barbecolor2)
    SetPedHeadOverlayColor(GetPlayerPed(-1), 1, 1, barbecolor, barbecolor2)
end)

RegisterNetEvent('G_BarberJob:barbecolor2C')
AddEventHandler('G_BarberJob:barbecolor2C', function(barbecolor, barbecolor2)
    SetPedHeadOverlayColor(GetPlayerPed(-1), 1, 1, barbecolor, barbecolor2)
end)

RegisterNetEvent('G_BarberJob:sourcilC')
AddEventHandler('G_BarberJob:sourcilC', function(sourcil, opacity)    
    SetPedHeadOverlay(GetPlayerPed(-1), 2, sourcil-1, opacity)
end)

RegisterNetEvent('G_BarberJob:sourcilcolorC')
AddEventHandler('G_BarberJob:sourcilcolorC', function(sourcilcolor, sourcilcolor2)
    SetPedHeadOverlayColor(GetPlayerPed(-1), 2, 1, sourcilcolor, sourcilcolor2)
end)

RegisterNetEvent('G_BarberJob:sourcilcolor2C')
AddEventHandler('G_BarberJob:sourcilcolor2C', function(sourcilcolor, sourcilcolor2)
    SetPedHeadOverlayColor(GetPlayerPed(-1), 2, 1, sourcilcolor, sourcilcolor2)
end)

RegisterNetEvent('G_BarberJob:maquillageC')
AddEventHandler('G_BarberJob:maquillageC', function(maquillage, opacity)    
    SetPedHeadOverlay(GetPlayerPed(-1), 4, maquillage, opacity)
end)

RegisterNetEvent('G_BarberJob:maquillagecolorC')
AddEventHandler('G_BarberJob:maquillagecolorC', function(maquillagecolor, maquillagecolor2)
    SetPedHeadOverlayColor(GetPlayerPed(-1), 4, 1, maquillagecolor, maquillagecolor2)
end)

RegisterNetEvent('G_BarberJob:maquillagecolor2C')
AddEventHandler('G_BarberJob:maquillagecolor2C', function(maquillagecolor, maquillagecolor2)
    SetPedHeadOverlayColor(GetPlayerPed(-1), 4, 1, maquillagecolor, maquillagecolor2)
end)

RegisterNetEvent('G_BarberJob:boucheC')
AddEventHandler('G_BarberJob:boucheC', function(bouche, opacity)   
    SetPedHeadOverlay(GetPlayerPed(-1), 8, bouche, opacity)
end)

RegisterNetEvent('G_BarberJob:bouchecolorC')
AddEventHandler('G_BarberJob:bouchecolorC', function(bouchecolor, bouchecolor2)
    SetPedHeadOverlayColor(GetPlayerPed(-1), 8, 1, bouchecolor, bouchecolor2)
end)

RegisterNetEvent('G_BarberJob:bouchecolor2C')
AddEventHandler('G_BarberJob:bouchecolor2C', function(bouchecolor, bouchecolor2)
    SetPedHeadOverlayColor(GetPlayerPed(-1), 8, 1, bouchecolor, bouchecolor2)
end)