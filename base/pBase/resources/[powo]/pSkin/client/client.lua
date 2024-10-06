if pSkin.ESX == "new" then
	ESX = exports["es_extended"]:getSharedObject()
elseif pSkin.ESX == "old" then
	ESX = nil
	Citizen.CreateThread(function()
		while ESX == nil do
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
			Citizen.Wait(0)
		end
	end)
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer) 
    ESX.PlayerData = xPlayer 
    ESX.PlayerLoaded = true 
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function() 
    ESX.PlayerLoaded = false 
    ESX.PlayerData = {} 
end)

local mainMenu = RageUI.CreateMenu("Menu Skin", "MENU")
local subMenu2 = RageUI.CreateSubMenu(mainMenu, "Menu Skin", "MENU")
local subMenu = RageUI.CreateSubMenu(subMenu2, "Menu Skin", "MENU")
local subMenu3 = RageUI.CreateSubMenu(mainMenu, "Gestion des favoris", "MENU")

mainMenu.Closed = function()
    skinmenu = false
end

subMenu2.Closed = function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
    DeleteSkinCam()
end

subMenu2:AddInstructionButton({[1] = GetControlInstructionalButton(0, pSkin.Key.TournerDroite, 0), [2] = "Tourner à Droite"})
subMenu2:AddInstructionButton({[1] = GetControlInstructionalButton(0, pSkin.Key.TournerGauche, 0), [2] = "Tourner à Gauche"})
subMenu2:AddInstructionButton({[1] = GetControlInstructionalButton(0, pSkin.Key.ActiverDesactiverCamera, 0), [2] = "Activer/Désactiver la Caméra"})
subMenu2:AddInstructionButton({[1] = GetControlInstructionalButton(0, pSkin.Key.Tourner90, 0), [2] = "Tourner 90°"})
subMenu2:AddInstructionButton({[1] = GetControlInstructionalButton(0, pSkin.Key.Dezoomer, 0), [2] = "Dézoomer"})
subMenu2:AddInstructionButton({[1] = GetControlInstructionalButton(0, pSkin.Key.Zoomer, 0), [2] = "Zoomer"})

skinData = {}
Index = 1

Citizen.CreateThread(function()
    while not ESX.PlayerLoaded do 
        Citizen.Wait(100) 
    end
    if pSkin.Legacy then
        TriggerEvent('skinchanger:getSkin', function(skin)
            TriggerServerEvent('esx_skin:setWeight', skin)
        end) 
    end
    TriggerServerEvent("pSkin:getData")
end)

RegisterNetEvent('pSkin:getData')
AddEventHandler('pSkin:getData', function(data)
    skinData = data
end)

local lastSkin, cam, isCameraActive
local firstSpawn, zoomOffset, camOffset, heading, skinLoaded = true, 0.0, 0.0, 90.0, false
angle = 90
isEdit = false

function CreateMain()
	local coords = GetEntityCoords(GetPlayerPed(-1))
    cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', coords.x-0.5, coords.y, coords.z, 0.0, 0.0, 270.0, 70.0, true, true)
    RenderScriptCams(true, true, 2000, true, true)
    isCamera()
    SetEntityHeading(GetPlayerPed(-1), 0.0)
end

function DeleteSkinCam()
    isCamera()
    RenderScriptCams(false, true, 1500, true, true)
    DestroyAllCams(true)
    FreezeEntityPosition(GetPlayerPed(-1), false)
end

local sex,sex1 = {},1
local face,face1 = {},1
local teint,teint1 = {},1
local nose,nose1 = {},1
local nose2,nose12 = {},1
local nose3,nose13 = {},1
local nose4,nose14 = {},1
local nose5,nose15 = {},1
local nose6,nose16 = {},1
local cheeks,cheeks1 = {},1
local cheeks2,cheeks12 = {},1
local cheeks3,cheeks13 = {},1
local lip_thickness,lip_thickness1 = {},1
local jaw,jaw1 = {},1
local jaw2,jaw12 = {},1
local chin,chin1 = {},1
local chin2,chin12 = {},1
local chin3,chin13 = {},1
local chin4,chin14 = {},1
local neck_thickness,neck_thickness1 = {},1
local hair,hair1 = {},1
local hair2,hair12 = {},1
local haircolor,haircolor1 = {},1
local haircolor2,haircolor12 = {},1
local tshirt,tshirt1 = {},1
local tshirtcolor,tshirtcolor1 = {},1
local torso,torso1 = {},1
local torsocolor,torsocolor1 = {},1
local decals,decals1 = {},1
local decalscolor,decalscolor1 = {},1
local arms,arms1 = {},1
local arms2,arms12 = {},1
local pants,pants1 = {},1
local pantscolor,pantscolor1 = {},1
local shoes,shoes1 = {},1
local shoescolor,shoescolor1 = {},1
local mask,mask1 = {},1
local maskcolor,maskcolor1 = {},1
local bproof,bproof1 = {},1
local bproofcolor,bproofcolor1 = {},1
local chain,chain1 = {},1
local chaincolor,chaincolor1 = {},1
local helmet,helmet1 = {},1
local helmetcolor,helmetcolor1 = {},1
local glasses,glasses1 = {},1
local glassescolor,glassescolor1 = {},1
local watches,watches1 = {},1
local watchescolor,watchescolor1 = {},1
local bracelets,bracelets1 = {},1
local braceletscolor,braceletscolor1 = {},1
local bags,bags1 = {},1
local bagscolor,bagscolor1 = {},1
local eyecolor,eyecolor1 = {},1
local eyesquint,eyesquint1 = {},1
local eyebrows,eyebrows1 = {},1
local eyebrows2,eyebrows12 = {},1
local eyebrows3,eyebrows13 = {},1
local eyebrows4,eyebrows14 = {},1
local eyebrows5,eyebrows15 = {},1
local eyebrows6,eyebrows16 = {},1
local makeup,makeup1 = {},1
local makeup2,makeup12 = {},1
local makeup3,makeup13 = {},1
local makeup4,makeup14 = {},1
local lipstick,lipstick1 = {},1
local lipstick2,lipstick12 = {},1
local lipstick3,lipstick13 = {},1
local lipstick4,lipstick14 = {},1
local ears,ears1 = {},1
local earscolor,earscolor1 = {},1
local chest,chest1 = {},1
local chest2,chest12 = {},1
local chest3,chest13 = {},1
local bodyb,bodyb1 = {},1
local bodyb2,bodyb12 = {},1
local bodyb3,bodyb13 = {},1
local bodyb4,bodyb14 = {},1
local age,age1 = {},1
local age2,age12 = {},1
local blemishes,blemishes1 = {},1
local blemishes2,blemishes12 = {},1
local blush,blush1 = {},1
local blush2,blush12 = {},1
local blush3,blush13 = {},1
local complexion,complexion1 = {},1
local complexion2,complexion12 = {},1
local sun,sun1 = {},1
local sun2,sun12 = {},1
local moles,moles1 = {},1
local moles2,moles12 = {},1
local beard,beard1 = {},1
local beard2,beard12 = {},1
local beard3,beard13 = {},1
local beard4,beard14 = {},1

