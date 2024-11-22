if not pGangBuilder.LastLegacy then
    ESX = nil

    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(5000)
        end
    end)
end

local Name,Label = "",""

local SocietyPos,SocietyGestion,GradeName,GradeLabel,GradeSalary,GradeNumber,GradeSalary2,GradeNumber2 = "",false,"","","","","",""

local Garage,GaragePos,GarageSpawn,GarageHeading,GarageReturn,GaragePnj = false,"","","","",false

local VehicleName,VehicleCount,iplaque2,xenon,custom,vitres,plaque,color,active = "","","",false,false,false,false,false,false

local Coffre,CoffrePos,CoffreMoney,CoffreDirtyMoney,temp_CountItem = false,"",0,0,""

local Vestiaire,VestiairePos,VestiaireGestion,ClothesName = false,"",false,""

local BlipPreview,Blip,Blip2,BlipPos,BlipName = false,false,false,"",""

local Marker,MarkerPreview = false,false

local _Index,_Index2,_Index3,_Index4,_Index5,_Index6,_Index7,_Index8,_Index9,_Index10,_Index11,_Index12,_Index13,_Index14,_Index15,_Index16,_Index17,_Index18,_Index19,_Index20,_Index21,_Index22,_Index23,_Index24,_Index25,_Index26,_Index27,_Index28,_Index29,_Index30,_Index31,_Index32,_Index33,_Index34,_Index35,_Index36,_Index37,_Index38,_Index39,_Index40,_Index41 = 1,1,1,1,1,1,1,10,1,1,1,1,1,19,19,19,11,11,11,1,1,1,256,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

local aucun = true

local data_grade = {}
local ModifyGrade = {value = nil, verify = false}

local data_vehicle = {}
local ModifyVehicle = {value = nil, verify = false}

local data_clothes = {}
local ModifyClothes = {value = nil, verify = false}

local data_coffre_item = {}

local data_coffre_weapon = {}

------------------------------------------
--local edit_Name,edit_Label = "",""

--local edit_SocietyPos,edit_SocietyGestion = "",false
local edit_GradeName,edit_GradeLabel,edit_GradeSalary,edit_GradeNumber,edit_GradeSalary2,edit_GradeNumber2 = "","","","","",""

--local edit_Garage,edit_GaragePos,edit_GarageSpawn,edit_GarageHeading,edit_GarageReturn,edit_GaragePnj = false,"","","","",false

local edit_VehicleName,edit_VehicleCount,edit_iplaque2,edit_xenon,edit_custom,edit_vitres,edit_plaque,edit_color,edit_active = "","","",false,false,false,false,false,false

--local edit_Coffre,edit_CoffrePos,edit_CoffreMoney,edit_CoffreDirtyMoney = false,"",0,0
local edit_temp_CountItem = ""

--local edit_Vestiaire,edit_VestiairePos,edit_VestiaireGestion = false,"",false
local edit_ClothesName = ""

local edit_BlipPreview,edit_Blip,edit_Blip2,edit_BlipPos,edit_BlipName = false,false,false,"",""

--local edit_Marker,edit_MarkerPreview = false,false

--local edit__Index,edit__Index2,edit__Index3,edit__Index4,edit__Index5,edit__Index6,edit__Index7,edit__Index8,edit__Index9,edit__Index10,edit__Index11,edit__Index12,edit__Index13,edit__Index14,edit__Index15,edit__Index16,edit__Index17,edit__Index18,edit__Index19,edit__Index20,edit__Index21,edit__Index22,edit__Index23,edit__Index24,edit__Index25,edit__Index26,edit__Index27,edit__Index28,edit__Index29,edit__Index30,edit__Index31,edit__Index32,edit__Index33,edit__Index34,edit__Index35,edit__Index36,edit__Index37,edit__Index38,edit__Index39,edit__Index40,edit__Index41 = 1,1,1,1,1,1,1,10,1,1,1,1,1,19,19,19,11,11,11,1,1,1,256,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

local edit_aucun = true

local edit_data_grade = {}
local edit_ModifyGrade = {value = nil, verify = false}

local edit_data_vehicle = {}
local edit_ModifyVehicle = {value = nil, verify = false}

local edit_data_clothes = {}
local edit_ModifyClothes = {value = nil, verify = false}

local edit_data_coffre_item = {}

local edit_data_coffre_weapon = {}
------------------------------------------
local theIndex = 1

local speItemsTeinte = {"Classic/Metallic", "Matte", "Chrome"}
local speItemsColor = {"Noir", "Rouge", "Bleu", "Vert", "Jaune", "Violet", "Blanc"}

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

    vestecolor,tshirtcolor,pantaloncolor,chaussurecolor,calquecolor,chainecolor,casquecolor,lunettecolor,oreillecolor,montrecolor,braceletcolor,saccolor = {},{},{},{},{},{},{},{},{},{},{},{}
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
    end)
end

