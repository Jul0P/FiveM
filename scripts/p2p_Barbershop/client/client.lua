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

local mainMenu = RageUI.CreateMenu(Config.Translate('menu_title'), Config.Translate('menu_desc'))
local type_index, cheveux_index, barbe_index, sourcil_index, maquillage_index, bouche_index, lentille_index = 1,1,1,1,1,1,1
local cheveuxcolor_index, cheveuxcolor2_index, barbeopacity_index, barbecolor_index, barbecolor2_index, sourcilopacity_index, sourcilcolor_index, sourcilcolor2_index, maquillageopacity_index, maquillagecolor_index, maquillagecolor2_index, boucheopacity_index, bouchecolor_index, bouchecolor2_index = 1,1,1.0,1,1,1.0,1,1,1.0,1,1,1.0,1,1

mainMenu.EnableMouse = true
mainMenu.Closed = function()
    barber = false
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
    FreezeEntityPosition(PlayerPedId(), false)
    RenderScriptCams(0, true, 2000)
    DestroyAllCams(true)
end

mainMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, Config.key.tournerdroite, 0), [2] = Config.Translate('cam_right')})
mainMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, Config.key.tournergauche, 0), [2] = Config.Translate('cam_left')})
mainMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, Config.key.activerdesactivercamera, 0), [2] = Config.Translate('cam_active')})
mainMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, Config.key.tourner90, 0), [2] = Config.Translate('cam_90')})
mainMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, Config.key.dezoomer, 0), [2] = Config.Translate('cam_zoomout')})
mainMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, Config.key.zoomer, 0), [2] = Config.Translate('cam_zoom')})

local arraycheveux,arraybarbe,arraysourcil,arraylentille,arraymaquillage,arraybouche = {},{},{},{},{},{}

function GetBarberArray()
    for i = 0, Config.array.cheveux-1, 1 do 
        arraycheveux[i] = i 
    end 
    for i = 0, Config.array.barbe-1, 1 do 
        arraybarbe[i] = i 
    end 
    for i = 0, Config.array.sourcil-1, 1 do 
        arraysourcil[i] = i 
    end 
    for i = 0, Config.array.lentille, 1 do 
        arraylentille[i] = i 
    end 
    for i = 0, Config.array.maquillage-1, 1 do 
        arraymaquillage[i] = i 
    end 
    for i = 0, Config.array.bouche-1, 1 do 
        arraybouche[i] = i 
    end 
end