function GetIndex()
    for i = 0, 2, 1 do sex[i] = i end
    for i = 0, 45, 1 do face[i] = i end
    for i = 0, 100, 1 do teint[i] = i end
    for i = 0, 10, 1 do nose[i] = i end
    for i = 0, 10, 1 do nose2[i] = i end
    for i = 0, 10, 1 do nose3[i] = i end
    for i = 0, 10, 1 do nose4[i] = i end
    for i = 0, 10, 1 do nose5[i] = i end
    for i = 0, 10, 1 do nose6[i] = i end
    for i = 0, 10, 1 do cheeks[i] = i end
    for i = 0, 10, 1 do cheeks2[i] = i end
    for i = 0, 10, 1 do cheeks3[i] = i end
    for i = 0, 10, 1 do lip_thickness[i] = i end
    for i = 0, 10, 1 do jaw[i] = i end
    for i = 0, 10, 1 do jaw2[i] = i end
    for i = 0, 10, 1 do chin[i] = i end
    for i = 0, 10, 1 do chin2[i] = i end
    for i = 0, 10, 1 do chin3[i] = i end
    for i = 0, 10, 1 do chin4[i] = i end
    for i = 0, 10, 1 do neck_thickness[i] = i end
    for i = 0, GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 2)-1, 1 do hair[i] = i end
    for i = 0, GetNumHairColors()-1, 1 do haircolor[i] = i end
    for i = 0, GetNumHairColors()-1, 1 do haircolor2[i] = i end
    for i = 0, GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 11)-1, 1 do torso[i] = i end 
    for i = 0, GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 8)-1, 1 do tshirt[i] = i end
    for i = 0, GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 10)-1, 1 do decals[i] = i end
    for i = 0, GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 3)-1, 1 do arms[i] = i end
    for i = 0, 10, 1 do arms2[i] = i end     
    for i = 0, GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 4)-1, 1 do pants[i] = i end
    for i = 0, GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 6)-1, 1 do shoes[i] = i end
    for i = 0, GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 1)-1, 1 do mask[i] = i end
    for i = 0, GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 9)-1, 1 do bproof[i] = i end
    for i = 0, GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 7)-1, 1 do chain[i] = i end
    for i = 0, GetNumberOfPedPropDrawableVariations(GetPlayerPed(-1), 0)-1, 1 do helmet[i] = i end
    for i = 0, GetNumberOfPedPropDrawableVariations(GetPlayerPed(-1), 1)-1, 1 do glasses[i] = i end
    for i = 0, GetNumberOfPedPropDrawableVariations(GetPlayerPed(-1), 6)-1, 1 do watches[i] = i end
    for i = 0, GetNumberOfPedPropDrawableVariations(GetPlayerPed(-1), 7)-1, 1 do bracelets[i] = i end
    for i = 0, GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 5)-1, 1 do bags[i] = i end
    for i = 0, 31, 1 do eyecolor[i] = i end
    for i = 0, 10, 1 do eyesquint[i] = i end
    for i = 0, GetPedHeadOverlayNum(2)-1, 1 do eyebrows[i] = i end
    for i = 0, 10, 1 do eyebrows2[i] = i end
    for i = 0, GetNumHairColors()-1, 1 do eyebrows3[i] = i end
    for i = 0, GetNumHairColors()-1, 1 do eyebrows4[i] = i end
    for i = 0, 31, 1 do eyebrows5[i] = i end
    for i = 0, 10, 1 do eyebrows6[i] = i end
    for i = 0, GetPedHeadOverlayNum(4)-1, 1 do makeup[i] = i end
    for i = 0, 10, 1 do makeup2[i] = i end
    for i = 0, GetNumHairColors()-1, 1 do makeup3[i] = i end
    for i = 0, GetNumHairColors()-1, 1 do makeup4[i] = i end
    for i = 0, GetPedHeadOverlayNum(8)-1, 1 do lipstick[i] = i end
    for i = 0, 10, 1 do lipstick2[i] = i end
    for i = 0, GetNumHairColors()-1, 1 do lipstick3[i] = i end
    for i = 0, GetNumHairColors()-1, 1 do lipstick4[i] = i end
    for i = 0, GetNumberOfPedPropDrawableVariations(GetPlayerPed(-1), 2)-1, 1 do ears[i] = i end
    for i = 0, GetPedHeadOverlayNum(10)-1, 1 do chest[i] = i end
    for i = 0, 10, 1 do chest2[i] = i end
    for i = 0, GetNumHairColors()-1, 1 do chest3[i] = i end
    for i = 0, GetPedHeadOverlayNum(11)-1, 1 do bodyb[i] = i end
    for i = 0, 10, 1 do bodyb2[i] = i end
    for i = 0, GetPedHeadOverlayNum(12)-1, 1 do bodyb3[i] = i end
    for i = 0, 10, 1 do bodyb4[i] = i end
    for i = 0, GetPedHeadOverlayNum(3)-1, 1 do age[i] = i end
    for i = 0, 10, 1 do age2[i] = i end
    for i = 0, GetPedHeadOverlayNum(0)-1, 1 do blemishes[i] = i end
    for i = 0, 10, 1 do blemishes2[i] = i end
    for i = 0, GetPedHeadOverlayNum(5)-1, 1 do blush[i] = i end
    for i = 0, 10, 1 do blush2[i] = i end
    for i = 0, GetNumHairColors()-1, 1 do blush3[i] = i end
    for i = 0, GetPedHeadOverlayNum(6)-1, 1 do complexion[i] = i end
    for i = 0, 10, 1 do complexion2[i] = i end
    for i = 0, GetPedHeadOverlayNum(7)-1, 1 do sun[i] = i end
    for i = 0, 10, 1 do sun2[i] = i end
    for i = 0, GetPedHeadOverlayNum(9)-1, 1 do moles[i] = i end
    for i = 0, 10, 1 do moles2[i] = i end
    for i = 0, GetPedHeadOverlayNum(1)-1, 1 do beard[i] = i end
    for i = 0, 10, 1 do beard2[i] = i end
    for i = 0, GetNumHairColors()-1, 1 do beard3[i] = i end
    for i = 0, GetNumHairColors()-1, 1 do beard4[i] = i end

    hair2,tshirtcolor,torsocolor,decalscolor,pantscolor,shoescolor,maskcolor,bproofcolor,chaincolor,helmetcolor,glassescolor,watchescolor,braceletscolor,bagscolor,earscolor = {},{},{},{},{},{},{},{},{},{},{},{},{},{},{}
    for i = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 2, hair1-1), 1 do hair2[i] = i end
    for i = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 8, tshirt1-1), 1 do tshirtcolor[i] = i end
    for i = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 11, torso1-1), 1 do torsocolor[i] = i end
    for i = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 10, decals1-1), 1 do decalscolor[i] = i end
    for i = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 4, pants1-1), 1 do pantscolor[i] = i end
    for i = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 6, shoes1-1), 1 do shoescolor[i] = i end
    for i = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 1, mask1-1), 1 do maskcolor[i] = i end
    for i = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 9, bproof1-1), 1 do bproofcolor[i] = i end
    for i = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 7, chain1-1), 1 do chaincolor[i] = i end
    for i = 0, GetNumberOfPedPropTextureVariations(PlayerPedId(), 0, helmet1-2), 1 do helmetcolor[i] = i end
    for i = 0, GetNumberOfPedPropTextureVariations(PlayerPedId(), 1, glasses1-2), 1 do glassescolor[i] = i end
    for i = 0, GetNumberOfPedPropTextureVariations(PlayerPedId(), 6, watches1-2), 1 do watchescolor[i] = i end
    for i = 0, GetNumberOfPedPropTextureVariations(PlayerPedId(), 7, bracelets1-2), 1 do braceletscolor[i] = i end
    for i = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 5, bags1-1), 1 do bagscolor[i] = i end
    for i = 0, GetNumberOfPedPropTextureVariations(PlayerPedId(), 2, ears1-3), 1 do earscolor[i] = i end

    -- ## A Enlever si jamais BUG
    if GetNumberOfPedPropTextureVariations(PlayerPedId(), 0, helmet1-2) == 0 then
        helmetcolor = {1}
    end
    if GetNumberOfPedPropTextureVariations(PlayerPedId(), 1, glasses1-2) == 0 then
        glassescolor = {1}  
    end 
    if GetNumberOfPedPropTextureVariations(PlayerPedId(), 6, watches1-2) == 0 then
        watchescolor = {1}
    end
    if GetNumberOfPedPropTextureVariations(PlayerPedId(), 7, bracelets1-2) == 0 then
        braceletscolor = {1}
    end
    if GetNumberOfPedPropTextureVariations(PlayerPedId(), 2, ears1-3) == 0 then
        earscolor = {1}
    end
end

function GetSkinValue()
    TriggerEvent('skinchanger:getSkin', function(skin)
        sex1 = skin.sex+1
        face1 = skin.face+1
        teint1 = skin.skin+1
        nose1 = skin.nose_1+1
        nose12 = skin.nose_2+1
        nose13 = skin.nose_3+1
        nose14 = skin.nose_4+1
        nose15 = skin.nose_5+1
        nose16 = skin.nose_6+1
        cheeks1 = skin.cheeks_1+1
        cheeks12 = skin.cheeks_2+1
        cheeks13 = skin.cheeks_3+1
        lip_thickness1 = skin.lip_thickness+1
        jaw1 = skin.jaw_1+1
        jaw12 = skin.jaw_2+1
        chin1 = skin.chin_1+1
        chin12 = skin.chin_2+1
        chin13 = skin.chin_3+1
        chin14 = skin.chin_4+1
        neck_thickness1 = skin.neck_thickness+1
        hair1 = skin.hair_1+1
        hair12 = skin.hair_2+1
        haircolor1 = skin.hair_color_1+1
        haircolor12 = skin.hair_color_2+1
        tshirt1 = skin.tshirt_1+1
        tshirtcolor1 = skin.tshirt_2+1
        torso1 = skin.torso_1+1
        torsocolor1 = skin.torso_2+1
        decals1 = skin.decals_1+1
        decalscolor1 = skin.decals_2+1
        arms1 = skin.arms+1
        arms12 = skin.arms_2+1
        pants1 = skin.pants_1+1
        pantscolor1 = skin.pants_2+1
        shoes1 = skin.shoes_1+1
        shoescolor1 = skin.shoes_2+1
        mask1 = skin.mask_1+1
        maskcolor1 = skin.mask_2+1
        bproof1 = skin.bproof_1+1
        bproofcolor1 = skin.bproof_2+1
        chain1 = skin.chain_1+1
        chaincolor1 = skin.chain_2+1
        helmet1 = skin.helmet_1+2
        helmetcolor1 = skin.helmet_2+1
        glasses1 = skin.glasses_1+1
        glassescolor1 = skin.glasses_2+1
        watches1 = skin.watches_1+2
        watchescolor1 = skin.watches_2+1
        bracelets1 = skin.bracelets_1+2
        braceletscolor1 = skin.bracelets_2+1
        bags1 = skin.bags_1+1
        bagscolor1 = skin.bags_2+1
        eyecolor1 = skin.eye_color+1
        eyesquint1 = skin.eye_squint+1
        eyebrows1 = skin.eyebrows_1+1
        if pSkin.Type == "simple" then
            eyebrows12 = skin.eyebrows_2+1
        elseif pSkin.Type == "advanced" then 
            eyebrows12 = skin.eyebrows_2
        end
        eyebrows13 = skin.eyebrows_3+1
        eyebrows14 = skin.eyebrows_4+1
        eyebrows15 = skin.eyebrows_5+1
        eyebrows16 = skin.eyebrows_6+1
        makeup1 = skin.makeup_1+1
        makeup12 = skin.makeup_2+1
        makeup13 = skin.makeup_3+1
        makeup14 = skin.makeup_4+1
        lipstick1 = skin.lipstick_1+1
        lipstick12 = skin.lipstick_2+1
        lipstick13 = skin.lipstick_3+1
        lipstick14 = skin.lipstick_4+1
        ears1 = skin.ears_1+2
        earscolor1 = skin.ears_2+1
        chest1 = skin.chest_1+1
        chest12 = skin.chest_2+1
        chest13 = skin.chest_3+1
        bodyb1 = skin.bodyb_1+1
        bodyb12 = skin.bodyb_2+1
        bodyb13 = skin.bodyb_3+1
        bodyb14 = skin.bodyb_4+1
        age1 = skin.age_1+1
        age12 = skin.age_2+1
        blemishes1 = skin.blemishes_1+1
        blemishes12 = skin.blemishes_2+1
        blush1 = skin.blush_1+1
        blush12 = skin.blush_2+1
        blush13 = skin.blush_3+1
        complexion1 = skin.complexion_1+1
        complexion12 = skin.complexion_2+1
        sun1 = skin.sun_1+1
        sun12 = skin.sun_2+1
        moles1 = skin.moles_1+1
        moles12 = skin.moles_2+1
        beard1 = skin.beard_1+1
        beard12 = skin.beard_2+1
        beard13 = skin.beard_3+1
        beard14 = skin.beard_4+1
    end)