local function starts(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end

function OpenGangBuilder()
    local builder = false 

    veste,veste1 = {},1
    vestecolor,vestecolor1 = {},1
    tshirt,tshirt1 = {},1
    tshirtcolor,tshirtcolor1 = {},1
    pantalon,pantalon1 = {},1
    pantaloncolor,pantaloncolor1 = {},1
    chaussure,chaussure1 = {},1
    chaussurecolor,chaussurecolor1 = {},1
    bras,bras1 = {},1
    calque,calque1 = {},1
    calquecolor,calquecolor1 = {},1
    chaine,chaine1 = {},1
    chainecolor,chainecolor1 = {},1
    casque,casque1 = {},1
    casquecolor,casquecolor1 = {},1
    lunette,lunette1 = {},1
    lunettecolor,lunettecolor1 = {},1
    oreille,oreille1 = {},1
    oreillecolor,oreillecolor1 = {},1
    montre,montre1 = {},1
    montrecolor,montrecolor1 = {},1
    bracelet,bracelet1 = {},1
    braceletcolor,braceletcolor1 = {},1
    sac,sac1 = {},1
    saccolor,saccolor1 = {},1

    CoffrePlaces = pGangBuilder.WeightChest[1].value
    
    local _Items = {}
    for i = 1, #pGangBuilder.WeightChest, 1 do
        table.insert(_Items, pGangBuilder.WeightChest[i].label)
    end

    local _Items2 = {}
    for i = 1, 826, 1 do
        _Items2[i] = i
    end

    local _Items3 = {}
    for i = 1, 85, 1 do
        _Items3[i] = i
    end

    local _Items4 = {}
    for i = 1, 85, 1 do
        _Items4[i] = i
    end

    local _Items5 = {}
    for i = 1, 43, 1 do
        _Items5[i] = i
    end

    local _Items6 = {}
    for i = -180.0, 180.0, 10 do
        table.insert(_Items6, i)
    end

    local _Items7 = {}
    for i = -180.0, 180.0, 10 do
        table.insert(_Items7, i)
    end

    local _Items8 = {}
    for i = -180.0, 180.0, 10 do
        table.insert(_Items8, i)
    end

    local _Items9 = {}
    for i = 0.0, 2.0, 0.1 do
        table.insert(_Items9, i)
    end

    local _Items10 = {}
    for i = 0.0, 2.0, 0.1 do
        table.insert(_Items10, i)
    end

    local _Items11 = {}
    for i = 0.0, 2.0, 0.1 do
        table.insert(_Items11, i)
    end

    local _Items12 = {}
    for i = 0, 255, 1 do
        table.insert(_Items12, i)
    end

    local _Items13 = {}
    for i = 0, 255, 1 do
        table.insert(_Items13, i)
    end

    local _Items14 = {}
    for i = 0, 255, 1 do
        table.insert(_Items14, i)
    end

    local _Items15 = {}
    for i = 0, 255, 1 do
        table.insert(_Items15, i)
    end

    local _Items16 = {"Aucun","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"}

    local edit__Items = {}
    for i = 1, #pGangBuilder.WeightChest, 1 do
        table.insert(edit__Items, pGangBuilder.WeightChest[i].label)
    end

    local edit__Items2 = {}
    for i = 1, 826, 1 do
        edit__Items2[i] = i
    end

    local edit__Items3 = {}
    for i = 1, 85, 1 do
        edit__Items3[i] = i
    end

    local edit__Items4 = {}
    for i = 1, 85, 1 do
        edit__Items4[i] = i
    end

    local edit__Items5 = {}
    for i = 1, 43, 1 do
        edit__Items5[i] = i
    end

    local edit__Items6 = {}
    for i = -180.0, 180.0, 10 do
        table.insert(edit__Items6, i)
    end

    local edit__Items7 = {}
    for i = -180.0, 180.0, 10 do
        table.insert(edit__Items7, i)
    end

    local edit__Items8 = {}
    for i = -180.0, 180.0, 10 do
        table.insert(edit__Items8, i)
    end

    local edit__Items9 = {}
    for i = 0.0, 2.0, 0.1 do
        table.insert(edit__Items9, i)
    end

    local edit__Items10 = {}
    for i = 0.0, 2.0, 0.1 do
        table.insert(edit__Items10, i)
    end

    local edit__Items11 = {}
    for i = 0.0, 2.0, 0.1 do
        table.insert(edit__Items11, i)
    end

    local edit__Items12 = {}
    for i = 0, 255, 1 do
        table.insert(edit__Items12, i)
    end

    local edit__Items13 = {}
    for i = 0, 255, 1 do
        table.insert(edit__Items13, i)
    end

    local edit__Items14 = {}
    for i = 0, 255, 1 do
        table.insert(edit__Items14, i)
    end

    local edit__Items15 = {}
    for i = 0, 255, 1 do
        table.insert(edit__Items15, i)
    end

    local edit__Items16 = {"Aucun","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"}

    MarkerType = pGangBuilder.DefaultMarker.MarkerType
    MarkerrotX = pGangBuilder.DefaultMarker.MarkerrotX
    MarkerrotY = pGangBuilder.DefaultMarker.MarkerrotY
    MarkerrotZ = pGangBuilder.DefaultMarker.MarkerrotZ
    MarkerscaleX = pGangBuilder.DefaultMarker.MarkerscaleX
    MarkerscaleY = pGangBuilder.DefaultMarker.MarkerscaleY
    MarkerscaleZ = pGangBuilder.DefaultMarker.MarkerscaleZ
    MarkerR = pGangBuilder.DefaultMarker.MarkerR
    MarkerV = pGangBuilder.DefaultMarker.MarkerV
    MarkerB = pGangBuilder.DefaultMarker.MarkerB
    MarkerO = pGangBuilder.DefaultMarker.MarkerO

    _Index13 = MarkerType
    _Index14 = getMarkerItems(MarkerrotX, _Items6)
    _Index15 = getMarkerItems(MarkerrotY, _Items7)
    _Index16 = getMarkerItems(MarkerrotZ, _Items8)
    _Index17 = getMarkerItems(MarkerscaleX, _Items9)
    _Index18 = getMarkerItems(MarkerscaleY, _Items10)
    _Index19 = getMarkerItems(MarkerscaleZ, _Items11)
    _Index20 = MarkerR + 1
    _Index21 = MarkerV + 1
    _Index22 = MarkerB + 1
    _Index23 = MarkerO + 1 

    local mainMenu = RageUI.CreateMenu("Gang Builder", "Menu")
    local mainMenu2 = RageUI.CreateSubMenu(mainMenu, "Création de Gang", "Menu")
    local mainMenu3 = RageUI.CreateSubMenu(mainMenu, "Gestion des Gangs", "Menu")

    local subMenu = RageUI.CreateSubMenu(mainMenu2, "Gestion de la société", "Menu")
    local subMenu2 = RageUI.CreateSubMenu(mainMenu2, "Gestion du garage", "Menu")
    local subMenu3 = RageUI.CreateSubMenu(mainMenu2, "Gestion du coffre", "Menu")
    local subMenu4 = RageUI.CreateSubMenu(mainMenu2, "Gestion du vestiaire", "Menu")
    local subMenu5 = RageUI.CreateSubMenu(mainMenu2, "Gestion des blips", "Menu")
    local subMenu6 = RageUI.CreateSubMenu(mainMenu2, "Gestion des markers", "Menu")

    local subMenu7 = RageUI.CreateSubMenu(subMenu, "Ajouter un grade", "Menu")
    local subMenu8 = RageUI.CreateSubMenu(subMenu2, "Ajouter un véhicule", "Menu")
    local subMenu9 = RageUI.CreateSubMenu(subMenu4, "Ajouter une tenue", "Menu")
    local subMenu10 = RageUI.CreateSubMenu(subMenu3, "Ajouter un(e) item/arme", "Menu")

    local subMenu11 = RageUI.CreateSubMenu(mainMenu3, "Modification du Gang", "Menu")

    local edit_subMenu = RageUI.CreateSubMenu(subMenu11, "Gestion de la société", "Menu")
    local edit_subMenu2 = RageUI.CreateSubMenu(subMenu11, "Gestion du garage", "Menu")
    local edit_subMenu3 = RageUI.CreateSubMenu(subMenu11, "Gestion du coffre", "Menu")
    local edit_subMenu4 = RageUI.CreateSubMenu(subMenu11, "Gestion du vestiaire", "Menu")
    local edit_subMenu5 = RageUI.CreateSubMenu(subMenu11, "Gestion des blips", "Menu")
    local edit_subMenu6 = RageUI.CreateSubMenu(subMenu11, "Gestion des markers", "Menu")

    local edit_subMenu7 = RageUI.CreateSubMenu(edit_subMenu, "Ajouter un grade", "Menu")
    local edit_subMenu8 = RageUI.CreateSubMenu(edit_subMenu2, "Ajouter un véhicule", "Menu")
    local edit_subMenu9 = RageUI.CreateSubMenu(edit_subMenu4, "Ajouter une tenue", "Menu")
    local edit_subMenu10 = RageUI.CreateSubMenu(edit_subMenu3, "Ajouter un(e) item/arme", "Menu")
    mainMenu.Closed = function()
        builder = false
    end
    subMenu9.Closed = function()
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
            TriggerEvent('skinchanger:loadSkin', skin)
        end)
        FreezeEntityPosition(GetPlayerPed(-1), false)
        RenderScriptCams(0, 1, 1000, 1, 1)
        DestroyAllCams(true)
    end
    subMenu11.Closed = function()
        edit_GradeName,edit_GradeLabel,edit_GradeSalary = "","",""
        edit_VehicleName,edit_VehicleCount,edit_iplaque2,edit_xenon,edit_custom,edit_vitres,edit_plaque,edit_color,edit_active = "","","",false,false,false,false,false,false
        edit_temp_CountItem = ""
        edit_ClothesName = ""
        edit_BlipPreview,edit_Blip,edit_Blip2,edit_BlipPos,edit_BlipName = false,false,false,"",""
        edit_aucun = true
        edit_data_grade = {}
        edit_ModifyGrade = {value = nil, verify = false}
        edit_data_vehicle = {}
        edit_ModifyVehicle = {value = nil, verify = false}
        edit_data_clothes = {}
        edit_ModifyClothes = {value = nil, verify = false}
        edit_data_coffre_item = {}
        edit_data_coffre_weapon = {}
    end
    edit_subMenu9.Closed = function()
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
            TriggerEvent('skinchanger:loadSkin', skin)
        end)
        FreezeEntityPosition(GetPlayerPed(-1), false)
        RenderScriptCams(0, 1, 1000, 1, 1)
        DestroyAllCams(true)
    end
    subMenu9:AddInstructionButton({[1] = GetControlInstructionalButton(0, 47, 0), [2] = "Tourner à Gauche"})
    subMenu9:AddInstructionButton({[1] = GetControlInstructionalButton(0, 23, 0), [2] = "Tourner à Droite"}) 
    subMenu9:AddInstructionButton({[1] = GetControlInstructionalButton(0, 82, 0), [2] = "Activer/Désactiver la Caméra"})
    subMenu9:AddInstructionButton({[1] = GetControlInstructionalButton(0, 22, 0), [2] = "Tourner 90°"})

    subMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 11, 0), [2] = "Descendre"})
    subMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 10, 0), [2] = "Monter"})
    subMenu2:AddInstructionButton({[1] = GetControlInstructionalButton(0, 11, 0), [2] = "Descendre"})
    subMenu2:AddInstructionButton({[1] = GetControlInstructionalButton(0, 10, 0), [2] = "Monter"})
    subMenu3:AddInstructionButton({[1] = GetControlInstructionalButton(0, 11, 0), [2] = "Descendre"})
    subMenu3:AddInstructionButton({[1] = GetControlInstructionalButton(0, 10, 0), [2] = "Monter"})
    subMenu4:AddInstructionButton({[1] = GetControlInstructionalButton(0, 11, 0), [2] = "Descendre"})
    subMenu4:AddInstructionButton({[1] = GetControlInstructionalButton(0, 10, 0), [2] = "Monter"})

    edit_subMenu9:AddInstructionButton({[1] = GetControlInstructionalButton(0, 47, 0), [2] = "Tourner à Gauche"})
    edit_subMenu9:AddInstructionButton({[1] = GetControlInstructionalButton(0, 23, 0), [2] = "Tourner à Droite"}) 
    edit_subMenu9:AddInstructionButton({[1] = GetControlInstructionalButton(0, 82, 0), [2] = "Activer/Désactiver la Caméra"})
    edit_subMenu9:AddInstructionButton({[1] = GetControlInstructionalButton(0, 22, 0), [2] = "Tourner 90°"})

    edit_subMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 11, 0), [2] = "Descendre"})
    edit_subMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 10, 0), [2] = "Monter"})
    edit_subMenu2:AddInstructionButton({[1] = GetControlInstructionalButton(0, 11, 0), [2] = "Descendre"})
    edit_subMenu2:AddInstructionButton({[1] = GetControlInstructionalButton(0, 10, 0), [2] = "Monter"})
    edit_subMenu3:AddInstructionButton({[1] = GetControlInstructionalButton(0, 11, 0), [2] = "Descendre"})
    edit_subMenu3:AddInstructionButton({[1] = GetControlInstructionalButton(0, 10, 0), [2] = "Monter"})
    edit_subMenu4:AddInstructionButton({[1] = GetControlInstructionalButton(0, 11, 0), [2] = "Descendre"})
    edit_subMenu4:AddInstructionButton({[1] = GetControlInstructionalButton(0, 10, 0), [2] = "Monter"})
    if not builder then builder = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
		    while builder do 
                RageUI.IsVisible(mainMenu,function()         
                    RageUI.Button("Créer un gang", nil, {RightLabel = "→"}, true, {}, mainMenu2) 
                    RageUI.Button("Gérer les gangs", nil, {RightLabel = "→"}, true, {}, mainMenu3) 
                end)   
                RageUI.IsVisible(mainMenu2,function()
                    mainMenu2:UpdateInstructionalButtons(true) 
                    RageUI.Button("Nom", nil, {RightLabel = "~b~"..Name.." ~s~→"}, true, {
                        onSelected = function()
                            Name = KeyboardInput("Donner un nom à votre gang", nil, 50)
                            for k,v in pairs(getData.Gang) do
                                if v.name == Name then
                                    Name = ""
                                    ESX.ShowNotification("Un gang porte déjà ce nom")
                                    return
                                end
                            end
                            if Name == nil or Name == "" then
                                Name = ""
                                ESX.ShowNotification("Vous devez rentrer un nom valide")
                            else                       
                                ESX.ShowNotification("Vous avez nommé votre gang ~b~"..Name)
                            end
                        end
                    })
                    RageUI.Button("Label", nil, {RightLabel = "~b~"..Label.." ~s~→"}, true, {
                        onSelected = function()
                            Label = KeyboardInput("Donner un label à votre gang", nil, 50)
                            for k,v in pairs(getData.Gang) do
                                if v.label == Label then
                                    Label = ""
                                    ESX.ShowNotification("Un gang porte déjà ce label")
                                    return
                                end
                            end
                            if Label == nil or Label == "" then
                                Label = ""
                                ESX.ShowNotification("Vous devez rentrer un label valide")
                            else                       
                                ESX.ShowNotification("Vous avez mis un label sur votre gang ~b~"..Label)
                            end
                        end
                    })
                    RageUI.Separator("↓ Gestion ↓")
                    RageUI.Button("Société", nil, {RightLabel = "→"}, true, {}, subMenu)
                    RageUI.Button("Garage", nil, {RightLabel = "→"}, true, {}, subMenu2)
                    RageUI.Button("Coffre", nil, {RightLabel = "→"}, true, {}, subMenu3)
                    RageUI.Button("Vestiaire", nil, {RightLabel = "→"}, true, {}, subMenu4)
                    RageUI.Button("Blips", nil, {RightLabel = "→"}, true, {}, subMenu5)
                    RageUI.Button("Markers", nil, {RightLabel = "→"}, true, {}, subMenu6)
                    RageUI.Line()
                    RageUI.Button("Valider", nil, pGangBuilder.RightLabel, true, {
                        onSelected = function()
                            confirmation = KeyboardInput("Entrez : CONFIRMER", nil, 9)
                            if confirmation == "CONFIRMER" then
                                TriggerServerEvent("pGangBuilder:deleteJobs", Name, Label)
                                Wait(200)
                                TriggerServerEvent("pGangBuilder:deleteJobsGrade", Name)
                                Wait(200)
                                TriggerServerEvent("pGangBuilder:createGang", Name, Label, SocietyPos, SocietyGestion, GaragePos, {x = GarageSpawn.x, y = GarageSpawn.y, z = GarageSpawn.z, w = GarageHeading}, GarageReturn, GaragePnj, data_vehicle, CoffrePos, CoffrePlaces, {money = CoffreMoney, dirtymoney = CoffreDirtyMoney, items = data_coffre_item, weapons = data_coffre_weapon}, VestiairePos, VestiaireGestion, data_clothes, {pos = BlipPos, name = BlipName, sprite = BlipSprite, scale = BlipScale, color = BlipColor, scale2 = BlipScale2, color2 = BlipColor2, opacity = BlipOpacity}, {types = MarkerType, rotX = MarkerrotX, rotY = MarkerrotY, rotZ = MarkerrotZ, scaleX = MarkerscaleX, scaleY = MarkerscaleY, scaleZ = MarkerscaleZ, colorR = MarkerR, colorV = MarkerV, colorB = MarkerB, colorO = MarkerO}, data_grade)
                                Name,Label = "",""
                                SocietyPos,SocietyGestion,GradeName,GradeLabel,GradeSalary,GradeNumber = "",false,"","","",""            
                                Garage,GaragePos,GarageSpawn,GarageHeading,GarageReturn,GaragePnj = false,"","","","",false                      
                                VehicleName,VehicleCount,iplaque2,xenon,custom,vitres,plaque,color,active = "","","",false,false,false,false,false,false
                                Coffre,CoffrePos,CoffreMoney,CoffreDirtyMoney,temp_CountItem = false,"",0,0,""
                                Vestiaire,VestiairePos,VestiaireGestion,ClothesName = false,"",""
                                BlipPreview,Blip,Blip2,BlipPos,BlipName = false,false,false,"",""
                                Marker,MarkerPreview = false,false
                                _Index,_Index2,_Index3,_Index4,_Index5,_Index6,_Index7,_Index8,_Index9,_Index10,_Index11,_Index12,_Index13,_Index14,_Index15,_Index16,_Index17,_Index18,_Index19,_Index20,_Index21,_Index22,_Index23,_Index24,_Index25,_Index26,_Index27,_Index28,_Index29,_Index30,_Index31,_Index32,_Index33,_Index34,_Index35,_Index36,_Index37,_Index38,_Index39,_Index40,_Index41 = 1,1,1,1,1,1,1,10,1,1,1,1,1,19,19,19,11,11,11,1,1,1,256,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                                aucun = true
                                data_grade = {}
                                ModifyGrade = {value = nil, verify = false}
                                data_vehicle = {}
                                ModifyVehicle = {value = nil, verify = false}
                                data_clothes = {}
                                ModifyClothes = {value = nil, verify = false}                     
                                data_coffre_item = {}                   
                                data_coffre_weapon = {}
                                temp_verify,temp_verify2 = false,false
                                RemoveBlip(_blip)
                                RemoveBlip(_blip2)
                                Wait(200) 
                                getDataGang()
                                Wait(200)
                                getDataBlips(false)
                                Wait(200)
                                getDataBlips(true)
                                RageUI.CloseAll()
                                builder = false
                            else
                                ESX.ShowNotification("Vous n'avez pas confirmé votre création")
                            end
                        end
                    })            
                end)
                RageUI.IsVisible(mainMenu3,function()
                    mainMenu3:UpdateInstructionalButtons(true) 
                    for k,v in pairs(getData.Gang) do
                        RageUI.List(v.label, {"Modifier", "Supprimer"}, theIndex, nil, {}, true, {
                            onListChange = function(Index)
                                theIndex = Index
                            end,
                            onSelected = function()
                                if theIndex == 1 then
                                    edit__Index,edit__Index2,edit__Index3,edit__Index4,edit__Index5,edit__Index6,edit__Index7,edit__Index8,edit__Index9,edit__Index10,edit__Index11,edit__Index12,edit__Index13,edit__Index14,edit__Index15,edit__Index16,edit__Index17,edit__Index18,edit__Index19,edit__Index20,edit__Index21,edit__Index22,edit__Index23,edit__Index24,edit__Index25,edit__Index26,edit__Index27,edit__Index28,edit__Index29,edit__Index30,edit__Index31,edit__Index32,edit__Index33,edit__Index34,edit__Index35,edit__Index36,edit__Index37,edit__Index38,edit__Index39,edit__Index40,edit__Index41 = 1,1,1,1,1,1,1,10,1,1,1,1,1,19,19,19,11,11,11,1,1,1,256,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

                                    edit_id = v.id
                                    edit_Name = v.name

                                    previous_edit_name = v.name

                                    edit_Label = v.label

                                    previous_edit_label = v.label

                                    edit_SocietyPos = v.society_pos
                                    if v.society_gestion == "1" then
                                        edit_SocietyGestion = true
                                    else
                                        edit_SocietyGestion = false
                                    end
                                    if v.garage_pos == "" then
                                        edit_Garage = false
                                    else
                                        edit_Garage = true
                                    end
                                    edit_GaragePos = v.garage_pos
                                    edit_GarageSpawn = v.spawn_pos
                                    edit_GarageHeading = v.spawn_pos.w
                                    edit_GarageReturn = v.return_pos
                                    if v.pnj == "1" then
                                        edit_GaragePnj = true
                                    else
                                        edit_GaragePnj = false
                                    end
                                    if v.coffre_pos == "" then
                                        edit_Coffre = false
                                    else
                                        edit_Coffre = true
                                    end
                                    edit_CoffrePos = v.coffre_pos
                                    edit__Index37 = getCoffreItems(v.weight, pGangBuilder.WeightChest)
                                    edit_CoffrePlaces = pGangBuilder.WeightChest[edit__Index37].value
                                    edit_CoffreMoney = v.coffre_data.money
                                    edit_CoffreDirtyMoney = v.coffre_data.dirtymoney
                                    if v.vestiaire_pos == "" then
                                        edit_Vestiaire = false
                                    else
                                        edit_Vestiaire = true
                                    end
                                    edit_VestiairePos = v.vestiaire_pos
                                    if v.vestiaire_gestion == "1" then
                                        edit_VestiaireGestion = true
                                    else
                                        edit_VestiaireGestion = false
                                    end

                                    if v.blips.name ~= "" then
                                        --edit_BlipPreview = true
                                        edit_Blip = true
                                        edit_Blip2 = true
                                        edit_BlipPos = v.blips.pos
                                        edit_BlipName = v.blips.name

                                        edit__Index7 = v.blips.sprite
                                        edit__Index8 = v.blips.scale * 10
                                        edit__Index9 = v.blips.color

                                        edit_BlipSprite = edit__Items2[edit__Index7]
                                        edit_BlipScale = edit__Index8 / 10
                                        edit_BlipColor = edit__Items3[edit__Index9] 

                                        edit__Index10 = v.blips.scale2 / 10
                                        edit__Index11 = v.blips.color2
                                        edit__Index12 = v.blips.opacity / 10

                                        edit_BlipScale2 = edit__Index10 * 10
                                        edit_BlipColor2 = edit__Items4[edit__Index11]   
                                        edit_BlipOpacity = edit__Index12 * 10 
                                    else
                                        --edit_BlipPreview = false
                                        edit_Blip = false
                                        edit_Blip2 = false
                                        edit_BlipPos = ""
                                        edit_BlipName = ""
                                    end 

                                    edit_Marker = true
                                    edit_MarkerPreview = true
                                    edit__Index13 = v.markers.types
                                    edit__Index14 = getMarkerItems(v.markers.rotX, edit__Items6)
                                    edit__Index15 = getMarkerItems(v.markers.rotY, edit__Items7)
                                    edit__Index16 = getMarkerItems(v.markers.rotZ, edit__Items8)
                                    edit__Index17 = getMarkerItems(v.markers.scaleX, edit__Items9)
                                    edit__Index18 = getMarkerItems(v.markers.scaleY, edit__Items10)
                                    edit__Index19 = getMarkerItems(v.markers.scaleZ, edit__Items11)
                                    edit__Index20 = v.markers.colorR + 1
                                    edit__Index21 = v.markers.colorV + 1
                                    edit__Index22 = v.markers.colorB + 1
                                    edit__Index23 = v.markers.colorO + 1

                                    edit_MarkerType = edit__Items5[edit__Index13]
                                    edit_MarkerrotX = edit__Items6[edit__Index14]
                                    edit_MarkerrotY = edit__Items7[edit__Index15]
                                    edit_MarkerrotZ = edit__Items8[edit__Index16]
                                    edit_MarkerscaleX = edit__Items9[edit__Index17]
                                    edit_MarkerscaleY = edit__Items10[edit__Index18]
                                    edit_MarkerscaleZ = edit__Items11[edit__Index19]
                                    edit_MarkerR = edit__Items12[edit__Index20]
                                    edit_MarkerV = edit__Items13[edit__Index21]
                                    edit_MarkerB = edit__Items14[edit__Index22]
                                    edit_MarkerO = edit__Items15[edit__Index23]

                                    ESX.TriggerServerCallback("pGangBuilder:getSocietyGrade", function(data)
                                        for y,z in pairs(data) do
                                            table.insert(edit_data_grade, {name = z.name, label = z.label, salary = z.salary, number = z.grade})
                                        end
                                    end, v.name)                               

                                    for y,z in pairs(v.garage_data) do
                                        table.insert(edit_data_vehicle, {name = z.name, count = z.count, plate = z.plate, props = z.props})
                                    end

                                    for y,z in pairs(v.vestiaire_data) do
                                        table.insert(edit_data_clothes, {name = z.name, skin = z.skin})
                                    end

                                    for y,z in pairs(v.coffre_data.items) do
                                        table.insert(edit_data_coffre_item, {label = z.label, name = z.name, count = z.count})
                                    end

                                    for y,z in pairs(v.coffre_data.weapons) do
                                        table.insert(edit_data_coffre_weapon, {label = z.label, name = z.name, count = z.count, munition = z.munition})
                                    end

                                    actualysocietypos = true
                                    actualygaragepos = true
                                    actualygaragespawn = true
                                    actualygarageheading = true
                                    actualygaragereturn = true
                                    actualycoffrepos = true
                                    actualyvestiairepos = true
                                    actualyblipspos = true

                                    preivous_data_grade = edit_data_grade

                                    Wait(100)
                                    RageUI.Visible(subMenu11, true)
                                elseif theIndex == 2 then
                                    TriggerServerEvent("pGangBuilder:deleteJobs", v.name, v.label)
                                    Wait(200)
                                    TriggerServerEvent("pGangBuilder:deleteJobsGrade", v.name)
                                    Wait(200)
                                    TriggerServerEvent("pGangBuilder:deleteGang", v.id)
                                    Wait(200)
                                    getDataGang()
                                    Wait(200)
                                    getDataBlips(false)
                                    Wait(200) 
                                    getDataBlips(true)
                                end
                            end
                        })
                    end                 
                end)
                RageUI.IsVisible(subMenu,function()
                    subMenu:UpdateInstructionalButtons(true) 
                    RageUI.Button("Placer la société", "~b~"..SocietyPos, {RightLabel = "→"}, true, {
                        onSelected = function()
                            SocietyPos = GetEntityCoords(PlayerPedId())
                            ESX.ShowNotification("Vous venez de sauvegarder la ~b~position de la société")
                        end
                    })  
                    RageUI.Checkbox("Gestion des grades par le boss", nil, SocietyGestion, {}, {
                        onChecked = function()
                            SocietyGestion = true
                            ESX.ShowNotification("Le boss ~g~pourra~s~ gérer les grades")                        
                        end,
                        onUnChecked = function()
                            SocietyGestion = false       
                            ESX.ShowNotification("Le boss ~r~ne pourra pas~s~ gérer les grades")                     
                        end
                    })                     
                    RageUI.Line()
                    RageUI.Button("Ajouter un grade", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            ModifyGrade = {value = nil, verify = false}
                            GradeName,GradeLabel,GradeSalary,GradeNumber,GradeSalary2,GradeNumber2 = "","","","","",""
                        end
                    }, subMenu7) 
                    RageUI.Separator("↓ Liste des grades ↓")
                    if #data_grade == 0 then
                        RageUI.Separator("Aucun grade présent") 
                    end
                    for k,v in pairs(data_grade) do
                        RageUI.List(v.label, {"Modifier", "Supprimer"}, _Index, nil, {}, true, {
                            onActive = function()
                                if k ~= GetkTable(data_grade) then
                                    if IsControlJustPressed(0, 11) then
                                        table.remove(data_grade, k)
                                        table.insert(data_grade, k+1, {name = v.name, label = v.label, salary = v.salary, number = v.number})
                                    end
                                end
                                if k ~= 1 then
                                    if IsControlJustPressed(0, 10) then
                                        table.remove(data_grade, k)
                                        table.insert(data_grade, k-1, {name = v.name, label = v.label, salary = v.salary, number = v.number})
                                    end 
                                end
                                RageUI.Info("Information des grades", 
                                    {
                                        "Label :", 
                                        "Name :", 
                                        "Salaire :", 
                                        "Numéro du grade :"
                                    }, 
                                    {
                                        "~b~"..v.label, 
                                        "~o~"..v.name, 
                                        "~g~"..v.salary.."$", 
                                        "~p~"..v.number
                                    }
                                )
                            end,
                            onListChange = function(Index)
                                _Index = Index
                            end,
                            onSelected = function()
                                if _Index == 1 then
                                    ModifyGrade = {value = k, verify = true}
                                    GradeName = v.name
                                    GradeLabel = v.label
                                    GradeSalary = v.salary
                                    GradeSalary2 = v.salary.."$"
                                    GradeNumber = v.number
                                    GradeNumber2 = "N°"..v.number
                                    Wait(100)
                                    RageUI.Visible(subMenu7, true)
                                elseif _Index == 2 then
                                    table.remove(data_grade, k)
                                end
                            end
                        })
                    end
                end)
                RageUI.IsVisible(subMenu2,function()
                    subMenu2:UpdateInstructionalButtons(true) 
                    RageUI.Checkbox("Ajouter un garage", nil, Garage, {}, {
                        onChecked = function()
                            Garage = true
                            ESX.ShowNotification("Vous avez ~g~ajouté~s~ le garage au gang ~b~"..Label)                        
                        end,
                        onUnChecked = function()
                            Garage = false       
                            ESX.ShowNotification("Vous avez ~r~retiré~s~ le garage au gang ~b~"..Label)                
                        end
                    }) 
                    if Garage then
                        RageUI.Line()
                        RageUI.Button("Placer le garage", "~b~"..GaragePos, {RightLabel = "→"}, true, {
                            onSelected = function()
                                GaragePos = GetEntityCoords(PlayerPedId())
                                ESX.ShowNotification("Vous venez de sauvegarder la ~b~position du garage")
                            end
                        })
                        RageUI.Button("Placer le point de spawn", "~b~"..GarageSpawn, {RightLabel = "→"}, true, {
                            onSelected = function()
                                GarageSpawn = GetEntityCoords(PlayerPedId())
                                ESX.ShowNotification("Vous venez de sauvegarder la ~b~position de spawn des véhicules")
                            end
                        }) 
                        RageUI.Button("Placer la direction de spawn", "~b~"..GarageHeading, {RightLabel = "→"}, true, {
                            onSelected = function()
                                GarageHeading = GetEntityHeading(PlayerPedId())
                                ESX.ShowNotification("Vous venez de sauvegarder la ~b~direction de spawn des véhicules")
                            end
                        }) 
                        RageUI.Button("Placer le point de rangement", "~b~"..GarageReturn, {RightLabel = "→"}, true, {
                            onSelected = function()
                                GarageReturn = GetEntityCoords(PlayerPedId())
                                ESX.ShowNotification("Vous venez de sauvegarder la ~b~position de rangement du garage")
                            end
                        })
                        RageUI.Checkbox("Accepter les véhicules de pnj", nil, GaragePnj, {}, {
                            onChecked = function()
                                GaragePnj = true
                                ESX.ShowNotification("Votre garage ~g~acceptera~s~ les véhicules de pnj")                        
                            end,
                            onUnChecked = function()
                                GaragePnj = false       
                                ESX.ShowNotification("Votre garage ~r~refusera~s~ les véhicules de pnj")                  
                            end
                        })
                        RageUI.Line()
                        RageUI.Button("Ajouter un véhicule", nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                ModifyVehicle = {value = nil, verify = false}
                                _Index2,_Index3,_Index4,_Index5 = 1,1,1,1
                                VehicleName,VehicleCount,iplaque2 = "","",""
                                xenon,custom,vitres,plaque,color,active = false,false,false,false,false,false
                            end
                        }, subMenu8)
                        RageUI.Separator("↓ Liste des véhicules ↓")
                        if #data_vehicle == 0 then
                            RageUI.Separator("Aucun véhicule présent") 
                        end
                        for k,v in pairs(data_vehicle) do
                            RageUI.List(GetLabelText(GetDisplayNameFromVehicleModel(v.props.model)), {"Modifier", "Supprimer"}, _Index6, nil, {}, true, {
                                onActive = function()
                                    if k ~= GetkTable(data_vehicle) then
                                        if IsControlJustPressed(0, 11) then
                                            table.remove(data_vehicle, k)
                                            table.insert(data_vehicle, k+1, {name = v.name, count = v.count, plate = v.plate, props = v.props})
                                        end
                                    end
                                    if k ~= 1 then
                                        if IsControlJustPressed(0, 10) then
                                            table.remove(data_vehicle, k)
                                            table.insert(data_vehicle, k-1, {name = v.name, count = v.count, plate = v.plate, props = v.props})
                                        end 
                                    end

                                    if v.props.color1 == 2 or v.props.color1 == 27 or v.props.color1 == 64 or v.props.color1 == 49 or v.props.color1 == 88 or v.props.color1 == 71 or v.props.color1 == 111 then
                                        _Index3 = 1 
                                    elseif v.props.color1 == 12 or v.props.color1 == 39 or v.props.color1 == 83 or v.props.color1 == 128 or v.props.color1 == 42 or v.props.color1 == 148 or v.props.color1 == 131 then
                                        _Index3 = 2
                                    elseif v.props.color1 == 120 then
                                        _Index3 = 3
                                    end
                                    
                                    if v.props.color1 == 2 or v.props.color1 == 12 or v.props.color1 == 120 then
                                        _Index4 = 1
                                    elseif v.props.color1 == 27 or v.props.color1 == 39 or v.props.color1 == 120 then
                                        _Index4 = 2
                                    elseif v.props.color1 == 64 or v.props.color1 == 83 or v.props.color1 == 120 then
                                        _Index4 = 3
                                    elseif v.props.color1 == 49 or v.props.color1 == 128 or v.props.color1 == 120 then
                                        _Index4 = 4
                                    elseif v.props.color1 == 88 or v.props.color1 == 42 or v.props.color1 == 120 then
                                        _Index4 = 5
                                    elseif v.props.color1 == 71 or v.props.color1 == 148 or v.props.color1 == 120 then
                                        _Index4 = 6
                                    elseif v.props.color1 == 111 or v.props.color1 == 131 or v.props.color1 == 120 then
                                        _Index4 = 7
                                    end

                                    if v.count == -1 then
                                        _Index2 = 1 
                                    else
                                        _Index2 = 2
                                        VehicleCount = v.count
                                    end

                                    VehicleName = GetLabelText(GetDisplayNameFromVehicleModel(v.props.model))
                                    zVehicleName = v.props.model

                                    if v.props.modXenon == 1 then
                                        xenon = true
                                    else
                                        xenon = false
                                    end
                                    if v.props.modTransmission == 2 or v.props.modEngine == 3 or v.props.modBrakes == 2 or v.props.modSuspension == 3 or v.props.modArmor == 4 or v.props.modTurbo == 1 then
                                        custom = true
                                    else
                                        custom = false
                                    end
                                    if v.props.windowTint == -1 then
                                        vitres = false
                                    else
                                        vitres = true
                                    end
                                    if v.props.plate == string.upper(v.plate) then
                                        plaque = true
                                        iplaque2 = v.plate
                                    else
                                        plaque = false
                                    end

                                    RageUI.Info("Information des véhicules", 
                                        {
                                            "Nom du véhicule :", 
                                            "Nombre de véhicule :", 
                                            "Phares Xenon :", 
                                            "Full Custom (performance) :",
                                            "Vitres Teintées :",
                                            "Plaque :",
                                            "Teinte :",
                                            "Couleur :"                                  
                                        }, 
                                        {
                                            "~b~"..VehicleName,    
                                            "~b~"..GetValueCount(_Index2, v.count),
                                            "~b~"..GetValue(xenon),
                                            "~b~"..GetValue(custom),
                                            "~b~"..GetValue(vitres),
                                            "~b~"..GetValue(plaque),
                                            "~b~"..speItemsTeinte[_Index3], 
                                            "~b~"..speItemsColor[_Index4]                              
                                        }
                                    )
                                end,
                                onListChange = function(Index)
                                    _Index6 = Index
                                end,
                                onSelected = function()
                                    if _Index6 == 1 then
                                        ModifyVehicle = {value = k, verify = true}
                                        Wait(100)
                                        RageUI.Visible(subMenu8, true)
                                    elseif _Index6 == 2 then
                                        table.remove(data_vehicle, k)
                                    end
                                end
                            })
                        end  
                    end
                end)
                RageUI.IsVisible(subMenu3,function()
                    subMenu3:UpdateInstructionalButtons(true) 
                    RageUI.Checkbox("Ajouter un coffre", nil, Coffre, {}, {
                        onChecked = function()
                            Coffre = true
                            ESX.ShowNotification("Vous avez ~g~ajouté~s~ le coffre au gang ~b~"..Label)                        
                        end,
                        onUnChecked = function()
                            Coffre = false       
                            ESX.ShowNotification("Vous avez ~r~retiré~s~ le coffre au gang ~b~"..Label)                
                        end
                    })
                    if Coffre then
                        RageUI.Line()
                        RageUI.Button("Placer le coffre", "~b~"..CoffrePos, {RightLabel = "→"}, true, {
                            onSelected = function()
                                CoffrePos = GetEntityCoords(PlayerPedId())
                                ESX.ShowNotification("Vous venez de sauvegarder la ~b~position du coffre")
                            end
                        })
                        RageUI.List("Places dans le coffre", _Items, _Index37, nil, {}, true, {
                            onListChange = function(Index)
                                _Index37 = Index
                            end,
                            onActive = function()
                                CoffrePlaces = pGangBuilder.WeightChest[_Index37].value
                            end,
                            onSelected = function()
                                ESX.ShowNotification("Vous venez de sauvegarder la place dans le coffre qui est de ~b~"..pGangBuilder.WeightChest[_Index37].label)
                            end
                        })
                        RageUI.Button("Ajouter un(e) item/arme", nil, {RightLabel = "→"}, true, {}, subMenu10)
                        RageUI.Separator("↓ Contenu du coffre de base ↓")
                        RageUI.Button("Argent Propre", nil, {RightLabel = "~g~"..CoffreMoney.."$ ~s~→"}, true, {
                            onSelected = function()
                                CoffreMoney = KeyboardInput("Donner un montant de base (argent propre)", nil, 10)
                                if CoffreMoney == nil or CoffreMoney == "" or not tonumber(CoffreMoney) then
                                    CoffreMoney = 0
                                    ESX.ShowNotification("Vous devez rentrer un montant valide")
                                else       
                                    CoffreMoney = tonumber(CoffreMoney)
                                    ESX.ShowNotification("Vous venez de sauvegarder le montant d'argent propre de base ~g~"..CoffreMoney.."$")          
                                end
                            end 
                        })
                        RageUI.Button("Argent Sale", nil, {RightLabel = "~r~"..CoffreDirtyMoney.."$ ~s~→"}, true, {
                            onSelected = function()
                                CoffreDirtyMoney = KeyboardInput("Donner un montant de base (argent sale)", nil, 10)
                                if CoffreDirtyMoney == nil or CoffreDirtyMoney == "" or not tonumber(CoffreDirtyMoney) then
                                    CoffreDirtyMoney = 0
                                    ESX.ShowNotification("Vous devez rentrer un montant valide")
                                else       
                                    CoffreDirtyMoney = tonumber(CoffreDirtyMoney)
                                    ESX.ShowNotification("Vous venez de sauvegarder le montant d'argent sale de base ~r~"..CoffreDirtyMoney.."$")          
                                end
                            end 
                        })
                        RageUI.Separator("↓ Liste des items ↓")
                        if #data_coffre_item == 0 then
                            RageUI.Separator("Aucun item présent") 
                        end
                        for k,v in pairs(data_coffre_item) do
                            RageUI.List("~b~x"..v.count.." ~s~"..v.label, {"Modifier", "Supprimer"}, _Index38, nil, {}, true, {
                                onActive = function()
                                    if k ~= GetkTable(data_coffre_item) then
                                        if IsControlJustPressed(0, 11) then
                                            table.remove(data_coffre_item, k)
                                            table.insert(data_coffre_item, k+1, {label = v.label, name = v.name, count = v.count})
                                        end
                                    end
                                    if k ~= 1 then
                                        if IsControlJustPressed(0, 10) then
                                            table.remove(data_coffre_item, k)
                                            table.insert(data_coffre_item, k-1, {label = v.label, name = v.name, count = v.count})
                                        end 
                                    end
                                end,
                                onListChange = function(Index)
                                    _Index38 = Index
                                end,
                                onSelected = function()
                                    if _Index38 == 1 then
                                        temp_CountItem2 = KeyboardInput("Donner un nouveau nombre d'items", nil, 5)
                                        if temp_CountItem2 == nil or temp_CountItem2 == "" or not tonumber(temp_CountItem2) then
                                            temp_CountItem2 = ""
                                            ESX.ShowNotification("Vous devez rentrer un nombre valide")
                                        else   
                                            ESX.ShowNotification("Vous venez de re-sauvegarder l'ajout de ~y~x"..temp_CountItem2.." ~b~"..v.label)
                                            table.remove(data_coffre_item, k)               
                                            table.insert(data_coffre_item, k, {label = v.label, name = v.name, count = tonumber(temp_CountItem2)})
                                        end
                                    elseif _Index38 == 2 then
                                        if k == 1 then
                                            temp_verify = false
                                        end
                                        table.remove(data_coffre_item, k)
                                    end
                                end
                            })
                        end
                        RageUI.Separator("↓ Liste des armes ↓")
                        if #data_coffre_weapon == 0 then
                            RageUI.Separator("Aucune arme présente") 
                        end
                        for k,v in pairs(data_coffre_weapon) do
                            if v.munition ~= nil then
                                RageUI.List("~b~x"..v.count.." ~s~"..v.label.." (~o~x"..v.munition.."~s~)", {"Modifier le nombre", "Modifier les munitions", "Supprimer"}, _Index39, nil, {}, true, {
                                    onActive = function()
                                        if k ~= GetkTable(data_coffre_weapon) then
                                            if IsControlJustPressed(0, 11) then
                                                table.remove(data_coffre_weapon, k)
                                                table.insert(data_coffre_weapon, k+1, {label = v.label, name = v.name, count = v.count, munition = v.munition})
                                            end
                                        end
                                        if k ~= 1 then
                                            if IsControlJustPressed(0, 10) then
                                                table.remove(data_coffre_weapon, k)
                                                table.insert(data_coffre_weapon, k-1, {label = v.label, name = v.name, count = v.count, munition = v.munition})
                                            end 
                                        end
                                    end,
                                    onListChange = function(Index)
                                        _Index39 = Index
                                    end,
                                    onSelected = function()
                                        if _Index39 == 1 then
                                            temp_CountWeapon2 = KeyboardInput("Donner un nouveau nombre d'arme", nil, 5)
                                            if temp_CountWeapon2 == nil or temp_CountWeapon2 == "" or not tonumber(temp_CountWeapon2) then
                                                temp_CountWeapon2 = ""
                                                ESX.ShowNotification("Vous devez rentrer un nombre valide")
                                            else   
                                                ESX.ShowNotification("Vous venez de re-sauvegarder l'ajout de ~y~x"..temp_CountWeapon2.." ~b~"..v.label)              
                                                table.remove(data_coffre_weapon, k) 
                                                table.insert(data_coffre_weapon, k, {label = v.label, name = v.name, count = tonumber(temp_CountWeapon2), munition = v.munition})
                                            end
                                        elseif _Index39 == 2 then
                                            temp_CountWeapon3 = KeyboardInput("Donner un nouveau nombre de munitions", nil, 5)
                                            if temp_CountWeapon3 == nil or temp_CountWeapon3 == "" or not tonumber(temp_CountWeapon3) then
                                                temp_CountWeapon3 = ""
                                                ESX.ShowNotification("Vous devez rentrer un nombre valide")
                                            else   
                                                ESX.ShowNotification("Vous venez de re-sauvegarder l'ajout de ~y~x"..temp_CountWeapon3.." munitions ~s~à la/au ~b~"..v.label) 
                                                table.remove(data_coffre_weapon, k)              
                                                table.insert(data_coffre_weapon, k, {label = v.label, name = v.name, count = v.count, munition = tonumber(temp_CountWeapon3)})
                                            end
                                        elseif _Index39 == 3 then
                                            if k == 1 then
                                                temp_verify2 = false
                                            end
                                            table.remove(data_coffre_weapon, k)
                                        end
                                    end
                                })
                            else
                                RageUI.List("~b~x"..v.count.." ~s~"..v.label, {"Modifier le nombre", "Supprimer"}, _Index40, nil, {}, true, {
                                    onActive = function()
                                        if k ~= GetkTable(data_coffre_weapon) then
                                            if IsControlJustPressed(0, 11) then
                                                table.remove(data_coffre_weapon, k)
                                                table.insert(data_coffre_weapon, k+1, {label = v.label, name = v.name, count = v.count, munition = nil})
                                            end
                                        end
                                        if k ~= 1 then
                                            if IsControlJustPressed(0, 10) then
                                                table.remove(data_coffre_weapon, k)
                                                table.insert(data_coffre_weapon, k-1, {label = v.label, name = v.name, count = v.count, munition = nil})
                                            end 
                                        end
                                    end,
                                    onListChange = function(Index)
                                        _Index40 = Index
                                    end,
                                    onSelected = function()
                                        if _Index40 == 1 then
                                            temp_CountWeapon2 = KeyboardInput("Donner un nouveau nombre d'arme", nil, 5)
                                            if temp_CountWeapon2 == nil or temp_CountWeapon2 == "" or not tonumber(temp_CountWeapon2) then
                                                temp_CountWeapon2 = ""
                                                ESX.ShowNotification("Vous devez rentrer un nombre valide")
                                            else   
                                                ESX.ShowNotification("Vous venez de re-sauvegarder l'ajout de ~y~x"..temp_CountWeapon2.." ~b~"..v.label)   
                                                table.remove(data_coffre_weapon, k)            
                                                table.insert(data_coffre_weapon, k, {label = v.label, name = v.name, count = tonumber(temp_CountWeapon2), munition = nil})
                                            end
                                        elseif _Index40 == 3 then
                                            table.remove(data_coffre_weapon, k)
                                        end
                                    end
                                })
                            end
                        end
                    end
                end)
                RageUI.IsVisible(subMenu4,function()
                    subMenu4:UpdateInstructionalButtons(true) 
                    RageUI.Checkbox("Ajouter un vestiaire", nil, Vestiaire, {}, {
                        onChecked = function()
                            Vestiaire = true
                            ESX.ShowNotification("Vous avez ~g~ajouté~s~ le vestiaire au gang ~b~"..Label)                        
                        end,
                        onUnChecked = function()
                            Vestiaire = false       
                            ESX.ShowNotification("Vous avez ~r~retiré~s~ le vestiaire au gang ~b~"..Label)                
                        end
                    }) 
                    if Vestiaire then
                        RageUI.Line()
                        RageUI.Button("Placer le vestiaire", "~b~"..VestiairePos, {RightLabel = "→"}, true, {
                            onSelected = function()
                                VestiairePos = GetEntityCoords(PlayerPedId())
                                ESX.ShowNotification("Vous venez de sauvegarder la ~b~position du vestiaire")
                            end
                        })
                        RageUI.Checkbox("Gestion des tenues par le boss", nil, VestiaireGestion, {}, {
                            onChecked = function()
                                VestiaireGestion = true
                                ESX.ShowNotification("Le boss ~g~pourra~s~ gérer les tenues")                        
                            end,
                            onUnChecked = function()
                                VestiaireGestion = false       
                                ESX.ShowNotification("Le boss ~r~ne pourra pas~s~ gérer les tenues")                     
                            end
                        }) 
                        RageUI.Line()
                        RageUI.Button("Ajouter une tenue", nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                ModifyClothes = {value = nil, verify = false}
                                ClothesName = ""
                                GetSkinValue() 
                                CreateMain() 
                                Wait(100) 
                                FreezeEntityPosition(GetPlayerPed(-1), true)
                            end
                        }, subMenu9) 
                        RageUI.Separator("↓ Liste des tenues ↓")
                        if #data_clothes == 0 then
                            RageUI.Separator("Aucune tenue présente") 
                        end
                        for k,v in pairs(data_clothes) do
                            RageUI.List(v.name, {"Modifier", "Supprimer"}, _Index41, nil, {}, true, {
                                onActive = function()
                                    if k ~= GetkTable(data_clothes) then
                                        if IsControlJustPressed(0, 11) then
                                            table.remove(data_clothes, k)
                                            table.insert(data_clothes, k+1, {name = v.name, skin = v.skin})
                                        end
                                    end
                                    if k ~= 1 then
                                        if IsControlJustPressed(0, 10) then
                                            table.remove(data_clothes, k)
                                            table.insert(data_clothes, k-1, {name = v.name, skin = v.skin})
                                        end 
                                    end
                                end,
                                onListChange = function(Index)
                                    _Index41 = Index
                                end,
                                onSelected = function()
                                    if _Index41 == 1 then
                                        ModifyClothes = {value = k, verify = true}
                                        ClothesName = v.name
                                        veste1 = v.skin.torso_1+1
                                        vestecolor1 = v.skin.torso_2+1
                                        tshirt1 = v.skin.tshirt_1+1
                                        tshirtcolor1 = v.skin.tshirt_2+1
                                        pantalon1 = v.skin.pants_1+1
                                        pantaloncolor1 = v.skin.pants_2+1
                                        chaussure1 = v.skin.shoes_1+1
                                        chaussurecolor1 = v.skin.shoes_2+1
                                        bras1 = v.skin.arms+1
                                        calque1 = v.skin.decals_1+1
                                        calquecolor1 = v.skin.decals_2+1
                                        chaine1 = v.skin.chain_1+1
                                        chainecolor1 = v.skin.chain_2+1
                                        casque1 = v.skin.helmet_1+2
                                        casquecolor1 = v.skin.helmet_2+1
                                        lunette1 = v.skin.glasses_1+1
                                        lunettecolor1 = v.skin.glasses_2+1
                                        oreille1 = v.skin.ears_1+2
                                        oreillecolor1 = v.skin.ears_2+1
                                        montre1 = v.skin.watches_1+2
                                        montrecolor1 = v.skin.watches_2+1
                                        bracelet1 = v.skin.bracelets_1+2
                                        braceletcolor1 = v.skin.bracelets_2+1
                                        sac1 = v.skin.bags_1+1
                                        saccolor1 = v.skin.bags_2+1
                                        TriggerEvent('skinchanger:loadSkin', v.skin)
                                        GetSkinValue() 
                                        CreateMain() 
                                        Wait(100) 
                                        FreezeEntityPosition(GetPlayerPed(-1), true)
                                        RageUI.Visible(subMenu9, true)
                                    elseif _Index41 == 2 then
                                        table.remove(data_clothes, k)
                                    end
                                end
                            })
                        end
                    end
                end)
                RageUI.IsVisible(subMenu5,function()
                    RageUI.Checkbox("Ajouter un blip", nil, Blip, {}, {
                        onChecked = function()
                            Blip = true
                            if BlipPreview == true then        
                                RemoveBlip(_blip)
                                RemoveBlip(_blip2)  
                                _PreviewBlip(BlipPos, BlipName, Blip, Blip2) 
                            end 
                            ESX.ShowNotification("Vous avez ~g~ajouté~s~ le blip au gang ~b~"..Label)                        
                        end,
                        onUnChecked = function()
                            Blip = false
                            if BlipPreview == true then        
                                RemoveBlip(_blip)
                                RemoveBlip(_blip2)  
                                _PreviewBlip(BlipPos, BlipName, Blip, Blip2) 
                            end 
                            ESX.ShowNotification("Vous avez ~r~retiré~s~ le blip au gang ~b~"..Label)                
                        end
                    })
                    if Blip then
                        RageUI.Line()
                        RageUI.Checkbox("Prévisualisé le blip", nil, BlipPreview, {}, {
                            onChecked = function()
                                BlipPreview = true 
                                BlipSprite = _Items2[_Index7]
                                BlipScale = _Index8 / 10
                                BlipColor = _Items3[_Index9]         
                                _PreviewBlip(BlipPos, BlipName, Blip, Blip2) 
                                ESX.ShowNotification("Prévisualisation ~g~activée~s~")       
                            end,
                            onUnChecked = function()   
                                BlipPreview = false
                                RemoveBlip(_blip)
                                RemoveBlip(_blip2)  
                                ESX.ShowNotification("Prévisualisation ~r~désactivée~s~")           
                            end
                        })
                        RageUI.Button("Placer le blip", "~b~"..BlipPos, {RightLabel = "→"}, true, {
                            onSelected = function()
                                BlipPos = GetEntityCoords(PlayerPedId())
                                ESX.ShowNotification("Vous venez de sauvegarder la ~b~position du blip")
                                if BlipPreview == true then        
                                    RemoveBlip(_blip)
                                    RemoveBlip(_blip2)  
                                    _PreviewBlip(BlipPos, BlipName, Blip, Blip2) 
                                end
                            end
                        })
                        RageUI.Button("Nom", nil, {RightLabel = "~b~"..BlipName.." ~s~→"}, true, {
                            onSelected = function()
                                BlipName = KeyboardInput("Donner un nom à votre blip", nil, 50)
                                if BlipName == nil or BlipName == "" then
                                    BlipName = ""
                                    ESX.ShowNotification("Vous devez rentrer un nom valide")
                                else       
                                    if BlipPreview == true then        
                                        RemoveBlip(_blip)
                                        RemoveBlip(_blip2)  
                                        _PreviewBlip(BlipPos, BlipName, Blip, Blip2) 
                                    end                
                                    ESX.ShowNotification("Vous avez nommé votre blip ~b~"..BlipName)
                                end
                            end
                        })
                        RageUI.List("Type", _Items2, _Index7, nil, {}, true, {
                            onListChange = function(Index)
                                _Index7 = Index
                                if BlipPreview == true then        
                                    RemoveBlip(_blip)
                                    RemoveBlip(_blip2)  
                                    _PreviewBlip(BlipPos, BlipName, Blip, Blip2) 
                                end
                            end,
                            onActive = function()
                                BlipSprite = _Index7
                            end,
                            onSelected = function()
                                BlipSprite = KeyboardInput("Donner un type à votre blip (0 - 826)", nil, 3)
                                if BlipSprite == nil or BlipSprite == "" or not tonumber(BlipSprite) then
                                    BlipSprite = ""
                                    ESX.ShowNotification("Vous devez rentrer un type valide")
                                else
                                    _Index7 = tonumber(BlipSprite)   
                                    BlipSprite = _Index7
                                    if BlipPreview == true then        
                                        RemoveBlip(_blip)
                                        RemoveBlip(_blip2)  
                                        _PreviewBlip(BlipPos, BlipName, Blip, Blip2) 
                                    end 
                                    ESX.ShowNotification("Vous venez de sauvegarder le type du blip qui est de ~b~"..BlipSprite)          
                                end
                            end
                        })
                        RageUI.List("Taille", {0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0,1.1,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,2.0}, _Index8, nil, {}, true, {
                            onListChange = function(Index)
                                _Index8 = Index
                                if BlipPreview == true then        
                                    RemoveBlip(_blip)
                                    RemoveBlip(_blip2)  
                                    _PreviewBlip(BlipPos, BlipName, Blip, Blip2) 
                                end
                            end,
                            onActive = function()
                                BlipScale = _Index8 / 10
                            end,
                            onSelected = function()
                                BlipScale = KeyboardInput("Donner une taille à votre blip (0.1 - 2.0)", nil, 3)
                                if BlipScale == nil or BlipScale == "" or not tonumber(BlipScale) then
                                    BlipScale = ""
                                    ESX.ShowNotification("Vous devez rentrer une taille valide")
                                else       
                                    _Index8 = tonumber(BlipScale) * 10
                                    BlipScale = tonumber(BlipScale) * 1.0
                                    if BlipPreview == true then        
                                        RemoveBlip(_blip)
                                        RemoveBlip(_blip2)  
                                        _PreviewBlip(BlipPos, BlipName, Blip, Blip2) 
                                    end 
                                    ESX.ShowNotification("Vous venez de sauvegarder la taille du blip qui est de ~b~"..BlipScale)           
                                end
                            end
                        })
                        RageUI.List("Couleur", _Items3, _Index9, nil, {}, true, {
                            onListChange = function(Index)
                                _Index9 = Index
                                if BlipPreview == true then        
                                    RemoveBlip(_blip)
                                    RemoveBlip(_blip2)  
                                    _PreviewBlip(BlipPos, BlipName, Blip, Blip2) 
                                end
                            end,
                            onActive = function()
                                BlipColor = _Index9
                            end,
                            onSelected = function()
                                BlipColor = KeyboardInput("Donner une couleur à votre blip (0 - 85)", nil, 2)
                                if BlipColor == nil or BlipColor == "" or not tonumber(BlipColor) then
                                    BlipColor = ""
                                    ESX.ShowNotification("Vous devez rentrer une couleur valide")
                                else   
                                    _Index9 = tonumber(BlipColor)  
                                    BlipColor = _Index9  
                                    if BlipPreview == true then        
                                        RemoveBlip(_blip)
                                        RemoveBlip(_blip2)  
                                        _PreviewBlip(BlipPos, BlipName, Blip, Blip2) 
                                    end 
                                    ESX.ShowNotification("Vous venez de sauvegarder la couleur du blip qui est de ~b~"..BlipColor)               
                                end
                            end
                        })
                        RageUI.Checkbox("Ajouter un blip de zone", nil, Blip2, {}, {
                            onChecked = function()
                                Blip2 = true
                                if BlipPreview == true then
                                    BlipScale2 = _Index10 * 10
                                    BlipColor2 = _Items4[_Index11]   
                                    BlipOpacity = _Index12 * 10                          
                                    RemoveBlip(_blip)
                                    RemoveBlip(_blip2)  
                                    _PreviewBlip(BlipPos, BlipName, Blip, Blip2) 
                                end 
                                ESX.ShowNotification("Vous avez ~g~ajouté~s~ le blip de zone au gang ~b~"..Label)                        
                            end,
                            onUnChecked = function()
                                Blip2 = false       
                                if BlipPreview == true then        
                                    RemoveBlip(_blip)
                                    RemoveBlip(_blip2)  
                                    _PreviewBlip(BlipPos, BlipName, Blip, Blip2) 
                                end 
                                ESX.ShowNotification("Vous avez ~r~retiré~s~ le blip de zone au gang ~b~"..Label)                
                            end
                        })
                        if Blip2 then
                            RageUI.List("Taille", {10,20,30,40,50,60,70,80,90,100,110,120,130,140,150,160,170,180,190,200}, _Index10, nil, {}, true, {
                                onListChange = function(Index)
                                    _Index10 = Index
                                    if BlipPreview == true then        
                                        RemoveBlip(_blip)
                                        RemoveBlip(_blip2)  
                                        _PreviewBlip(BlipPos, BlipName, Blip, Blip2) 
                                    end
                                end,
                                onActive = function()
                                    BlipScale2 = _Index10 * 10.0
                                end,
                                onSelected = function()
                                    BlipScale2 = KeyboardInput("Donner une taille à votre blip de zone (10 - 200)", nil, 3)
                                    if BlipScale2 == nil or BlipScale2 == "" or not tonumber(BlipScale2) then
                                        BlipScale2 = ""
                                        ESX.ShowNotification("Vous devez rentrer une taille valide")
                                    else     
                                        _Index10 = tonumber(BlipScale2) / 10 
                                        BlipScale2 = tonumber(BlipScale2) * 1.0
                                        if BlipPreview == true then        
                                            RemoveBlip(_blip)
                                            RemoveBlip(_blip2)  
                                            _PreviewBlip(BlipPos, BlipName, Blip, Blip2) 
                                        end 
                                        ESX.ShowNotification("Vous venez de sauvegarder la taille du blip de zone qui est de ~b~"..BlipScale2)           
                                    end
                                end
                            })
                            RageUI.List("Couleur", _Items4, _Index11, nil, {}, true, {
                                onListChange = function(Index)
                                    _Index11 = Index
                                    if BlipPreview == true then        
                                        RemoveBlip(_blip)
                                        RemoveBlip(_blip2)  
                                        _PreviewBlip(BlipPos, BlipName, Blip, Blip2) 
                                    end
                                end,
                                onActive = function()
                                    BlipColor2 = _Index11
                                end,
                                onSelected = function()
                                    BlipColor2 = KeyboardInput("Donner une couleur à votre blip de zone (0 - 85)", nil, 2)
                                    if BlipColor2 == nil or BlipColor2 == "" or not tonumber(BlipColor2) then
                                        BlipColor2 = ""
                                        ESX.ShowNotification("Vous devez rentrer une couleur valide")
                                    else     
                                        _Index11 = tonumber(BlipColor2)
                                        BlipColor2 = _Index11
                                        if BlipPreview == true then        
                                            RemoveBlip(_blip)
                                            RemoveBlip(_blip2)  
                                            _PreviewBlip(BlipPos, BlipName, Blip, Blip2) 
                                        end 
                                        ESX.ShowNotification("Vous venez de sauvegarder la couleur du blip de zone qui est de ~b~"..BlipColor2)               
                                    end
                                end
                            })
                            RageUI.List("Opacité", {10,20,30,40,50,60,70,80,90,100,110,120,130,140,150,160,170,180,190,200}, _Index12, nil, {}, true, {
                                onListChange = function(Index)
                                    _Index12 = Index
                                    if BlipPreview == true then        
                                        RemoveBlip(_blip)
                                        RemoveBlip(_blip2)  
                                        _PreviewBlip(BlipPos, BlipName, Blip, Blip2) 
                                    end
                                end,
                                onActive = function()
                                    BlipOpacity = _Index12 * 10
                                end,
                                onSelected = function()
                                    BlipOpacity = KeyboardInput("Donner une opacité à votre blip de zone (10 - 200)", nil, 3)
                                    if BlipOpacity == nil or BlipOpacity == "" or not tonumber(BlipOpacity) then
                                        BlipOpacity = ""
                                        ESX.ShowNotification("Vous devez rentrer une opacité valide")
                                    else      
                                        _Index12 = tonumber(BlipOpacity) / 10
                                        BlipOpacity = tonumber(BlipOpacity)
                                        if BlipPreview == true then        
                                            RemoveBlip(_blip)
                                            RemoveBlip(_blip2)  
                                            _PreviewBlip(BlipPos, BlipName, Blip, Blip2) 
                                        end 
                                        ESX.ShowNotification("Vous venez de sauvegarder l'opacité du blip de zone qui est de ~b~"..BlipOpacity)            
                                    end
                                end
                            })
                        end
                    end
                end)
                RageUI.IsVisible(subMenu6,function()
                    if MarkerPreview then
                        DrawMarker(MarkerType, GetEntityCoords(PlayerPedId()).x, GetEntityCoords(PlayerPedId()).y, GetEntityCoords(PlayerPedId()).z-1, 0.0, 0.0, 0.0, MarkerrotX, MarkerrotY, MarkerrotZ, MarkerscaleX, MarkerscaleY, MarkerscaleZ, MarkerR, MarkerV, MarkerB, MarkerO, false, false, p19, false) 
                    end
                    RageUI.Checkbox("Ajouter un marker", nil, Marker, {}, {
                        onChecked = function()
                            Marker = true
                            ESX.ShowNotification("Vous avez ~g~ajouté~s~ le marker au gang ~b~"..Label)                        
                        end,
                        onUnChecked = function()
                            Marker = false
                            ESX.ShowNotification("Vous avez ~r~retiré~s~ le marker au gang ~b~"..Label)                
                        end
                    })
                    if Marker then
                        RageUI.Line()
                        RageUI.Checkbox("Prévisualisé le marker", nil, MarkerPreview, {}, {
                            onChecked = function()
                                MarkerPreview = true
                                MarkerType = _Items5[_Index13]
                                MarkerrotX = _Items6[_Index14]
                                MarkerrotY = _Items7[_Index15]
                                MarkerrotZ = _Items8[_Index16]
                                MarkerscaleX = _Items9[_Index17]
                                MarkerscaleY = _Items10[_Index18]
                                MarkerscaleZ = _Items11[_Index19]
                                MarkerR = _Items12[_Index20]
                                MarkerV = _Items13[_Index21]
                                MarkerB = _Items14[_Index22]
                                MarkerO = _Items15[_Index23]          
                                ESX.ShowNotification("Prévisualisation ~g~activée~s~")       
                            end,
                            onUnChecked = function()   
                                MarkerPreview = false
                                ESX.ShowNotification("Prévisualisation ~r~désactivée~s~")           
                            end
                        })
                        RageUI.List("Type", _Items5, _Index13, nil, {}, true, {
                            onListChange = function(Index)
                                _Index13 = Index
                            end,
                            onActive = function()
                                MarkerType = _Index13
                            end
                        })
                        RageUI.List("Rotation X", _Items6, _Index14, nil, {}, true, {
                            onListChange = function(Index)
                                _Index14 = Index
                            end,
                            onActive = function()
                                MarkerrotX = _Items6[_Index14]
                            end,
                            onSelected = function()
                                MarkerrotX = KeyboardInput("Donner une rotation x à votre marker (-180.0 - 180.0)", nil, 5)
                                if MarkerrotX == nil or MarkerrotX == "" or not tonumber(MarkerrotX) then
                                    MarkerrotX = ""
                                    ESX.ShowNotification("Vous devez rentrer une rotation valide")
                                else      
                                    for k,v in pairs(_Items6) do
                                        if v == tonumber(MarkerrotX) then
                                            _Index14 = k
                                        end
                                    end 
                                    ESX.ShowNotification("Vous venez de sauvegarder la rotation x du marker qui est de ~b~"..MarkerrotX)          
                                end
                            end
                        })
                        RageUI.List("Rotation Y", _Items7, _Index15, nil, {}, true, {
                            onListChange = function(Index)
                                _Index15 = Index
                            end,
                            onActive = function()
                                MarkerrotY = _Items7[_Index15]
                            end,
                            onSelected = function()
                                MarkerrotY = KeyboardInput("Donner une rotation y à votre marker (-180.0 - 180.0)", nil, 5)
                                if MarkerrotY == nil or MarkerrotY == "" or not tonumber(MarkerrotY) then
                                    MarkerrotY = ""
                                    ESX.ShowNotification("Vous devez rentrer une rotation valide")
                                else       
                                    for k,v in pairs(_Items7) do
                                        if v == tonumber(MarkerrotY) then
                                            _Index15 = k
                                        end
                                    end
                                    ESX.ShowNotification("Vous venez de sauvegarder la rotation y du marker qui est de ~b~"..MarkerrotY)          
                                end
                            end
                        })
                        RageUI.List("Rotation Z", _Items8, _Index16, nil, {}, true, {
                            onListChange = function(Index)
                                _Index16 = Index
                            end,
                            onActive = function()
                                MarkerrotZ = _Items8[_Index16]
                            end,
                            onSelected = function()
                                MarkerrotZ = KeyboardInput("Donner une rotation z à votre marker (-180.0 - 180.0)", nil, 5)
                                if MarkerrotZ == nil or MarkerrotZ == "" or not tonumber(MarkerrotZ) then
                                    MarkerrotZ = ""
                                    ESX.ShowNotification("Vous devez rentrer une rotation valide")
                                else       
                                    for k,v in pairs(_Items8) do
                                        if v == tonumber(MarkerrotZ) then
                                            _Index16 = k
                                        end
                                    end
                                    ESX.ShowNotification("Vous venez de sauvegarder la rotation z du marker qui est de ~b~"..MarkerrotZ)          
                                end
                            end
                        })
                        RageUI.List("Taille X", _Items9, _Index17, nil, {}, true, {
                            onListChange = function(Index)
                                _Index17 = Index
                            end,
                            onActive = function()
                                MarkerscaleX = _Items9[_Index17]
                            end,
                            onSelected = function()
                                MarkerscaleX = KeyboardInput("Donner une taille x à votre marker (0.0 - 2.0)", nil, 5)
                                if MarkerscaleX == nil or MarkerscaleX == "" or not tonumber(MarkerscaleX) then
                                    MarkerscaleX = ""
                                    ESX.ShowNotification("Vous devez rentrer une taille valide")
                                else       
                                    for k,v in pairs(_Items9) do
                                        if v == tonumber(MarkerscaleX) then
                                            _Index17 = k
                                        end
                                    end 
                                    ESX.ShowNotification("Vous venez de sauvegarder la taille x du marker qui est de ~b~"..MarkerscaleX)          
                                end
                            end
                        })
                        RageUI.List("Taille Y", _Items10, _Index18, nil, {}, true, {
                            onListChange = function(Index)
                                _Index18 = Index
                            end,
                            onActive = function()
                                MarkerscaleY = _Items10[_Index18]
                            end,
                            onSelected = function()
                                MarkerscaleY = KeyboardInput("Donner une taille y à votre marker (0.0 - 2.0)", nil, 5)
                                if MarkerscaleY == nil or MarkerscaleY == "" or not tonumber(MarkerscaleY) then
                                    MarkerscaleY = ""
                                    ESX.ShowNotification("Vous devez rentrer une taille valide")
                                else       
                                    for k,v in pairs(_Items10) do
                                        if v == tonumber(MarkerscaleY) then
                                            _Index18 = k
                                        end
                                    end 
                                    ESX.ShowNotification("Vous venez de sauvegarder la taille y du marker qui est de ~b~"..MarkerscaleY)          
                                end
                            end
                        })
                        RageUI.List("Taille Z", _Items11, _Index19, nil, {}, true, {
                            onListChange = function(Index)
                                _Index19 = Index
                            end,
                            onActive = function()
                                MarkerscaleZ = _Items11[_Index19]
                            end,
                            onSelected = function()
                                MarkerscaleZ = KeyboardInput("Donner une taille z à votre marker (0.0 - 2.0)", nil, 5)
                                if MarkerscaleZ == nil or MarkerscaleZ == "" or not tonumber(MarkerscaleZ) then
                                    MarkerscaleZ = ""
                                    ESX.ShowNotification("Vous devez rentrer une taille valide")
                                else        
                                    for k,v in pairs(_Items11) do
                                        if v == tonumber(MarkerscaleZ) then
                                            _Index19 = k
                                        end
                                    end 
                                    ESX.ShowNotification("Vous venez de sauvegarder la taille z du marker qui est de ~b~"..MarkerscaleZ)          
                                end
                            end
                        })
                        RageUI.List("R", _Items12, _Index20, nil, {}, true, {
                            onListChange = function(Index)
                                _Index20 = Index
                            end,
                            onActive = function()
                                MarkerR = _Items12[_Index20]
                            end,
                            onSelected = function()
                                MarkerR = KeyboardInput("Donner une couleur rouge à votre marker (0 - 255)", nil, 5)
                                if MarkerR == nil or MarkerR == "" or not tonumber(MarkerR) then
                                    MarkerR = ""
                                    ESX.ShowNotification("Vous devez rentrer une couleur rouge valide")
                                else   
                                    for k,v in pairs(_Items12) do
                                        if v == tonumber(MarkerR) then
                                            _Index20 = k
                                        end
                                    end        
                                    ESX.ShowNotification("Vous venez de sauvegarder la couleur rouge du marker qui est de ~b~"..MarkerR)          
                                end
                            end
                        })
                        RageUI.List("V", _Items13, _Index21, nil, {}, true, {
                            onListChange = function(Index)
                                _Index21 = Index
                            end,
                            onActive = function()
                                MarkerV = _Items13[_Index21]
                            end,
                            onSelected = function()
                                MarkerV = KeyboardInput("Donner une couleur verte à votre marker (0 - 255)", nil, 5)
                                if MarkerV == nil or MarkerV == "" or not tonumber(MarkerV) then
                                    MarkerV = ""
                                    ESX.ShowNotification("Vous devez rentrer une couleur verte valide")
                                else       
                                    for k,v in pairs(_Items13) do
                                        if v == tonumber(MarkerV) then
                                            _Index21 = k
                                        end
                                    end     
                                    ESX.ShowNotification("Vous venez de sauvegarder la couleur vert du marker qui est de ~b~"..MarkerV)          
                                end
                            end
                        })
                        RageUI.List("B", _Items14, _Index22, nil, {}, true, {
                            onListChange = function(Index)
                                _Index22 = Index
                            end,
                            onActive = function()
                                MarkerB = _Items14[_Index22]
                            end,
                            onSelected = function()
                                MarkerB = KeyboardInput("Donner une couleur bleu à votre marker (0 - 255)", nil, 5)
                                if MarkerB == nil or MarkerB == "" or not tonumber(MarkerB) then
                                    MarkerB = ""
                                    ESX.ShowNotification("Vous devez rentrer une couleur bleu valide")
                                else      
                                    for k,v in pairs(_Items14) do
                                        if v == tonumber(MarkerB) then
                                            _Index22 = k
                                        end
                                    end      
                                    ESX.ShowNotification("Vous venez de sauvegarder la couleur bleu du marker qui est de ~b~"..MarkerB)          
                                end
                            end
                        })
                        RageUI.List("O", _Items15, _Index23, nil, {}, true, {
                            onListChange = function(Index)
                                _Index23 = Index
                            end,
                            onActive = function()
                                MarkerO = _Items15[_Index23]
                            end,
                            onSelected = function()
                                MarkerO = KeyboardInput("Donner une opacité à votre marker (0 - 255)", nil, 5)
                                if MarkerO == nil or MarkerO == "" or not tonumber(MarkerO) then
                                    MarkerO = ""
                                    ESX.ShowNotification("Vous devez rentrer une opacité valide")
                                else
                                    for k,v in pairs(_Items15) do
                                        if v == tonumber(MarkerO) then
                                            _Index23 = k
                                        end
                                    end      
                                    ESX.ShowNotification("Vous venez de sauvegarder l'opacité du marker qui est de ~b~"..MarkerO)          
                                end
                            end
                        })
                    end
                end)
                RageUI.IsVisible(subMenu7,function()
                    subMenu7:UpdateInstructionalButtons(true) 
                    RageUI.Button("Nom", nil, {RightLabel = "~b~"..GradeName.." ~s~→"}, true, {
                        onSelected = function()
                            GradeName = KeyboardInput("Donner un nom à votre grade", nil, 50)
                            if GradeName == nil or GradeName == "" then
                                GradeName = ""
                                ESX.ShowNotification("Vous devez rentrer un nom valide")
                            else                       
                                ESX.ShowNotification("Vous avez nommé votre grade ~b~"..GradeName)
                            end
                        end
                    })
                    RageUI.Button("Label", nil, {RightLabel = "~o~"..GradeLabel.." ~s~→"}, true, {
                        onSelected = function()
                            GradeLabel = KeyboardInput("Donner un label à votre grade", nil, 50)
                            if GradeLabel == nil or GradeLabel == "" then
                                GradeLabel = ""
                                ESX.ShowNotification("Vous devez rentrer un label valide")
                            else                       
                                ESX.ShowNotification("Vous avez mis un label sur votre grade ~b~"..GradeLabel)
                            end
                        end
                    })
                    RageUI.Button("Salaire", nil, {RightLabel = "~g~"..GradeSalary2.." ~s~→"}, true, {
                        onSelected = function()
                            GradeSalary = KeyboardInput("Donner un salaire à votre grade", nil, 50)
                            if GradeSalary == nil or GradeSalary == "" or not tonumber(GradeSalary) then
                                GradeSalary = ""
                                ESX.ShowNotification("Vous devez rentrer un salaire valide")
                            else     
                                GradeSalary2 = GradeSalary.."$"          
                                ESX.ShowNotification("Vous avez définis un salaire de ~b~"..GradeSalary)
                            end
                        end
                    })
                    RageUI.Button("Numéro du grade", nil, {RightLabel = "~p~"..GradeNumber2.." ~s~→"}, true, {
                        onSelected = function()
                            GradeNumber = KeyboardInput("Donner un salaire à votre grade", nil, 50)
                            if GradeNumber == nil or GradeNumber == "" or not tonumber(GradeNumber) then
                                GradeNumber = ""
                                ESX.ShowNotification("Vous devez rentrer un salaire valide")
                            else
                                GradeNumber2 = "N°"..GradeNumber  
                                ESX.ShowNotification("Vous avez définis un salaire de ~b~"..GradeNumber)
                            end
                        end
                    })
                    RageUI.Button("Valider", nil, pGangBuilder.RightLabel, true, {
                        onSelected = function()
                            if ModifyGrade.verify == true then
                                table.remove(data_grade, ModifyGrade.value)
                                table.insert(data_grade, ModifyGrade.value, {name = GradeName, label = GradeLabel, salary = GradeSalary, number = GradeNumber})
                                ModifyGrade = {value = nil, verify = false}
                                GradeName,GradeLabel,GradeSalary,GradeNumber,GradeSalary2,GradeNumber2 = "","","","","",""
                                RageUI.GoBack()
                            else
                                table.insert(data_grade, {name = GradeName, label = GradeLabel, salary = GradeSalary, number = GradeNumber})
                                ModifyGrade = {value = nil, verify = false}
                                GradeName,GradeLabel,GradeSalary,GradeNumber,GradeSalary2,GradeNumber2 = "","","","","",""
                                RageUI.GoBack() 
                            end                     
                        end
                    })
                end)
                RageUI.IsVisible(subMenu8, function()
                    subMenu8:UpdateInstructionalButtons(true) 
                    RageUI.Button("Nom du véhicule", nil, {RightLabel = "~b~"..VehicleName.." ~s~→"}, true, {
                        onSelected = function()
                            VehicleName = KeyboardInput("Donner un nom à votre véhicule", nil, 50)
                            if VehicleName == nil or VehicleName == "" then
                                VehicleName = ""
                                ESX.ShowNotification("Vous devez rentrer un nom de véhicule valide")
                            else          
                                zVehicleName = VehicleName               
                                ESX.ShowNotification("Le nom de votre véhicule sera ~b~"..VehicleName)
                            end
                            active = false
                        end
                    })
                    RageUI.List("Nombre de véhicule", {"Infini", "Personnalisé"}, _Index2, nil, {}, true, {
                        onActive = function()
                            if _Index2 == 1 then
                                VehicleCount = -1
                            end                
                            active = false
                        end,
                        onListChange = function(Index)
                            _Index2 = Index
                        end,
                        onSelected = function()
                            if _Index2 == 2 then
                                VehicleCount = KeyboardInput("Donner un nombre de véhicule", nil, 3)
                                if VehicleCount == nil or VehicleCount == "" or not tonumber(VehicleCount) then
                                    VehicleCount = ""
                                    ESX.ShowNotification("Vous devez rentrer un count valide")
                                else
                                    VehicleCount = tonumber(VehicleCount)                       
                                    ESX.ShowNotification("Le count de votre véhicule sera ~b~"..VehicleCount)
                                end
                            end
                        end
                    })
                    RageUI.Checkbox("Phares Xenon", nil, xenon, {}, {
                        onChecked = function() 
                            xenon = true 
                            active = false
                        end, 
                        onUnChecked = function() 
                            xenon = false 
                            active = false
                        end
                    })
                    RageUI.Checkbox("Full Custom (performance)", nil, custom, {}, {
                        onChecked = function() 
                            custom = true 
                            active = false
                        end, 
                        onUnChecked = function() 
                            custom = false 
                            active = false
                        end
                    })
                    RageUI.Checkbox("Vitres Teintées", nil, vitres, {}, {
                        onChecked = function() 
                            vitres = true 
                            active = false
                        end, 
                        onUnChecked = function() 
                            vitres = false 
                            active = false
                        end
                    })
                    RageUI.Checkbox("Plaque", "~b~"..iplaque2, plaque, {}, {
                        onChecked = function() 
                            plaque = true 
                            local iplaque = KeyboardInput("Numéro de la plaque ", "", 10) 
                            if iplaque == nil or iplaque == "" then 
                                iplaque = ""
                                ESX.ShowNotification("Numéro Invalide")
                            else
                                iplaque2 = iplaque
                                ESX.ShowNotification("Votre plaque de voiture sera ~b~"..iplaque2)  
                            end
                            active = false 
                        end, 
                        onUnChecked = function() 
                            plaque = false 
                            active = false
                        end
                    })
                    RageUI.List("Teinte", {"Classic/Metallic", "Matte", "Chrome"}, _Index3, nil, {}, true, {
                        onListChange = function(Index)
                            _Index3 = Index
                            active = false
                        end
                    })
                    RageUI.List("Couleur", {"Noir", "Rouge", "Bleu", "Vert", "Jaune", "Violet", "Blanc"}, _Index4, nil, {}, true, {
                        onListChange = function(Index)
                            _Index4 = Index
                            active = false
                        end,
                        onActive = function()
                            if _Index4 == 1 then
                                color = {2, 12, 120}
                            elseif _Index4 == 2 then
                                color = {27, 39, 120}
                            elseif _Index4 == 3 then
                                color = {64, 83, 120}
                            elseif _Index4 == 4 then
                                color = {49, 128, 120}
                            elseif _Index4 == 5 then
                                color = {88, 42, 120}
                            elseif _Index4 == 6 then
                                color = {71, 148, 120}
                            elseif _Index4 == 7 then
                                color = {111, 131, 120}
                            end
                        end
                    })
                    RageUI.List("Prévisualiser le véhicule", {"Spawn sur soi", "Spawn du garage"}, _Index5, nil, {}, true, {
                        onListChange = function(Index)
                            _Index5 = Index
                        end,
                        onSelected = function()
                            if _Index5 == 1 then
                                if ESX.Game.IsSpawnPointClear(GetEntityCoords(PlayerPedId()), 2.0) then
                                    ESX.Game.SpawnVehicle(zVehicleName, GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), function(vehicle)
                                        if xenon then 
                                            Xenon(vehicle) 
                                        end
                                        if custom then 
                                            Custom(vehicle) 
                                        end
                                        if vitres then 
                                            Vitres(vehicle) 
                                        end
                                        if plaque then 
                                            SetVehicleNumberPlateText(vehicle, iplaque2) 
                                        end
                                        if color then
                                            Color(vehicle, color[_Index3])
                                        end
                                        vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                                        ESX.ShowNotification("Suppression du véhicule dans 10 secondes")
                                        Wait(10000)
                                        ESX.Game.DeleteVehicle(vehicle)
                                        active = true
                                    end)
                                else 
                                    ESX.ShowNotification("La sortie est bloqué")                                  
                                end
                            elseif _Index5 == 2 then
                                if ESX.Game.IsSpawnPointClear(GarageSpawn, 2.0) then
                                    ESX.Game.SpawnVehicle(zVehicleName, GarageSpawn, GarageHeading, function(vehicle)
                                        if xenon then 
                                            Xenon(vehicle) 
                                        end
                                        if custom then 
                                            Custom(vehicle) 
                                        end
                                        if vitres then 
                                            Vitres(vehicle) 
                                        end
                                        if plaque then 
                                            SetVehicleNumberPlateText(vehicle, iplaque2) 
                                        else
                                            iplaque2 = GetVehicleNumberPlateText(vehicle)
                                        end
                                        if color then
                                            Color(vehicle, color[_Index3])
                                        end
                                        vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                                        ESX.ShowNotification("Suppression du véhicule dans 10 secondes")
                                        Wait(10000)
                                        ESX.Game.DeleteVehicle(vehicle)
                                        active = true
                                    end)
                                else 
                                    ESX.ShowNotification("La sortie est bloqué")                                  
                                end
                            end
                        end
                    })
                    RageUI.Button("Valider", nil, pGangBuilder.RightLabel, active, {
                        onSelected = function()
                            if VehicleName == nil or VehicleName == "" or VehicleCount == nil or VehicleCount == "" then
                                ESX.ShowNotification("Il vous manque des données")
                            else
                                if ModifyVehicle.verify == true then
                                    table.remove(data_vehicle, ModifyVehicle.value)
                                    table.insert(data_vehicle, ModifyVehicle.value, {name = VehicleName, count = VehicleCount, plate = iplaque2, props = vehicleProps})
                                    ModifyVehicle = {value = nil, verify = false}
                                    _Index2,_Index3,_Index4,_Index5 = 1,1,1,1
                                    VehicleName,VehicleCount,iplaque2 = "","",""
                                    xenon,custom,vitres,plaque,color,active = false,false,false,false,false,false
                                    RageUI.GoBack()
                                else
                                    table.insert(data_vehicle, {name = VehicleName, count = VehicleCount, plate = iplaque2, props = vehicleProps})
                                    ModifyVehicle = {value = nil, verify = false}
                                    _Index2,_Index3,_Index4,_Index5 = 1,1,1,1
                                    VehicleName,VehicleCount,iplaque2 = "","",""
                                    xenon,custom,vitres,plaque,color,active = false,false,false,false,false,false
                                    RageUI.GoBack()
                                end
                            end
                        end
                    })
                end)
                RageUI.IsVisible(subMenu9,function()
                    subMenu9:UpdateInstructionalButtons(true)   
                    GetIndex() 
                    Load_Clothes()                                        
                    RageUI.Button("Nom de la tenue", nil, {RightLabel = "~b~"..ClothesName.." ~s~→"}, true, {
                        onSelected = function()
                            ClothesName = KeyboardInput("Donner un nom à votre tenue", nil, 50)
                            if ClothesName == nil or ClothesName == "" then
                                ClothesName = ""
                                ESX.ShowNotification("Vous devez rentrer un nom valide")
                            else                       
                                ESX.ShowNotification("Vous avez nommé votre tenue ~b~"..ClothesName)
                            end
                        end
                    })
                    RageUI.Line()                
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
                    RageUI.List("Bras", bras, bras1, nil, {}, true, {
                        onListChange = function(Index)
                            bras1 = Index
                            TriggerEvent("skinchanger:change", "arms", bras1-1)
                        end
                    })
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
                    RageUI.Button("Valider", nil, pGangBuilder.RightLabel, true, {
                        onSelected = function()
                            if ClothesName == nil or ClothesName == "" then
                                ESX.ShowNotification("Vous n'avez pas donné de nom à la tenue")
                            else                       
                                TriggerEvent('skinchanger:getSkin', function(skin)
                                    if ModifyClothes.verify == true then
                                        table.remove(data_clothes, ModifyClothes.value)
                                        table.insert(data_clothes, ModifyClothes.value, {name = ClothesName, skin = skin})
                                        ModifyClothes = {value = nil, verify = false}
                                        ClothesName = ""
                                        RageUI.GoBack()
                                    else
                                        table.insert(data_clothes, {name = ClothesName, skin = skin})
                                        ModifyClothes = {value = nil, verify = false}
                                        ClothesName = ""
                                        RageUI.GoBack()
                                    end
                                end)
                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                                    TriggerEvent('skinchanger:loadSkin', skin)
                                end)
                                FreezeEntityPosition(GetPlayerPed(-1), false)
                                RenderScriptCams(0, 1, 1000, 1, 1)
                                DestroyAllCams(true)
                            end                   
                        end
                    })
                end)
                RageUI.IsVisible(subMenu10,function()
                    subMenu10:UpdateInstructionalButtons(true) 
                    RageUI.List("Filtre :", {"Aucun", "Item", "Arme"}, _Index25, nil, {}, true, {
                        onListChange = function(Index) 
                            _Index25 = Index
                        end               
                    })
                    RageUI.Line()
                    if _Index25 == 1 or _Index25 == 2 then
                        RageUI.List("Filtre Item :", _Items16, _Index24, nil, {}, true, {
                            onListChange = function(Index) 
                                _Index24 = Index
                                if Index == 1 then
                                    aucun = true
                                else 
                                    aucun = false
                                end
                            end,
                            onSelected = function()
                                temp_filtre = KeyboardInput("Donner une lettre bien précise", nil, 1)
                                if temp_filtre == nil or temp_filtre == "" or tonumber(temp_filtre) then
                                    temp_filtre = ""
                                    ESX.ShowNotification("Vous devez rentrer une lettre valide")
                                else 
                                    for k,v in pairs(_Items16) do
                                        if v == string.upper(temp_filtre) then
                                            Index = k
                                            _Index24 = k
                                        else
                                            ESX.ShowNotification("Vous devez rentrer une lettre valide") 
                                        end
                                    end
                                end  
                            end                  
                        })
                        RageUI.Separator("↓ Liste des items ↓")
                        for k,v in pairs(getData.Items) do
                            if starts(v.label:lower(), _Items16[_Index24]:lower()) or aucun then
                                RageUI.Button(v.label, nil, {RightLabel = "→"}, true, {
                                    onSelected = function()
                                        temp_CountItem = KeyboardInput("Donner un nombre d'items", nil, 5)
                                        if temp_CountItem == nil or temp_CountItem == "" or not tonumber(temp_CountItem) then
                                            temp_CountItem = ""
                                            ESX.ShowNotification("Vous devez rentrer un nombre valide")
                                        else
                                            if temp_verify then
                                                for y,z in pairs(data_coffre_item) do
                                                    if z.name == v.name then                                         
                                                        ESX.ShowNotification("Vous avez déjà ajouté cette item, pour le modifier il suffit de revenir au menu précédent")
                                                        return
                                                    end
                                                end
                                                table.insert(data_coffre_item, {label = v.label, name = v.name, count = tonumber(temp_CountItem)}) 
                                                ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x"..temp_CountItem.." ~b~"..v.label)   
                                            else
                                                table.insert(data_coffre_item, {label = v.label, name = v.name, count = tonumber(temp_CountItem)}) 
                                                ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x"..temp_CountItem.." ~b~"..v.label)   
                                            end 
                                            temp_verify = true 
                                        end
                                    end
                                })
                            end
                        end
                    end
                    if _Index25 == 1 or _Index25 == 3 then
                        RageUI.List("Filtre Arme :", {"Aucun", "Mêlée", "Armes de poing", "Mitraillettes", "Fusils de chasse", "Fusils d'assaut", "Mitrailleuses légères", "Fusils de sniper", "Artillerie lourde", "Jetables", "Divers", }, _Index26, nil, {}, true, {
                            onListChange = function(Index) 
                                _Index26 = Index
                            end               
                        })
                        RageUI.Separator("↓ Liste des armes ↓")
                        if _Index26 == 1 or _Index26 == 2 then
                            for k,v in pairs(pGangBuilder.ArrayWeapon.Melee) do
                                RageUI.List(v.label, {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}, _Index27, nil, {}, true, {
                                    onListChange = function(Index)
                                        _Index27 = Index
                                    end,
                                    onSelected = function()
                                        if temp_verify2 then
                                            for y,z in pairs(data_coffre_weapon) do
                                                if z.name == v.name then                                         
                                                    ESX.ShowNotification("Vous avez déjà ajouté cette arme, pour la modifier il suffit de revenir au menu précédent")
                                                    return
                                                end
                                            end
                                            table.insert(data_coffre_weapon, {label = v.label, name = v.name, count = _Index27, munition = nil}) 
                                            ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x".._Index27.." ~b~"..v.label)  
                                        else
                                            table.insert(data_coffre_weapon, {label = v.label, name = v.name, count = _Index27, munition = nil}) 
                                            ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x".._Index27.." ~b~"..v.label)  
                                        end 
                                        temp_verify2 = true 
                                    end
                                })
                            end
                        end
                        if _Index26 == 1 or _Index26 == 3 then
                            for k,v in pairs(pGangBuilder.ArrayWeapon.Handguns) do
                                RageUI.List(v.label, {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}, _Index28, nil, {}, true, {
                                    onListChange = function(Index)
                                        _Index28 = Index
                                    end,
                                    onSelected = function()
                                        temp_CountWeapon = KeyboardInput("Donner un nombre de munitions (0 - 999)", nil, 3)
                                        if temp_CountWeapon == nil or temp_CountWeapon == "" or not tonumber(temp_CountWeapon) then
                                            temp_CountWeapon = ""
                                            ESX.ShowNotification("Vous devez rentrer un nombre de munition valide")
                                        else
                                            if tonumber(temp_CountWeapon) < 0 or tonumber(temp_CountWeapon) > 999 then
                                                temp_CountWeapon = ""
                                                ESX.ShowNotification("Vous devez rentrer un nombre de munition valide")
                                            else
                                                if temp_verify2 then
                                                    for y,z in pairs(data_coffre_weapon) do
                                                        if z.name == v.name then                                         
                                                            ESX.ShowNotification("Vous avez déjà ajouté cette arme, pour la modifier il suffit de revenir au menu précédent")
                                                            return
                                                        end
                                                    end
                                                    table.insert(data_coffre_weapon, {label = v.label, name = v.name, count = _Index28, munition = tonumber(temp_CountWeapon)})  
                                                    ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x".._Index28.." ~b~"..v.label.." ~s~munis de ~o~x"..temp_CountWeapon.." ~s~munitions")  
                                                else
                                                    table.insert(data_coffre_weapon, {label = v.label, name = v.name, count = _Index28, munition = tonumber(temp_CountWeapon)}) 
                                                    ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x".._Index28.." ~b~"..v.label.." ~s~munis de ~o~x"..temp_CountWeapon.." ~s~munitions")   
                                                end 
                                                temp_verify2 = true 
                                            end
                                        end
                                    end
                                })
                            end
                        end
                        if _Index26 == 1 or _Index26 == 4 then
                            for k,v in pairs(pGangBuilder.ArrayWeapon.SubmachineGuns) do
                                RageUI.List(v.label, {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}, _Index29, nil, {}, true, {
                                    onListChange = function(Index)
                                        _Index29 = Index
                                    end,
                                    onSelected = function()
                                        temp_CountWeapon = KeyboardInput("Donner un nombre de munitions (0 - 999)", nil, 3)
                                        if temp_CountWeapon == nil or temp_CountWeapon == "" or not tonumber(temp_CountWeapon) then
                                            temp_CountWeapon = ""
                                            ESX.ShowNotification("Vous devez rentrer un nombre de munition valide")
                                        else
                                            if tonumber(temp_CountWeapon) < 0 or tonumber(temp_CountWeapon) > 999 then
                                                temp_CountWeapon = ""
                                                ESX.ShowNotification("Vous devez rentrer un nombre de munition valide")
                                            else
                                                if temp_verify2 then
                                                    for y,z in pairs(data_coffre_weapon) do
                                                        if z.name == v.name then                                         
                                                            ESX.ShowNotification("Vous avez déjà ajouté cette arme, pour la modifier il suffit de revenir au menu précédent")
                                                            return
                                                        end
                                                    end
                                                    table.insert(data_coffre_weapon, {label = v.label, name = v.name, count = _Index29, munition = tonumber(temp_CountWeapon)}) 
                                                    ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x".._Index29.." ~b~"..v.label.." ~s~munis de ~o~x"..temp_CountWeapon.." ~s~munitions") 
                                                else
                                                    table.insert(data_coffre_weapon, {label = v.label, name = v.name, count = _Index29, munition = tonumber(temp_CountWeapon)}) 
                                                    ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x".._Index29.." ~b~"..v.label.." ~s~munis de ~o~x"..temp_CountWeapon.." ~s~munitions")   
                                                end 
                                                temp_verify2 = true 
                                            end
                                        end
                                    end
                                })
                            end
                        end              
                        if _Index26 == 1 or _Index26 == 5 then
                            for k,v in pairs(pGangBuilder.ArrayWeapon.Shotguns) do
                                RageUI.List(v.label, {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}, _Index30, nil, {}, true, {
                                    onListChange = function(Index)
                                        _Index30 = Index
                                    end,
                                    onSelected = function()
                                        temp_CountWeapon = KeyboardInput("Donner un nombre de munitions (0 - 999)", nil, 3)
                                        if temp_CountWeapon == nil or temp_CountWeapon == "" or not tonumber(temp_CountWeapon) then
                                            temp_CountWeapon = ""
                                            ESX.ShowNotification("Vous devez rentrer un nombre de munition valide")
                                        else
                                            if tonumber(temp_CountWeapon) < 0 or tonumber(temp_CountWeapon) > 999 then
                                                temp_CountWeapon = ""
                                                ESX.ShowNotification("Vous devez rentrer un nombre de munition valide")
                                            else
                                                if temp_verify2 then
                                                    for y,z in pairs(data_coffre_weapon) do
                                                        if z.name == v.name then                                         
                                                            ESX.ShowNotification("Vous avez déjà ajouté cette arme, pour la modifier il suffit de revenir au menu précédent")
                                                            return
                                                        end
                                                    end
                                                    table.insert(data_coffre_weapon, {label = v.label, name = v.name, count = _Index30, munition = tonumber(temp_CountWeapon)})
                                                    ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x".._Index30.." ~b~"..v.label.." ~s~munis de ~o~x"..temp_CountWeapon.." ~s~munitions") 
                                                else
                                                    table.insert(data_coffre_weapon, {label = v.label, name = v.name, count = _Index30, munition = tonumber(temp_CountWeapon)}) 
                                                    ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x".._Index30.." ~b~"..v.label.." ~s~munis de ~o~x"..temp_CountWeapon.." ~s~munitions")   
                                                end 
                                                temp_verify2 = true 
                                            end
                                        end
                                    end
                                })
                            end
                        end                    
                        if _Index26 == 1 or _Index26 == 6 then
                            for k,v in pairs(pGangBuilder.ArrayWeapon.AssaultRifles) do
                                RageUI.List(v.label, {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}, _Index31, nil, {}, true, {
                                    onListChange = function(Index)
                                        _Index31 = Index
                                    end,
                                    onSelected = function()
                                        temp_CountWeapon = KeyboardInput("Donner un nombre de munitions (0 - 999)", nil, 3)
                                        if temp_CountWeapon == nil or temp_CountWeapon == "" or not tonumber(temp_CountWeapon) then
                                            temp_CountWeapon = ""
                                            ESX.ShowNotification("Vous devez rentrer un nombre de munition valide")
                                        else
                                            if tonumber(temp_CountWeapon) < 0 or tonumber(temp_CountWeapon) > 999 then
                                                temp_CountWeapon = ""
                                                ESX.ShowNotification("Vous devez rentrer un nombre de munition valide")
                                            else
                                                if temp_verify2 then
                                                    for y,z in pairs(data_coffre_weapon) do
                                                        if z.name == v.name then                                         
                                                            ESX.ShowNotification("Vous avez déjà ajouté cette arme, pour la modifier il suffit de revenir au menu précédent")
                                                            return
                                                        end
                                                    end
                                                    table.insert(data_coffre_weapon, {label = v.label, name = v.name, count = _Index31, munition = tonumber(temp_CountWeapon)}) 
                                                    ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x".._Index31.." ~b~"..v.label.." ~s~munis de ~o~x"..temp_CountWeapon.." ~s~munitions") 
                                                else
                                                    table.insert(data_coffre_weapon, {label = v.label, name = v.name, count = _Index31, munition = tonumber(temp_CountWeapon)}) 
                                                    ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x".._Index31.." ~b~"..v.label.." ~s~munis de ~o~x"..temp_CountWeapon.." ~s~munitions")   
                                                end 
                                                temp_verify2 = true 
                                            end
                                        end
                                    end
                                })
                            end
                        end
                        if _Index26 == 1 or _Index26 == 7 then
                            for k,v in pairs(pGangBuilder.ArrayWeapon.LightMachineGuns) do
                                RageUI.List(v.label, {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}, _Index32, nil, {}, true, {
                                    onListChange = function(Index)
                                        _Index32 = Index
                                    end,
                                    onSelected = function()
                                        temp_CountWeapon = KeyboardInput("Donner un nombre de munitions (0 - 999)", nil, 3)
                                        if temp_CountWeapon == nil or temp_CountWeapon == "" or not tonumber(temp_CountWeapon) then
                                            temp_CountWeapon = ""
                                            ESX.ShowNotification("Vous devez rentrer un nombre de munition valide")
                                        else
                                            if tonumber(temp_CountWeapon) < 0 or tonumber(temp_CountWeapon) > 999 then
                                                temp_CountWeapon = ""
                                                ESX.ShowNotification("Vous devez rentrer un nombre de munition valide")
                                            else
                                                if temp_verify2 then
                                                    for y,z in pairs(data_coffre_weapon) do
                                                        if z.name == v.name then                                         
                                                            ESX.ShowNotification("Vous avez déjà ajouté cette arme, pour la modifier il suffit de revenir au menu précédent")
                                                            return
                                                        end
                                                    end
                                                    table.insert(data_coffre_weapon, {label = v.label, name = v.name, count = _Index32, munition = tonumber(temp_CountWeapon)}) 
                                                    ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x".._Index32.." ~b~"..v.label.." ~s~munis de ~o~x"..temp_CountWeapon.." ~s~munitions") 
                                                else
                                                    table.insert(data_coffre_weapon, {label = v.label, name = v.name, count = _Index32, munition = tonumber(temp_CountWeapon)}) 
                                                    ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x".._Index32.." ~b~"..v.label.." ~s~munis de ~o~x"..temp_CountWeapon.." ~s~munitions")   
                                                end 
                                                temp_verify2 = true 
                                            end
                                        end
                                    end
                                })
                            end
                        end
                        if _Index26 == 1 or _Index26 == 8 then
                            for k,v in pairs(pGangBuilder.ArrayWeapon.SniperRifles) do
                                RageUI.List(v.label, {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}, _Index33, nil, {}, true, {
                                    onListChange = function(Index)
                                        _Index33 = Index
                                    end,
                                    onSelected = function()
                                        temp_CountWeapon = KeyboardInput("Donner un nombre de munitions (0 - 999)", nil, 3)
                                        if temp_CountWeapon == nil or temp_CountWeapon == "" or not tonumber(temp_CountWeapon) then
                                            temp_CountWeapon = ""
                                            ESX.ShowNotification("Vous devez rentrer un nombre de munition valide")
                                        else
                                            if tonumber(temp_CountWeapon) < 0 or tonumber(temp_CountWeapon) > 999 then
                                                temp_CountWeapon = ""
                                                ESX.ShowNotification("Vous devez rentrer un nombre de munition valide")
                                            else
                                                if temp_verify2 then
                                                    for y,z in pairs(data_coffre_weapon) do
                                                        if z.name == v.name then                                         
                                                            ESX.ShowNotification("Vous avez déjà ajouté cette arme, pour la modifier il suffit de revenir au menu précédent")
                                                            return
                                                        end
                                                    end
                                                    table.insert(data_coffre_weapon, {label = v.label, name = v.name, count = _Index33, munition = tonumber(temp_CountWeapon)}) 
                                                    ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x".._Index33.." ~b~"..v.label.." ~s~munis de ~o~x"..temp_CountWeapon.." ~s~munitions")  
                                                else
                                                    table.insert(data_coffre_weapon, {label = v.label, name = v.name, count = _Index33, munition = tonumber(temp_CountWeapon)}) 
                                                    ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x".._Index33.." ~b~"..v.label.." ~s~munis de ~o~x"..temp_CountWeapon.." ~s~munitions")   
                                                end 
                                                temp_verify2 = true 
                                            end
                                        end
                                    end
                                })
                            end
                        end
                        if _Index26 == 1 or _Index26 == 9 then
                            for k,v in pairs(pGangBuilder.ArrayWeapon.HeavyWeapons) do
                                RageUI.List(v.label, {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}, _Index34, nil, {}, true, {
                                    onListChange = function(Index)
                                        _Index34 = Index
                                    end,
                                    onSelected = function()
                                        temp_CountWeapon = KeyboardInput("Donner un nombre de munitions (0 - 999)", nil, 3)
                                        if temp_CountWeapon == nil or temp_CountWeapon == "" or not tonumber(temp_CountWeapon) then
                                            temp_CountWeapon = ""
                                            ESX.ShowNotification("Vous devez rentrer un nombre de munition valide")
                                        else
                                            if tonumber(temp_CountWeapon) < 0 or tonumber(temp_CountWeapon) > 999 then
                                                temp_CountWeapon = ""
                                                ESX.ShowNotification("Vous devez rentrer un nombre de munition valide")
                                            else
                                                if temp_verify2 then
                                                    for y,z in pairs(data_coffre_weapon) do
                                                        if z.name == v.name then                                         
                                                            ESX.ShowNotification("Vous avez déjà ajouté cette arme, pour la modifier il suffit de revenir au menu précédent")
                                                            return
                                                        end
                                                    end
                                                    table.insert(data_coffre_weapon, {label = v.label, name = v.name, count = _Index34, munition = tonumber(temp_CountWeapon)}) 
                                                    ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x".._Index34.." ~b~"..v.label.." ~s~munis de ~o~x"..temp_CountWeapon.." ~s~munitions") 
                                                else
                                                    table.insert(data_coffre_weapon, {label = v.label, name = v.name, count = _Index34, munition = tonumber(temp_CountWeapon)}) 
                                                    ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x".._Index34.." ~b~"..v.label.." ~s~munis de ~o~x"..temp_CountWeapon.." ~s~munitions")   
                                                end 
                                                temp_verify2 = true 
                                            end
                                        end
                                    end
                                })
                            end
                        end
                        if _Index26 == 1 or _Index26 == 10 then
                            for k,v in pairs(pGangBuilder.ArrayWeapon.Throwables) do
                                RageUI.List(v.label, {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}, _Index35, nil, {}, true, {
                                    onListChange = function(Index)
                                        _Index35 = Index
                                    end,
                                    onSelected = function()
                                        if temp_verify2 then
                                            for y,z in pairs(data_coffre_weapon) do
                                                if z.name == v.name then                                         
                                                    ESX.ShowNotification("Vous avez déjà ajouté cette arme, pour la modifier il suffit de revenir au menu précédent")
                                                    return
                                                end
                                            end
                                            table.insert(data_coffre_weapon, {label = v.label, name = v.name, count = _Index35, munition = nil}) 
                                            ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x".._Index35.." ~b~"..v.label)      
                                        else
                                            table.insert(data_coffre_weapon, {label = v.label, name = v.name, count = _Index35, munition = nil}) 
                                            ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x".._Index35.." ~b~"..v.label)  
                                        end 
                                        temp_verify2 = true
                                    end 
                                })
                            end
                        end
                        if _Index26 == 1 or _Index26 == 11 then
                            for k,v in pairs(pGangBuilder.ArrayWeapon.Miscellaneous) do
                                RageUI.List(v.label, {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}, _Index36, nil, {}, true, {
                                    onListChange = function(Index)
                                        _Index36 = Index
                                    end,
                                    onSelected = function()
                                        if temp_verify2 then
                                            for y,z in pairs(data_coffre_weapon) do
                                                if z.name == v.name then                                         
                                                    ESX.ShowNotification("Vous avez déjà ajouté cette arme, pour la modifier il suffit de revenir au menu précédent")
                                                    return
                                                end
                                            end
                                            table.insert(data_coffre_weapon, {label = v.label, name = v.name, count = _Index36, munition = nil}) 
                                            ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x".._Index36.." ~b~"..v.label)   
                                        else
                                            table.insert(data_coffre_weapon, {label = v.label, name = v.name, count = _Index36, munition = nil}) 
                                            ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x".._Index36.." ~b~"..v.label)  
                                        end 
                                        temp_verify2 = true 
                                    end
                                })
                            end
                        end
                    end
                end)
                RageUI.IsVisible(subMenu11,function() 
                    subMenu11:UpdateInstructionalButtons(true) 
                    RageUI.Button("Nom", nil, {RightLabel = "~b~"..edit_Name.." ~s~→"}, true, {
                        onSelected = function()
                            edit_Name = KeyboardInput("Donner un nom à votre gang", nil, 50)
                            if edit_Name == nil or edit_Name == "" then
                                edit_Name = ""
                                ESX.ShowNotification("Vous devez rentrer un nom valide")
                            else                       
                                ESX.ShowNotification("Vous avez nommé votre gang ~b~"..edit_Name)
                            end
                        end
                    })
                    RageUI.Button("Label", nil, {RightLabel = "~b~"..edit_Label.." ~s~→"}, true, {
                        onSelected = function()
                            edit_Label = KeyboardInput("Donner un label à votre gang", nil, 50)
                            if edit_Label == nil or edit_Label == "" then
                                edit_Label = ""
                                ESX.ShowNotification("Vous devez rentrer un label valide")
                            else                       
                                ESX.ShowNotification("Vous avez mis un label sur votre gang ~b~"..edit_Label)
                            end
                        end
                    })
                    RageUI.Separator("↓ Gestion ↓")
                    RageUI.Button("Société", nil, {RightLabel = "→"}, true, {}, edit_subMenu)
                    RageUI.Button("Garage", nil, {RightLabel = "→"}, true, {}, edit_subMenu2)
                    RageUI.Button("Coffre", nil, {RightLabel = "→"}, true, {}, edit_subMenu3)
                    RageUI.Button("Vestiaire", nil, {RightLabel = "→"}, true, {}, edit_subMenu4)
                    RageUI.Button("Blips", nil, {RightLabel = "→"}, true, {}, edit_subMenu5)
                    RageUI.Button("Markers", nil, {RightLabel = "→"}, true, {}, edit_subMenu6)
                    RageUI.Line()
                    RageUI.Button("Valider les modifications", nil, pGangBuilder.RightLabel, true, {
                        onSelected = function()
                            confirmation = KeyboardInput("Entrez : CONFIRMER", nil, 9)
                            if confirmation == "CONFIRMER" then
                                TriggerServerEvent("pGangBuilder:deleteJobs", previous_edit_name, previous_edit_label)
                                Wait(200)
                                TriggerServerEvent("pGangBuilder:deleteJobsGrade", previous_edit_name)
                                Wait(200)
                                TriggerServerEvent("pGangBuilder:modifyGang", edit_id, edit_Name, edit_Label, edit_SocietyPos, edit_SocietyGestion, edit_GaragePos, {x = edit_GarageSpawn.x, y = edit_GarageSpawn.y, z = edit_GarageSpawn.z, w = edit_GarageHeading}, edit_GarageReturn, edit_GaragePnj, edit_data_vehicle, edit_CoffrePos, edit_CoffrePlaces, {money = edit_CoffreMoney, dirtymoney = edit_CoffreDirtyMoney, items = edit_data_coffre_item, weapons = edit_data_coffre_weapon}, edit_VestiairePos, edit_VestiaireGestion, edit_data_clothes, {pos = edit_BlipPos, name = edit_BlipName, sprite = edit_BlipSprite, scale = edit_BlipScale, color = edit_BlipColor, scale2 = edit_BlipScale2, color2 = edit_BlipColor2, opacity = edit_BlipOpacity}, {types = edit_MarkerType, rotX = edit_MarkerrotX, rotY = edit_MarkerrotY, rotZ = edit_MarkerrotZ, scaleX = edit_MarkerscaleX, scaleY = edit_MarkerscaleY, scaleZ = edit_MarkerscaleZ, colorR = edit_MarkerR, colorV = edit_MarkerV, colorB = edit_MarkerB, colorO = edit_MarkerO}, edit_data_grade, previous_edit_name, previous_edit_label)                               
                                edit_Name,edit_Label = "",""
                                edit_SocietyPos,edit_SocietyGestion,edit_GradeName,edit_GradeLabel,edit_GradeSalary,edit_GradeNumber = "",false,"","","",""            
                                edit_Garage,edit_GaragePos,edit_GarageSpawn,edit_GarageHeading,edit_GarageReturn,edit_GaragePnj = false,"","","","",false                      
                                edit_VehicleName,edit_VehicleCount,edit_iplaque2,edit_xenon,edit_custom,edit_vitres,edit_plaque,edit_color,edit_active = "","","",false,false,false,false,false,false
                                edit_Coffre,edit_CoffrePos,edit_CoffreMoney,edit_CoffreDirtyMoney,edit_temp_CountItem = false,"",0,0,""
                                edit_Vestiaire,edit_VestiairePos,edit_VestiaireGestion,edit_ClothesName = false,"",""
                                edit_BlipPreview,edit_Blip,edit_Blip2,edit_BlipPos,edit_BlipName = false,false,false,"",""
                                edit_Marker,edit_MarkerPreview = false,false
                                edit__Index,edit__Index2,edit__Index3,edit__Index4,edit__Index5,edit__Index6,edit__Index7,edit__Index8,edit__Index9,edit__Index10,edit__Index11,edit__Index12,edit__Index13,edit__Index14,edit__Index15,edit__Index16,edit__Index17,edit__Index18,edit__Index19,edit__Index20,edit__Index21,edit__Index22,edit__Index23,edit__Index24,edit__Index25,edit__Index26,edit__Index27,edit__Index28,edit__Index29,edit__Index30,edit__Index31,edit__Index32,edit__Index33,edit__Index34,edit__Index35,edit__Index36,edit__Index37,edit__Index38,edit__Index39,edit__Index40,edit__Index41 = 1,1,1,1,1,1,1,10,1,1,1,1,1,19,19,19,11,11,11,1,1,1,256,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                                edit_aucun = true
                                edit_data_grade = {}
                                edit_ModifyGrade = {value = nil, verify = false}
                                edit_data_vehicle = {}
                                edit_ModifyVehicle = {value = nil, verify = false}
                                edit_data_clothes = {}
                                edit_ModifyClothes = {value = nil, verify = false}                     
                                edit_data_coffre_item = {}                   
                                edit_data_coffre_weapon = {}
                                edit_temp_verify,edit_temp_verify2 = false,false
                                RemoveBlip(edit__blip)
                                RemoveBlip(edit__blip2)
                                Wait(200) 
                                getDataGang()
                                Wait(200)
                                getDataBlips(false)
                                Wait(200)
                                getDataBlips(true)
                                RageUI.CloseAll()
                                builder = false
                            else
                                ESX.ShowNotification("Vous n'avez pas confirmé votre création")
                            end
                        end
                    })
                end)
                RageUI.IsVisible(edit_subMenu,function()
                    edit_subMenu:UpdateInstructionalButtons(true) 
                    if actualysocietypos then
                        RageUI.Button("Placer la société", nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                edit_SocietyPos = GetEntityCoords(PlayerPedId())
                                ESX.ShowNotification("Vous venez de sauvegarder la ~b~position de la société")
                                actualysocietypos = false
                            end
                        })
                    else
                        RageUI.Button("Placer la société", "~b~"..edit_SocietyPos, {RightLabel = "→"}, true, {
                            onSelected = function()
                                edit_SocietyPos = GetEntityCoords(PlayerPedId())
                                ESX.ShowNotification("Vous venez de sauvegarder la ~b~position de la société")
                            end
                        })
                    end
                    RageUI.Checkbox("Gestion des grades par le boss", nil, edit_SocietyGestion, {}, {
                        onChecked = function()
                            edit_SocietyGestion = true
                            ESX.ShowNotification("Le boss ~g~pourra~s~ gérer les grades")                        
                        end,
                        onUnChecked = function()
                            edit_SocietyGestion = false       
                            ESX.ShowNotification("Le boss ~r~ne pourra pas~s~ gérer les grades")                     
                        end
                    })                     
                    RageUI.Line()
                    RageUI.Button("Ajouter un grade", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            edit_ModifyGrade = {value = nil, verify = false}
                            edit_GradeName,edit_GradeLabel,edit_GradeSalary,edit_GradeNumber,edit_GradeSalary2,edit_GradeNumber2 = "","","","","",""
                        end
                    }, edit_subMenu7) 
                    RageUI.Separator("↓ Liste des grades ↓")
                    if #edit_data_grade == 0 then
                        RageUI.Separator("Aucun grade présent") 
                    end
                    for k,v in pairs(edit_data_grade) do
                        RageUI.List(v.label, {"Modifier", "Supprimer"}, edit__Index, nil, {}, true, {
                            onActive = function()
                                if k ~= GetkTable(edit_data_grade) then
                                    if IsControlJustPressed(0, 11) then
                                        table.remove(edit_data_grade, k)
                                        table.insert(edit_data_grade, k+1, {name = v.name, label = v.label, salary = v.salary, number = v.number})
                                    end
                                end
                                if k ~= 1 then
                                    if IsControlJustPressed(0, 10) then
                                        table.remove(edit_data_grade, k)
                                        table.insert(edit_data_grade, k-1, {name = v.name, label = v.label, salary = v.salary, number = v.number})
                                    end 
                                end
                                RageUI.Info("Information des grades", {"Label :", "Name :", "Salaire :", "Numéro du grade :"}, {"~b~"..v.label, "~o~"..v.name, "~g~"..v.salary.."$", "~p~"..v.number})
                            end,
                            onListChange = function(Index)
                                edit__Index = Index
                            end,
                            onSelected = function()
                                if edit__Index == 1 then
                                    edit_ModifyGrade = {value = k, verify = true}
                                    edit_GradeName = v.name
                                    edit_GradeLabel = v.label
                                    edit_GradeSalary = v.salary
                                    edit_GradeSalary2 = v.salary.."$"
                                    edit_GradeNumber = v.number
                                    edit_GradeNumber2 = "N°"..v.number
                                    Wait(100)
                                    RageUI.Visible(edit_subMenu7, true)
                                elseif edit__Index == 2 then
                                    table.remove(edit_data_grade, k)
                                end
                            end
                        })
                    end
                end)
                RageUI.IsVisible(edit_subMenu2,function()
                    edit_subMenu2:UpdateInstructionalButtons(true) 
                    RageUI.Checkbox("Ajouter un garage", nil, edit_Garage, {}, {
                        onChecked = function()
                            edit_Garage = true
                            ESX.ShowNotification("Vous avez ~g~ajouté~s~ le garage au gang ~b~"..edit_Label)                        
                        end,
                        onUnChecked = function()
                            edit_Garage = false       
                            ESX.ShowNotification("Vous avez ~r~retiré~s~ le garage au gang ~b~"..edit_Label)                
                        end
                    }) 
                    if edit_Garage then
                        RageUI.Line()
                        if actualygaragepos then
                            RageUI.Button("Placer le garage", nil, {RightLabel = "→"}, true, {
                                onSelected = function()
                                    edit_GaragePos = GetEntityCoords(PlayerPedId())
                                    ESX.ShowNotification("Vous venez de sauvegarder la ~b~position du garage")
                                    actualygaragepos = false
                                end
                            })
                        else
                            RageUI.Button("Placer le garage", "~b~"..edit_GaragePos, {RightLabel = "→"}, true, {
                                onSelected = function()
                                    edit_GaragePos = GetEntityCoords(PlayerPedId())
                                    ESX.ShowNotification("Vous venez de sauvegarder la ~b~position du garage")
                                end
                            })
                        end
                        if actualygaragespawn then
                            RageUI.Button("Placer le point de spawn", nil, {RightLabel = "→"}, true, {
                                onSelected = function()
                                    edit_GarageSpawn = GetEntityCoords(PlayerPedId())
                                    ESX.ShowNotification("Vous venez de sauvegarder la ~b~position de spawn des véhicules")
                                    actualygaragespawn = false
                                end
                            }) 
                        else
                            RageUI.Button("Placer le point de spawn", "~b~"..edit_GarageSpawn, {RightLabel = "→"}, true, {
                                onSelected = function()
                                    edit_GarageSpawn = GetEntityCoords(PlayerPedId())
                                    ESX.ShowNotification("Vous venez de sauvegarder la ~b~position de spawn des véhicules")
                                end
                            }) 
                        end
                        if actualygarageheading then
                            RageUI.Button("Placer la direction de spawn", nil, {RightLabel = "→"}, true, {
                                onSelected = function()
                                    edit_GarageHeading = GetEntityHeading(PlayerPedId())
                                    ESX.ShowNotification("Vous venez de sauvegarder la ~b~direction de spawn des véhicules")
                                    actualygarageheading = false
                                end
                            }) 
                        else
                            RageUI.Button("Placer la direction de spawn", "~b~"..edit_GarageHeading, {RightLabel = "→"}, true, {
                                onSelected = function()
                                    edit_GarageHeading = GetEntityHeading(PlayerPedId())
                                    ESX.ShowNotification("Vous venez de sauvegarder la ~b~direction de spawn des véhicules")
                                end
                            }) 
                        end
                        if actualygaragereturn then
                            RageUI.Button("Placer le point de rangement", nil, {RightLabel = "→"}, true, {
                                onSelected = function()
                                    edit_GarageReturn = GetEntityCoords(PlayerPedId())
                                    ESX.ShowNotification("Vous venez de sauvegarder la ~b~position de rangement du garage")
                                    actualygaragereturn = false
                                end
                            })
                        else
                            RageUI.Button("Placer le point de rangement", "~b~"..edit_GarageReturn, {RightLabel = "→"}, true, {
                                onSelected = function()
                                    edit_GarageReturn = GetEntityCoords(PlayerPedId())
                                    ESX.ShowNotification("Vous venez de sauvegarder la ~b~position de rangement du garage")
                                end
                            })
                        end
                        RageUI.Checkbox("Accepter les véhicules de pnj", nil, edit_GaragePnj, {}, {
                            onChecked = function()
                                edit_GaragePnj = true
                                ESX.ShowNotification("Votre garage ~g~acceptera~s~ les véhicules de pnj")                        
                            end,
                            onUnChecked = function()
                                edit_GaragePnj = false       
                                ESX.ShowNotification("Votre garage ~r~refusera~s~ les véhicules de pnj")                  
                            end
                        })
                        RageUI.Line()
                        RageUI.Button("Ajouter un véhicule", nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                edit_ModifyVehicle = {value = nil, verify = false}
                                edit__Index2,edit__Index3,edit__Index4,edit__Index5 = 1,1,1,1
                                edit_VehicleName,edit_VehicleCount,edit_iplaque2 = "","",""
                                edit_xenon,edit_custom,edit_vitres,edit_plaque,edit_color,edit_active = false,false,false,false,false,false
                            end
                        }, edit_subMenu8)
                        RageUI.Separator("↓ Liste des véhicules ↓")
                        if #edit_data_vehicle == 0 then
                            RageUI.Separator("Aucun véhicule présent") 
                        end
                        for k,v in pairs(edit_data_vehicle) do
                            if v.count ~= nil then
                                RageUI.List(GetLabelText(GetDisplayNameFromVehicleModel(v.props.model)), {"Modifier", "Supprimer"}, edit__Index6, nil, {}, true, {
                                    onActive = function()
                                        if k ~= GetkTable(edit_data_vehicle) then
                                            if IsControlJustPressed(0, 11) then
                                                table.remove(edit_data_vehicle, k)
                                                table.insert(edit_data_vehicle, k+1, {name = v.name, count = v.count, plate = v.plate, props = v.props})
                                            end
                                        end
                                        if k ~= 1 then
                                            if IsControlJustPressed(0, 10) then
                                                table.remove(edit_data_vehicle, k)
                                                table.insert(edit_data_vehicle, k-1, {name = v.name, count = v.count, plate = v.plate, props = v.props})
                                            end 
                                        end

                                        if v.props.color1 == 2 or v.props.color1 == 27 or v.props.color1 == 64 or v.props.color1 == 49 or v.props.color1 == 88 or v.props.color1 == 71 or v.props.color1 == 111 then
                                            edit__Index3 = 1 
                                        elseif v.props.color1 == 12 or v.props.color1 == 39 or v.props.color1 == 83 or v.props.color1 == 128 or v.props.color1 == 42 or v.props.color1 == 148 or v.props.color1 == 131 then
                                            edit__Index3 = 2
                                        elseif v.props.color1 == 120 then
                                            edit__Index3 = 3
                                        end
                                        
                                        if v.props.color1 == 2 or v.props.color1 == 12 or v.props.color1 == 120 then
                                            edit__Index4 = 1
                                        elseif v.props.color1 == 27 or v.props.color1 == 39 or v.props.color1 == 120 then
                                            edit__Index4 = 2
                                        elseif v.props.color1 == 64 or v.props.color1 == 83 or v.props.color1 == 120 then
                                            edit__Index4 = 3
                                        elseif v.props.color1 == 49 or v.props.color1 == 128 or v.props.color1 == 120 then
                                            edit__Index4 = 4
                                        elseif v.props.color1 == 88 or v.props.color1 == 42 or v.props.color1 == 120 then
                                            edit__Index4 = 5
                                        elseif v.props.color1 == 71 or v.props.color1 == 148 or v.props.color1 == 120 then
                                            edit__Index4 = 6
                                        elseif v.props.color1 == 111 or v.props.color1 == 131 or v.props.color1 == 120 then
                                            edit__Index4 = 7
                                        end

                                        if v.count == -1 then
                                            edit__Index2 = 1
                                        else
                                            edit__Index2 = 2
                                            edit_VehicleCount = v.count
                                        end

                                        edit_VehicleName = GetLabelText(GetDisplayNameFromVehicleModel(v.props.model))
                                        edit_zVehicleName = v.props.model

                                        if v.props.modXenon == 1 then
                                            edit_xenon = true
                                        else
                                            edit_xenon = false
                                        end
                                        if v.props.modTransmission == 2 or v.props.modEngine == 3 or v.props.modBrakes == 2 or v.props.modSuspension == 3 or v.props.modArmor == 4 or v.props.modTurbo == 1 then
                                            edit_custom = true
                                        else
                                            edit_custom = false
                                        end
                                        if v.props.windowTint == -1 then
                                            edit_vitres = false
                                        else
                                            edit_vitres = true
                                        end
                                        if v.props.plate == string.upper(v.plate) then
                                            edit_plaque = true
                                            edit_iplaque2 = v.plate
                                        else
                                            edit_plaque = false
                                        end

                                        RageUI.Info("Information des véhicules", 
                                            {
                                                "Nom du véhicule :", 
                                                "Nombre de véhicule :", 
                                                "Phares Xenon :", 
                                                "Full Custom (performance) :",
                                                "Vitres Teintées :",
                                                "Plaque :",
                                                "Teinte :",
                                                "Couleur :"                                  
                                            }, 
                                            {
                                                "~b~"..edit_VehicleName,    
                                                "~b~"..GetValueCount(edit__Index2, v.count),
                                                "~b~"..GetValue(edit_xenon),
                                                "~b~"..GetValue(edit_custom),
                                                "~b~"..GetValue(edit_vitres),
                                                "~b~"..GetValue(edit_plaque),
                                                "~b~"..speItemsTeinte[edit__Index3], 
                                                "~b~"..speItemsColor[edit__Index4]                              
                                            }
                                        )
                                    end,
                                    onListChange = function(Index)
                                        edit__Index6 = Index
                                    end,
                                    onSelected = function()
                                        if edit__Index6 == 1 then
                                            edit_ModifyVehicle = {value = k, verify = true}
                                            Wait(100)
                                            RageUI.Visible(edit_subMenu8, true)
                                        elseif edit__Index6 == 2 then
                                            table.remove(edit_data_vehicle, k)
                                        end
                                    end
                                })
                            end
                        end  
                    end
                end)
                RageUI.IsVisible(edit_subMenu3,function()
                    edit_subMenu3:UpdateInstructionalButtons(true) 
                    RageUI.Checkbox("Ajouter un coffre", nil, edit_Coffre, {}, {
                        onChecked = function()
                            edit_Coffre = true
                            ESX.ShowNotification("Vous avez ~g~ajouté~s~ le coffre au gang ~b~"..edit_Label)                        
                        end,
                        onUnChecked = function()
                            edit_Coffre = false       
                            ESX.ShowNotification("Vous avez ~r~retiré~s~ le coffre au gang ~b~"..edit_Label)                
                        end
                    })
                    if edit_Coffre then
                        RageUI.Line()
                        if actualycoffrepos then
                            RageUI.Button("Placer le coffre", nil, {RightLabel = "→"}, true, {
                                onSelected = function()
                                    edit_CoffrePos = GetEntityCoords(PlayerPedId())
                                    ESX.ShowNotification("Vous venez de sauvegarder la ~b~position du coffre")
                                    actualycoffrepos = false
                                end
                            })
                        else
                            RageUI.Button("Placer le coffre", "~b~"..edit_CoffrePos, {RightLabel = "→"}, true, {
                                onSelected = function()
                                    edit_CoffrePos = GetEntityCoords(PlayerPedId())
                                    ESX.ShowNotification("Vous venez de sauvegarder la ~b~position du coffre")
                                end
                            })
                        end
                        RageUI.List("Places dans le coffre", edit__Items, edit__Index37, nil, {}, true, {
                            onListChange = function(Index)
                                edit__Index37 = Index
                            end,
                            onActive = function()
                                edit_CoffrePlaces = pGangBuilder.WeightChest[edit__Index37].value
                            end,
                            onSelected = function()
                                ESX.ShowNotification("Vous venez de sauvegarder la place dans le coffre qui est de ~b~"..pGangBuilder.WeightChest[edit__Index37].label)
                            end
                        })
                        RageUI.Button("Ajouter un(e) item/arme", nil, {RightLabel = "→"}, true, {}, edit_subMenu10)
                        RageUI.Separator("↓ Contenu du coffre de base ↓")
                        RageUI.Button("Argent Propre", nil, {RightLabel = "~g~"..edit_CoffreMoney.."$ ~s~→"}, true, {
                            onSelected = function()
                                edit_CoffreMoney = KeyboardInput("Donner un montant de base (argent propre)", nil, 10)
                                if edit_CoffreMoney == nil or edit_CoffreMoney == "" or not tonumber(edit_CoffreMoney) then
                                    edit_CoffreMoney = 0
                                    ESX.ShowNotification("Vous devez rentrer un montant valide")
                                else 
                                    edit_CoffreMoney = tonumber(edit_CoffreMoney)
                                    ESX.ShowNotification("Vous venez de sauvegarder le montant d'argent propre de base ~g~"..edit_CoffreMoney.."$")          
                                end
                            end 
                        })
                        RageUI.Button("Argent Sale", nil, {RightLabel = "~r~"..edit_CoffreDirtyMoney.."$ ~s~→"}, true, {
                            onSelected = function()
                                edit_CoffreDirtyMoney = KeyboardInput("Donner un montant de base (argent sale)", nil, 10)
                                if edit_CoffreDirtyMoney == nil or edit_CoffreDirtyMoney == "" or not tonumber(edit_CoffreDirtyMoney) then
                                    edit_CoffreDirtyMoney = 0                      
                                    ESX.ShowNotification("Vous devez rentrer un montant valide")
                                else       
                                    edit_CoffreDirtyMoney = tonumber(edit_CoffreDirtyMoney)
                                    ESX.ShowNotification("Vous venez de sauvegarder le montant d'argent sale de base ~r~"..edit_CoffreDirtyMoney.."$")          
                                end
                            end 
                        })
                        RageUI.Separator("↓ Liste des items ↓")
                        if #edit_data_coffre_item == 0 then
                            RageUI.Separator("Aucun item présent") 
                        end
                        for k,v in pairs(edit_data_coffre_item) do
                            RageUI.List("~b~x"..v.count.." ~s~"..v.label, {"Modifier", "Supprimer"}, edit__Index38, nil, {}, true, {
                                onActive = function()
                                    if k ~= GetkTable(edit_data_coffre_item) then
                                        if IsControlJustPressed(0, 11) then
                                            table.remove(edit_data_coffre_item, k)
                                            table.insert(edit_data_coffre_item, k+1, {label = v.label, name = v.name, count = v.count})
                                        end
                                    end
                                    if k ~= 1 then
                                        if IsControlJustPressed(0, 10) then
                                            table.remove(edit_data_coffre_item, k)
                                            table.insert(edit_data_coffre_item, k-1, {label = v.label, name = v.name, count = v.count})
                                        end 
                                    end
                                end,
                                onListChange = function(Index)
                                    edit__Index38 = Index
                                end,
                                onSelected = function()
                                    if edit__Index38 == 1 then
                                        edit_temp_CountItem2 = KeyboardInput("Donner un nouveau nombre d'items", nil, 5)
                                        if edit_temp_CountItem2 == nil or edit_temp_CountItem2 == "" or not tonumber(edit_temp_CountItem2) then
                                            edit_temp_CountItem2 = ""
                                            ESX.ShowNotification("Vous devez rentrer un nombre valide")
                                        else   
                                            ESX.ShowNotification("Vous venez de re-sauvegarder l'ajout de ~y~x"..edit_temp_CountItem2.." ~b~"..v.label)
                                            table.remove(edit_data_coffre_item, k)               
                                            table.insert(edit_data_coffre_item, k, {label = v.label, name = v.name, count = tonumber(edit_temp_CountItem2)})
                                        end
                                    elseif edit__Index38 == 2 then
                                        if k == 1 then
                                            temp_verify = false
                                        end
                                        table.remove(edit_data_coffre_item, k)
                                    end
                                end
                            })
                        end
                        RageUI.Separator("↓ Liste des armes ↓")
                        if #edit_data_coffre_weapon == 0 then
                            RageUI.Separator("Aucune arme présente") 
                        end
                        for k,v in pairs(edit_data_coffre_weapon) do
                            if v.munition ~= nil then
                                RageUI.List("~b~x"..v.count.." ~s~"..v.label.." (~o~x"..v.munition.."~s~)", {"Modifier le nombre", "Modifier les munitions", "Supprimer"}, edit__Index39, nil, {}, true, {
                                    onActive = function()
                                        if k ~= GetkTable(edit_data_coffre_weapon) then
                                            if IsControlJustPressed(0, 11) then
                                                table.remove(edit_data_coffre_weapon, k)
                                                table.insert(edit_data_coffre_weapon, k+1, {label = v.label, name = v.name, count = v.count, munition = v.munition})
                                            end
                                        end
                                        if k ~= 1 then
                                            if IsControlJustPressed(0, 10) then
                                                table.remove(edit_data_coffre_weapon, k)
                                                table.insert(edit_data_coffre_weapon, k-1, {label = v.label, name = v.name, count = v.count, munition = v.munition})
                                            end 
                                        end
                                    end,
                                    onListChange = function(Index)
                                        edit__Index39 = Index
                                    end,
                                    onSelected = function()
                                        if edit__Index39 == 1 then
                                            edit_temp_CountWeapon2 = KeyboardInput("Donner un nouveau nombre d'arme", nil, 5)
                                            if edit_temp_CountWeapon2 == nil or edit_temp_CountWeapon2 == "" or not tonumber(edit_temp_CountWeapon2) then
                                                edit_temp_CountWeapon2 = ""
                                                ESX.ShowNotification("Vous devez rentrer un nombre valide")
                                            else   
                                                ESX.ShowNotification("Vous venez de re-sauvegarder l'ajout de ~y~x"..edit_temp_CountWeapon2.." ~b~"..v.label)              
                                                table.remove(edit_data_coffre_weapon, k) 
                                                table.insert(edit_data_coffre_weapon, k, {label = v.label, name = v.name, count = tonumber(edit_temp_CountWeapon2), munition = v.munition})
                                            end
                                        elseif edit__Index39 == 2 then
                                            edit_temp_CountWeapon3 = KeyboardInput("Donner un nouveau nombre de munitions", nil, 5)
                                            if edit_temp_CountWeapon3 == nil or edit_temp_CountWeapon3 == "" or not tonumber(edit_temp_CountWeapon3) then
                                                edit_temp_CountWeapon3 = ""
                                                ESX.ShowNotification("Vous devez rentrer un nombre valide")
                                            else   
                                                ESX.ShowNotification("Vous venez de re-sauvegarder l'ajout de ~y~x"..edit_temp_CountWeapon3.." munitions ~s~à la/au ~b~"..v.label) 
                                                table.remove(edit_data_coffre_weapon, k)              
                                                table.insert(edit_data_coffre_weapon, k, {label = v.label, name = v.name, count = v.count, munition = tonumber(edit_temp_CountWeapon3)})
                                            end
                                        elseif edit__Index39 == 3 then
                                            if k == 1 then
                                                temp_verify2 = false
                                            end
                                            table.remove(edit_data_coffre_weapon, k)
                                        end
                                    end
                                })
                            else
                                RageUI.List("~b~x"..v.count.." ~s~"..v.label, {"Modifier le nombre", "Supprimer"}, edit__Index40, nil, {}, true, {
                                    onActive = function()
                                        if k ~= GetkTable(edit_data_coffre_weapon) then
                                            if IsControlJustPressed(0, 11) then
                                                table.remove(edit_data_coffre_weapon, k)
                                                table.insert(edit_data_coffre_weapon, k+1, {label = v.label, name = v.name, count = v.count, munition = nil})
                                            end
                                        end
                                        if k ~= 1 then
                                            if IsControlJustPressed(0, 10) then
                                                table.remove(edit_data_coffre_weapon, k)
                                                table.insert(edit_data_coffre_weapon, k-1, {label = v.label, name = v.name, count = v.count, munition = nil})
                                            end 
                                        end
                                    end,
                                    onListChange = function(Index)
                                        edit__Index40 = Index
                                    end,
                                    onSelected = function()
                                        if edit__Index40 == 1 then
                                            edit_temp_CountWeapon2 = KeyboardInput("Donner un nouveau nombre d'arme", nil, 5)
                                            if edit_temp_CountWeapon2 == nil or edit_temp_CountWeapon2 == "" or not tonumber(edit_temp_CountWeapon2) then
                                                edit_temp_CountWeapon2 = ""
                                                ESX.ShowNotification("Vous devez rentrer un nombre valide")
                                            else   
                                                ESX.ShowNotification("Vous venez de re-sauvegarder l'ajout de ~y~x"..edit_temp_CountWeapon2.." ~b~"..v.label)   
                                                table.remove(edit_data_coffre_weapon, k)            
                                                table.insert(edit_data_coffre_weapon, k, {label = v.label, name = v.name, count = tonumber(edit_temp_CountWeapon2), munition = nil})
                                            end
                                        elseif edit__Index40 == 3 then
                                            table.remove(edit_data_coffre_weapon, k)
                                        end
                                    end
                                })
                            end
                        end
                    end
                end)
                RageUI.IsVisible(edit_subMenu4,function()
                    edit_subMenu4:UpdateInstructionalButtons(true) 
                    RageUI.Checkbox("Ajouter un vestiaire", nil, edit_Vestiaire, {}, {
                        onChecked = function()
                            edit_Vestiaire = true
                            ESX.ShowNotification("Vous avez ~g~ajouté~s~ le vestiaire au gang ~b~"..edit_Label)                        
                        end,
                        onUnChecked = function()
                            edit_Vestiaire = false       
                            ESX.ShowNotification("Vous avez ~r~retiré~s~ le vestiaire au gang ~b~"..edit_Label)                
                        end
                    }) 
                    if edit_Vestiaire then
                        RageUI.Line()
                        if actualyvestiairepos then
                            RageUI.Button("Placer le vestiaire", nil, {RightLabel = "→"}, true, {
                                onSelected = function()
                                    edit_VestiairePos = GetEntityCoords(PlayerPedId())
                                    ESX.ShowNotification("Vous venez de sauvegarder la ~b~position du vestiaire")
                                    actualyvestiairepos = false
                                end
                            })
                        else
                            RageUI.Button("Placer le vestiaire", "~b~"..edit_VestiairePos, {RightLabel = "→"}, true, {
                                onSelected = function()
                                    edit_VestiairePos = GetEntityCoords(PlayerPedId())
                                    ESX.ShowNotification("Vous venez de sauvegarder la ~b~position du vestiaire")
                                end
                            })
                        end
                        RageUI.Checkbox("Gestion des tenues par le boss", nil, edit_VestiaireGestion, {}, {
                            onChecked = function()
                                edit_VestiaireGestion = true
                                ESX.ShowNotification("Le boss ~g~pourra~s~ gérer les tenues")                        
                            end,
                            onUnChecked = function()
                                edit_VestiaireGestion = false       
                                ESX.ShowNotification("Le boss ~r~ne pourra pas~s~ gérer les tenues")                     
                            end
                        })  
                        RageUI.Line()
                        RageUI.Button("Ajouter une tenue", nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                edit_ModifyClothes = {value = nil, verify = false}
                                edit_ClothesName = ""
                                GetSkinValue() 
                                CreateMain() 
                                Wait(100) 
                                FreezeEntityPosition(GetPlayerPed(-1), true)
                            end
                        }, edit_subMenu9) 
                        RageUI.Separator("↓ Liste des tenues ↓")
                        if #edit_data_clothes == 0 then
                            RageUI.Separator("Aucune tenue présente") 
                        end
                        for k,v in pairs(edit_data_clothes) do
                            RageUI.List(v.name, {"Modifier", "Supprimer"}, edit__Index41, nil, {}, true, {
                                onActive = function()
                                    if k ~= GetkTable(edit_data_clothes) then
                                        if IsControlJustPressed(0, 11) then
                                            table.remove(edit_data_clothes, k)
                                            table.insert(edit_data_clothes, k+1, {name = v.name, skin = v.skin})
                                        end
                                    end
                                    if k ~= 1 then
                                        if IsControlJustPressed(0, 10) then
                                            table.remove(edit_data_clothes, k)
                                            table.insert(edit_data_clothes, k-1, {name = v.name, skin = v.skin})
                                        end 
                                    end
                                end,
                                onListChange = function(Index)
                                    edit__Index41 = Index
                                end,
                                onSelected = function()
                                    if edit__Index41 == 1 then
                                        edit_ModifyClothes = {value = k, verify = true}
                                        edit_ClothesName = v.name
                                        veste1 = v.skin.torso_1+1
                                        vestecolor1 = v.skin.torso_2+1
                                        tshirt1 = v.skin.tshirt_1+1
                                        tshirtcolor1 = v.skin.tshirt_2+1
                                        pantalon1 = v.skin.pants_1+1
                                        pantaloncolor1 = v.skin.pants_2+1
                                        chaussure1 = v.skin.shoes_1+1
                                        chaussurecolor1 = v.skin.shoes_2+1
                                        bras1 = v.skin.arms+1
                                        calque1 = v.skin.decals_1+1
                                        calquecolor1 = v.skin.decals_2+1
                                        chaine1 = v.skin.chain_1+1
                                        chainecolor1 = v.skin.chain_2+1
                                        casque1 = v.skin.helmet_1+2
                                        casquecolor1 = v.skin.helmet_2+1
                                        lunette1 = v.skin.glasses_1+1
                                        lunettecolor1 = v.skin.glasses_2+1
                                        oreille1 = v.skin.ears_1+2
                                        oreillecolor1 = v.skin.ears_2+1
                                        montre1 = v.skin.watches_1+2
                                        montrecolor1 = v.skin.watches_2+1
                                        bracelet1 = v.skin.bracelets_1+2
                                        braceletcolor1 = v.skin.bracelets_2+1
                                        sac1 = v.skin.bags_1+1
                                        saccolor1 = v.skin.bags_2+1
                                        TriggerEvent('skinchanger:loadSkin', v.skin)
                                        GetSkinValue() 
                                        CreateMain() 
                                        Wait(100) 
                                        FreezeEntityPosition(GetPlayerPed(-1), true)
                                        RageUI.Visible(edit_subMenu9, true)
                                    elseif edit__Index41 == 2 then
                                        table.remove(edit_data_clothes, k)
                                    end
                                end
                            })
                        end
                    end
                end)
                RageUI.IsVisible(edit_subMenu5,function()
                    RageUI.Checkbox("Ajouter un blip", nil, edit_Blip, {}, {
                        onChecked = function()
                            edit_Blip = true
                            if edit_BlipPreview == true then        
                                RemoveBlip(edit__blip)
                                RemoveBlip(edit__blip2)  
                                edit__PreviewBlip(edit_BlipPos, edit_BlipName, edit_Blip, edit_Blip2) 
                            end 
                            ESX.ShowNotification("Vous avez ~g~ajouté~s~ le blip au gang ~b~"..edit_Label)                        
                        end,
                        onUnChecked = function()
                            edit_Blip = false
                            if edit_BlipPreview == true then        
                                RemoveBlip(edit__blip)
                                RemoveBlip(edit__blip2)  
                                edit__PreviewBlip(edit_BlipPos, edit_BlipName, edit_Blip, edit_Blip2) 
                            end 
                            ESX.ShowNotification("Vous avez ~r~retiré~s~ le blip au gang ~b~"..edit_Label)                
                        end
                    })
                    if edit_Blip then
                        RageUI.Line()
                        RageUI.Checkbox("Prévisualisé le blip", nil, edit_BlipPreview, {}, {
                            onChecked = function()
                                edit_BlipPreview = true 
                                edit_BlipSprite = edit__Items2[edit__Index7]
                                edit_BlipScale = edit__Index8 / 10
                                edit_BlipColor = edit__Items3[edit__Index9]         
                                edit__PreviewBlip(edit_BlipPos, edit_BlipName, edit_Blip, edit_Blip2) 
                                ESX.ShowNotification("Prévisualisation ~g~activée~s~")       
                            end,
                            onUnChecked = function()   
                                edit_BlipPreview = false
                                RemoveBlip(edit__blip)
                                RemoveBlip(edit__blip2)  
                                ESX.ShowNotification("Prévisualisation ~r~désactivée~s~")           
                            end
                        })
                        if actualyblipspos then
                            RageUI.Button("Placer le blip", nil, {RightLabel = "→"}, true, {
                                onSelected = function()
                                    edit_BlipPos = GetEntityCoords(PlayerPedId())
                                    ESX.ShowNotification("Vous venez de sauvegarder la ~b~position du blip")
                                    if edit_BlipPreview == true then        
                                        RemoveBlip(edit__blip)
                                        RemoveBlip(edit__blip2)  
                                        edit__PreviewBlip(edit_BlipPos, edit_BlipName, edit_Blip, edit_Blip2) 
                                    end
                                    actualyblipspos = false
                                end
                            })
                        else
                            RageUI.Button("Placer le blip", "~b~"..edit_BlipPos, {RightLabel = "→"}, true, {
                                onSelected = function()
                                    edit_BlipPos = GetEntityCoords(PlayerPedId())
                                    ESX.ShowNotification("Vous venez de sauvegarder la ~b~position du blip")
                                    if edit_BlipPreview == true then        
                                        RemoveBlip(edit__blip)
                                        RemoveBlip(edit__blip2)  
                                        edit__PreviewBlip(edit_BlipPos, edit_BlipName, edit_Blip, edit_Blip2) 
                                    end
                                end
                            })
                        end
                        RageUI.Button("Nom", nil, {RightLabel = "~b~"..edit_BlipName.." ~s~→"}, true, {
                            onSelected = function()
                                edit_BlipName = KeyboardInput("Donner un nom à votre blip", nil, 50)
                                if edit_BlipName == nil or edit_BlipName == "" then
                                    edit_BlipName = ""
                                    ESX.ShowNotification("Vous devez rentrer un nom valide")
                                else       
                                    if BlipPreview == true then        
                                        RemoveBlip(edit__blip)
                                        RemoveBlip(edit__blip2)  
                                        edit__PreviewBlip(edit_BlipPos, edit_BlipName, edit_Blip, edit_Blip2) 
                                    end                
                                    ESX.ShowNotification("Vous avez nommé votre blip ~b~"..edit_BlipName)
                                end
                            end
                        })
                        RageUI.List("Type", edit__Items2, edit__Index7, nil, {}, true, {
                            onListChange = function(Index)
                                edit__Index7 = Index
                                if edit_BlipPreview == true then        
                                    RemoveBlip(edit__blip)
                                    RemoveBlip(edit__blip2)  
                                    edit__PreviewBlip(edit_BlipPos, edit_BlipName, edit_Blip, edit_Blip2) 
                                end
                            end,
                            onActive = function()
                                edit_BlipSprite = edit__Index7
                            end,
                            onSelected = function()
                                edit_BlipSprite = KeyboardInput("Donner un type à votre blip (0 - 826)", nil, 3)
                                if edit_BlipSprite == nil or edit_BlipSprite == "" or not tonumber(edit_BlipSprite) then
                                    edit_BlipSprite = ""
                                    ESX.ShowNotification("Vous devez rentrer un type valide")
                                else
                                    edit__Index7 = tonumber(edit_BlipSprite)   
                                    edit_BlipSprite = edit__Index7
                                    if edit_BlipPreview == true then        
                                        RemoveBlip(edit__blip)
                                        RemoveBlip(edit__blip2)  
                                        edit__PreviewBlip(edit_BlipPos, edit_BlipName, edit_Blip, edit_Blip2) 
                                    end 
                                    ESX.ShowNotification("Vous venez de sauvegarder le type du blip qui est de ~b~"..edit_BlipSprite)          
                                end
                            end
                        })
                        RageUI.List("Taille", {0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0,1.1,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,2.0}, edit__Index8, nil, {}, true, {
                            onListChange = function(Index)
                                edit__Index8 = Index
                                if edit_BlipPreview == true then        
                                    RemoveBlip(edit__blip)
                                    RemoveBlip(edit__blip2)  
                                    edit__PreviewBlip(edit_BlipPos, edit_BlipName, edit_Blip, edit_Blip2) 
                                end
                            end,
                            onActive = function()
                                edit_BlipScale = edit__Index8 / 10
                            end,
                            onSelected = function()
                                edit_BlipScale = KeyboardInput("Donner une taille à votre blip (0.1 - 2.0)", nil, 3)
                                if edit_BlipScale == nil or edit_BlipScale == "" or not tonumber(edit_BlipScale) then
                                    edit_BlipScale = ""
                                    ESX.ShowNotification("Vous devez rentrer une taille valide")
                                else       
                                    edit__Index8 = tonumber(edit_BlipScale) * 10
                                    edit_BlipScale = tonumber(edit_BlipScale) * 1.0
                                    if edit_BlipPreview == true then        
                                        RemoveBlip(edit__blip)
                                        RemoveBlip(edit__blip2)  
                                        edit__PreviewBlip(edit_BlipPos, edit_BlipName, edit_Blip, edit_Blip2) 
                                    end 
                                    ESX.ShowNotification("Vous venez de sauvegarder la taille du blip qui est de ~b~"..edit_BlipScale)           
                                end
                            end
                        })
                        RageUI.List("Couleur", edit__Items3, edit__Index9, nil, {}, true, {
                            onListChange = function(Index)
                                edit__Index9 = Index
                                if edit_BlipPreview == true then        
                                    RemoveBlip(edit__blip)
                                    RemoveBlip(edit__blip2)  
                                    edit__PreviewBlip(edit_BlipPos, edit_BlipName, edit_Blip, edit_Blip2) 
                                end
                            end,
                            onActive = function()
                                edit_BlipColor = edit__Index9
                            end,
                            onSelected = function()
                                edit_BlipColor = KeyboardInput("Donner une couleur à votre blip (0 - 85)", nil, 2)
                                if edit_BlipColor == nil or edit_BlipColor == "" or not tonumber(edit_BlipColor) then
                                    edit_BlipColor = ""
                                    ESX.ShowNotification("Vous devez rentrer une couleur valide")
                                else   
                                    edit__Index9 = tonumber(edit_BlipColor)  
                                    edit_BlipColor = edit__Index9  
                                    if BlipPreview == true then        
                                        RemoveBlip(edit__blip)
                                        RemoveBlip(edit__blip2)  
                                        edit__PreviewBlip(edit_BlipPos, edit_BlipName, edit_Blip, edit_Blip2) 
                                    end 
                                    ESX.ShowNotification("Vous venez de sauvegarder la couleur du blip qui est de ~b~"..edit_BlipColor)               
                                end
                            end
                        })
                        RageUI.Checkbox("Ajouter un blip de zone", nil, edit_Blip2, {}, {
                            onChecked = function()
                                edit_Blip2 = true
                                if edit_BlipPreview == true then
                                    edit_BlipScale2 = edit__Index10 * 10
                                    edit_BlipColor2 = edit__Items4[edit__Index11]   
                                    edit_BlipOpacity = edit__Index12 * 10                          
                                    RemoveBlip(edit__blip)
                                    RemoveBlip(edit__blip2)  
                                    edit__PreviewBlip(edit_BlipPos, edit_BlipName, edit_Blip, edit_Blip2) 
                                end 
                                ESX.ShowNotification("Vous avez ~g~ajouté~s~ le blip de zone au gang ~b~"..edit_Label)                        
                            end,
                            onUnChecked = function()
                                edit_Blip2 = false       
                                if edit_BlipPreview == true then        
                                    RemoveBlip(edit__blip)
                                    RemoveBlip(edit__blip2)  
                                    edit__PreviewBlip(edit_BlipPos, edit_BlipName, edit_Blip, edit_Blip2) 
                                end 
                                ESX.ShowNotification("Vous avez ~r~retiré~s~ le blip de zone au gang ~b~"..edit_Label)                
                            end
                        })
                        if edit_Blip2 then
                            RageUI.List("Taille", {10,20,30,40,50,60,70,80,90,100,110,120,130,140,150,160,170,180,190,200}, edit__Index10, nil, {}, true, {
                                onListChange = function(Index)
                                    edit__Index10 = Index
                                    if edit_BlipPreview == true then        
                                        RemoveBlip(edit__blip)
                                        RemoveBlip(edit__blip2)  
                                        edit__PreviewBlip(edit_BlipPos, edit_BlipName, edit_Blip, edit_Blip2) 
                                    end
                                end,
                                onActive = function()
                                    edit_BlipScale2 = edit__Index10 * 10.0
                                end,
                                onSelected = function()
                                    edit_BlipScale2 = KeyboardInput("Donner une taille à votre blip de zone (10 - 200)", nil, 3)
                                    if edit_BlipScale2 == nil or edit_BlipScale2 == "" or not tonumber(edit_BlipScale2) then
                                        edit_BlipScale2 = ""
                                        ESX.ShowNotification("Vous devez rentrer une taille valide")
                                    else     
                                        edit__Index10 = tonumber(edit_BlipScale2) / 10 
                                        edit_BlipScale2 = tonumber(edit_BlipScale2) * 1.0
                                        if edit_BlipPreview == true then        
                                            RemoveBlip(edit__blip)
                                            RemoveBlip(edit__blip2)  
                                            edit__PreviewBlip(edit_BlipPos, edit_BlipName, edit_Blip, edit_Blip2) 
                                        end 
                                        ESX.ShowNotification("Vous venez de sauvegarder la taille du blip de zone qui est de ~b~"..edit_BlipScale2)           
                                    end
                                end
                            })
                            RageUI.List("Couleur", edit__Items4, edit__Index11, nil, {}, true, {
                                onListChange = function(Index)
                                    edit__Index11 = Index
                                    if edit_BlipPreview == true then        
                                        RemoveBlip(edit__blip)
                                        RemoveBlip(edit__blip2)  
                                        edit__PreviewBlip(edit_BlipPos, edit_BlipName, edit_Blip, edit_Blip2) 
                                    end
                                end,
                                onActive = function()
                                    edit_BlipColor2 = edit__Index11
                                end,
                                onSelected = function()
                                    edit_BlipColor2 = KeyboardInput("Donner une couleur à votre blip de zone (0 - 85)", nil, 2)
                                    if edit_BlipColor2 == nil or edit_BlipColor2 == "" or not tonumber(edit_BlipColor2) then
                                        edit_BlipColor2 = ""
                                        ESX.ShowNotification("Vous devez rentrer une couleur valide")
                                    else     
                                        edit__Index11 = tonumber(edit_BlipColor2)
                                        edit_BlipColor2 = edit__Index11
                                        if edit_BlipPreview == true then        
                                            RemoveBlip(edit__blip)
                                            RemoveBlip(edit__blip2)  
                                            edit__PreviewBlip(edit_BlipPos, edit_BlipName, edit_Blip, edit_Blip2) 
                                        end 
                                        ESX.ShowNotification("Vous venez de sauvegarder la couleur du blip de zone qui est de ~b~"..edit_BlipColor2)               
                                    end
                                end
                            })
                            RageUI.List("Opacité", {10,20,30,40,50,60,70,80,90,100,110,120,130,140,150,160,170,180,190,200}, edit__Index12, nil, {}, true, {
                                onListChange = function(Index)
                                    edit__Index12 = Index
                                    if edit_BlipPreview == true then        
                                        RemoveBlip(edit__blip)
                                        RemoveBlip(edit__blip2)  
                                        edit__PreviewBlip(edit_BlipPos, edit_BlipName, edit_Blip, edit_Blip2) 
                                    end
                                end,
                                onActive = function()
                                    edit_BlipOpacity = edit__Index12 * 10
                                end,
                                onSelected = function()
                                    edit_BlipOpacity = KeyboardInput("Donner une opacité à votre blip de zone (10 - 200)", nil, 3)
                                    if edit_BlipOpacity == nil or edit_BlipOpacity == "" or not tonumber(edit_BlipOpacity) then
                                        edit_BlipOpacity = ""
                                        ESX.ShowNotification("Vous devez rentrer une opacité valide")
                                    else      
                                        edit__Index12 = tonumber(edit_BlipOpacity) / 10
                                        edit_BlipOpacity = tonumber(edit_BlipOpacity)
                                        if edit_BlipPreview == true then        
                                            RemoveBlip(edit__blip)
                                            RemoveBlip(edit__blip2)  
                                            edit__PreviewBlip(edit_BlipPos, edit_BlipName, edit_Blip, edit_Blip2) 
                                        end 
                                        ESX.ShowNotification("Vous venez de sauvegarder l'opacité du blip de zone qui est de ~b~"..edit_BlipOpacity)            
                                    end
                                end
                            })
                        end
                    end
                end)
                RageUI.IsVisible(edit_subMenu6,function()
                    if edit_MarkerPreview then
                        DrawMarker(edit_MarkerType, GetEntityCoords(PlayerPedId()).x, GetEntityCoords(PlayerPedId()).y, GetEntityCoords(PlayerPedId()).z-1, 0.0, 0.0, 0.0, edit_MarkerrotX, edit_MarkerrotY, edit_MarkerrotZ, edit_MarkerscaleX, edit_MarkerscaleY, edit_MarkerscaleZ, edit_MarkerR, edit_MarkerV, edit_MarkerB, edit_MarkerO, false, false, p19, false) 
                    end
                    RageUI.Checkbox("Ajouter un marker", nil, edit_Marker, {}, {
                        onChecked = function()
                            edit_Marker = true
                            ESX.ShowNotification("Vous avez ~g~ajouté~s~ le marker au gang ~b~"..edit_Label)                        
                        end,
                        onUnChecked = function()
                            edit_Marker = false
                            ESX.ShowNotification("Vous avez ~r~retiré~s~ le marker au gang ~b~"..edit_Label)                
                        end
                    })
                    if edit_Marker then
                        RageUI.Line()
                        RageUI.Checkbox("Prévisualisé le marker", nil, edit_MarkerPreview, {}, {
                            onChecked = function()
                                edit_MarkerPreview = true
                                edit_MarkerType = edit__Items5[edit__Index13]
                                edit_MarkerrotX = edit__Items6[edit__Index14]
                                edit_MarkerrotY = edit__Items7[edit__Index15]
                                edit_MarkerrotZ = edit__Items8[edit__Index16]
                                edit_MarkerscaleX = edit__Items9[edit__Index17]
                                edit_MarkerscaleY = edit__Items10[edit__Index18]
                                edit_MarkerscaleZ = edit__Items11[edit__Index19]
                                edit_MarkerR = edit__Items12[edit__Index20]
                                edit_MarkerV = edit__Items13[edit__Index21]
                                edit_MarkerB = edit__Items14[edit__Index22]
                                edit_MarkerO = edit__Items15[edit__Index23]          
                                ESX.ShowNotification("Prévisualisation ~g~activée~s~")       
                            end,
                            onUnChecked = function()   
                                edit_MarkerPreview = false
                                ESX.ShowNotification("Prévisualisation ~r~désactivée~s~")           
                            end
                        })
                        RageUI.List("Type", edit__Items5, edit__Index13, nil, {}, true, {
                            onListChange = function(Index)
                                edit__Index13 = Index
                            end,
                            onActive = function()
                                edit_MarkerType = edit__Index13
                            end
                        })
                        RageUI.List("Rotation X", edit__Items6, edit__Index14, nil, {}, true, {
                            onListChange = function(Index)
                                edit__Index14 = Index
                            end,
                            onActive = function()
                                edit_MarkerrotX = edit__Items6[edit__Index14]
                            end,
                            onSelected = function()
                                edit_MarkerrotX = KeyboardInput("Donner une rotation x à votre marker (-180.0 - 180.0)", nil, 5)
                                if edit_MarkerrotX == nil or edit_MarkerrotX == "" or not tonumber(edit_MarkerrotX) then
                                    edit_MarkerrotX = ""
                                    ESX.ShowNotification("Vous devez rentrer une rotation valide")
                                else      
                                    for k,v in pairs(edit__Items6) do
                                        if v == tonumber(edit_MarkerrotX) then
                                            edit__Index14 = k
                                        end
                                    end 
                                    ESX.ShowNotification("Vous venez de sauvegarder la rotation x du marker qui est de ~b~"..edit_MarkerrotX)          
                                end
                            end
                        })
                        RageUI.List("Rotation Y", edit__Items7, edit__Index15, nil, {}, true, {
                            onListChange = function(Index)
                                edit__Index15 = Index
                            end,
                            onActive = function()
                                edit_MarkerrotY = edit__Items7[edit__Index15]
                            end,
                            onSelected = function()
                                edit_MarkerrotY = KeyboardInput("Donner une rotation y à votre marker (-180.0 - 180.0)", nil, 5)
                                if edit_MarkerrotY == nil or edit_MarkerrotY == "" or not tonumber(edit_MarkerrotY) then
                                    edit_MarkerrotY = ""
                                    ESX.ShowNotification("Vous devez rentrer une rotation valide")
                                else       
                                    for k,v in pairs(edit__Items7) do
                                        if v == tonumber(edit_MarkerrotY) then
                                            edit__Index15 = k
                                        end
                                    end
                                    ESX.ShowNotification("Vous venez de sauvegarder la rotation y du marker qui est de ~b~"..edit_MarkerrotY)          
                                end
                            end
                        })
                        RageUI.List("Rotation Z", edit__Items8, edit__Index16, nil, {}, true, {
                            onListChange = function(Index)
                                edit__Index16 = Index
                            end,
                            onActive = function()
                                edit_MarkerrotZ = edit__Items8[edit__Index16]
                            end,
                            onSelected = function()
                                edit_MarkerrotZ = KeyboardInput("Donner une rotation z à votre marker (-180.0 - 180.0)", nil, 5)
                                if edit_MarkerrotZ == nil or edit_MarkerrotZ == "" or not tonumber(edit_MarkerrotZ) then
                                    edit_MarkerrotZ = ""
                                    ESX.ShowNotification("Vous devez rentrer une rotation valide")
                                else       
                                    for k,v in pairs(edit__Items8) do
                                        if v == tonumber(edit_MarkerrotZ) then
                                            edit__Index16 = k
                                        end
                                    end
                                    ESX.ShowNotification("Vous venez de sauvegarder la rotation z du marker qui est de ~b~"..edit_MarkerrotZ)          
                                end
                            end
                        })
                        RageUI.List("Taille X", edit__Items9, edit__Index17, nil, {}, true, {
                            onListChange = function(Index)
                                edit__Index17 = Index
                            end,
                            onActive = function()
                                edit_MarkerscaleX = edit__Items9[edit__Index17]
                            end,
                            onSelected = function()
                                edit_MarkerscaleX = KeyboardInput("Donner une taille x à votre marker (0.0 - 2.0)", nil, 5)
                                if edit_MarkerscaleX == nil or edit_MarkerscaleX == "" or not tonumber(edit_MarkerscaleX) then
                                    edit_MarkerscaleX = ""
                                    ESX.ShowNotification("Vous devez rentrer une taille valide")
                                else       
                                    for k,v in pairs(edit__Items9) do
                                        if v == tonumber(edit_MarkerscaleX) then
                                            edit__Index17 = k
                                        end
                                    end 
                                    ESX.ShowNotification("Vous venez de sauvegarder la taille x du marker qui est de ~b~"..edit_MarkerscaleX)          
                                end
                            end
                        })
                        RageUI.List("Taille Y", edit__Items10, edit__Index18, nil, {}, true, {
                            onListChange = function(Index)
                                edit__Index18 = Index
                            end,
                            onActive = function()
                                edit_MarkerscaleY = edit__Items10[edit__Index18]
                            end,
                            onSelected = function()
                                edit_MarkerscaleY = KeyboardInput("Donner une taille y à votre marker (0.0 - 2.0)", nil, 5)
                                if edit_MarkerscaleY == nil or edit_MarkerscaleY == "" or not tonumber(edit_MarkerscaleY) then
                                    edit_MarkerscaleY = ""
                                    ESX.ShowNotification("Vous devez rentrer une taille valide")
                                else       
                                    for k,v in pairs(edit__Items10) do
                                        if v == tonumber(edit_MarkerscaleY) then
                                            edit__Index18 = k
                                        end
                                    end 
                                    ESX.ShowNotification("Vous venez de sauvegarder la taille y du marker qui est de ~b~"..edit_MarkerscaleY)          
                                end
                            end
                        })
                        RageUI.List("Taille Z", edit__Items11, edit__Index19, nil, {}, true, {
                            onListChange = function(Index)
                                edit__Index19 = Index
                            end,
                            onActive = function()
                                edit_MarkerscaleZ = edit__Items11[edit__Index19]
                            end,
                            onSelected = function()
                                edit_MarkerscaleZ = KeyboardInput("Donner une taille z à votre marker (0.0 - 2.0)", nil, 5)
                                if edit_MarkerscaleZ == nil or edit_MarkerscaleZ == "" or not tonumber(edit_MarkerscaleZ) then
                                    edit_MarkerscaleZ = ""
                                    ESX.ShowNotification("Vous devez rentrer une taille valide")
                                else        
                                    for k,v in pairs(edit__Items11) do
                                        if v == tonumber(edit_MarkerscaleZ) then
                                            edit__Index19 = k
                                        end
                                    end 
                                    ESX.ShowNotification("Vous venez de sauvegarder la taille z du marker qui est de ~b~"..edit_MarkerscaleZ)          
                                end
                            end
                        })
                        RageUI.List("R", edit__Items12, edit__Index20, nil, {}, true, {
                            onListChange = function(Index)
                                edit__Index20 = Index
                            end,
                            onActive = function()
                                edit_MarkerR = edit__Items12[edit__Index20]
                            end,
                            onSelected = function()
                                edit_MarkerR = KeyboardInput("Donner une couleur rouge à votre marker (0 - 255)", nil, 5)
                                if edit_MarkerR == nil or edit_MarkerR == "" or not tonumber(edit_MarkerR) then
                                    edit_MarkerR = ""
                                    ESX.ShowNotification("Vous devez rentrer une couleur rouge valide")
                                else   
                                    for k,v in pairs(edit__Items12) do
                                        if v == tonumber(edit_MarkerR) then
                                            edit__Index20 = k
                                        end
                                    end        
                                    ESX.ShowNotification("Vous venez de sauvegarder la couleur rouge du marker qui est de ~b~"..edit_MarkerR)          
                                end
                            end
                        })
                        RageUI.List("V", edit__Items13, edit__Index21, nil, {}, true, {
                            onListChange = function(Index)
                                edit__Index21 = Index
                            end,
                            onActive = function()
                                edit_MarkerV = edit__Items13[edit__Index21]
                            end,
                            onSelected = function()
                                edit_MarkerV = KeyboardInput("Donner une couleur verte à votre marker (0 - 255)", nil, 5)
                                if edit_MarkerV == nil or edit_MarkerV == "" or not tonumber(edit_MarkerV) then
                                    edit_MarkerV = ""
                                    ESX.ShowNotification("Vous devez rentrer une couleur verte valide")
                                else       
                                    for k,v in pairs(edit__Items13) do
                                        if v == tonumber(edit_MarkerV) then
                                            edit__Index21 = k
                                        end
                                    end     
                                    ESX.ShowNotification("Vous venez de sauvegarder la couleur vert du marker qui est de ~b~"..edit_MarkerV)          
                                end
                            end
                        })
                        RageUI.List("B", edit__Items14, edit__Index22, nil, {}, true, {
                            onListChange = function(Index)
                                edit__Index22 = Index
                            end,
                            onActive = function()
                                edit_MarkerB = edit__Items14[edit__Index22]
                            end,
                            onSelected = function()
                                edit_MarkerB = KeyboardInput("Donner une couleur bleu à votre marker (0 - 255)", nil, 5)
                                if edit_MarkerB == nil or edit_MarkerB == "" or not tonumber(edit_MarkerB) then
                                    edit_MarkerB = ""
                                    ESX.ShowNotification("Vous devez rentrer une couleur bleu valide")
                                else      
                                    for k,v in pairs(edit__Items14) do
                                        if v == tonumber(edit_MarkerB) then
                                            edit__Index22 = k
                                        end
                                    end      
                                    ESX.ShowNotification("Vous venez de sauvegarder la couleur bleu du marker qui est de ~b~"..edit_MarkerB)          
                                end
                            end
                        })
                        RageUI.List("O", edit__Items15, edit__Index23, nil, {}, true, {
                            onListChange = function(Index)
                                edit__Index23 = Index
                            end,
                            onActive = function()
                                edit_MarkerO = edit__Items15[edit__Index23]
                            end,
                            onSelected = function()
                                edit_MarkerO = KeyboardInput("Donner une opacité à votre marker (0 - 255)", nil, 5)
                                if edit_MarkerO == nil or edit_MarkerO == "" or not tonumber(edit_MarkerO) then
                                    edit_MarkerO = ""
                                    ESX.ShowNotification("Vous devez rentrer une opacité valide")
                                else
                                    for k,v in pairs(edit__Items15) do
                                        if v == tonumber(edit_MarkerO) then
                                            edit__Index23 = k
                                        end
                                    end      
                                    ESX.ShowNotification("Vous venez de sauvegarder l'opacité du marker qui est de ~b~"..edit_MarkerO)          
                                end
                            end
                        })
                    end
                end)
                RageUI.IsVisible(edit_subMenu7,function()
                    edit_subMenu7:UpdateInstructionalButtons(true) 
                    RageUI.Button("Nom", nil, {RightLabel = "~b~"..edit_GradeName.." ~s~→"}, true, {
                        onSelected = function()
                            edit_GradeName = KeyboardInput("Donner un nom à votre grade", nil, 50)
                            if edit_GradeName == nil or edit_GradeName == "" then
                                edit_GradeName = ""
                                ESX.ShowNotification("Vous devez rentrer un nom valide")
                            else                       
                                ESX.ShowNotification("Vous avez nommé votre grade ~b~"..edit_GradeName)
                            end
                        end
                    })
                    RageUI.Button("Label", nil, {RightLabel = "~o~"..edit_GradeLabel.." ~s~→"}, true, {
                        onSelected = function()
                            edit_GradeLabel = KeyboardInput("Donner un label à votre grade", nil, 50)
                            if edit_GradeLabel == nil or edit_GradeLabel == "" then
                                edit_GradeLabel = ""
                                ESX.ShowNotification("Vous devez rentrer un label valide")
                            else                       
                                ESX.ShowNotification("Vous avez mis un label sur votre grade ~b~"..edit_GradeLabel)
                            end
                        end
                    })
                    RageUI.Button("Salaire", nil, {RightLabel = "~g~"..edit_GradeSalary2.." ~s~→"}, true, {
                        onSelected = function()
                            edit_GradeSalary = KeyboardInput("Donner un salaire à votre grade", nil, 50)
                            if edit_GradeSalary == nil or edit_GradeSalary == "" or not tonumber(edit_GradeSalary) then
                                edit_GradeSalary = ""
                                ESX.ShowNotification("Vous devez rentrer un salaire valide")
                            else     
                                edit_GradeSalary2 = edit_GradeSalary.."$"          
                                ESX.ShowNotification("Vous avez définis un salaire de ~b~"..edit_GradeSalary)
                            end
                        end
                    })
                    RageUI.Button("Numéro du grade", nil, {RightLabel = "~p~"..edit_GradeNumber2.." ~s~→"}, true, {
                        onSelected = function()
                            edit_GradeNumber = KeyboardInput("Donner un salaire à votre grade", nil, 50)
                            if edit_GradeNumber == nil or edit_GradeNumber == "" or not tonumber(edit_GradeNumber) then
                                edit_GradeNumber = ""
                                ESX.ShowNotification("Vous devez rentrer un salaire valide")
                            else             
                                edit_GradeNumber2 = "N°"..edit_GradeNumber 
                                ESX.ShowNotification("Vous avez définis un salaire de ~b~"..edit_GradeNumber)
                            end
                        end
                    })
                    RageUI.Button("Valider", nil, pGangBuilder.RightLabel, true, {
                        onSelected = function()
                            if edit_ModifyGrade.verify == true then
                                table.remove(edit_data_grade, edit_ModifyGrade.value)
                                table.insert(edit_data_grade, edit_ModifyGrade.value, {name = edit_GradeName, label = edit_GradeLabel, salary = edit_GradeSalary, number = edit_GradeNumber})
                                edit_ModifyGrade = {value = nil, verify = false}
                                edit_GradeName,edit_GradeLabel,edit_GradeSalary,edit_GradeNumber,edit_GradeSalary2,edit_GradeNumber2 = "","","","","",""
                                RageUI.GoBack()
                            else
                                table.insert(edit_data_grade, {name = edit_GradeName, label = edit_GradeLabel, salary = edit_GradeSalary, number = edit_GradeNumber})
                                edit_ModifyGrade = {value = nil, verify = false}
                                edit_GradeName,edit_GradeLabel,edit_GradeSalary,edit_GradeNumber,edit_GradeSalary2,edit_GradeNumber2 = "","","","","",""
                                RageUI.GoBack() 
                            end                     
                        end
                    })
                end)
                RageUI.IsVisible(edit_subMenu8, function()
                    edit_subMenu8:UpdateInstructionalButtons(true) 
                    RageUI.Button("Nom du véhicule", nil, {RightLabel = "~b~"..edit_VehicleName.." ~s~→"}, true, {
                        onSelected = function()
                            edit_VehicleName = KeyboardInput("Donner un nom à votre véhicule", nil, 50)
                            if edit_VehicleName == nil or edit_VehicleName == "" then
                                edit_VehicleName = ""
                                ESX.ShowNotification("Vous devez rentrer un nom de véhicule valide")
                            else    
                                edit_zVehicleName = edit_VehicleName                   
                                ESX.ShowNotification("Le nom de votre véhicule sera ~b~"..edit_VehicleName)
                            end
                            edit_active = false
                        end
                    })
                    RageUI.List("Nombre de véhicule", {"Infini", "Personnalisé"}, edit__Index2, nil, {}, true, {
                        onActive = function()
                            if edit__Index2 == 1 then
                                edit_VehicleCount = -1
                            end
                            edit_active = false
                        end,
                        onListChange = function(Index)
                            edit__Index2 = Index
                        end,
                        onSelected = function()
                            if edit__Index2 == 2 then
                                edit_VehicleCount = KeyboardInput("Donner un nombre de véhicule", nil, 3)
                                if edit_VehicleCount == nil or edit_VehicleCount == "" or not tonumber(edit_VehicleCount) then
                                    edit_VehicleCount = ""
                                    ESX.ShowNotification("Vous devez rentrer un count valide")
                                else   
                                    edit_VehicleCount = tonumber(edit_VehicleCount)                    
                                    ESX.ShowNotification("Le count de votre véhicule sera ~b~"..edit_VehicleCount)
                                end
                            end
                        end
                    })
                    RageUI.Checkbox("Phares Xenon", nil, edit_xenon, {}, {
                        onChecked = function() 
                            edit_xenon = true 
                            edit_active = false
                        end, 
                        onUnChecked = function() 
                            edit_xenon = false 
                            edit_active = false
                        end
                    })
                    RageUI.Checkbox("Full Custom (performance)", nil, edit_custom, {}, {
                        onChecked = function() 
                            edit_custom = true 
                            edit_active = false
                        end, 
                        onUnChecked = function() 
                            edit_custom = false 
                            edit_active = false
                        end
                    })
                    RageUI.Checkbox("Vitres Teintées", nil, edit_vitres, {}, {
                        onChecked = function() 
                            edit_vitres = true 
                            edit_active = false
                        end, 
                        onUnChecked = function() 
                            edit_vitres = false 
                            edit_active = false
                        end
                    })
                    RageUI.Checkbox("Plaque", "~b~"..edit_iplaque2, edit_plaque, {}, {
                        onChecked = function() 
                            edit_plaque = true 
                            local edit_iplaque = KeyboardInput("Numéro de la plaque ", "", 10) 
                            if edit_iplaque == nil or edit_iplaque == "" then 
                                edit_iplaque = ""
                                ESX.ShowNotification("Numéro Invalide")
                            else
                                edit_iplaque2 = edit_iplaque
                                ESX.ShowNotification("Votre plaque de voiture sera ~b~"..edit_iplaque2)  
                            end
                            edit_active = false 
                        end, 
                        onUnChecked = function() 
                            edit_plaque = false 
                            edit_active = false
                        end
                    })
                    RageUI.List("Teinte", {"Classic/Metallic", "Matte", "Chrome"}, edit__Index3, nil, {}, true, {
                        onListChange = function(Index)
                            edit__Index3 = Index
                            edit_active = false
                        end
                    })
                    RageUI.List("Couleur", {"Noir", "Rouge", "Bleu", "Vert", "Jaune", "Violet", "Blanc"}, edit__Index4, nil, {}, true, {
                        onListChange = function(Index)
                            edit__Index4 = Index
                            edit_active = false
                        end,
                        onActive = function()
                            if edit__Index4 == 1 then
                                edit_color = {2, 12, 120}
                            elseif edit__Index4 == 2 then
                                edit_color = {27, 39, 120}
                            elseif edit__Index4 == 3 then
                                edit_color = {64, 83, 120}
                            elseif edit__Index4 == 4 then
                                edit_color = {49, 128, 120}
                            elseif edit__Index4 == 5 then
                                edit_color = {88, 42, 120}
                            elseif edit__Index4 == 6 then
                                edit_color = {71, 148, 120}
                            elseif edit__Index4 == 7 then
                                edit_color = {111, 131, 120}
                            end
                        end
                    })
                    RageUI.List("Prévisualiser le véhicule", {"Spawn sur soi", "Spawn du garage"}, edit__Index5, nil, {}, true, {
                        onListChange = function(Index)
                            edit__Index5 = Index
                        end,
                        onSelected = function()
                            if edit__Index5 == 1 then
                                if ESX.Game.IsSpawnPointClear(GetEntityCoords(PlayerPedId()), 2.0) then
                                    ESX.Game.SpawnVehicle(edit_zVehicleName, GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), function(vehicle)
                                        if edit_xenon then 
                                            Xenon(vehicle) 
                                        end
                                        if edit_custom then 
                                            Custom(vehicle) 
                                        end
                                        if edit_vitres then 
                                            Vitres(vehicle) 
                                        end
                                        if edit_plaque then 
                                            SetVehicleNumberPlateText(vehicle, edit_iplaque2) 
                                        end
                                        if edit_color then
                                            Color(vehicle, edit_color[edit__Index3])
                                        end
                                        edit_vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                                        ESX.ShowNotification("Suppression du véhicule dans 10 secondes")
                                        Wait(10000)
                                        ESX.Game.DeleteVehicle(vehicle)
                                        edit_active = true
                                    end)
                                else 
                                    ESX.ShowNotification("La sortie est bloqué")                                  
                                end
                            elseif edit__Index5 == 2 then
                                if ESX.Game.IsSpawnPointClear(edit_GarageSpawn, 2.0) then
                                    ESX.Game.SpawnVehicle(edit_zVehicleName, edit_GarageSpawn, edit_GarageHeading, function(vehicle)
                                        if edit_xenon then 
                                            Xenon(vehicle) 
                                        end
                                        if edit_custom then 
                                            Custom(vehicle) 
                                        end
                                        if edit_vitres then 
                                            Vitres(vehicle) 
                                        end
                                        if edit_plaque then 
                                            SetVehicleNumberPlateText(vehicle, edit_iplaque2) 
                                        else
                                            edit_iplaque2 = GetVehicleNumberPlateText(vehicle)
                                        end
                                        if edit_color then
                                            Color(vehicle, edit_color[_Index3])
                                        end
                                        edit_vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                                        ESX.ShowNotification("Suppression du véhicule dans 10 secondes")
                                        Wait(10000)
                                        ESX.Game.DeleteVehicle(vehicle)
                                        edit_active = true
                                    end)
                                else 
                                    ESX.ShowNotification("La sortie est bloqué")                                  
                                end
                            end
                        end
                    })
                    RageUI.Button("Valider", nil, pGangBuilder.RightLabel, edit_active, {
                        onSelected = function()
                            if edit_VehicleName == nil or edit_VehicleName == "" or edit_VehicleCount == nil or edit_VehicleCount == "" then
                                ESX.ShowNotification("Il vous manque des données")
                            else
                                if edit_ModifyVehicle.verify == true then
                                    table.remove(edit_data_vehicle, edit_ModifyVehicle.value)
                                    table.insert(edit_data_vehicle, edit_ModifyVehicle.value, {name = edit_VehicleName, count = edit_VehicleCount, plate = edit_iplaque2, props = edit_vehicleProps})
                                    edit_ModifyVehicle = {value = nil, verify = false}
                                    edit__Index2,edit__Index3,edit__Index4,edit__Index5 = 1,1,1,1
                                    edit_VehicleName,edit_VehicleCount,edit_iplaque2 = "","",""
                                    edit_xenon,edit_custom,edit_vitres,edit_plaque,edit_color,edit_active = false,false,false,false,false,false
                                    RageUI.GoBack()
                                else
                                    table.insert(edit_data_vehicle, {name = edit_VehicleName, count = edit_VehicleCount, plate = edit_iplaque2, props = edit_vehicleProps})
                                    edit_ModifyVehicle = {value = nil, verify = false}
                                    edit__Index2,edit__Index3,edit__Index4,edit__Index5 = 1,1,1,1
                                    edit_VehicleName,edit_VehicleCount,edit_iplaque2 = "","",""
                                    edit_xenon,edit_custom,edit_vitres,edit_plaque,edit_color,edit_active = false,false,false,false,false,false
                                    RageUI.GoBack()
                                end
                            end
                        end
                    })
                end)
                RageUI.IsVisible(edit_subMenu9,function()
                    edit_subMenu9:UpdateInstructionalButtons(true)   
                    GetIndex() 
                    Load_Clothes()                                        
                    RageUI.Button("Nom de la tenue", nil, {RightLabel = "~b~"..edit_ClothesName.." ~s~→"}, true, {
                        onSelected = function()
                            edit_ClothesName = KeyboardInput("Donner un nom à votre tenue", nil, 50)
                            if edit_ClothesName == nil or edit_ClothesName == "" then
                                edit_ClothesName = ""
                                ESX.ShowNotification("Vous devez rentrer un nom valide")
                            else                       
                                ESX.ShowNotification("Vous avez nommé votre tenue ~b~"..edit_ClothesName)
                            end
                        end
                    })
                    RageUI.Line()                
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
                    RageUI.List("Bras", bras, bras1, nil, {}, true, {
                        onListChange = function(Index)
                            bras1 = Index
                            TriggerEvent("skinchanger:change", "arms", bras1-1)
                        end
                    })
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
                    RageUI.Button("Valider", nil, pGangBuilder.RightLabel, true, {
                        onSelected = function()
                            if edit_ClothesName == nil or edit_ClothesName == "" then
                                ESX.ShowNotification("Vous n'avez pas donné de nom à la tenue")
                            else                       
                                TriggerEvent('skinchanger:getSkin', function(skin)
                                    if edit_ModifyClothes.verify == true then
                                        table.remove(edit_data_clothes, edit_ModifyClothes.value)
                                        table.insert(edit_data_clothes, edit_ModifyClothes.value, {name = edit_ClothesName, skin = skin})
                                        edit_ModifyClothes = {value = nil, verify = false}
                                        edit_ClothesName = ""
                                        RageUI.GoBack()
                                    else
                                        table.insert(edit_data_clothes, {name = edit_ClothesName, skin = skin})
                                        edit_ModifyClothes = {value = nil, verify = false}
                                        edit_ClothesName = ""
                                        RageUI.GoBack()
                                    end
                                end)
                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                                    TriggerEvent('skinchanger:loadSkin', skin)
                                end)
                                FreezeEntityPosition(GetPlayerPed(-1), false)
                                RenderScriptCams(0, 1, 1000, 1, 1)
                                DestroyAllCams(true)
                            end                   
                        end
                    })
                end)
                RageUI.IsVisible(edit_subMenu10,function()
                    edit_subMenu10:UpdateInstructionalButtons(true) 
                    RageUI.List("Filtre :", {"Aucun", "Item", "Arme"}, edit__Index25, nil, {}, true, {
                        onListChange = function(Index) 
                            edit__Index25 = Index
                        end               
                    })
                    RageUI.Line()
                    if edit__Index25 == 1 or edit__Index25 == 2 then
                        RageUI.List("Filtre Item :", edit__Items16, edit__Index24, nil, {}, true, {
                            onListChange = function(Index) 
                                edit__Index24 = Index
                                if Index == 1 then
                                    edit_aucun = true
                                else 
                                    edit_aucun = false
                                end
                            end,
                            onSelected = function()
                                edit_temp_filtre = KeyboardInput("Donner une lettre bien précise", nil, 1)
                                if edit_temp_filtre == nil or edit_temp_filtre == "" or tonumber(edit_temp_filtre) then
                                    edit_temp_filtre = ""
                                    ESX.ShowNotification("Vous devez rentrer une lettre valide")
                                else 
                                    for k,v in pairs(edit__Items16) do
                                        if v == string.upper(edit_temp_filtre) then
                                            Index = k
                                            edit__Index24 = k
                                        else
                                            ESX.ShowNotification("Vous devez rentrer une lettre valide") 
                                        end
                                    end
                                end  
                            end                  
                        })
                        RageUI.Separator("↓ Liste des items ↓")
                        for k,v in pairs(getData.Items) do
                            if starts(v.label:lower(), edit__Items16[edit__Index24]:lower()) or edit_aucun then
                                RageUI.Button(v.label, nil, {RightLabel = "→"}, true, {
                                    onSelected = function()
                                        edit_temp_CountItem = KeyboardInput("Donner un nombre d'items", nil, 5)
                                        if edit_temp_CountItem == nil or edit_temp_CountItem == "" or not tonumber(edit_temp_CountItem) then
                                            edit_temp_CountItem = ""
                                            ESX.ShowNotification("Vous devez rentrer un nombre valide")
                                        else
                                            if edit_temp_verify then
                                                for y,z in pairs(edit_data_coffre_item) do
                                                    if z.name == v.name then                                         
                                                        ESX.ShowNotification("Vous avez déjà ajouté cette item, pour le modifier il suffit de revenir au menu précédent")
                                                        return
                                                    end
                                                end
                                                table.insert(edit_data_coffre_item, {label = v.label, name = v.name, count = tonumber(edit_temp_CountItem)}) 
                                                ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x"..edit_temp_CountItem.." ~b~"..v.label)   
                                            else
                                                table.insert(edit_data_coffre_item, {label = v.label, name = v.name, count = tonumber(edit_temp_CountItem)}) 
                                                ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x"..edit_temp_CountItem.." ~b~"..v.label)   
                                            end 
                                            edit_temp_verify = true 
                                        end
                                    end
                                })
                            end
                        end
                    end
                    if edit__Index25 == 1 or edit__Index25 == 3 then
                        RageUI.List("Filtre Arme :", {"Aucun", "Mêlée", "Armes de poing", "Mitraillettes", "Fusils de chasse", "Fusils d'assaut", "Mitrailleuses légères", "Fusils de sniper", "Artillerie lourde", "Jetables", "Divers", }, edit__Index26, nil, {}, true, {
                            onListChange = function(Index) 
                                edit__Index26 = Index
                            end               
                        })
                        RageUI.Separator("↓ Liste des armes ↓")
                        if edit__Index26 == 1 or edit__Index26 == 2 then
                            for k,v in pairs(pGangBuilder.ArrayWeapon.Melee) do
                                RageUI.List(v.label, {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}, edit__Index27, nil, {}, true, {
                                    onListChange = function(Index)
                                        edit__Index27 = Index
                                    end,
                                    onSelected = function()
                                        if edit_temp_verify2 then
                                            for y,z in pairs(edit_data_coffre_weapon) do
                                                if z.name == v.name then                                         
                                                    ESX.ShowNotification("Vous avez déjà ajouté cette arme, pour la modifier il suffit de revenir au menu précédent")
                                                    return
                                                end
                                            end
                                            table.insert(edit_data_coffre_weapon, {label = v.label, name = v.name, count = edit__Index27, munition = nil}) 
                                            ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x"..edit__Index27.." ~b~"..v.label)  
                                        else
                                            table.insert(edit_data_coffre_weapon, {label = v.label, name = v.name, count = edit__Index27, munition = nil}) 
                                            ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x"..edit__Index27.." ~b~"..v.label)  
                                        end 
                                        edit_temp_verify2 = true 
                                    end
                                })
                            end
                        end
                        if edit__Index26 == 1 or edit__Index26 == 3 then
                            for k,v in pairs(pGangBuilder.ArrayWeapon.Handguns) do
                                RageUI.List(v.label, {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}, edit__Index28, nil, {}, true, {
                                    onListChange = function(Index)
                                        edit__Index28 = Index
                                    end,
                                    onSelected = function()
                                        edit_temp_CountWeapon = KeyboardInput("Donner un nombre de munitions (0 - 999)", nil, 3)
                                        if edit_temp_CountWeapon == nil or edit_temp_CountWeapon == "" or not tonumber(edit_temp_CountWeapon) then
                                            edit_temp_CountWeapon = ""
                                            ESX.ShowNotification("Vous devez rentrer un nombre de munition valide")
                                        else
                                            if tonumber(edit_temp_CountWeapon) < 0 or tonumber(edit_temp_CountWeapon) > 999 then
                                                edit_temp_CountWeapon = ""
                                                ESX.ShowNotification("Vous devez rentrer un nombre de munition valide")
                                            else
                                                if edit_temp_verify2 then
                                                    for y,z in pairs(edit_data_coffre_weapon) do
                                                        if z.name == v.name then                                         
                                                            ESX.ShowNotification("Vous avez déjà ajouté cette arme, pour la modifier il suffit de revenir au menu précédent")
                                                            return
                                                        end
                                                    end
                                                    table.insert(edit_data_coffre_weapon, {label = v.label, name = v.name, count = edit__Index28, munition = tonumber(edit_temp_CountWeapon)})  
                                                    ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x"..edit__Index28.." ~b~"..v.label.." ~s~munis de ~o~x"..edit_temp_CountWeapon.." ~s~munitions")  
                                                else
                                                    table.insert(edit_data_coffre_weapon, {label = v.label, name = v.name, count = edit__Index28, munition = tonumber(edit_temp_CountWeapon)}) 
                                                    ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x"..edit__Index28.." ~b~"..v.label.." ~s~munis de ~o~x"..edit_temp_CountWeapon.." ~s~munitions")   
                                                end 
                                                edit_temp_verify2 = true 
                                            end
                                        end
                                    end
                                })
                            end
                        end
                        if edit__Index26 == 1 or edit__Index26 == 4 then
                            for k,v in pairs(pGangBuilder.ArrayWeapon.SubmachineGuns) do
                                RageUI.List(v.label, {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}, edit__Index29, nil, {}, true, {
                                    onListChange = function(Index)
                                        edit__Index29 = Index
                                    end,
                                    onSelected = function()
                                        edit_temp_CountWeapon = KeyboardInput("Donner un nombre de munitions (0 - 999)", nil, 3)
                                        if edit_temp_CountWeapon == nil or edit_temp_CountWeapon == "" or not tonumber(edit_temp_CountWeapon) then
                                            edit_temp_CountWeapon = ""
                                            ESX.ShowNotification("Vous devez rentrer un nombre de munition valide")
                                        else
                                            if tonumber(edit_temp_CountWeapon) < 0 or tonumber(edit_temp_CountWeapon) > 999 then
                                                edit_temp_CountWeapon = ""
                                                ESX.ShowNotification("Vous devez rentrer un nombre de munition valide")
                                            else
                                                if edit_temp_verify2 then
                                                    for y,z in pairs(edit_data_coffre_weapon) do
                                                        if z.name == v.name then                                         
                                                            ESX.ShowNotification("Vous avez déjà ajouté cette arme, pour la modifier il suffit de revenir au menu précédent")
                                                            return
                                                        end
                                                    end
                                                    table.insert(edit_data_coffre_weapon, {label = v.label, name = v.name, count = edit__Index29, munition = tonumber(edit_temp_CountWeapon)}) 
                                                    ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x"..edit__Index29.." ~b~"..v.label.." ~s~munis de ~o~x"..edit_temp_CountWeapon.." ~s~munitions") 
                                                else
                                                    table.insert(edit_data_coffre_weapon, {label = v.label, name = v.name, count = edit__Index29, munition = tonumber(edit_temp_CountWeapon)}) 
                                                    ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x"..edit__Index29.." ~b~"..v.label.." ~s~munis de ~o~x"..edit_temp_CountWeapon.." ~s~munitions")   
                                                end 
                                                edit_temp_verify2 = true 
                                            end
                                        end
                                    end
                                })
                            end
                        end              
                        if edit__Index26 == 1 or edit__Index26 == 5 then
                            for k,v in pairs(pGangBuilder.ArrayWeapon.Shotguns) do
                                RageUI.List(v.label, {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}, edit__Index30, nil, {}, true, {
                                    onListChange = function(Index)
                                        edit__Index30 = Index
                                    end,
                                    onSelected = function()
                                        edit_temp_CountWeapon = KeyboardInput("Donner un nombre de munitions (0 - 999)", nil, 3)
                                        if edit_temp_CountWeapon == nil or edit_temp_CountWeapon == "" or not tonumber(edit_temp_CountWeapon) then
                                            edit_temp_CountWeapon = ""
                                            ESX.ShowNotification("Vous devez rentrer un nombre de munition valide")
                                        else
                                            if tonumber(edit_temp_CountWeapon) < 0 or tonumber(edit_temp_CountWeapon) > 999 then
                                                edit_temp_CountWeapon = ""
                                                ESX.ShowNotification("Vous devez rentrer un nombre de munition valide")
                                            else
                                                if edit_temp_verify2 then
                                                    for y,z in pairs(edit_data_coffre_weapon) do
                                                        if z.name == v.name then                                         
                                                            ESX.ShowNotification("Vous avez déjà ajouté cette arme, pour la modifier il suffit de revenir au menu précédent")
                                                            return
                                                        end
                                                    end
                                                    table.insert(edit_data_coffre_weapon, {label = v.label, name = v.name, count = edit__Index30, munition = tonumber(edit_temp_CountWeapon)})
                                                    ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x"..edit__Index30.." ~b~"..v.label.." ~s~munis de ~o~x"..edit_temp_CountWeapon.." ~s~munitions") 
                                                else
                                                    table.insert(edit_data_coffre_weapon, {label = v.label, name = v.name, count = edit__Index30, munition = tonumber(edit_temp_CountWeapon)}) 
                                                    ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x"..edit__Index30.." ~b~"..v.label.." ~s~munis de ~o~x"..edit_temp_CountWeapon.." ~s~munitions")   
                                                end 
                                                edit_temp_verify2 = true 
                                            end
                                        end
                                    end
                                })
                            end
                        end                    
                        if edit__Index26 == 1 or edit__Index26 == 6 then
                            for k,v in pairs(pGangBuilder.ArrayWeapon.AssaultRifles) do
                                RageUI.List(v.label, {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}, edit__Index31, nil, {}, true, {
                                    onListChange = function(Index)
                                        edit__Index31 = Index
                                    end,
                                    onSelected = function()
                                        edit_temp_CountWeapon = KeyboardInput("Donner un nombre de munitions (0 - 999)", nil, 3)
                                        if edit_temp_CountWeapon == nil or edit_temp_CountWeapon == "" or not tonumber(edit_temp_CountWeapon) then
                                            edit_temp_CountWeapon = ""
                                            ESX.ShowNotification("Vous devez rentrer un nombre de munition valide")
                                        else
                                            if tonumber(edit_temp_CountWeapon) < 0 or tonumber(edit_temp_CountWeapon) > 999 then
                                                edit_temp_CountWeapon = ""
                                                ESX.ShowNotification("Vous devez rentrer un nombre de munition valide")
                                            else
                                                if edit_temp_verify2 then
                                                    for y,z in pairs(edit_data_coffre_weapon) do
                                                        if z.name == v.name then                                         
                                                            ESX.ShowNotification("Vous avez déjà ajouté cette arme, pour la modifier il suffit de revenir au menu précédent")
                                                            return
                                                        end
                                                    end
                                                    table.insert(edit_data_coffre_weapon, {label = v.label, name = v.name, count = edit__Index31, munition = tonumber(edit_temp_CountWeapon)}) 
                                                    ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x"..edit__Index31.." ~b~"..v.label.." ~s~munis de ~o~x"..edit_temp_CountWeapon.." ~s~munitions") 
                                                else
                                                    table.insert(edit_data_coffre_weapon, {label = v.label, name = v.name, count = edit__Index31, munition = tonumber(edit_temp_CountWeapon)}) 
                                                    ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x"..edit__Index31.." ~b~"..v.label.." ~s~munis de ~o~x"..edit_temp_CountWeapon.." ~s~munitions")   
                                                end 
                                                edit_temp_verify2 = true 
                                            end
                                        end
                                    end
                                })
                            end
                        end
                        if edit__Index26 == 1 or edit__Index26 == 7 then
                            for k,v in pairs(pGangBuilder.ArrayWeapon.LightMachineGuns) do
                                RageUI.List(v.label, {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}, edit__Index32, nil, {}, true, {
                                    onListChange = function(Index)
                                        edit__Index32 = Index
                                    end,
                                    onSelected = function()
                                        edit_temp_CountWeapon = KeyboardInput("Donner un nombre de munitions (0 - 999)", nil, 3)
                                        if edit_temp_CountWeapon == nil or edit_temp_CountWeapon == "" or not tonumber(edit_temp_CountWeapon) then
                                            edit_temp_CountWeapon = ""
                                            ESX.ShowNotification("Vous devez rentrer un nombre de munition valide")
                                        else
                                            if tonumber(edit_temp_CountWeapon) < 0 or tonumber(edit_temp_CountWeapon) > 999 then
                                                edit_temp_CountWeapon = ""
                                                ESX.ShowNotification("Vous devez rentrer un nombre de munition valide")
                                            else
                                                if edit_temp_verify2 then
                                                    for y,z in pairs(edit_data_coffre_weapon) do
                                                        if z.name == v.name then                                         
                                                            ESX.ShowNotification("Vous avez déjà ajouté cette arme, pour la modifier il suffit de revenir au menu précédent")
                                                            return
                                                        end
                                                    end
                                                    table.insert(edit_data_coffre_weapon, {label = v.label, name = v.name, count = edit__Index32, munition = tonumber(edit_temp_CountWeapon)}) 
                                                    ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x"..edit__Index32.." ~b~"..v.label.." ~s~munis de ~o~x"..edit_temp_CountWeapon.." ~s~munitions") 
                                                else
                                                    table.insert(edit_data_coffre_weapon, {label = v.label, name = v.name, count = edit__Index32, munition = tonumber(edit_temp_CountWeapon)}) 
                                                    ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x"..edit__Index32.." ~b~"..v.label.." ~s~munis de ~o~x"..edit_temp_CountWeapon.." ~s~munitions")   
                                                end 
                                                edit_temp_verify2 = true 
                                            end
                                        end
                                    end
                                })
                            end
                        end
                        if edit__Index26 == 1 or edit__Index26 == 8 then
                            for k,v in pairs(pGangBuilder.ArrayWeapon.SniperRifles) do
                                RageUI.List(v.label, {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}, edit__Index33, nil, {}, true, {
                                    onListChange = function(Index)
                                        edit__Index33 = Index
                                    end,
                                    onSelected = function()
                                        edit_temp_CountWeapon = KeyboardInput("Donner un nombre de munitions (0 - 999)", nil, 3)
                                        if edit_temp_CountWeapon == nil or edit_temp_CountWeapon == "" or not tonumber(edit_temp_CountWeapon) then
                                            edit_temp_CountWeapon = ""
                                            ESX.ShowNotification("Vous devez rentrer un nombre de munition valide")
                                        else
                                            if tonumber(edit_temp_CountWeapon) < 0 or tonumber(edit_temp_CountWeapon) > 999 then
                                                edit_temp_CountWeapon = ""
                                                ESX.ShowNotification("Vous devez rentrer un nombre de munition valide")
                                            else
                                                if edit_temp_verify2 then
                                                    for y,z in pairs(edit_data_coffre_weapon) do
                                                        if z.name == v.name then                                         
                                                            ESX.ShowNotification("Vous avez déjà ajouté cette arme, pour la modifier il suffit de revenir au menu précédent")
                                                            return
                                                        end
                                                    end
                                                    table.insert(edit_data_coffre_weapon, {label = v.label, name = v.name, count = edit__Index33, munition = tonumber(edit_temp_CountWeapon)}) 
                                                    ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x"..edit__Index33.." ~b~"..v.label.." ~s~munis de ~o~x"..edit_temp_CountWeapon.." ~s~munitions")  
                                                else
                                                    table.insert(edit_data_coffre_weapon, {label = v.label, name = v.name, count = edit__Index33, munition = tonumber(edit_temp_CountWeapon)}) 
                                                    ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x"..edit__Index33.." ~b~"..v.label.." ~s~munis de ~o~x"..edit_temp_CountWeapon.." ~s~munitions")   
                                                end 
                                                edit_temp_verify2 = true 
                                            end
                                        end
                                    end
                                })
                            end
                        end
                        if edit__Index26 == 1 or edit__Index26 == 9 then
                            for k,v in pairs(pGangBuilder.ArrayWeapon.HeavyWeapons) do
                                RageUI.List(v.label, {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}, edit__Index34, nil, {}, true, {
                                    onListChange = function(Index)
                                        edit__Index34 = Index
                                    end,
                                    onSelected = function()
                                        edit_temp_CountWeapon = KeyboardInput("Donner un nombre de munitions (0 - 999)", nil, 3)
                                        if edit_temp_CountWeapon == nil or edit_temp_CountWeapon == "" or not tonumber(edit_temp_CountWeapon) then
                                            edit_temp_CountWeapon = ""
                                            ESX.ShowNotification("Vous devez rentrer un nombre de munition valide")
                                        else
                                            if tonumber(edit_temp_CountWeapon) < 0 or tonumber(edit_temp_CountWeapon) > 999 then
                                                edit_temp_CountWeapon = ""
                                                ESX.ShowNotification("Vous devez rentrer un nombre de munition valide")
                                            else
                                                if edit_temp_verify2 then
                                                    for y,z in pairs(edit_data_coffre_weapon) do
                                                        if z.name == v.name then                                         
                                                            ESX.ShowNotification("Vous avez déjà ajouté cette arme, pour la modifier il suffit de revenir au menu précédent")
                                                            return
                                                        end
                                                    end
                                                    table.insert(edit_data_coffre_weapon, {label = v.label, name = v.name, count = edit__Index34, munition = tonumber(edit_temp_CountWeapon)}) 
                                                    ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x"..edit__Index34.." ~b~"..v.label.." ~s~munis de ~o~x"..edit_temp_CountWeapon.." ~s~munitions") 
                                                else
                                                    table.insert(edit_data_coffre_weapon, {label = v.label, name = v.name, count = edit__Index34, munition = tonumber(edit_temp_CountWeapon)}) 
                                                    ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x"..edit__Index34.." ~b~"..v.label.." ~s~munis de ~o~x"..edit_temp_CountWeapon.." ~s~munitions")   
                                                end 
                                                edit_temp_verify2 = true 
                                            end
                                        end
                                    end
                                })
                            end
                        end
                        if edit__Index26 == 1 or edit__Index26 == 10 then
                            for k,v in pairs(pGangBuilder.ArrayWeapon.Throwables) do
                                RageUI.List(v.label, {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}, edit__Index35, nil, {}, true, {
                                    onListChange = function(Index)
                                        edit__Index35 = Index
                                    end,
                                    onSelected = function()
                                        if edit_temp_verify2 then
                                            for y,z in pairs(edit_data_coffre_weapon) do
                                                if z.name == v.name then                                         
                                                    ESX.ShowNotification("Vous avez déjà ajouté cette arme, pour la modifier il suffit de revenir au menu précédent")
                                                    return
                                                end
                                            end
                                            table.insert(edit_data_coffre_weapon, {label = v.label, name = v.name, count = edit__Index35, munition = nil}) 
                                            ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x"..edit__Index35.." ~b~"..v.label)      
                                        else
                                            table.insert(edit_data_coffre_weapon, {label = v.label, name = v.name, count = edit__Index35, munition = nil}) 
                                            ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x"..edit__Index35.." ~b~"..v.label)  
                                        end 
                                        edit_temp_verify2 = true
                                    end 
                                })
                            end
                        end
                        if edit__Index26 == 1 or edit__Index26 == 11 then
                            for k,v in pairs(pGangBuilder.ArrayWeapon.Miscellaneous) do
                                RageUI.List(v.label, {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}, edit__Index36, nil, {}, true, {
                                    onListChange = function(Index)
                                        edit__Index36 = Index
                                    end,
                                    onSelected = function()
                                        if edit_temp_verify2 then
                                            for y,z in pairs(edit_data_coffre_weapon) do
                                                if z.name == v.name then                                         
                                                    ESX.ShowNotification("Vous avez déjà ajouté cette arme, pour la modifier il suffit de revenir au menu précédent")
                                                    return
                                                end
                                            end
                                            table.insert(edit_data_coffre_weapon, {label = v.label, name = v.name, count = edit__Index36, munition = nil}) 
                                            ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x"..edit__Index36.." ~b~"..v.label)   
                                        else
                                            table.insert(edit_data_coffre_weapon, {label = v.label, name = v.name, count = edit__Index36, munition = nil}) 
                                            ESX.ShowNotification("Vous venez de sauvegarder l'ajout de ~y~x"..edit__Index36.." ~b~"..v.label)  
                                        end 
                                        edit_temp_verify2 = true 
                                    end
                                })
                            end
                        end
                    end
                end)
            Wait(0)
            end
        end)
    end
end

RegisterCommand("gangbuilder", function()
    ESX.TriggerServerCallback('pGangBuilder:getUserGroup', function(group)
        playergroup = group
        for _,v in pairs(pGangBuilder.AllowedGroup) do
            if v == playergroup then
                CheckAllowedGroup = true
            end            
        end
    end)
    for _,v in pairs(pGangBuilder.AllowedPermission) do
        if v == ESX.PlayerData.identifier then
            CheckAllowedPermission = true
        end            
    end
    Wait(200)
    if CheckAllowedPermission then
        OpenGangBuilder()
    elseif CheckAllowedGroup then
        OpenGangBuilder()
    else
        ESX.ShowNotification("Vous n'avez pas la permission pour exécuter cette commande")
    end
end)