function Barber()
    if not barber then barber = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
		    while barber do
                RageUI.IsVisible(mainMenu,function()
                    mainMenu:UpdateInstructionalButtons(true)
                    LoadCam()
                    RageUI.List(Config.Translate('hair'), arraycheveux, cheveux_index, nil, {}, true, {
                        onListChange = function(Index)
                            cheveux_index = Index
                            TriggerEvent('skinchanger:change', 'hair_1', cheveux_index-1)
                        end
                    })
                    RageUI.List(Config.Translate('beard'), arraybarbe, barbe_index, nil, {}, true, {
                        onListChange = function(Index)
                            barbe_index = Index
                            TriggerEvent('skinchanger:change', 'beard_1', barbe_index-1)
                        end
                    })
                    RageUI.List(Config.Translate('eyebrows'), arraysourcil, sourcil_index, nil, {}, true, {
                        onListChange = function(Index)
                            sourcil_index = Index
                            TriggerEvent('skinchanger:change', 'eyebrows_1', sourcil_index-1)
                        end
                    })
                    RageUI.List(Config.Translate('makeup'), arraymaquillage, maquillage_index, nil, {}, true, {
                        onListChange = function(Index)
                            maquillage_index = Index
                            TriggerEvent('skinchanger:change', 'makeup_1', maquillage_index-1)
                        end
                    })
                    RageUI.List(Config.Translate('lipstick'), arraybouche, bouche_index, nil, {}, true, {
                        onListChange = function(Index)
                            bouche_index = Index
                            TriggerEvent('skinchanger:change', 'lipstick_1', bouche_index-1)
                        end
                    })
                    RageUI.List(Config.Translate('eye_color'), arraylentille, lentille_index, nil, {}, true, {
                        onListChange = function(Index)
                            lentille_index = Index
                            TriggerEvent('skinchanger:change', 'eye_color', lentille_index-1)
                        end
                    })
                    RageUI.Line()
                    RageUI.List(Config.Translate('type_price'), {"~g~"..Config.Translate('type_cash').."~s~", "~b~"..Config.Translate('type_bank').."~s~"}, type_index, nil, {}, true, {
                        onListChange = function(Index)
                            type_index = Index
                        end
                    })
                    RageUI.Button(Config.Translate('purchase_validated', (type_index == 1 and "~g~"..Config.price or "~b~"..Config.price)), false, {RightBadge = RageUI.BadgeStyle.Tick, Color = {BackgroundColor = {120,255,0,100}}}, true, {
                        onSelected = function()
                            ESX.TriggerServerCallback('p2p_Barbershop:buy', function(success)
                                if success then
                                    TriggerEvent('skinchanger:getSkin', function(skin)
                                        TriggerServerEvent('esx_skin:save', skin)
                                    end)
                                    RageUI.CloseAll()
                                    barber = false
                                    FreezeEntityPosition(PlayerPedId(), false)
                                    RenderScriptCams(0, true, 2000)
                                    DestroyAllCams(true)
                                end
                            end, type_index)
                        end
                    })
                    RageUI.ColourPanel(Config.Translate('hair_color_1'), RageUI.PanelColour.HairCut, Config.index.couleurcheveuxprimaire[1], cheveuxcolor_index, {
                        onColorChange = function(MinimumIndex, CurrentIndex)                          
                            Config.index.couleurcheveuxprimaire[1] = MinimumIndex
                            cheveuxcolor_index = CurrentIndex
                            TriggerEvent('skinchanger:change', 'hair_color_1',  cheveuxcolor_index-1)
                        end
                    }, 1);
                    RageUI.ColourPanel(Config.Translate('hair_color_2'), RageUI.PanelColour.HairCut, Config.index.couleurcheveuxsecondaire[1], cheveuxcolor2_index, {
                        onColorChange = function(MinimumIndex, CurrentIndex)                       
                            Config.index.couleurcheveuxsecondaire[1] = MinimumIndex
                            cheveuxcolor2_index = CurrentIndex
                            TriggerEvent('skinchanger:change', 'hair_color_2', cheveuxcolor2_index-1)
                        end
                    }, 1);
                    RageUI.PercentagePanel(barbeopacity_index, Config.Translate('beard_2'), '0%', '100%', {
                        onProgressChange = function(i)                          
                            barbeopacity_index = i
                            TriggerEvent('skinchanger:change', 'beard_2', i*10)
                        end
                    }, 2);
                    RageUI.ColourPanel(Config.Translate('beard_3'), RageUI.PanelColour.HairCut, Config.index.couleurbarbeprimaire[1], barbecolor_index, {
                        onColorChange = function(MinimumIndex, CurrentIndex)                           
                            Config.index.couleurbarbeprimaire[1] = MinimumIndex
                            barbecolor_index = CurrentIndex
                            TriggerEvent('skinchanger:change', 'beard_3', barbecolor_index-1)
                        end
                    }, 2);
                    RageUI.ColourPanel(Config.Translate('beard_4'), RageUI.PanelColour.HairCut, Config.index.couleurbarbesecondaire[1], barbecolor2_index, {
                        onColorChange = function(MinimumIndex, CurrentIndex)                       
                            Config.index.couleurbarbesecondaire[1] = MinimumIndex
                            barbecolor2_index = CurrentIndex
                            TriggerEvent('skinchanger:change', 'beard_4', barbecolor2_index-1)
                        end
                    }, 2);
                    RageUI.PercentagePanel(sourcilopacity_index, Config.Translate('eyebrows_2'), '0%', '100%', {
                        onProgressChange = function(i)                        
                            sourcilopacity_index = i
                            TriggerEvent('skinchanger:change', 'eyebrows_2', i*10)
                        end
                    }, 3);
                    RageUI.ColourPanel(Config.Translate('eyebrows_3'), RageUI.PanelColour.HairCut, Config.index.couleursourcilprimaire[1], sourcilcolor_index, {
                        onColorChange = function(MinimumIndex, CurrentIndex)                           
                            Config.index.couleursourcilprimaire[1] = MinimumIndex
                            sourcilcolor_index = CurrentIndex 
                            TriggerEvent('skinchanger:change', 'eyebrows_3', sourcilcolor_index-1)                  
                        end
                    }, 3);
                    RageUI.ColourPanel(Config.Translate('eyebrows_4'), RageUI.PanelColour.HairCut, Config.index.couleursourcilsecondaire[1], sourcilcolor2_index, {
                        onColorChange = function(MinimumIndex, CurrentIndex)                        
                            Config.index.couleursourcilsecondaire[1] = MinimumIndex
                            sourcilcolor2_index = CurrentIndex
                            TriggerEvent('skinchanger:change', 'eyebrows_4', sourcilcolor2_index-1) 
                        end
                    }, 3);
                    RageUI.PercentagePanel(maquillageopacity_index, Config.Translate('makeup_2'), '0%', '100%', {
                        onProgressChange = function(i)                  
                            maquillageopacity_index = i                            
                            TriggerEvent('skinchanger:change', 'makeup_2', i*10)
                        end
                    }, 4);
                    RageUI.ColourPanel(Config.Translate('makeup_3'), RageUI.PanelColour.HairCut, Config.index.couleurmaquillageprimaire[1], maquillagecolor_index, {
                        onColorChange = function(MinimumIndex, CurrentIndex)                           
                            Config.index.couleurmaquillageprimaire[1] = MinimumIndex
                            maquillagecolor_index = CurrentIndex
                            TriggerEvent('skinchanger:change', 'makeup_3', maquillagecolor_index-1)
                        end
                    }, 4);
                    RageUI.ColourPanel(Config.Translate('makeup_4'), RageUI.PanelColour.HairCut, Config.index.couleurmaquillagesecondaire[1], maquillagecolor2_index, {
                        onColorChange = function(MinimumIndex, CurrentIndex)                         
                            Config.index.couleurmaquillagesecondaire[1] = MinimumIndex
                            maquillagecolor2_index = CurrentIndex
                            TriggerEvent('skinchanger:change', 'makeup_4', maquillagecolor2_index-1)
                        end
                    }, 4);
                    RageUI.PercentagePanel(boucheopacity_index, Config.Translate('lipstick_2'), '0%', '100%', {
                        onProgressChange = function(i)                        
                            boucheopacity_index = i
                            TriggerEvent('skinchanger:change', 'lipstick_2', i*10)
                        end
                    }, 5);
                    RageUI.ColourPanel(Config.Translate('lipstick_3'), RageUI.PanelColour.HairCut, Config.index.couleurboucheprimaire[1], bouchecolor_index, {
                        onColorChange = function(MinimumIndex, CurrentIndex)                         
                            Config.index.couleurboucheprimaire[1] = MinimumIndex
                            bouchecolor_index = CurrentIndex
                            TriggerEvent('skinchanger:change', 'lipstick_3', bouchecolor_index-1)
                        end
                    }, 5);
                    RageUI.ColourPanel(Config.Translate('lipstick_4'), RageUI.PanelColour.HairCut, Config.index.couleurbouchesecondaire[1], bouchecolor2_index, {
                        onColorChange = function(MinimumIndex, CurrentIndex)                        
                            Config.index.couleurbouchesecondaire[1] = MinimumIndex
                            bouchecolor2_index = CurrentIndex
                            TriggerEvent('skinchanger:change', 'lipstick_4', bouchecolor2_index-1)
                        end                           
                    }, 5);
                end)
            Wait(0)
            end
        end)
    end