end

iIndex = {
    Hair = 1,
    Hair2 = 1,
    Sourcil = 1,
    Sourcil2 = 1
}

function OpenMenu()
    if not CheckAllowedPermission and not CheckAllowedGroup then
        mainMenu.Closable = false
        subMenu2.Closable = false
    end
    if not skinmenu then skinmenu = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
		    while skinmenu do
                RageUI.IsVisible(mainMenu,function()
                    mainMenu:UpdateInstructionalButtons(true)
                    RageUI.Button("Modification du personnage", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            CreateMain()
                            FreezeEntityPosition(GetPlayerPed(-1), true)
                        end
                    }, subMenu2)
                    if CheckAllowedPermission or CheckAllowedGroup then
                        RageUI.Button("Gestion des favoris", nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                TriggerEvent('skinchanger:getSkin', function(skin)
                                    PostSkin = skin
                                end)
                            end
                        }, subMenu3)
                    end
                end)
                RageUI.IsVisible(subMenu2,function()
                    GetIndex()
                    Load_Skin()
                    subMenu2:UpdateInstructionalButtons(true)
                    if pSkin.Type == "simple" then
                        RageUI.List("Sexe", sex, sex1, nil, {}, true, {
                            onListChange = function(Index)
                                sex1 = Index
                                TriggerEvent("skinchanger:change", "sex", sex1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.6
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Visage", face, face1, nil, {}, true, {
                            onListChange = function(Index)
                                face1 = Index
                                TriggerEvent("skinchanger:change", "face", face1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.6
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Teint", teint, teint1, nil, {}, true, {
                            onListChange = function(Index)
                                teint1 = Index                          
                                TriggerEvent("skinchanger:change", "skin", teint1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.6
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Largeur du nez", nose, nose1, nil, {}, true, {
                            onListChange = function(Index)
                                nose1 = Index                          
                                TriggerEvent("skinchanger:change", "nose_1", nose1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.6
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Hauteur du pic du nez", nose2, nose12, nil, {}, true, {
                            onListChange = function(Index)
                                nose12 = Index                          
                                TriggerEvent("skinchanger:change", "nose_2", nose12-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.6
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Longueur du pic du nez", nose3, nose13, nil, {}, true, {
                            onListChange = function(Index)
                                nose13 = Index                          
                                TriggerEvent("skinchanger:change", "nose_3", nose13-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.6
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Hauteur de l'os du nez", nose4, nose14, nil, {}, true, {
                            onListChange = function(Index)
                                nose14 = Index                          
                                TriggerEvent("skinchanger:change", "nose_4", nose14-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.6
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Abaissement du pic du nez", nose5, nose15, nil, {}, true, {
                            onListChange = function(Index)
                                nose15 = Index                          
                                TriggerEvent("skinchanger:change", "nose_5", nose15-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.6
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Torsion de l'os du nez", nose6, nose16, nil, {}, true, {
                            onListChange = function(Index)
                                nose16 = Index                          
                                TriggerEvent("skinchanger:change", "nose_6", nose16-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.6
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Hauteur des pommettes", cheeks, cheeks1, nil, {}, true, {
                            onListChange = function(Index)
                                cheeks1 = Index                          
                                TriggerEvent("skinchanger:change", "cheeks_1", cheeks1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Largeur des pommettes", cheeks2, cheeks12, nil, {}, true, {
                            onListChange = function(Index)
                                cheeks12 = Index                          
                                TriggerEvent("skinchanger:change", "cheeks_2", cheeks12-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Largeur des joues", cheeks3, cheeks13, nil, {}, true, {
                            onListChange = function(Index)
                                cheeks13 = Index                          
                                TriggerEvent("skinchanger:change", "cheeks_3", cheeks13-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Plénitude des lèvres", lip_thickness, lip_thickness1, nil, {}, true, {
                            onListChange = function(Index)
                                lip_thickness1 = Index                          
                                TriggerEvent("skinchanger:change", "lip_thickness", lip_thickness1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Largeur de l'os de la mâchoire", jaw, jaw1, nil, {}, true, {
                            onListChange = function(Index)
                                jaw1 = Index                          
                                TriggerEvent("skinchanger:change", "jaw_1", jaw1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Longueur de l'os de la mâchoire", jaw2, jaw12, nil, {}, true, {
                            onListChange = function(Index)
                                jaw12 = Index                          
                                TriggerEvent("skinchanger:change", "jaw_2", jaw12-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Hauteur du menton", chin, chin1, nil, {}, true, {
                            onListChange = function(Index)
                                chin1 = Index                          
                                TriggerEvent("skinchanger:change", "chin_1", chin1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Longueur du menton", chin2, chin12, nil, {}, true, {
                            onListChange = function(Index)
                                chin12 = Index                          
                                TriggerEvent("skinchanger:change", "chin_2", chin12-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Largeur du menton", chin3, chin13, nil, {}, true, {
                            onListChange = function(Index)
                                chin13 = Index                          
                                TriggerEvent("skinchanger:change", "chin_3", chin13-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Taille du trou du menton", chin4, chin14, nil, {}, true, {
                            onListChange = function(Index)
                                chin14 = Index                          
                                TriggerEvent("skinchanger:change", "chin_4", chin14-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Épaisseur du cou", neck_thickness, neck_thickness1, nil, {}, true, {
                            onListChange = function(Index)
                                neck_thickness1 = Index                          
                                TriggerEvent("skinchanger:change", "neck_thickness", neck_thickness1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Cheveux 1", hair, hair1, nil, {}, true, {
                            onListChange = function(Index)
                                hair1 = Index                          
                                TriggerEvent("skinchanger:change", "hair_1", hair1-1)
                                hair12 = 1                         
                                TriggerEvent("skinchanger:change", "hair_2", hair12-1) 
                            end,
                            onActive = function()
                                zoomOffset = 0.6
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Cheveux 2", hair2, hair12, nil, {}, true, {
                            onListChange = function(Index)
                                hair12 = Index                          
                                TriggerEvent("skinchanger:change", "hair_2", hair12-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.6
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Couleur de cheveux 1", haircolor, haircolor1, nil, {}, true, {
                            onListChange = function(Index)
                                haircolor1 = Index                          
                                TriggerEvent("skinchanger:change", "hair_color_1", haircolor1-1)
                                haircolor12 = 1                          
                                TriggerEvent("skinchanger:change", "hair_color_2", haircolor12-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.6
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Couleur de cheveux 2", haircolor2, haircolor12, nil, {}, true, {
                            onListChange = function(Index)
                                haircolor12 = Index                          
                                TriggerEvent("skinchanger:change", "hair_color_2", haircolor12-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.6
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("T-Shirt 1", tshirt, tshirt1, nil, {}, true, {
                            onListChange = function(Index)
                                tshirt1 = Index
                                TriggerEvent("skinchanger:change", "tshirt_1", tshirt1-1)
                                tshirtcolor1 = 1
                                TriggerEvent("skinchanger:change", "tshirt_2", tshirtcolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end 
                        })
                        RageUI.List("T-Shirt 2", tshirtcolor, tshirtcolor1, nil, {}, true, {
                            onListChange = function(Index)
                                tshirtcolor1 = Index
                                TriggerEvent("skinchanger:change", "tshirt_2", tshirtcolor1-1)                            
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end
                        }, subMenu)
                        RageUI.List("Torse 1", torso, torso1, nil, {}, true, {
                            onListChange = function(Index)
                                torso1 = Index                          
                                TriggerEvent("skinchanger:change", "torso_1", torso1-1)
                                torsocolor1 = 1                         
                                TriggerEvent("skinchanger:change", "torso_2", torsocolor1-1) 
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end
                        }, subMenu)
                        RageUI.List("Torse 2", torsocolor, torsocolor1, nil, {}, true, {
                            onListChange = function(Index)
                                torsocolor1 = Index
                                TriggerEvent("skinchanger:change", "torso_2", torsocolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end
                        }, subMenu)
                        RageUI.List("Calque 1", decals, decals1, nil, {}, true, {
                            onListChange = function(Index)
                                decals1 = Index
                                TriggerEvent("skinchanger:change", "decals_1", decals1-1)
                                decalscolor1 = 1
                                TriggerEvent("skinchanger:change", "decals_2", decalscolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end
                        }, subMenu)
                        RageUI.List("Calque 2", decalscolor, decalscolor1, nil, {}, true, {
                            onListChange = function(Index)
                                decalscolor1 = Index
                                TriggerEvent("skinchanger:change", "decals_2", decalscolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end
                        }, subMenu)
                        RageUI.List("Bras 1", arms, arms1, nil, {}, true, {
                            onListChange = function(Index)
                                arms1 = Index
                                TriggerEvent("skinchanger:change", "arms", arms1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end
                        }, subMenu)
                        RageUI.List("Bras 2", arms2, arms12, nil, {}, true, {
                            onListChange = function(Index)
                                arms12 = Index
                                TriggerEvent("skinchanger:change", "arms_2", arms12-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end
                        }, subMenu)
                        RageUI.List("Pantalon 1", pants, pants1, nil, {}, true, {
                            onListChange = function(Index)
                                pants1 = Index
                                TriggerEvent("skinchanger:change", "pants_1", pants1-1)
                                pantscolor1 = 1
                                TriggerEvent("skinchanger:change", "pants_2", pantscolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.8
                                camOffset = -0.5
                            end
                        }, subMenu)
                        RageUI.List("Pantalon 2", pantscolor, pantscolor1, nil, {}, true, {
                            onListChange = function(Index)
                                pantscolor1 = Index
                                TriggerEvent("skinchanger:change", "pants_2", pantscolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.8
                                camOffset = -0.5
                            end
                        }, subMenu)
                        RageUI.List("Chaussure 1", shoes, shoes1, nil, {}, true, {
                            onListChange = function(Index)
                                shoes1 = Index
                                TriggerEvent("skinchanger:change", "shoes_1", shoes1-1)
                                shoescolor1 = 1
                                TriggerEvent("skinchanger:change", "shoes_2", shoescolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.8
                                camOffset = -0.8
                            end
                        }, subMenu)
                        RageUI.List("Chaussure 2", shoescolor, shoescolor1, nil, {}, true, {
                            onListChange = function(Index)
                                shoescolor1 = Index
                                TriggerEvent("skinchanger:change", "shoes_2", shoescolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.8
                                camOffset = -0.8
                            end
                        }, subMenu)
                        RageUI.List("Masque 1", mask, mask1, nil, {}, true, {
                            onListChange = function(Index)
                                mask1 = Index
                                TriggerEvent("skinchanger:change", "mask_1", mask1-1)
                                maskcolor1 = 1
                                TriggerEvent("skinchanger:change", "mask_2", maskcolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.6
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Masque 2", maskcolor, maskcolor1, nil, {}, true, {
                            onListChange = function(Index)
                                maskcolor1 = Index
                                TriggerEvent("skinchanger:change", "mask_2", maskcolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.6
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Gilet par balle 1", bproof, bproof1, nil, {}, true, {
                            onListChange = function(Index)
                                bproof1 = Index
                                TriggerEvent("skinchanger:change", "bproof_1", bproof1-1)
                                bproofcolor1 = 1
                                TriggerEvent("skinchanger:change", "bproof_2", bproofcolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end
                        }, subMenu)
                        RageUI.List("Gilet par balle 2", bproofcolor, bproofcolor1, nil, {}, true, {
                            onListChange = function(Index)
                                bproofcolor1 = Index
                                TriggerEvent("skinchanger:change", "bproof_2", bproofcolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end
                        }, subMenu)
                        RageUI.List("Chaine 1", chain, chain1, nil, {}, true, {
                            onListChange = function(Index)
                                chain1 = Index
                                TriggerEvent("skinchanger:change", "chain_1", chain1-1)
                                chaincolor1 = 1
                                TriggerEvent("skinchanger:change", "chain_2", chaincolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.6
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Chaine 2", chaincolor, chaincolor1, nil, {}, true, {
                            onListChange = function(Index)
                                chaincolor1 = Index
                                TriggerEvent("skinchanger:change", "chain_2", chaincolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.6
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Casque 1", helmet, helmet1, nil, {}, true, {
                            onListChange = function(Index)
                                helmet1 = Index
                                TriggerEvent("skinchanger:change", "helmet_1", helmet1-2)
                                helmetcolor1 = 1
                                TriggerEvent("skinchanger:change", "helmet_2", helmetcolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.6
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Casque 2", helmetcolor, helmetcolor1, nil, {}, true, {
                            onListChange = function(Index)
                                helmetcolor1 = Index
                                TriggerEvent("skinchanger:change", "helmet_2", helmetcolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.6
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Lunette 1", glasses, glasses1, nil, {}, true, {
                            onListChange = function(Index)
                                glasses1 = Index
                                TriggerEvent("skinchanger:change", "glasses_1", glasses1-1)
                                glassescolor1 = 1
                                TriggerEvent("skinchanger:change", "glasses_2", glassescolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.6
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Lunette 2", glassescolor, glassescolor1, nil, {}, true, {
                            onListChange = function(Index)
                                glassescolor1 = Index
                                TriggerEvent("skinchanger:change", "glasses_2", glassescolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.6
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Montre 1", watches, watches1, nil, {}, true, {
                            onListChange = function(Index)
                                watches1 = Index
                                TriggerEvent("skinchanger:change", "watches_1", watches1-2)
                                watchescolor1 = 1
                                TriggerEvent("skinchanger:change", "watches_2", watchescolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end
                        }, subMenu)
                        RageUI.List("Montre 2", watchescolor, watchescolor1, nil, {}, true, {
                            onListChange = function(Index)
                                watchescolor1 = Index
                                TriggerEvent("skinchanger:change", "watches_2", watchescolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end
                        }, subMenu)
                        RageUI.List("Bracelet 1", bracelets, bracelets1, nil, {}, true, {
                            onListChange = function(Index)
                                bracelets1 = Index
                                TriggerEvent("skinchanger:change", "bracelets_1", bracelets1-2)
                                braceletscolor1 = 1
                                TriggerEvent("skinchanger:change", "bracelets_2", braceletscolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end
                        }, subMenu)
                        RageUI.List("Bracelet 2", braceletscolor, braceletscolor1, nil, {}, true, {
                            onListChange = function(Index)
                                braceletscolor1 = Index
                                TriggerEvent("skinchanger:change", "bracelets_2", braceletscolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end
                        }, subMenu)
                        RageUI.List("Sac 1", bags, bags1, nil, {}, true, {
                            onListChange = function(Index)
                                bags1 = Index
                                TriggerEvent("skinchanger:change", "bags_1", bags1-1)
                                bagscolor1 = 1
                                TriggerEvent("skinchanger:change", "bags_2", bagscolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end
                        }, subMenu)
                        RageUI.List("Sac 2", bagscolor, bagscolor1, nil, {}, true, {
                            onListChange = function(Index)
                                bagscolor1 = Index
                                TriggerEvent("skinchanger:change", "bags_2", bagscolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end
                        }, subMenu)
                        RageUI.List("Couleur des yeux", eyecolor, eyecolor1, nil, {}, true, {
                            onListChange = function(Index)
                                eyecolor1 = Index
                                TriggerEvent("skinchanger:change", "eye_color", eyecolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Strabisme", eyesquint, eyesquint1, nil, {}, true, {
                            onListChange = function(Index)
                                eyesquint1 = Index
                                TriggerEvent("skinchanger:change", "eye_squint", eyesquint1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)                        
                        RageUI.List("Type de sourcil", eyebrows, eyebrows1, nil, {}, true, {
                            onListChange = function(Index)
                                eyebrows1 = Index
                                TriggerEvent("skinchanger:change", "eyebrows_1", eyebrows1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Taille des sourcils", eyebrows2, eyebrows12, nil, {}, true, {
                            onListChange = function(Index)
                                eyebrows12 = Index
                                TriggerEvent("skinchanger:change", "eyebrows_2", eyebrows12-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Couleur des sourcils 1", eyebrows3, eyebrows13, nil, {}, true, {
                            onListChange = function(Index)
                                eyebrows13 = Index
                                TriggerEvent("skinchanger:change", "eyebrows_3", eyebrows13-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Couleur des sourcils 2", eyebrows4, eyebrows14, nil, {}, true, {
                            onListChange = function(Index)
                                eyebrows14 = Index
                                TriggerEvent("skinchanger:change", "eyebrows_4", eyebrows14-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Hauteur des sourcils", eyebrows5, eyebrows15, nil, {}, true, {
                            onListChange = function(Index)
                                eyebrows15 = Index
                                TriggerEvent("skinchanger:change", "eyebrows_5", eyebrows15-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Profondeur des sourcils", eyebrows6, eyebrows16, nil, {}, true, {
                            onListChange = function(Index)
                                eyebrows16 = Index
                                TriggerEvent("skinchanger:change", "eyebrows_6", eyebrows16-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)    
                        RageUI.List("Type de maquillage", makeup, makeup1, nil, {}, true, {
                            onListChange = function(Index)
                                makeup1 = Index
                                TriggerEvent("skinchanger:change", "makeup_1", makeup1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Épaisseur de maquillage", makeup2, makeup12, nil, {}, true, {
                            onListChange = function(Index)
                                makeup12 = Index
                                TriggerEvent("skinchanger:change", "makeup_2", makeup12-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Maquillage couleur 1", makeup3, makeup13, nil, {}, true, {
                            onListChange = function(Index)
                                makeup13 = Index
                                TriggerEvent("skinchanger:change", "makeup_3", makeup13-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Maquillage couleur 2", makeup4, makeup14, nil, {}, true, {
                            onListChange = function(Index)
                                makeup14 = Index
                                TriggerEvent("skinchanger:change", "makeup_4", makeup14-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Type de rouge à lèvres", lipstick, lipstick1, nil, {}, true, {
                            onListChange = function(Index)
                                lipstick1 = Index
                                TriggerEvent("skinchanger:change", "lipstick_1", lipstick1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Épaisseur du rouge à lèvres", lipstick2, lipstick12, nil, {}, true, {
                            onListChange = function(Index)
                                lipstick12 = Index
                                TriggerEvent("skinchanger:change", "lipstick_2", lipstick12-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Couleur de rouge à lèvres 1", lipstick3, lipstick13, nil, {}, true, {
                            onListChange = function(Index)
                                lipstick13 = Index
                                TriggerEvent("skinchanger:change", "lipstick_3", lipstick13-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Couleur de rouge à lèvres 2", lipstick4, lipstick14, nil, {}, true, {
                            onListChange = function(Index)
                                lipstick14 = Index
                                TriggerEvent("skinchanger:change", "lipstick_4", lipstick14-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Accessoire d'Oreille 1", ears, ears1, nil, {}, true, {
                            onListChange = function(Index)
                                ears1 = Index
                                TriggerEvent("skinchanger:change", "ears_1", ears1-2)
                                earscolor1 = 1
                                TriggerEvent("skinchanger:change", "ears_2", earscolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Accessoire d'Oreille 2", earscolor, earscolor1, nil, {}, true, {
                            onListChange = function(Index)
                                earscolor1 = Index
                                TriggerEvent("skinchanger:change", "ears_2", earscolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Poils du torse", chest, chest1, nil, {}, true, {
                            onListChange = function(Index)
                                chest1 = Index                          
                                TriggerEvent("skinchanger:change", "chest_1", chest1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end
                        }, subMenu)
                        RageUI.List("Poils du torse 2", chest2, chest12, nil, {}, true, {
                            onListChange = function(Index)
                                chest12 = Index                          
                                TriggerEvent("skinchanger:change", "chest_2", chest12-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end
                        }, subMenu)
                        RageUI.List("Couleur poils du torse", chest3, chest13, nil, {}, true, {
                            onListChange = function(Index)
                                chest13 = Index                          
                                TriggerEvent("skinchanger:change", "chest_3", chest13-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end
                        }, subMenu)
                        RageUI.List("Imperfections du corps", bodyb, bodyb1, nil, {}, true, {
                            onListChange = function(Index)
                                bodyb1 = Index
                                TriggerEvent("skinchanger:change", "bodyb_1", bodyb1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end
                        }, subMenu)
                        RageUI.List("Imperfections du corps 2", bodyb2, bodyb12, nil, {}, true, {
                            onListChange = function(Index)
                                bodyb12 = Index
                                TriggerEvent("skinchanger:change", "bodyb_2", bodyb12-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end
                        }, subMenu)
                        RageUI.List("Effet corps", bodyb3, bodyb13, nil, {}, true, {
                            onListChange = function(Index)
                                bodyb13 = Index
                                TriggerEvent("skinchanger:change", "bodyb_3", bodyb13-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Effet corps 2", bodyb4, bodyb14, nil, {}, true, {
                            onListChange = function(Index)
                                bodyb14 = Index
                                TriggerEvent("skinchanger:change", "bodyb_4", bodyb14-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Les rides", age, age1, nil, {}, true, {
                            onListChange = function(Index)
                                age1 = Index
                                TriggerEvent("skinchanger:change", "age_1", age1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Épaisseur des rides", age2, age12, nil, {}, true, {
                            onListChange = function(Index)
                                age12 = Index
                                TriggerEvent("skinchanger:change", "age_2", age12-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Imperfections", blemishes, blemishes1, nil, {}, true, {
                            onListChange = function(Index)
                                blemishes1 = Index
                                TriggerEvent("skinchanger:change", "blemishes_1", blemishes1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Épaisseur des imperfections", blemishes2, blemishes12, nil, {}, true, {
                            onListChange = function(Index)
                                blemishes12 = Index
                                TriggerEvent("skinchanger:change", "blemishes_2", blemishes12-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Rougir", blush, blush1, nil, {}, true, {
                            onListChange = function(Index)
                                blush1 = Index                          
                                TriggerEvent("skinchanger:change", "blush_1", blush1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Épaisseur du fard à joues", blush2, blush12, nil, {}, true, {
                            onListChange = function(Index)
                                blush12 = Index                          
                                TriggerEvent("skinchanger:change", "blush_2", blush12-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Couleur fard à joues", blush3, blush13, nil, {}, true, {
                            onListChange = function(Index)
                                blush13 = Index                          
                                TriggerEvent("skinchanger:change", "blush_3", blush13-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Complexion", complexion, complexion1, nil, {}, true, {
                            onListChange = function(Index)
                                complexion1 = Index                          
                                TriggerEvent("skinchanger:change", "complexion_1", complexion1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Épaisseur du teint", complexion2, complexion12, nil, {}, true, {
                            onListChange = function(Index)
                                complexion12 = Index                          
                                TriggerEvent("skinchanger:change", "complexion_2", complexion12-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Soleil", sun, sun1, nil, {}, true, {
                            onListChange = function(Index)
                                sun1 = Index                          
                                TriggerEvent("skinchanger:change", "sun_1", sun1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Épaisseur du soleil", sun2, sun12, nil, {}, true, {
                            onListChange = function(Index)
                                sun12 = Index                          
                                TriggerEvent("skinchanger:change", "sun_2", sun12-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Taches de rousseur", moles, moles1, nil, {}, true, {
                            onListChange = function(Index)
                                moles1 = Index                          
                                TriggerEvent("skinchanger:change", "moles_1", moles1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Taches de rousseur 2", moles2, moles12, nil, {}, true, {
                            onListChange = function(Index)
                                moles12 = Index                          
                                TriggerEvent("skinchanger:change", "moles_2", moles12-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Type de barbe", beard, beard1, nil, {}, true, {
                            onListChange = function(Index)
                                beard1 = Index
                                TriggerEvent("skinchanger:change", "beard_1", beard1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Taille de barbe", beard2, beard12, nil, {}, true, {
                            onListChange = function(Index)
                                beard12 = Index
                                TriggerEvent("skinchanger:change", "beard_2", beard12-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Couleur de barbe 1", beard3, beard13, nil, {}, true, {
                            onListChange = function(Index)
                                beard13 = Index
                                TriggerEvent("skinchanger:change", "beard_3", beard13-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Couleur de barbe 2", beard4, beard14, nil, {}, true, {
                            onListChange = function(Index)
                                beard14 = Index
                                TriggerEvent("skinchanger:change", "beard_4", beard14-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)      
                    elseif pSkin.Type == "advanced" then
                        subMenu2.EnableMouse = false
                        RageUI.List("Sexe", sex, sex1, nil, {}, true, {
                            onListChange = function(Index)
                                sex1 = Index
                                TriggerEvent("skinchanger:change", "sex", sex1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.6
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Visage", face, face1, nil, {}, true, {
                            onListChange = function(Index)
                                face1 = Index
                                TriggerEvent("skinchanger:change", "face", face1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.6
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Teint", teint, teint1, nil, {}, true, {
                            onListChange = function(Index)
                                teint1 = Index                          
                                TriggerEvent("skinchanger:change", "skin", teint1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.6
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.Button("Principal Nez", nil, {}, true, {
                            onActive = function()
                                subMenu2.EnableMouse = true
                                zoomOffset = 0.6
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.Button("Profil du Nez", nil, {}, true, {
                            onActive = function()
                                subMenu2.EnableMouse = true
                                zoomOffset = 0.6
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.Button("Bout de nez", nil, {}, true, {
                            onActive = function()
                                subMenu2.EnableMouse = true
                                zoomOffset = 0.6
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.Button("Pommettes", nil, {}, true, {
                            onActive = function()
                                subMenu2.EnableMouse = true
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.Button("Largeur des joues", nil, {}, true, {
                            onActive = function()
                                subMenu2.EnableMouse = true
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Plénitude des lèvres", lip_thickness, lip_thickness1, nil, {}, true, {
                            onListChange = function(Index)
                                lip_thickness1 = Index                          
                                TriggerEvent("skinchanger:change", "lip_thickness", lip_thickness1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.Button("Mâchoire", nil, {}, true, {
                            onActive = function()
                                subMenu2.EnableMouse = true
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Hauteur du menton", chin, chin1, nil, {}, true, {
                            onListChange = function(Index)
                                chin1 = Index                          
                                TriggerEvent("skinchanger:change", "chin_1", chin1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Longueur du menton", chin2, chin12, nil, {}, true, {
                            onListChange = function(Index)
                                chin12 = Index                          
                                TriggerEvent("skinchanger:change", "chin_2", chin12-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Largeur du menton", chin3, chin13, nil, {}, true, {
                            onListChange = function(Index)
                                chin13 = Index                          
                                TriggerEvent("skinchanger:change", "chin_3", chin13-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Taille du trou du menton", chin4, chin14, nil, {}, true, {
                            onListChange = function(Index)
                                chin14 = Index                          
                                TriggerEvent("skinchanger:change", "chin_4", chin14-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Épaisseur du cou", neck_thickness, neck_thickness1, nil, {}, true, {
                            onListChange = function(Index)
                                neck_thickness1 = Index                          
                                TriggerEvent("skinchanger:change", "neck_thickness", neck_thickness1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Cheveux 1", hair, hair1, nil, {}, true, {
                            onListChange = function(Index)
                                hair1 = Index                          
                                TriggerEvent("skinchanger:change", "hair_1", hair1-1)
                                hair12 = 1                         
                                TriggerEvent("skinchanger:change", "hair_2", hair12-1) 
                            end,
                            onActive = function()
                                subMenu2.EnableMouse = true
                                zoomOffset = 0.6
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Cheveux 2", hair2, hair12, nil, {}, true, {
                            onListChange = function(Index)
                                hair12 = Index                          
                                TriggerEvent("skinchanger:change", "hair_2", hair12-1)
                            end,
                            onActive = function()
                                subMenu2.EnableMouse = true
                                zoomOffset = 0.6
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("T-Shirt 1", tshirt, tshirt1, nil, {}, true, {
                            onListChange = function(Index)
                                tshirt1 = Index
                                TriggerEvent("skinchanger:change", "tshirt_1", tshirt1-1)
                                tshirtcolor1 = 1
                                TriggerEvent("skinchanger:change", "tshirt_2", tshirtcolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end 
                        })
                        RageUI.List("T-Shirt 2", tshirtcolor, tshirtcolor1, nil, {}, true, {
                            onListChange = function(Index)
                                tshirtcolor1 = Index
                                TriggerEvent("skinchanger:change", "tshirt_2", tshirtcolor1-1)                            
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end
                        }, subMenu)
                        RageUI.List("Torse 1", torso, torso1, nil, {}, true, {
                            onListChange = function(Index)
                                torso1 = Index                          
                                TriggerEvent("skinchanger:change", "torso_1", torso1-1)
                                torsocolor1 = 1                         
                                TriggerEvent("skinchanger:change", "torso_2", torsocolor1-1) 
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end
                        }, subMenu)
                        RageUI.List("Torse 2", torsocolor, torsocolor1, nil, {}, true, {
                            onListChange = function(Index)
                                torsocolor1 = Index
                                TriggerEvent("skinchanger:change", "torso_2", torsocolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end
                        }, subMenu)
                        RageUI.List("Calque 1", decals, decals1, nil, {}, true, {
                            onListChange = function(Index)
                                decals1 = Index
                                TriggerEvent("skinchanger:change", "decals_1", decals1-1)
                                decalscolor1 = 1
                                TriggerEvent("skinchanger:change", "decals_2", decalscolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end
                        }, subMenu)
                        RageUI.List("Calque 2", decalscolor, decalscolor1, nil, {}, true, {
                            onListChange = function(Index)
                                decalscolor1 = Index
                                TriggerEvent("skinchanger:change", "decals_2", decalscolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end
                        }, subMenu)
                        RageUI.List("Bras 1", arms, arms1, nil, {}, true, {
                            onListChange = function(Index)
                                arms1 = Index
                                TriggerEvent("skinchanger:change", "arms", arms1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end
                        }, subMenu)
                        RageUI.List("Bras 2", arms2, arms12, nil, {}, true, {
                            onListChange = function(Index)
                                arms12 = Index
                                TriggerEvent("skinchanger:change", "arms_2", arms12-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end
                        }, subMenu)
                        RageUI.List("Pantalon 1", pants, pants1, nil, {}, true, {
                            onListChange = function(Index)
                                pants1 = Index
                                TriggerEvent("skinchanger:change", "pants_1", pants1-1)
                                pantscolor1 = 1
                                TriggerEvent("skinchanger:change", "pants_2", pantscolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.8
                                camOffset = -0.5
                            end
                        }, subMenu)
                        RageUI.List("Pantalon 2", pantscolor, pantscolor1, nil, {}, true, {
                            onListChange = function(Index)
                                pantscolor1 = Index
                                TriggerEvent("skinchanger:change", "pants_2", pantscolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.8
                                camOffset = -0.5
                            end
                        }, subMenu)
                        RageUI.List("Chaussure 1", shoes, shoes1, nil, {}, true, {
                            onListChange = function(Index)
                                shoes1 = Index
                                TriggerEvent("skinchanger:change", "shoes_1", shoes1-1)
                                shoescolor1 = 1
                                TriggerEvent("skinchanger:change", "shoes_2", shoescolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.8
                                camOffset = -0.8
                            end
                        }, subMenu)
                        RageUI.List("Chaussure 2", shoescolor, shoescolor1, nil, {}, true, {
                            onListChange = function(Index)
                                shoescolor1 = Index
                                TriggerEvent("skinchanger:change", "shoes_2", shoescolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.8
                                camOffset = -0.8
                            end
                        }, subMenu)
                        RageUI.List("Masque 1", mask, mask1, nil, {}, true, {
                            onListChange = function(Index)
                                mask1 = Index
                                TriggerEvent("skinchanger:change", "mask_1", mask1-1)
                                maskcolor1 = 1
                                TriggerEvent("skinchanger:change", "mask_2", maskcolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.6
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Masque 2", maskcolor, maskcolor1, nil, {}, true, {
                            onListChange = function(Index)
                                maskcolor1 = Index
                                TriggerEvent("skinchanger:change", "mask_2", maskcolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.6
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Gilet par balle 1", bproof, bproof1, nil, {}, true, {
                            onListChange = function(Index)
                                bproof1 = Index
                                TriggerEvent("skinchanger:change", "bproof_1", bproof1-1)
                                bproofcolor1 = 1
                                TriggerEvent("skinchanger:change", "bproof_2", bproofcolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end
                        }, subMenu)
                        RageUI.List("Gilet par balle 2", bproofcolor, bproofcolor1, nil, {}, true, {
                            onListChange = function(Index)
                                bproofcolor1 = Index
                                TriggerEvent("skinchanger:change", "bproof_2", bproofcolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end
                        }, subMenu)
                        RageUI.List("Chaine 1", chain, chain1, nil, {}, true, {
                            onListChange = function(Index)
                                chain1 = Index
                                TriggerEvent("skinchanger:change", "chain_1", chain1-1)
                                chaincolor1 = 1
                                TriggerEvent("skinchanger:change", "chain_2", chaincolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.6
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Chaine 2", chaincolor, chaincolor1, nil, {}, true, {
                            onListChange = function(Index)
                                chaincolor1 = Index
                                TriggerEvent("skinchanger:change", "chain_2", chaincolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.6
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Casque 1", helmet, helmet1, nil, {}, true, {
                            onListChange = function(Index)
                                helmet1 = Index
                                TriggerEvent("skinchanger:change", "helmet_1", helmet1-2)
                                helmetcolor1 = 1
                                TriggerEvent("skinchanger:change", "helmet_2", helmetcolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.6
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Casque 2", helmetcolor, helmetcolor1, nil, {}, true, {
                            onListChange = function(Index)
                                helmetcolor1 = Index
                                TriggerEvent("skinchanger:change", "helmet_2", helmetcolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.6
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Lunette 1", glasses, glasses1, nil, {}, true, {
                            onListChange = function(Index)
                                glasses1 = Index
                                TriggerEvent("skinchanger:change", "glasses_1", glasses1-1)
                                glassescolor1 = 1
                                TriggerEvent("skinchanger:change", "glasses_2", glassescolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.6
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Lunette 2", glassescolor, glassescolor1, nil, {}, true, {
                            onListChange = function(Index)
                                glassescolor1 = Index
                                TriggerEvent("skinchanger:change", "glasses_2", glassescolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.6
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Montre 1", watches, watches1, nil, {}, true, {
                            onListChange = function(Index)
                                watches1 = Index
                                TriggerEvent("skinchanger:change", "watches_1", watches1-2)
                                watchescolor1 = 1
                                TriggerEvent("skinchanger:change", "watches_2", watchescolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end
                        }, subMenu)
                        RageUI.List("Montre 2", watchescolor, watchescolor1, nil, {}, true, {
                            onListChange = function(Index)
                                watchescolor1 = Index
                                TriggerEvent("skinchanger:change", "watches_2", watchescolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end
                        }, subMenu)
                        RageUI.List("Bracelet 1", bracelets, bracelets1, nil, {}, true, {
                            onListChange = function(Index)
                                bracelets1 = Index
                                TriggerEvent("skinchanger:change", "bracelets_1", bracelets1-2)
                                braceletscolor1 = 1
                                TriggerEvent("skinchanger:change", "bracelets_2", braceletscolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end
                        }, subMenu)
                        RageUI.List("Bracelet 2", braceletscolor, braceletscolor1, nil, {}, true, {
                            onListChange = function(Index)
                                braceletscolor1 = Index
                                TriggerEvent("skinchanger:change", "bracelets_2", braceletscolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end
                        }, subMenu)
                        RageUI.List("Sac 1", bags, bags1, nil, {}, true, {
                            onListChange = function(Index)
                                bags1 = Index
                                TriggerEvent("skinchanger:change", "bags_1", bags1-1)
                                bagscolor1 = 1
                                TriggerEvent("skinchanger:change", "bags_2", bagscolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end
                        }, subMenu)
                        RageUI.List("Sac 2", bagscolor, bagscolor1, nil, {}, true, {
                            onListChange = function(Index)
                                bagscolor1 = Index
                                TriggerEvent("skinchanger:change", "bags_2", bagscolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end
                        }, subMenu)
                        RageUI.List("Couleur des yeux", eyecolor, eyecolor1, nil, {}, true, {
                            onListChange = function(Index)
                                eyecolor1 = Index
                                TriggerEvent("skinchanger:change", "eye_color", eyecolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Strabisme", eyesquint, eyesquint1, nil, {}, true, {
                            onListChange = function(Index)
                                eyesquint1 = Index
                                TriggerEvent("skinchanger:change", "eye_squint", eyesquint1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)                        
                        RageUI.List("Sourcils", eyebrows, eyebrows1, nil, {}, true, {
                            onListChange = function(Index)
                                eyebrows1 = Index
                                TriggerEvent("skinchanger:change", "eyebrows_1", eyebrows1-1)
                            end,
                            onActive = function()
                                subMenu2.EnableMouse = true
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)   
                        RageUI.Button("Position Sourcils", nil, {}, true, {
                            onActive = function()
                                subMenu2.EnableMouse = true
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.Button("Largeur des joues", nil, {}, true, {
                            onActive = function()
                                subMenu2.EnableMouse = true
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Type de maquillage", makeup, makeup1, nil, {}, true, {
                            onListChange = function(Index)
                                makeup1 = Index
                                TriggerEvent("skinchanger:change", "makeup_1", makeup1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Épaisseur de maquillage", makeup2, makeup12, nil, {}, true, {
                            onListChange = function(Index)
                                makeup12 = Index
                                TriggerEvent("skinchanger:change", "makeup_2", makeup12-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Maquillage couleur 1", makeup3, makeup13, nil, {}, true, {
                            onListChange = function(Index)
                                makeup13 = Index
                                TriggerEvent("skinchanger:change", "makeup_3", makeup13-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Maquillage couleur 2", makeup4, makeup14, nil, {}, true, {
                            onListChange = function(Index)
                                makeup14 = Index
                                TriggerEvent("skinchanger:change", "makeup_4", makeup14-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Type de rouge à lèvres", lipstick, lipstick1, nil, {}, true, {
                            onListChange = function(Index)
                                lipstick1 = Index
                                TriggerEvent("skinchanger:change", "lipstick_1", lipstick1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Épaisseur du rouge à lèvres", lipstick2, lipstick12, nil, {}, true, {
                            onListChange = function(Index)
                                lipstick12 = Index
                                TriggerEvent("skinchanger:change", "lipstick_2", lipstick12-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Couleur de rouge à lèvres 1", lipstick3, lipstick13, nil, {}, true, {
                            onListChange = function(Index)
                                lipstick13 = Index
                                TriggerEvent("skinchanger:change", "lipstick_3", lipstick13-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Couleur de rouge à lèvres 2", lipstick4, lipstick14, nil, {}, true, {
                            onListChange = function(Index)
                                lipstick14 = Index
                                TriggerEvent("skinchanger:change", "lipstick_4", lipstick14-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Accessoire d'Oreille 1", ears, ears1, nil, {}, true, {
                            onListChange = function(Index)
                                ears1 = Index
                                TriggerEvent("skinchanger:change", "ears_1", ears1-2)
                                earscolor1 = 1
                                TriggerEvent("skinchanger:change", "ears_2", earscolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Accessoire d'Oreille 2", earscolor, earscolor1, nil, {}, true, {
                            onListChange = function(Index)
                                earscolor1 = Index
                                TriggerEvent("skinchanger:change", "ears_2", earscolor1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Poils du torse", chest, chest1, nil, {}, true, {
                            onListChange = function(Index)
                                chest1 = Index                          
                                TriggerEvent("skinchanger:change", "chest_1", chest1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end
                        }, subMenu)
                        RageUI.List("Poils du torse 2", chest2, chest12, nil, {}, true, {
                            onListChange = function(Index)
                                chest12 = Index                          
                                TriggerEvent("skinchanger:change", "chest_2", chest12-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end
                        }, subMenu)
                        RageUI.List("Couleur poils du torse", chest3, chest13, nil, {}, true, {
                            onListChange = function(Index)
                                chest13 = Index                          
                                TriggerEvent("skinchanger:change", "chest_3", chest13-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end
                        }, subMenu)
                        RageUI.List("Imperfections du corps", bodyb, bodyb1, nil, {}, true, {
                            onListChange = function(Index)
                                bodyb1 = Index
                                TriggerEvent("skinchanger:change", "bodyb_1", bodyb1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end
                        }, subMenu)
                        RageUI.List("Imperfections du corps 2", bodyb2, bodyb12, nil, {}, true, {
                            onListChange = function(Index)
                                bodyb12 = Index
                                TriggerEvent("skinchanger:change", "bodyb_2", bodyb12-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.75
                                camOffset = 0.15
                            end
                        }, subMenu)
                        RageUI.List("Effet corps", bodyb3, bodyb13, nil, {}, true, {
                            onListChange = function(Index)
                                bodyb13 = Index
                                TriggerEvent("skinchanger:change", "bodyb_3", bodyb13-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Effet corps 2", bodyb4, bodyb14, nil, {}, true, {
                            onListChange = function(Index)
                                bodyb14 = Index
                                TriggerEvent("skinchanger:change", "bodyb_4", bodyb14-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Les rides", age, age1, nil, {}, true, {
                            onListChange = function(Index)
                                age1 = Index
                                TriggerEvent("skinchanger:change", "age_1", age1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Épaisseur des rides", age2, age12, nil, {}, true, {
                            onListChange = function(Index)
                                age12 = Index
                                TriggerEvent("skinchanger:change", "age_2", age12-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Imperfections", blemishes, blemishes1, nil, {}, true, {
                            onListChange = function(Index)
                                blemishes1 = Index
                                TriggerEvent("skinchanger:change", "blemishes_1", blemishes1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Épaisseur des imperfections", blemishes2, blemishes12, nil, {}, true, {
                            onListChange = function(Index)
                                blemishes12 = Index
                                TriggerEvent("skinchanger:change", "blemishes_2", blemishes12-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Rougir", blush, blush1, nil, {}, true, {
                            onListChange = function(Index)
                                blush1 = Index                          
                                TriggerEvent("skinchanger:change", "blush_1", blush1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Épaisseur du fard à joues", blush2, blush12, nil, {}, true, {
                            onListChange = function(Index)
                                blush12 = Index                          
                                TriggerEvent("skinchanger:change", "blush_2", blush12-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Couleur fard à joues", blush3, blush13, nil, {}, true, {
                            onListChange = function(Index)
                                blush13 = Index                          
                                TriggerEvent("skinchanger:change", "blush_3", blush13-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Complexion", complexion, complexion1, nil, {}, true, {
                            onListChange = function(Index)
                                complexion1 = Index                          
                                TriggerEvent("skinchanger:change", "complexion_1", complexion1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Épaisseur du teint", complexion2, complexion12, nil, {}, true, {
                            onListChange = function(Index)
                                complexion12 = Index                          
                                TriggerEvent("skinchanger:change", "complexion_2", complexion12-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Soleil", sun, sun1, nil, {}, true, {
                            onListChange = function(Index)
                                sun1 = Index                          
                                TriggerEvent("skinchanger:change", "sun_1", sun1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Épaisseur du soleil", sun2, sun12, nil, {}, true, {
                            onListChange = function(Index)
                                sun12 = Index                          
                                TriggerEvent("skinchanger:change", "sun_2", sun12-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Taches de rousseur", moles, moles1, nil, {}, true, {
                            onListChange = function(Index)
                                moles1 = Index                          
                                TriggerEvent("skinchanger:change", "moles_1", moles1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Taches de rousseur 2", moles2, moles12, nil, {}, true, {
                            onListChange = function(Index)
                                moles12 = Index                          
                                TriggerEvent("skinchanger:change", "moles_2", moles12-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Type de barbe", beard, beard1, nil, {}, true, {
                            onListChange = function(Index)
                                beard1 = Index
                                TriggerEvent("skinchanger:change", "beard_1", beard1-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Taille de barbe", beard2, beard12, nil, {}, true, {
                            onListChange = function(Index)
                                beard12 = Index
                                TriggerEvent("skinchanger:change", "beard_2", beard12-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Couleur de barbe 1", beard3, beard13, nil, {}, true, {
                            onListChange = function(Index)
                                beard13 = Index
                                TriggerEvent("skinchanger:change", "beard_3", beard13-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.List("Couleur de barbe 2", beard4, beard14, nil, {}, true, {
                            onListChange = function(Index)
                                beard14 = Index
                                TriggerEvent("skinchanger:change", "beard_4", beard14-1)
                            end,
                            onActive = function()
                                zoomOffset = 0.4
                                camOffset = 0.65
                            end
                        }, subMenu)
                        RageUI.Grid(nose1/10, nose12/10, 'Haut', 'Bas', 'Étroit', 'Large', { 
                            onPositionChange = function(IndexX, IndexY, X, Y) 
                                nose1 = IndexX * 10
                                nose12 = IndexY * 10
                                TriggerEvent('skinchanger:change', 'nose_1', nose1)  
                                TriggerEvent('skinchanger:change', 'nose_2', nose12)  
                            end
                        }, 4)
                        RageUI.Grid(nose13/10, nose14/10, 'Courbé', 'Court', 'Long', 'Incurvé', { 
                            onPositionChange = function(IndexX, IndexY, X, Y) 
                                nose13 = IndexX * 10
                                nose14 = IndexY * 10
                                TriggerEvent('skinchanger:change', 'nose_3', nose13)  
                                TriggerEvent('skinchanger:change', 'nose_4', nose14)  
                            end
                        }, 5)
                        RageUI.Grid(nose15/10, nose16/10, 'Incliner', 'Gauche cassée', 'Droit cassé', 'Basculer', { 
                            onPositionChange = function(IndexX, IndexY, X, Y) 
                                nose15 = IndexX * 10
                                nose16 = IndexY * 10
                                TriggerEvent('skinchanger:change', 'nose_5', nose15)  
                                TriggerEvent('skinchanger:change', 'nose_6', nose16)  
                            end
                        }, 6)
                        RageUI.Grid(cheeks1/10, cheeks12/10, 'Étroit', 'Large', 'Haut', 'Bas', { 
                            onPositionChange = function(IndexX, IndexY, X, Y) 
                                cheeks1 = IndexX * 10
                                cheeks12 = IndexY * 10
                                TriggerEvent('skinchanger:change', 'cheeks_1', cheeks1)
                                TriggerEvent('skinchanger:change', 'cheeks_2', cheeks12)
                            end 
                        }, 7)
                        RageUI.Grid(cheeks13/10, 0.5, '', '', 'Large', 'Étroit', { 
                            onPositionChange = function(IndexX, IndexY, X, Y) 
                                cheeks13 = IndexX * 10
                                TriggerEvent('skinchanger:change', 'cheeks_3', cheeks13)
                            end 
                        }, 8)
                        RageUI.Grid(jaw1/10, jaw12/10, 'Haut', 'Bas', 'Étroit', 'Large', { 
                            onPositionChange = function(IndexX, IndexY, X, Y) 
                                jaw1 = IndexX * 10
                                jaw12 = IndexY * 10
                                TriggerEvent('skinchanger:change', 'jaw_1', jaw1)  
                                TriggerEvent('skinchanger:change', 'jaw_2', jaw12)  
                            end 
                        }, 10)
                        RageUI.ColourPanel("Couleur Principale", RageUI.PanelColour.HairCut, iIndex.Hair, haircolor1, { 
                            onColorChange = function(MinimumIndex, CurrentIndex) 
                                iIndex.Hair = MinimumIndex 
                                haircolor1 = CurrentIndex 
                                TriggerEvent('skinchanger:change', "hair_color_1", haircolor1-1) 
                            end
                        }, 16)
                        RageUI.ColourPanel("Couleur Secondaire", RageUI.PanelColour.HairCut, iIndex.Hair2, haircolor12, {
                            onColorChange = function(MinimumIndex, CurrentIndex)
                                iIndex.Hair2 = MinimumIndex
                                haircolor12 = CurrentIndex
                                TriggerEvent('skinchanger:change', "hair_color_2", haircolor12-1)
                            end
                        }, 17)
                        RageUI.PercentagePanel(eyebrows12/10, "Opacité (" .. math.floor((eyebrows12/10)*100) .. "%)", '0%', '100%', {
                            onProgressChange = function(Percentage)
                                eyebrows12 = Percentage * 10
                                TriggerEvent('skinchanger:change', "eyebrows_2", eyebrows12)
                            end
                        }, 48)
                        RageUI.ColourPanel("Couleur Principale", RageUI.PanelColour.HairCut, iIndex.Sourcil, eyebrows13, { 
                            onColorChange = function(MinimumIndex, CurrentIndex) 
                                iIndex.Sourcil = MinimumIndex 
                                eyebrows13 = CurrentIndex 
                                TriggerEvent('skinchanger:change', "eyebrows_3", eyebrows13-1) 
                            end 
                        }, 48)
                        RageUI.ColourPanel("Couleur Secondaire", RageUI.PanelColour.HairCut, iIndex.Sourcil2, eyebrows14, { 
                            onColorChange = function(MinimumIndex, CurrentIndex) 
                                iIndex.Sourcil2 = MinimumIndex 
                                eyebrows14 = CurrentIndex 
                                TriggerEvent('skinchanger:change', "eyebrows_4", eyebrows14-1) 
                            end 
                        }, 48)
                        RageUI.Grid(eyebrows15/10, eyebrows16/10, '', '', 'Haut', 'Bas', { 
                            onPositionChange = function(IndexX, IndexY, X, Y) 
                                eyebrows15 = IndexX * 10 
                                eyebrows16 = IndexY * 10
                                TriggerEvent('skinchanger:change', 'eyebrows_5', eyebrows15-1) 
                                TriggerEvent('skinchanger:change', 'eyebrows_6', eyebrows16-1) 
                            end 
                        }, 49)
                    end
                end) 
                RageUI.IsVisible(subMenu,function()
                    subMenu:UpdateInstructionalButtons(true)  
                    if CheckAllowedPermission or CheckAllowedGroup then
                        RageUI.Button('Sauvegarder le skin en favoris', nil, {}, true, {
                            onSelected = function()
                                local savelabel = KeyboardInput("Entrer le nom du skin favoris", "", 50)
                                TriggerEvent('skinchanger:getSkin', function(skin)
                                    saveskin = skin
                                end) 
                                TriggerServerEvent("pSkin:setData", "save", {identifier = ESX.PlayerData.identifier, label = savelabel, skin = saveskin})
                            end
                        })
                    end
                    RageUI.Button('~g~Valider le personnage', nil, {}, true, {
                        onSelected = function() 
                            TriggerEvent('skinchanger:getSkin', function(skin)
                                TriggerServerEvent('esx_skin:save', skin)
                                TriggerEvent('skinchanger:loadSkin', skin)
                                if isEdit then
                                    TriggerServerEvent("pSkin:setData", "edit", {skin = {identifier = tempEdit.identifier, label = tempEdit.label, skin = skin}, index = tempEdit.index})
                                end
                            end) 
                            DeleteSkinCam()
                            if isEdit then
                                RageUI.Visible(subMenu3, true)
                                subMenu2.Closable = true
                                isEdit = false
                            else
                                RageUI.CloseAll()
                                skinmenu = false
                            end
                            if not CheckAllowedPermission and not CheckAllowedGroup then
                                mainMenu.Closable = true
                                subMenu2.Closable = true
                            end
                        end
                    })
                end)
                RageUI.IsVisible(subMenu3,function()
                    RageUI.Button("Reprendre votre apparence", nil, {}, true, {
                        onSelected = function()
                            TriggerServerEvent('esx_skin:save', PostSkin)
                            TriggerEvent('skinchanger:loadSkin', PostSkin)
                        end
                    })
                    RageUI.Separator("↓ Liste des favoris ↓")
                    for k,v in pairs(skinData) do
                        if v.identifier == ESX.PlayerData.identifier then
                            RageUI.List(v.label, {"Mettre", "Partager", "Modifier", "Renommer", "Supprimer"}, Index, nil, {}, true, {
                                onListChange = function(i)
                                    Index = i
                                end,
                                onSelected = function()
                                    if Index == 1 then
                                        TriggerServerEvent('esx_skin:save', v.skin)
                                        TriggerEvent('skinchanger:loadSkin', v.skin)
                                    elseif Index == 2 then
                                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer() 
                                        if closestPlayer ~= -1 and closestDistance <= 3.0 then    
                                            ESX.TriggerServerCallback('pSkin:getUserIdentifier', function(identifier)
                                                if identifier then                                           
                                                    TriggerServerEvent("pSkin:setData", "share", {identifier = identifier, label = v.label, skin = v.skin}, GetPlayerServerId(closestPlayer))
                                                end
                                            end, GetPlayerServerId(closestPlayer))
                                        else
                                            ESX.ShowNotification('Aucun joueur à proximité')
                                        end 
                                    elseif Index == 3 then
                                        TriggerServerEvent('esx_skin:save', v.skin)
                                        TriggerEvent('skinchanger:loadSkin', v.skin)
                                        CreateMain()
                                        FreezeEntityPosition(GetPlayerPed(-1), true)
                                        Wait(100)
                                        GetSkinValue()
                                        RageUI.Visible(subMenu2, true)
                                        subMenu2.Closable = false
                                        isEdit = true
                                        tempEdit = {identifier = v.identifier, label = v.label, index = k}
                                    elseif Index == 4 then
                                        local renamelabel = KeyboardInput("Entrer le nouveau nom du skin favoris", "", 50)
                                        TriggerServerEvent("pSkin:setData", "rename",  {skin = {identifier = v.identifier, label = renamelabel, skin = v.skin}, index = k})
                                    elseif Index == 5 then
                                        TriggerServerEvent("pSkin:setData", "delete", k)
                                    end
                                end
                            })
                        end
                    end
                end)
            Wait(0)
            end
        end)
    end
end

function isCamera()
    isCameraActive = not isCameraActive
    Citizen.CreateThread(function()
        while isCameraActive do
            Wait(0)
            -- DisableControlAction(2, 30, true)
            -- DisableControlAction(2, 31, true)
            -- DisableControlAction(2, 32, true)
            -- DisableControlAction(2, 33, true)
            -- DisableControlAction(2, 34, true)
            -- DisableControlAction(2, 35, true)
            -- DisableControlAction(0, 25, true) 
            -- DisableControlAction(0, 24, true) 
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            local angle = heading * math.pi / 180.0
            local theta = {
                x = math.cos(angle),
                y = math.sin(angle)
            }
            local pos = {
                x = coords.x + (zoomOffset * theta.x),
                y = coords.y + (zoomOffset * theta.y)
            }
            local angleToLook = heading - 140.0
            if angleToLook > 360 then
                angleToLook = angleToLook - 360
            elseif angleToLook < 0 then
                angleToLook = angleToLook + 360
            end
            angleToLook = angleToLook * math.pi / 180.0
            local thetaToLook = {
                x = math.cos(angleToLook),
                y = math.sin(angleToLook)
            }
            local posToLook = {
                x = coords.x + (zoomOffset * thetaToLook.x),
                y = coords.y + (zoomOffset * thetaToLook.y)
            }
            SetCamCoord(cam, pos.x, pos.y, coords.z + camOffset)
            PointCamAtCoord(cam, posToLook.x-0.5, posToLook.y, coords.z + camOffset)
        end
    end)
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLength)
	AddTextEntry('FMMC_KEY_TIP1', TextEntry .. ':')
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

function Load_Skin()
    EnableControlAction(0, pSkin.Key.ActiverDesactiverCamera, true)  
    EnableControlAction(0, pSkin.Key.Tourner90, true)                  
    if IsControlJustPressed(0, pSkin.Key.Tourner90) then
        local back = GetEntityHeading(GetPlayerPed(-1))
        SetEntityHeading(GetPlayerPed(-1), back+90)      
    end
    if IsControlJustPressed(0, pSkin.Key.ActiverDesactiverCamera) then
        pressed = not pressed
        if pressed then
            RenderScriptCams(false, true, 1500, true, true)
            DestroyAllCams(true)
        else
            CreateMain()
        end
    end
    if IsDisabledControlPressed(0, pSkin.Key.TournerDroite) then
        SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())-1.5)
    elseif IsDisabledControlPressed(0, pSkin.Key.TournerGauche) then
        SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())+1.5)
    elseif IsDisabledControlPressed(0, pSkin.Key.Dezoomer) then
        SetCamFov(cam, GetCamFov(cam)+0.2)
    elseif IsDisabledControlPressed(0, pSkin.Key.Zoomer) then
        SetCamFov(cam, GetCamFov(cam)-0.2)
    end
end

if pSkin.ActiveSkinMenuSpawn then
    AddEventHandler('esx_skin:resetFirstSpawn', function()
        firstSpawn = true
        skinLoaded = false
        ESX.PlayerLoaded = false
    end)

    AddEventHandler('esx_skin:playerRegistered', function()
        CreateThread(function()
            while not ESX.PlayerLoaded do
                Wait(100)
            end

            if firstSpawn then
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                    if skin == nil then
                        TriggerEvent('skinchanger:loadSkin', {sex = 0})
                        Wait(100)
                        skinLoaded = true
                        GetSkinValue()
                        OpenMenu()
                    else
                        TriggerEvent('skinchanger:loadSkin', skin)
                        Wait(100)
                        skinLoaded = true
                    end
                end)

                firstSpawn = false
            end
        end)
    end)
end

AddEventHandler('esx_skin:getLastSkin', function(cb) cb(lastSkin) end)
AddEventHandler('esx_skin:setLastSkin', function(skin) lastSkin = skin end)

RegisterNetEvent('esx_skin:openMenu')
AddEventHandler('esx_skin:openMenu', function()
    GetSkinValue()
    OpenMenu()
end)

RegisterNetEvent('esx_skin:openRestrictedMenu')
AddEventHandler('esx_skin:openRestrictedMenu', function()
    GetSkinValue()
    OpenMenu()
end)

RegisterNetEvent('esx_skin:openSaveableMenu')
AddEventHandler('esx_skin:openSaveableMenu', function()
    GetSkinValue()
    OpenMenu()
end)

RegisterNetEvent('esx_skin:openSaveableRestrictedMenu')
AddEventHandler('esx_skin:openSaveableRestrictedMenu', function()
    GetSkinValue()
    OpenMenu()
end)

RegisterNetEvent('esx_skin:requestSaveSkin')
AddEventHandler('esx_skin:requestSaveSkin', function()
    TriggerEvent('skinchanger:getSkin', function(skin)
        TriggerServerEvent('esx_skin:responseSaveSkin', skin)
    end)
end)

RegisterCommand("skin", function()
    ESX.TriggerServerCallback('pSkin:getUserGroup', function(group)
        playergroup = group
        for _,v in pairs(pSkin.AllowedGroup) do
            if v == playergroup then
                CheckAllowedGroup = true
            end            
        end
    end)
    for _,v in pairs(pSkin.AllowedPermission) do
        if v == ESX.PlayerData.identifier then
            CheckAllowedPermission = true
        end            
    end
    Wait(200)
    if CheckAllowedPermission then
        GetSkinValue()
        OpenMenu()
    elseif CheckAllowedGroup then
        GetSkinValue()
        OpenMenu()
    else
        ESX.ShowNotification("Vous n'avez pas la permission pour exécuter cette commande")
    end
end)