end

Citizen.CreateThread(function()
    while true do
        local wait = 900
        for k,v in pairs(Config.coords) do
            local coords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist(coords.x, coords.y, coords.z, v.x, v.y, v.z)
            if dist <= 2.0 then
                wait = 0
                DrawMarker(Config.marker.type, v.x, v.y, v.z, 0.0, 0.0, 0.0, Config.marker.rotation.x, Config.marker.rotation.y, Config.marker.rotation.z, Config.marker.scale.x, Config.marker.scale.y, Config.marker.scale.z, Config.marker.color.r, Config.marker.color.g, Config.marker.color.b, Config.marker.color.a, Config.marker.jump, false, p19, Config.marker.rotate)
                if dist <= 2.0 then
                    wait = 0
                    ESX.ShowHelpNotification(Config.Translate('marker_title'))
                    if IsControlJustPressed(1,51) then
                        FreezeEntityPosition(PlayerPedId(), true)
                        CreateCam()
                        GetBarberArray()
                        Barber()
                    end
                end
            end
        end
    Citizen.Wait(wait)
    end
end)

Citizen.CreateThread(function()
    for k,v in pairs(Config.coords) do
        local blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(blip, Config.blip.sprite)
        SetBlipScale (blip, Config.blip.scale)
        SetBlipColour(blip, Config.blip.colour)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(Config.Translate('blip_label'))
        EndTextCommandSetBlipName(blip)
    end
end)

function CreateCam()
	local coords = GetEntityCoords(PlayerPedId())
    cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', coords.x - 1.75, coords.y, coords.z + 1, 0.0, 0.0, 0.0, 20.0, true, true)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z+0.65)
    RenderScriptCams(true, true, 1500, true, true)
    local hcam = GetEntityHeading(cam)
    SetEntityHeading(PlayerPedId(), hcam+90)
end

function LoadCam()
    EnableControlAction(0, Config.key.activerdesactivercamera, true)
    EnableControlAction(0, Config.key.tourner90, true)
    if IsControlJustPressed(0, Config.key.tourner90) then
        local back = GetEntityHeading(PlayerPedId())
        SetEntityHeading(PlayerPedId(), back+90)
    end
    if IsControlJustPressed(0, Config.key.activerdesactivercamera) then
        pressed = not pressed
        if pressed then
            RenderScriptCams(false, true, 1000, true, true)
            DestroyAllCams(true)
        else
            CreateCam()
        end
    end
    if IsDisabledControlPressed(0, Config.key.tournerdroite) then
        SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())-1.5)
    elseif IsDisabledControlPressed(0, Config.key.tournergauche) then
        SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())+1.5)
    elseif IsDisabledControlPressed(0, Config.key.dezoomer) then
        SetCamFov(cam, GetCamFov(cam)+0.2)
    elseif IsDisabledControlPressed(0, Config.key.zoomer) then
        SetCamFov(cam, GetCamFov(cam)-0.2)
    end
end