local Label = ""

local PosLabel,PosTP,PosTPHeading = "","",""

local BlipPreview,Blip,BlipName = false,false,""

local Marker,MarkerPreview = false,false

local _Index,_Index2,_Index3,_Index4,_Index5,_Index6,_Index7,_Index8,_Index9,_Index10,_Index11,_Index12,_Index13,_Index14,_Index15,_Index16,_Index17 = 1,1,1,1,10,1,1,19,19,19,11,11,11,1,1,1,256

local data_pos = {}
local ModifyPos = {value = nil, verify = false}

local data_job = {}
local ModifyJob = {value = nil, verify = false}

local data_user = {}
local ModifyUser = {value = nil, verify = false}

----------------------------------------
local edit_label = ""

local edit_PosLabel,edit_PosTP,edit_PosTPHeading = "","",""

local edit_BlipPreview,edit_Blip,edit_BlipName = false,false,""

local edit_Marker,edit_MarkerPreview = false,false

local edit__Index,edit__Index2,edit__Index3,edit__Index4,edit__Index5,edit__Index6,edit__Index7,edit__Index8,edit__Index9,edit__Index10,edit__Index11,edit__Index12,edit__Index13,edit__Index14,edit__Index15,edit__Index16,edit__Index17 = 1,1,1,1,10,1,1,19,19,19,11,11,11,1,1,1,256

local edit_data_pos = {}
local edit_ModifyPos = {value = nil, verify = false}

local edit_data_job = {}
local edit_ModifyJob = {value = nil, verify = false}

local edit_data_user = {}
local edit_ModifyUser = {value = nil, verify = false}
----------------------------------------
local theIndex = 1


function OpenAscenseurBuilder()
    local builder = false 

    local _Items2 = {}
    for i = 1, 826, 1 do
        _Items2[i] = i
    end

    local _Items3 = {}
    for i = 1, 85, 1 do
        _Items3[i] = i
    end

    local _Items4 = {}
    for i = 1, 43, 1 do
        _Items4[i] = i
    end

    local _Items5 = {}
    for i = -180.0, 180.0, 10 do
        table.insert(_Items5, i)
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
    for i = 0.0, 2.0, 0.1 do
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
    for i = 0, 255, 1 do
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

    local edit__Items2 = {}
    for i = 1, 826, 1 do
        edit__Items2[i] = i
    end

    local edit__Items3 = {}
    for i = 1, 85, 1 do
        edit__Items3[i] = i
    end

    local edit__Items4 = {}
    for i = 1, 43, 1 do
        edit__Items4[i] = i
    end

    local edit__Items5 = {}
    for i = -180.0, 180.0, 10 do
        table.insert(edit__Items5, i)
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
    for i = 0.0, 2.0, 0.1 do
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
    for i = 0, 255, 1 do
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

    MarkerType = pAscenseurBuilder.DefaultMarker.MarkerType
    MarkerrotX = pAscenseurBuilder.DefaultMarker.MarkerrotX
    MarkerrotY = pAscenseurBuilder.DefaultMarker.MarkerrotY
    MarkerrotZ = pAscenseurBuilder.DefaultMarker.MarkerrotZ
    MarkerscaleX = pAscenseurBuilder.DefaultMarker.MarkerscaleX
    MarkerscaleY = pAscenseurBuilder.DefaultMarker.MarkerscaleY
    MarkerscaleZ = pAscenseurBuilder.DefaultMarker.MarkerscaleZ
    MarkerR = pAscenseurBuilder.DefaultMarker.MarkerR
    MarkerV = pAscenseurBuilder.DefaultMarker.MarkerV
    MarkerB = pAscenseurBuilder.DefaultMarker.MarkerB
    MarkerO = pAscenseurBuilder.DefaultMarker.MarkerO

    _Index7 = MarkerType
    _Index8 = getMarkerItems(MarkerrotX, _Items5)
    _Index9 = getMarkerItems(MarkerrotY, _Items6)
    _Index10 = getMarkerItems(MarkerrotZ, _Items7)
    _Index11 = getMarkerItems(MarkerscaleX, _Items8)
    _Index12 = getMarkerItems(MarkerscaleY, _Items9)
    _Index13 = getMarkerItems(MarkerscaleZ, _Items10)
    _Index14 = MarkerR + 1
    _Index15 = MarkerV + 1
    _Index16 = MarkerB + 1
    _Index17 = MarkerO + 1

    local mainMenu = RageUI.CreateMenu("Ascenseur Builder", "Menu")
    local mainMenu2 = RageUI.CreateSubMenu(mainMenu, "Création d'Ascenseur", "Menu")
    local mainMenu3 = RageUI.CreateSubMenu(mainMenu, "Gestion des Ascenseurs", "Menu")

    local subMenu3 = RageUI.CreateSubMenu(mainMenu2, "Gestion des positions", "Menu")
    local subMenu = RageUI.CreateSubMenu(mainMenu2, "Gestion des jobs", "Menu")
    local subMenu2 = RageUI.CreateSubMenu(mainMenu2, "Gestion des utilisateurs", "Menu")
    local subMenu5 = RageUI.CreateSubMenu(mainMenu2, "Gestion des blips", "Menu")
    local subMenu6 = RageUI.CreateSubMenu(mainMenu2, "Gestion des markers", "Menu")

    local subMenu4 = RageUI.CreateSubMenu(subMenu3, "Ajouter une position", "Menu")
    local subMenu7 = RageUI.CreateSubMenu(subMenu, "Ajouter un job", "Menu")
    local subMenu8 = RageUI.CreateSubMenu(subMenu2, "Ajouter un utilisateur", "Menu")

    local subMenu9 = RageUI.CreateSubMenu(mainMenu3, "Modification de l'ascenceur", "Menu")

    local edit_subMenu3 = RageUI.CreateSubMenu(subMenu9, "Gestion des positions", "Menu")
    local edit_subMenu = RageUI.CreateSubMenu(subMenu9, "Gestion des jobs", "Menu")
    local edit_subMenu2 = RageUI.CreateSubMenu(subMenu9, "Gestion des utilisateurs", "Menu")
    local edit_subMenu5 = RageUI.CreateSubMenu(subMenu9, "Gestion des blips", "Menu")
    local edit_subMenu6 = RageUI.CreateSubMenu(subMenu9, "Gestion des markers", "Menu")

    local edit_subMenu4 = RageUI.CreateSubMenu(edit_subMenu3, "Ajouter une position", "Menu")
    local edit_subMenu7 = RageUI.CreateSubMenu(edit_subMenu, "Ajouter un job", "Menu")
    local edit_subMenu8 = RageUI.CreateSubMenu(edit_subMenu2, "Ajouter un utilisateur", "Menu")
    mainMenu.Closed = function()
        builder = false
        RemoveBlip(_blip)
    end
    subMenu9.Closed = function()
        edit_label = ""
        edit_PosLabel,edit_PosTP,edit_PosTPHeading = "","",""
        edit_BlipPreview,edit_Blip,edit_BlipName = false,false,""
        edit_Marker,edit_MarkerPreview = false,false
        edit__Index,edit__Index2,edit__Index3,edit__Index4,edit__Index5,edit__Index6,edit__Index7,edit__Index8,edit__Index9,edit__Index10,edit__Index11,edit__Index12,edit__Index13,edit__Index14,edit__Index15,edit__Index16,edit__Index17 = 1,1,1,1,10,1,1,19,19,19,11,11,11,1,1,1,256
        edit_data_pos = {}
        edit_ModifyPos = {value = nil, verify = false}
        edit_data_job = {}
        edit_ModifyJob = {value = nil, verify = false}
        edit_data_user = {}
        edit_ModifyUser = {value = nil, verify = false}
        RemoveBlip(edit__blip)
    end
    subMenu3:AddInstructionButton({[1] = GetControlInstructionalButton(0, 11, 0), [2] = "Descendre"})
    subMenu3:AddInstructionButton({[1] = GetControlInstructionalButton(0, 10, 0), [2] = "Monter"})
    subMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 11, 0), [2] = "Descendre"})
    subMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 10, 0), [2] = "Monter"})
    subMenu2:AddInstructionButton({[1] = GetControlInstructionalButton(0, 11, 0), [2] = "Descendre"})
    subMenu2:AddInstructionButton({[1] = GetControlInstructionalButton(0, 10, 0), [2] = "Monter"})

    edit_subMenu3:AddInstructionButton({[1] = GetControlInstructionalButton(0, 11, 0), [2] = "Descendre"})
    edit_subMenu3:AddInstructionButton({[1] = GetControlInstructionalButton(0, 10, 0), [2] = "Monter"})
    edit_subMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 11, 0), [2] = "Descendre"})
    edit_subMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 10, 0), [2] = "Monter"})
    edit_subMenu2:AddInstructionButton({[1] = GetControlInstructionalButton(0, 11, 0), [2] = "Descendre"})
    edit_subMenu2:AddInstructionButton({[1] = GetControlInstructionalButton(0, 10, 0), [2] = "Monter"})
    if not builder then builder = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
		    while builder do 
                RageUI.IsVisible(mainMenu,function()         
                    RageUI.Button("Créer un ascenseur", nil, {RightLabel = "→"}, true, {}, mainMenu2) 
                    RageUI.Button("Gérer les ascenseurs", nil, {RightLabel = "→"}, true, {}, mainMenu3) 
                end)   
                RageUI.IsVisible(mainMenu2,function()
                    mainMenu2:UpdateInstructionalButtons(true)    
                    RageUI.Button("Label", nil, {RightLabel = "~b~"..Label.." ~s~→"}, true, {
                        onSelected = function()
                            Label = KeyboardInput("Donner un label à votre ascenseur", nil, 50)
                            if Label == nil or Label == "" then
                                Label = ""
                                ESX.ShowNotification("Vous devez rentrer un label valide")
                            else                       
                                ESX.ShowNotification("Vous avez mis un label sur votre ascenseur ~b~"..Label)
                            end
                        end
                    })
                    RageUI.Separator("↓ Gestion ↓")
                    RageUI.Button("Position", nil, {RightLabel = "→"}, true, {}, subMenu3)
                    RageUI.Button("Jobs", nil, {RightLabel = "→"}, true, {}, subMenu)
                    RageUI.Button("Utilisateurs", nil, {RightLabel = "→"}, true, {}, subMenu2)
                    RageUI.Button("Blips", nil, {RightLabel = "→"}, true, {}, subMenu5)
                    RageUI.Button("Markers", nil, {RightLabel = "→"}, true, {}, subMenu6)
                    RageUI.Line()
                    RageUI.Button("Valider", nil, pAscenseurBuilder.RightLabel, true, {
                        onSelected = function()
                            confirmation = KeyboardInput("Entrez : CONFIRMER", nil, 9)
                            if confirmation == "CONFIRMER" then
                                TriggerServerEvent("pAscenseurBuilder:createAscenseur", Label, data_pos, data_job, data_user, {name = BlipName, sprite = BlipSprite, scale = BlipScale, color = BlipColor}, {types = MarkerType, rotX = MarkerrotX, rotY = MarkerrotY, rotZ = MarkerrotZ, scaleX = MarkerscaleX, scaleY = MarkerscaleY, scaleZ = MarkerscaleZ, colorR = MarkerR, colorV = MarkerV, colorB = MarkerB, colorO = MarkerO})                         
                                Label = ""
                                PosLabel,PosTP,PosTPHeading = "","",""
                                BlipPreview,Blip,BlipName = false,false,""
                                Marker,MarkerPreview = false,false
                                _Index,_Index2,_Index3,_Index4,_Index5,_Index6,_Index7,_Index8,_Index9,_Index10,_Index11,_Index12,_Index13,_Index14,_Index15,_Index16,_Index17 = 1,1,1,1,10,1,1,19,19,19,11,11,11,1,1,1,256
                                data_pos = {}
                                ModifyPos = {value = nil, verify = false}
                                data_job = {}
                                ModifyJob = {value = nil, verify = false}
                                data_user = {}
                                ModifyUser = {value = nil, verify = false}
                                RemoveBlip(_blip)
                                Wait(200) 
                                getDataAscenseur()
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
                    for k,v in pairs(getData.Ascenseur) do
                        RageUI.List(v.label, {"Modifier", "Supprimer"}, theIndex, nil, {}, true, {
                            onListChange = function(Index)
                                theIndex = Index
                            end,
                            onSelected = function()
                                if theIndex == 1 then
                                    edit_id = v.id                        
                                    edit_label = v.label
                                    for k,y in pairs(v.teleport_data) do 
                                        table.insert(edit_data_pos, {label = y.label, coords = y.coords})
                                    end
                                    for k,y in pairs(v.job_data) do
                                        table.insert(edit_data_job, {name = y.name, label = y.label})
                                    end
                                    for k,y in pairs(v.user_data) do
                                        table.insert(edit_data_user, {identifier = y.identifier, firstname = y.firstname, lastname = y.lastname})
                                    end
                                    if v.blips_data.name ~= "" then
                                        edit_Blip = true
                                        edit_BlipName = v.blips_data.name
                                        edit__Index4 = v.blips_data.sprite
                                        edit__Index5 = v.blips_data.scale * 10
                                        edit__Index6 = v.blips_data.color

                                        edit_BlipSprite = edit__Items2[edit__Index4]
                                        edit_BlipScale = edit__Index5 / 10
                                        edit_BlipColor = edit__Items3[edit__Index6] 
                                    end                          
                                    edit__Index7 = v.markers_data.types
                                    edit__Index8 = getMarkerItems(v.markers_data.rotX, _Items5)
                                    edit__Index9 = getMarkerItems(v.markers_data.rotY, _Items6)
                                    edit__Index10 = getMarkerItems(v.markers_data.rotZ, _Items7)
                                    edit__Index11 = getMarkerItems(v.markers_data.scaleX, _Items8)
                                    edit__Index12 = getMarkerItems(v.markers_data.scaleY, _Items9)
                                    edit__Index13 = getMarkerItems(v.markers_data.scaleZ, _Items10)
                                    edit__Index14 = v.markers_data.colorR + 1
                                    edit__Index15 = v.markers_data.colorV + 1
                                    edit__Index16 = v.markers_data.colorB + 1
                                    edit__Index17 = v.markers_data.colorO + 1

                                    edit_MarkerType = edit__Items4[edit__Index7]
                                    edit_MarkerrotX = edit__Items5[edit__Index8]
                                    edit_MarkerrotY = edit__Items6[edit__Index9]
                                    edit_MarkerrotZ = edit__Items7[edit__Index10]
                                    edit_MarkerscaleX = edit__Items8[edit__Index11]
                                    edit_MarkerscaleY = edit__Items9[edit__Index12]
                                    edit_MarkerscaleZ = edit__Items10[edit__Index13]
                                    edit_MarkerR = edit__Items11[edit__Index14]
                                    edit_MarkerV = edit__Items12[edit__Index15]
                                    edit_MarkerB = edit__Items13[edit__Index16]
                                    edit_MarkerO = edit__Items14[edit__Index17]
                                    Wait(100)
                                    RageUI.Visible(subMenu9, true)
                                elseif theIndex == 2 then
                                    TriggerServerEvent("pAscenseurBuilder:deleteAscenseur", v.id)
                                    Wait(200)
                                    getDataAscenseur()
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
                    RageUI.Button("Ajouter un job", nil, {RightLabel = "→"}, true, {}, subMenu7) 
                    RageUI.Separator("↓ Liste des Jobs ↓")
                    if #data_job == 0 then
                        RageUI.Separator("Aucun job présent") 
                    end
                    for k,v in pairs(data_job) do
                        RageUI.List(v.label, {"Modifier", "Supprimer"}, _Index, nil, {}, true, {
                            onActive = function()
                                if k ~= GetkTable(data_job) then
                                    if IsControlJustPressed(0, 11) then
                                        table.remove(data_job, k)
                                        table.insert(data_job, k+1, {name = v.name, label = v.label})
                                    end
                                end
                                if k ~= 1 then
                                    if IsControlJustPressed(0, 10) then
                                        table.remove(data_job, k)
                                        table.insert(data_job, k-1, {name = v.name, label = v.label})
                                    end 
                                end
                            end, 
                            onListChange = function(Index)
                                _Index = Index
                            end,
                            onSelected = function()
                                if _Index == 1 then
                                    ModifyJob = {value = k, verify = true}
                                    Wait(100)
                                    RageUI.Visible(subMenu7, true)
                                elseif _Index == 2 then
                                    table.remove(data_job, k)
                                end
                            end
                        })
                    end
                end)
                RageUI.IsVisible(subMenu2,function()   
                    subMenu2:UpdateInstructionalButtons(true)                       
                    RageUI.Button("Ajouter un utilisateur", nil, {RightLabel = "→"}, true, {}, subMenu8) 
                    RageUI.Separator("↓ Liste des Utilisateurs ↓")
                    if #data_user == 0 then
                        RageUI.Separator("Aucun utilisateur présent") 
                    end
                    for k,v in pairs(data_user) do
                        RageUI.List(v.firstname.." "..v.lastname, {"Modifier", "Supprimer"}, _Index2, nil, {}, true, {
                            onActive = function()
                                if k ~= GetkTable(data_user) then
                                    if IsControlJustPressed(0, 11) then
                                        table.remove(data_user, k)
                                        table.insert(data_user, k+1, {identifier = v.identifier, firstname = v.firstname, lastname = v.lastname})
                                    end
                                end
                                if k ~= 1 then
                                    if IsControlJustPressed(0, 10) then
                                        table.remove(data_user, k)
                                        table.insert(data_user, k-1, {identifier = v.identifier, firstname = v.firstname, lastname = v.lastname})
                                    end 
                                end
                            end, 
                            onListChange = function(Index)
                                _Index2 = Index
                            end,
                            onSelected = function()
                                if _Index2 == 1 then
                                    ModifyUser = {value = k, verify = true}
                                    Wait(100)
                                    RageUI.Visible(subMenu8, true)
                                elseif _Index2 == 2 then
                                    table.remove(data_user, k)
                                end
                            end
                        })
                    end
                end)
                RageUI.IsVisible(subMenu3,function()       
                    subMenu3:UpdateInstructionalButtons(true)                
                    RageUI.Button("Ajouter une position", nil, {RightLabel = "→"}, true, {}, subMenu4) 
                    RageUI.Separator("↓ Liste des Positions ↓")
                    if #data_pos == 0 then
                        RageUI.Separator("Aucune position présente") 
                    end
                    for k,v in pairs(data_pos) do
                        RageUI.List(v.label, {"Modifier", "Se Téléporter", "Supprimer"}, _Index3, nil, {}, true, {
                            onActive = function()
                                if k ~= GetkTable(data_pos) then
                                    if IsControlJustPressed(0, 11) then
                                        table.remove(data_pos, k)
                                        table.insert(data_pos, k+1, {label = v.label, coords = {x = v.coords.x, y = v.coords.y, z = v.coords.z, w = v.coords.w}})
                                    end
                                end
                                if k ~= 1 then
                                    if IsControlJustPressed(0, 10) then
                                        table.remove(data_pos, k)
                                        table.insert(data_pos, k-1, {label = v.label, coords = {x = v.coords.x, y = v.coords.y, z = v.coords.z, w = v.coords.w}})
                                    end 
                                end
                            end,                         
                            onListChange = function(Index)
                                _Index3 = Index
                            end,
                            onSelected = function()
                                if _Index3 == 1 then
                                    ModifyPos = {value = k, verify = true}
                                    actualymodify = true
                                    PosLabel = v.label
                                    PosTP = v.coords
                                    PosTPHeading = v.coords.w
                                    Wait(100)
                                    RageUI.Visible(subMenu4, true)
                                elseif _Index3 == 2 then
                                    SetEntityCoords(GetPlayerPed(-1), v.coords.x, v.coords.y, v.coords.z, 0.0, 0.0, 0.0, true)
                                    SetEntityHeading(GetPlayerPed(-1), v.coords.w)
                                elseif _Index3 == 3 then
                                    table.remove(data_pos, k)
                                end
                            end
                        })
                    end
                end)
                RageUI.IsVisible(subMenu5,function()
                    RageUI.Checkbox("Ajouter un blip", nil, Blip, {}, {
                        onChecked = function()
                            Blip = true
                            if BlipPreview == true then        
                                RemoveBlip(_blip) 
                                _PreviewBlip(BlipName, Blip) 
                            end 
                            ESX.ShowNotification("Vous avez ~g~ajouté~s~ le blip à l'ascenseur ~b~"..Label)                        
                        end,
                        onUnChecked = function()
                            Blip = false
                            if BlipPreview == true then        
                                RemoveBlip(_blip)
                                _PreviewBlip(BlipName, Blip) 
                            end 
                            ESX.ShowNotification("Vous avez ~r~retiré~s~ le blip à l'ascenseur ~b~"..Label)                
                        end
                    })
                    if Blip then
                        RageUI.Line()
                        RageUI.Checkbox("Prévisualiser le blip", nil, BlipPreview, {}, {
                            onChecked = function()
                                BlipPreview = true      
                                BlipSprite = _Items2[_Index4]
                                BlipScale = _Index5 / 10
                                BlipColor = _Items3[_Index6]       
                                _PreviewBlip(BlipName, Blip) 
                                ESX.ShowNotification("Prévisualisation ~g~activée~s~")       
                            end,
                            onUnChecked = function()   
                                BlipPreview = false
                                RemoveBlip(_blip) 
                                ESX.ShowNotification("Prévisualisation ~r~désactivée~s~")           
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
                                        _PreviewBlip(BlipName, Blip) 
                                    end                
                                    ESX.ShowNotification("Vous avez nommé votre blip ~b~"..BlipName)
                                end
                            end
                        })
                        RageUI.List("Type", _Items2, _Index4, nil, {}, true, {
                            onListChange = function(Index)
                                _Index4 = Index
                                if BlipPreview == true then        
                                    RemoveBlip(_blip)
                                    _PreviewBlip(BlipName, Blip) 
                                end
                            end,
                            onActive = function()
                                BlipSprite = _Index4
                            end,
                            onSelected = function()
                                BlipSprite = KeyboardInput("Donner un type à votre blip (0 - 826)", nil, 3)
                                if BlipSprite == nil or BlipSprite == "" or not tonumber(BlipSprite) then
                                    BlipSprite = ""
                                    ESX.ShowNotification("Vous devez rentrer un type valide")
                                else
                                    _Index4 = tonumber(BlipSprite)   
                                    BlipSprite = _Index4
                                    if BlipPreview == true then        
                                        RemoveBlip(_blip)
                                        _PreviewBlip(BlipName, Blip) 
                                    end 
                                    ESX.ShowNotification("Vous venez de sauvegarder le type du blip qui est de ~b~"..BlipSprite)          
                                end
                            end
                        })
                        RageUI.List("Taille", {0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0,1.1,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,2.0}, _Index5, nil, {}, true, {
                            onListChange = function(Index)
                                _Index5 = Index
                                if BlipPreview == true then        
                                    RemoveBlip(_blip)
                                    _PreviewBlip(BlipName, Blip) 
                                end
                            end,
                            onActive = function()
                                BlipScale = _Index5 / 10
                            end,
                            onSelected = function()
                                BlipScale = KeyboardInput("Donner une taille à votre blip (0.1 - 2.0)", nil, 3)
                                if BlipScale == nil or BlipScale == "" or not tonumber(BlipScale) then
                                    BlipScale = ""
                                    ESX.ShowNotification("Vous devez rentrer une taille valide")
                                else       
                                    _Index5 = tonumber(BlipScale) * 10
                                    BlipScale = tonumber(BlipScale) * 1.0
                                    if BlipPreview == true then        
                                        RemoveBlip(_blip) 
                                        _PreviewBlip(BlipName, Blip) 
                                    end 
                                    ESX.ShowNotification("Vous venez de sauvegarder la taille du blip qui est de ~b~"..BlipScale)           
                                end
                            end
                        })
                        RageUI.List("Couleur", _Items3, _Index6, nil, {}, true, {
                            onListChange = function(Index)
                                _Index6 = Index
                                if BlipPreview == true then        
                                    RemoveBlip(_blip)
                                    _PreviewBlip(BlipName, Blip) 
                                end
                            end,
                            onActive = function()
                                BlipColor = _Index6
                            end,
                            onSelected = function()
                                BlipColor = KeyboardInput("Donner une couleur à votre blip (0 - 85)", nil, 2)
                                if BlipColor == nil or BlipColor == "" or not tonumber(BlipColor) then
                                    BlipColor = ""
                                    ESX.ShowNotification("Vous devez rentrer une couleur valide")
                                else   
                                    _Index6 = tonumber(BlipColor)  
                                    BlipColor = _Index6  
                                    if BlipPreview == true then        
                                        RemoveBlip(_blip)
                                        _PreviewBlip(BlipName, Blip) 
                                    end 
                                    ESX.ShowNotification("Vous venez de sauvegarder la couleur du blip qui est de ~b~"..BlipColor)               
                                end
                            end
                        })                       
                    end
                end)
                RageUI.IsVisible(subMenu6,function()
                    if MarkerPreview then
                        DrawMarker(MarkerType, GetEntityCoords(PlayerPedId()).x, GetEntityCoords(PlayerPedId()).y, GetEntityCoords(PlayerPedId()).z-1, 0.0, 0.0, 0.0, MarkerrotX, MarkerrotY, MarkerrotZ, MarkerscaleX, MarkerscaleY, MarkerscaleZ, MarkerR, MarkerV, MarkerB, MarkerO, false, false, p19, false) 
                    end
                    RageUI.Checkbox("Ajouter un marker", nil, Marker, {}, {
                        onChecked = function()
                            Marker = true
                            ESX.ShowNotification("Vous avez ~g~ajouté~s~ le marker à l'ascenseur ~b~"..Label)                        
                        end,
                        onUnChecked = function()
                            Marker = false
                            ESX.ShowNotification("Vous avez ~r~retiré~s~ le marker à l'ascenseur ~b~"..Label)                
                        end
                    })
                    if Marker then
                        RageUI.Line()
                        RageUI.Checkbox("Prévisualiser le marker", nil, MarkerPreview, {}, {
                            onChecked = function()
                                MarkerPreview = true
                                MarkerType = _Items4[_Index7]
                                MarkerrotX = _Items5[_Index8]
                                MarkerrotY = _Items6[_Index9]
                                MarkerrotZ = _Items7[_Index10]
                                MarkerscaleX = _Items8[_Index11]
                                MarkerscaleY = _Items9[_Index12]
                                MarkerscaleZ = _Items10[_Index13]
                                MarkerR = _Items11[_Index14]
                                MarkerV = _Items12[_Index15]
                                MarkerB = _Items13[_Index16]
                                MarkerO = _Items14[_Index17]          
                                ESX.ShowNotification("Prévisualisation ~g~activée~s~")       
                            end,
                            onUnChecked = function()   
                                MarkerPreview = false
                                ESX.ShowNotification("Prévisualisation ~r~désactivée~s~")           
                            end
                        })
                        RageUI.List("Type", _Items4, _Index7, nil, {}, true, {
                            onListChange = function(Index)
                                _Index7 = Index
                            end,
                            onActive = function()
                                MarkerType = _Index7
                            end
                        })
                        RageUI.List("Rotation X", _Items5, _Index8, nil, {}, true, {
                            onListChange = function(Index)
                                _Index8 = Index
                            end,
                            onActive = function()
                                MarkerrotX = _Items5[_Index8]
                            end,
                            onSelected = function()
                                MarkerrotX = KeyboardInput("Donner une rotation x à votre marker (-180.0 - 180.0)", nil, 5)
                                if MarkerrotX == nil or MarkerrotX == "" or not tonumber(MarkerrotX) then
                                    MarkerrotX = ""
                                    ESX.ShowNotification("Vous devez rentrer une rotation valide")
                                else      
                                    for k,v in pairs(_Items5) do
                                        if v == tonumber(MarkerrotX) then
                                            _Index8 = k
                                        end
                                    end 
                                    ESX.ShowNotification("Vous venez de sauvegarder la rotation x du marker qui est de ~b~"..MarkerrotX)          
                                end
                            end
                        })
                        RageUI.List("Rotation Y", _Items6, _Index9, nil, {}, true, {
                            onListChange = function(Index)
                                _Index9 = Index
                            end,
                            onActive = function()
                                MarkerrotY = _Items6[_Index9]
                            end,
                            onSelected = function()
                                MarkerrotY = KeyboardInput("Donner une rotation y à votre marker (-180.0 - 180.0)", nil, 5)
                                if MarkerrotY == nil or MarkerrotY == "" or not tonumber(MarkerrotY) then
                                    MarkerrotY = ""
                                    ESX.ShowNotification("Vous devez rentrer une rotation valide")
                                else       
                                    for k,v in pairs(_Items6) do
                                        if v == tonumber(MarkerrotY) then
                                            _Index9 = k
                                        end
                                    end
                                    ESX.ShowNotification("Vous venez de sauvegarder la rotation y du marker qui est de ~b~"..MarkerrotY)          
                                end
                            end
                        })
                        RageUI.List("Rotation Z", _Items7, _Index10, nil, {}, true, {
                            onListChange = function(Index)
                                _Index10 = Index
                            end,
                            onActive = function()
                                MarkerrotZ = _Items7[_Index10]
                            end,
                            onSelected = function()
                                MarkerrotZ = KeyboardInput("Donner une rotation z à votre marker (-180.0 - 180.0)", nil, 5)
                                if MarkerrotZ == nil or MarkerrotZ == "" or not tonumber(MarkerrotZ) then
                                    MarkerrotZ = ""
                                    ESX.ShowNotification("Vous devez rentrer une rotation valide")
                                else       
                                    for k,v in pairs(_Items7) do
                                        if v == tonumber(MarkerrotZ) then
                                            _Index10 = k
                                        end
                                    end
                                    ESX.ShowNotification("Vous venez de sauvegarder la rotation z du marker qui est de ~b~"..MarkerrotZ)          
                                end
                            end
                        })
                        RageUI.List("Taille X", _Items8, _Index11, nil, {}, true, {
                            onListChange = function(Index)
                                _Index11 = Index
                            end,
                            onActive = function()
                                MarkerscaleX = _Items8[_Index11]
                            end,
                            onSelected = function()
                                MarkerscaleX = KeyboardInput("Donner une taille x à votre marker (0.0 - 2.0)", nil, 5)
                                if MarkerscaleX == nil or MarkerscaleX == "" or not tonumber(MarkerscaleX) then
                                    MarkerscaleX = ""
                                    ESX.ShowNotification("Vous devez rentrer une taille valide")
                                else       
                                    for k,v in pairs(_Items8) do
                                        if v == tonumber(MarkerscaleX) then
                                            _Index11 = k
                                        end
                                    end 
                                    ESX.ShowNotification("Vous venez de sauvegarder la taille x du marker qui est de ~b~"..MarkerscaleX)          
                                end
                            end
                        })
                        RageUI.List("Taille Y", _Items9, _Index12, nil, {}, true, {
                            onListChange = function(Index)
                                _Index12 = Index
                            end,
                            onActive = function()
                                MarkerscaleY = _Items9[_Index12]
                            end,
                            onSelected = function()
                                MarkerscaleY = KeyboardInput("Donner une taille y à votre marker (0.0 - 2.0)", nil, 5)
                                if MarkerscaleY == nil or MarkerscaleY == "" or not tonumber(MarkerscaleY) then
                                    MarkerscaleY = ""
                                    ESX.ShowNotification("Vous devez rentrer une taille valide")
                                else       
                                    for k,v in pairs(_Items9) do
                                        if v == tonumber(MarkerscaleY) then
                                            _Index12 = k
                                        end
                                    end 
                                    ESX.ShowNotification("Vous venez de sauvegarder la taille y du marker qui est de ~b~"..MarkerscaleY)          
                                end
                            end
                        })
                        RageUI.List("Taille Z", _Items10, _Index13, nil, {}, true, {
                            onListChange = function(Index)
                                _Index13 = Index
                            end,
                            onActive = function()
                                MarkerscaleZ = _Items10[_Index13]
                            end,
                            onSelected = function()
                                MarkerscaleZ = KeyboardInput("Donner une taille z à votre marker (0.0 - 2.0)", nil, 5)
                                if MarkerscaleZ == nil or MarkerscaleZ == "" or not tonumber(MarkerscaleZ) then
                                    MarkerscaleZ = ""
                                    ESX.ShowNotification("Vous devez rentrer une taille valide")
                                else        
                                    for k,v in pairs(_Items10) do
                                        if v == tonumber(MarkerscaleZ) then
                                            _Index13 = k
                                        end
                                    end 
                                    ESX.ShowNotification("Vous venez de sauvegarder la taille z du marker qui est de ~b~"..MarkerscaleZ)          
                                end
                            end
                        })
                        RageUI.List("R", _Items11, _Index14, nil, {}, true, {
                            onListChange = function(Index)
                                _Index14 = Index
                            end,
                            onActive = function()
                                MarkerR = _Items11[_Index14]
                            end,
                            onSelected = function()
                                MarkerR = KeyboardInput("Donner une couleur rouge à votre marker (0 - 255)", nil, 5)
                                if MarkerR == nil or MarkerR == "" or not tonumber(MarkerR) then
                                    MarkerR = ""
                                    ESX.ShowNotification("Vous devez rentrer une couleur rouge valide")
                                else   
                                    for k,v in pairs(_Items11) do
                                        if v == tonumber(MarkerR) then
                                            _Index14 = k
                                        end
                                    end        
                                    ESX.ShowNotification("Vous venez de sauvegarder la couleur rouge du marker qui est de ~b~"..MarkerR)          
                                end
                            end
                        })
                        RageUI.List("V", _Items12, _Index15, nil, {}, true, {
                            onListChange = function(Index)
                                _Index15 = Index
                            end,
                            onActive = function()
                                MarkerV = _Items12[_Index15]
                            end,
                            onSelected = function()
                                MarkerV = KeyboardInput("Donner une couleur verte à votre marker (0 - 255)", nil, 5)
                                if MarkerV == nil or MarkerV == "" or not tonumber(MarkerV) then
                                    MarkerV = ""
                                    ESX.ShowNotification("Vous devez rentrer une couleur verte valide")
                                else       
                                    for k,v in pairs(_Items12) do
                                        if v == tonumber(MarkerV) then
                                            _Index15 = k
                                        end
                                    end     
                                    ESX.ShowNotification("Vous venez de sauvegarder la couleur vert du marker qui est de ~b~"..MarkerV)          
                                end
                            end
                        })
                        RageUI.List("B", _Items13, _Index16, nil, {}, true, {
                            onListChange = function(Index)
                                _Index16 = Index
                            end,
                            onActive = function()
                                MarkerB = _Items13[_Index16]
                            end,
                            onSelected = function()
                                MarkerB = KeyboardInput("Donner une couleur bleu à votre marker (0 - 255)", nil, 5)
                                if MarkerB == nil or MarkerB == "" or not tonumber(MarkerB) then
                                    MarkerB = ""
                                    ESX.ShowNotification("Vous devez rentrer une couleur bleu valide")
                                else      
                                    for k,v in pairs(_Items13) do
                                        if v == tonumber(MarkerB) then
                                            _Index16 = k
                                        end
                                    end      
                                    ESX.ShowNotification("Vous venez de sauvegarder la couleur bleu du marker qui est de ~b~"..MarkerB)          
                                end
                            end
                        })
                        RageUI.List("O", _Items14, _Index17, nil, {}, true, {
                            onListChange = function(Index)
                                _Index17 = Index
                            end,
                            onActive = function()
                                MarkerO = _Items14[_Index17]
                            end,
                            onSelected = function()
                                MarkerO = KeyboardInput("Donner une opacité à votre marker (0 - 255)", nil, 5)
                                if MarkerO == nil or MarkerO == "" or not tonumber(MarkerO) then
                                    MarkerO = ""
                                    ESX.ShowNotification("Vous devez rentrer une opacité valide")
                                else
                                    for k,v in pairs(_Items14) do
                                        if v == tonumber(MarkerO) then
                                            _Index17 = k
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
                    RageUI.Button("Aucun pour le moment", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            data_job = {}
                            ModifyJob = {value = nil, verify = false}
                            RageUI.GoBack() 
                        end
                    }) 
                    RageUI.Line()
                    for _,v in pairs(getData.Jobs) do
                        RageUI.Button(v.label, nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                if ModifyJob.verify == true then
                                    table.remove(data_job, ModifyJob.value)
                                    table.insert(data_job, ModifyJob.value, {name = v.name, label = v.label})
                                    ModifyJob = {value = nil, verify = false}
                                    RageUI.GoBack()
                                else  
                                    table.insert(data_job, {name = v.name, label = v.label})
                                    ModifyJob = {value = nil, verify = false}
                                    RageUI.GoBack() 
                                end
                            end
                        }) 
                    end
                end)
                RageUI.IsVisible(subMenu8,function()
                    subMenu8:UpdateInstructionalButtons(true)    
                    RageUI.Button("Aucun pour le moment", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            data_user = {}
                            ModifyUser = {value = nil, verify = false}
                            RageUI.GoBack()
                        end
                    }) 
                    RageUI.Line()
                    for _,v in pairs(getData.Users) do
                        RageUI.Button(v.firstname.." "..v.lastname, nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                if ModifyUser.verify == true then
                                    table.remove(data_user, ModifyUser.value)
                                    table.insert(data_user, ModifyUser.value, {identifier = v.identifier, firstname = v.firstname, lastname = v.lastname})
                                    ModifyUser = {value = nil, verify = false}
                                    RageUI.GoBack()
                                else
                                    table.insert(data_user, {identifier = v.identifier, firstname = v.firstname, lastname = v.lastname})
                                    ModifyUser = {value = nil, verify = false}
                                    RageUI.GoBack() 
                                end
                            end
                        }) 
                    end
                end)
                RageUI.IsVisible(subMenu4,function()
                    subMenu4:UpdateInstructionalButtons(true)    
                    RageUI.Button("Label", nil, {RightLabel = "~b~"..PosLabel.." ~s~→"}, true, {
                        onSelected = function()
                            PosLabel = KeyboardInput("Donner un nom à votre position", nil, 50)
                            if PosLabel == nil or PosLabel == "" then
                                PosLabel = ""
                                ESX.ShowNotification("Vous devez rentrer un nom valide")
                            else                       
                                ESX.ShowNotification("Vous avez nommé votre position ~b~"..PosLabel)
                            end
                        end
                    })
                    if actualymodify then
                        RageUI.Button("Position de téléportation", nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                PosTP = GetEntityCoords(PlayerPedId())
                                ESX.ShowNotification("Vous venez de sauvegarder la ~b~position de téléportation")
                                actualymodify = false
                            end
                        })
                    else
                        RageUI.Button("Position de téléportation", "~b~"..PosTP, {RightLabel = "→"}, true, {
                            onSelected = function()
                                PosTP = GetEntityCoords(PlayerPedId())
                                ESX.ShowNotification("Vous venez de sauvegarder la ~b~position de téléportation")
                            end
                        }) 
                    end
                    RageUI.Button("Direction de téléportation", "~b~"..PosTPHeading, {RightLabel = "→"}, true, {
                        onSelected = function()
                            PosTPHeading = GetEntityHeading(PlayerPedId())
                            ESX.ShowNotification("Vous venez de sauvegarder la ~b~direction de téléportation")
                        end
                    }) 
                    RageUI.Button("Valider", nil, pAscenseurBuilder.RightLabel, true, {
                        onSelected = function()
                            if ModifyPos.verify == true then
                                table.remove(data_pos, ModifyPos.value)
                                table.insert(data_pos, ModifyPos.value, {label = PosLabel, coords = {x = PosTP.x, y = PosTP.y, z = PosTP.z, w = PosTPHeading}})
                                ModifyPos = {value = nil, verify = false}
                                PosLabel,PosTP,PosTPHeading = "","",""
                                RageUI.GoBack()
                            else
                                table.insert(data_pos, {label = PosLabel, coords = {x = PosTP.x, y = PosTP.y, z = PosTP.z, w = PosTPHeading}})
                                ModifyPos = {value = nil, verify = false}
                                PosLabel,PosTP,PosTPHeading = "","",""
                                RageUI.GoBack() 
                            end
                            actualymodify = false
                        end
                    }) 
                end)
                RageUI.IsVisible(subMenu9,function()
                    subMenu9:UpdateInstructionalButtons(true)  
                    RageUI.Button("Label", nil, {RightLabel = "~b~"..edit_label.." ~s~→"}, true, {
                        onSelected = function()
                            edit_label = KeyboardInput("Donner un label à votre ascenseur", nil, 50)
                            if edit_label == nil or edit_label == "" then
                                edit_label = ""
                                ESX.ShowNotification("Vous devez rentrer un label valide")
                            else                       
                                ESX.ShowNotification("Vous avez mis un label sur votre ascenseur ~b~"..edit_label)
                            end
                        end
                    })
                    RageUI.Separator("↓ Gestion ↓")
                    RageUI.Button("Position", nil, {RightLabel = "→"}, true, {}, edit_subMenu3)
                    RageUI.Button("Jobs", nil, {RightLabel = "→"}, true, {}, edit_subMenu)
                    RageUI.Button("Utilisateurs", nil, {RightLabel = "→"}, true, {}, edit_subMenu2)
                    RageUI.Button("Blips", nil, {RightLabel = "→"}, true, {}, edit_subMenu5)
                    RageUI.Button("Markers", nil, {RightLabel = "→"}, true, {}, edit_subMenu6)
                    RageUI.Line()
                    RageUI.Button("Valider les modifications", nil, pAscenseurBuilder.RightLabel, true, {
                        onSelected = function()
                            edit_confirmation = KeyboardInput("Entrez : CONFIRMER", nil, 9)
                            if edit_confirmation == "CONFIRMER" then
                                TriggerServerEvent("pAscenseurBuilder:modifyAscenseur", edit_id, edit_label, edit_data_pos, edit_data_job, edit_data_user, {name = edit_BlipName, sprite = edit_BlipSprite, scale = edit_BlipScale, color = edit_BlipColor}, {types = edit_MarkerType, rotX = edit_MarkerrotX, rotY = edit_MarkerrotY, rotZ = edit_MarkerrotZ, scaleX = edit_MarkerscaleX, scaleY = edit_MarkerscaleY, scaleZ = edit_MarkerscaleZ, colorR = edit_MarkerR, colorV = edit_MarkerV, colorB = edit_MarkerB, colorO = edit_MarkerO})                         
                                edit_label = ""
                                edit_PosLabel,edit_PosTP,edit_PosTPHeading = "","",""
                                edit_BlipPreview,edit_Blip,edit_BlipName = false,false,""
                                edit_Marker,edit_MarkerPreview = false,false
                                edit__Index,edit__Index2,edit__Index3,edit__Index4,edit__Index5,edit__Index6,edit__Index7,edit__Index8,edit__Index9,edit__Index10,edit__Index11,edit__Index12,edit__Index13,edit__Index14,edit__Index15,edit__Index16,edit__Index17 = 1,1,1,1,10,1,1,19,19,19,11,11,11,1,1,1,256
                                edit_data_pos = {}
                                edit_ModifyPos = {value = nil, verify = false}
                                edit_data_job = {}
                                edit_ModifyJob = {value = nil, verify = false}
                                edit_data_user = {}
                                edit_ModifyUser = {value = nil, verify = false}
                                RemoveBlip(edit__blip)
                                Wait(200) 
                                getDataAscenseur()
                                Wait(200)
                                getDataBlips(false)
                                Wait(200) 
                                getDataBlips(true)
                                RageUI.CloseAll()
                                builder = false
                            else
                                ESX.ShowNotification("Vous n'avez pas confirmé votre modification")
                            end
                        end
                    })
                end)
                RageUI.IsVisible(edit_subMenu,function()   
                    edit_subMenu:UpdateInstructionalButtons(true)                       
                    RageUI.Button("Ajouter un job", nil, {RightLabel = "→"}, true, {}, edit_subMenu7) 
                    RageUI.Separator("↓ Liste des Jobs ↓")
                    if #edit_data_job == 0 then
                        RageUI.Separator("Aucun job présent") 
                    end
                    for k,v in pairs(edit_data_job) do
                        RageUI.List(v.label, {"Modifier", "Supprimer"}, edit__Index, nil, {}, true, {
                            onActive = function()
                                if k ~= GetkTable(edit_data_job) then
                                    if IsControlJustPressed(0, 11) then
                                        table.remove(edit_data_job, k)
                                        table.insert(edit_data_job, k+1, {name = v.name, label = v.label})
                                    end
                                end
                                if k ~= 1 then
                                    if IsControlJustPressed(0, 10) then
                                        table.remove(edit_data_job, k)
                                        table.insert(edit_data_job, k-1, {name = v.name, label = v.label})
                                    end 
                                end
                            end, 
                            onListChange = function(Index)
                                edit__Index = Index
                            end,
                            onSelected = function()
                                if edit__Index == 1 then
                                    edit_ModifyJob = {value = k, verify = true}
                                    Wait(100)
                                    RageUI.Visible(edit_subMenu7, true)
                                elseif edit__Index == 2 then
                                    table.remove(edit_data_job, k)
                                end
                            end
                        })
                    end
                end)
                RageUI.IsVisible(edit_subMenu2,function()     
                    edit_subMenu2:UpdateInstructionalButtons(true)                     
                    RageUI.Button("Ajouter un utilisateur", nil, {RightLabel = "→"}, true, {}, edit_subMenu8) 
                    RageUI.Separator("↓ Liste des Utilisateurs ↓")
                    if #edit_data_user == 0 then
                        RageUI.Separator("Aucun utilisateur présent") 
                    end
                    for k,v in pairs(edit_data_user) do
                        RageUI.List(v.firstname.." "..v.lastname, {"Modifier", "Supprimer"}, edit__Index2, nil, {}, true, {
                            onActive = function()
                                if k ~= GetkTable(edit_data_user) then
                                    if IsControlJustPressed(0, 11) then
                                        table.remove(edit_data_user, k)
                                        table.insert(edit_data_user, k+1, {identifier = v.identifier, firstname = v.firstname, lastname = v.lastname})
                                    end
                                end
                                if k ~= 1 then
                                    if IsControlJustPressed(0, 10) then
                                        table.remove(edit_data_user, k)
                                        table.insert(edit_data_user, k-1, {identifier = v.identifier, firstname = v.firstname, lastname = v.lastname})
                                    end 
                                end
                            end, 
                            onListChange = function(Index)
                                edit__Index2 = Index
                            end,
                            onSelected = function()
                                if edit__Index2 == 1 then
                                    edit_ModifyUser = {value = k, verify = true}
                                    Wait(100)
                                    RageUI.Visible(edit_subMenu8, true)
                                elseif edit__Index2 == 2 then
                                    table.remove(edit_data_user, k)
                                end
                            end
                        })
                    end
                end)
                RageUI.IsVisible(edit_subMenu3,function()    
                    edit_subMenu3:UpdateInstructionalButtons(true)                      
                    RageUI.Button("Ajouter une position", nil, {RightLabel = "→"}, true, {}, edit_subMenu4) 
                    RageUI.Separator("↓ Liste des Positions ↓")
                    if #edit_data_pos == 0 then
                        RageUI.Separator("Aucune position présente") 
                    end
                    for k,v in pairs(edit_data_pos) do
                        RageUI.List(v.label, {"Modifier", "Se Téléporter", "Supprimer"}, edit__Index3, nil, {}, true, {
                            onActive = function()
                                if k ~= GetkTable(edit_data_pos) then
                                    if IsControlJustPressed(0, 11) then
                                        table.remove(edit_data_pos, k)
                                        table.insert(edit_data_pos, k+1, {label = v.label, coords = {x = v.coords.x, y = v.coords.y, z = v.coords.z, w = v.coords.w}})
                                    end
                                end
                                if k ~= 1 then
                                    if IsControlJustPressed(0, 10) then
                                        table.remove(edit_data_pos, k)
                                        table.insert(edit_data_pos, k-1, {label = v.label, coords = {x = v.coords.x, y = v.coords.y, z = v.coords.z, w = v.coords.w}})
                                    end 
                                end
                            end, 
                            onListChange = function(Index)
                                edit__Index3 = Index
                            end,
                            onSelected = function()
                                if edit__Index3 == 1 then
                                    edit_ModifyPos = {value = k, verify = true}
                                    edit_actualymodify = true
                                    edit_PosLabel = v.label
                                    edit_PosTP = v.coords
                                    edit_PosTPHeading = v.coords.w
                                    Wait(100)
                                    RageUI.Visible(edit_subMenu4, true)
                                elseif  edit__Index3 == 2 then
                                    SetEntityCoords(GetPlayerPed(-1), v.coords.x, v.coords.y, v.coords.z, 0.0, 0.0, 0.0, true)
                                    SetEntityHeading(GetPlayerPed(-1), v.coords.w)
                                elseif  edit__Index3 == 3 then
                                    table.remove(edit_data_pos, k)
                                end
                            end
                        })
                    end
                end)
                RageUI.IsVisible(edit_subMenu5,function()
                    RageUI.Checkbox("Ajouter un blip", nil, edit_Blip, {}, {
                        onChecked = function()
                            edit_Blip = true
                            if edit_BlipPreview == true then        
                                RemoveBlip(edit__blip)
                                edit__PreviewBlip(edit_BlipName, edit_Blip) 
                            end 
                            ESX.ShowNotification("Vous avez ~g~ajouté~s~ le blip à l'ascenseur ~b~"..edit_label)                        
                        end,
                        onUnChecked = function()
                            edit_Blip = false
                            if edit_BlipPreview == true then        
                                RemoveBlip(edit__blip)
                                edit__PreviewBlip(edit_BlipName, edit_Blip) 
                            end 
                            ESX.ShowNotification("Vous avez ~r~retiré~s~ le blip à l'ascenseur ~b~"..edit_label)                
                        end
                    })
                    if edit_Blip then
                        RageUI.Line()
                        RageUI.Checkbox("Prévisualisé le blip", nil, edit_BlipPreview, {}, {
                            onChecked = function()
                                edit_BlipPreview = true 
                                edit_BlipSprite = edit__Items2[edit__Index4]
                                edit_BlipScale = edit__Index5 / 10
                                edit_BlipColor = edit__Items3[edit__Index6]         
                                edit__PreviewBlip(edit_BlipName, edit_Blip) 
                                ESX.ShowNotification("Prévisualisation ~g~activée~s~")       
                            end,
                            onUnChecked = function()   
                                edit_BlipPreview = false
                                RemoveBlip(edit__blip)  
                                ESX.ShowNotification("Prévisualisation ~r~désactivée~s~")           
                            end
                        })
                        RageUI.Button("Nom", nil, {RightLabel = "~b~"..edit_BlipName.." ~s~→"}, true, {
                            onSelected = function()
                                edit_BlipName = KeyboardInput("Donner un nom à votre blip", nil, 50)
                                if edit_BlipName == nil or edit_BlipName == "" then
                                    edit_BlipName = ""
                                    ESX.ShowNotification("Vous devez rentrer un nom valide")
                                else       
                                    if edit_BlipPreview == true then        
                                        RemoveBlip(edit__blip)
                                        edit__PreviewBlip(edit_BlipName, edit_Blip) 
                                    end                
                                    ESX.ShowNotification("Vous avez nommé votre blip ~b~"..edit_BlipName)
                                end
                            end
                        })
                        RageUI.List("Type", edit__Items2, edit__Index4, nil, {}, true, {
                            onListChange = function(Index)
                                edit__Index4 = Index
                                if edit_BlipPreview == true then        
                                    RemoveBlip(edit__blip)
                                    edit__PreviewBlip(edit_BlipName, edit_Blip) 
                                end
                            end,
                            onActive = function()
                                edit_BlipSprite = edit__Index4
                            end,
                            onSelected = function()
                                edit_BlipSprite = KeyboardInput("Donner un type à votre blip (0 - 826)", nil, 3)
                                if edit_BlipSprite == nil or edit_BlipSprite == "" or not tonumber(edit_BlipSprite) then
                                    edit_BlipSprite = ""
                                    ESX.ShowNotification("Vous devez rentrer un type valide")
                                else
                                    edit__Index4 = tonumber(edit_BlipSprite)   
                                    edit_BlipSprite = edit__Index4
                                    if edit_BlipPreview == true then        
                                        RemoveBlip(edit__blip)
                                        edit__PreviewBlip(edit_BlipName, edit_Blip) 
                                    end 
                                    ESX.ShowNotification("Vous venez de sauvegarder le type du blip qui est de ~b~"..edit_BlipSprite)          
                                end
                            end
                        })
                        RageUI.List("Taille", {0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0,1.1,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,2.0}, edit__Index5, nil, {}, true, {
                            onListChange = function(Index)
                                edit__Index5 = Index
                                if edit_BlipPreview == true then        
                                    RemoveBlip(edit__blip) 
                                    edit__PreviewBlip(edit_BlipName, edit_Blip) 
                                end
                            end,
                            onActive = function()
                                edit_BlipScale = edit__Index5 / 10
                            end,
                            onSelected = function()
                                edit_BlipScale = KeyboardInput("Donner une taille à votre blip (0.1 - 2.0)", nil, 3)
                                if edit_BlipScale == nil or edit_BlipScale == "" or not tonumber(edit_BlipScale) then
                                    edit_BlipScale = ""
                                    ESX.ShowNotification("Vous devez rentrer une taille valide")
                                else       
                                    edit__Index5 = tonumber(edit_BlipScale) * 10
                                    edit_BlipScale = tonumber(edit_BlipScale) * 1.0
                                    if edit_BlipPreview == true then        
                                        RemoveBlip(edit__blip) 
                                        edit__PreviewBlip(edit_BlipName, edit_Blip) 
                                    end 
                                    ESX.ShowNotification("Vous venez de sauvegarder la taille du blip qui est de ~b~"..edit_BlipScale)           
                                end
                            end
                        })
                        RageUI.List("Couleur", edit__Items3, edit__Index6, nil, {}, true, {
                            onListChange = function(Index)
                                edit__Index6 = Index
                                if edit_BlipPreview == true then        
                                    RemoveBlip(edit__blip)
                                    edit__PreviewBlip(edit_BlipName, edit_Blip) 
                                end
                            end,
                            onActive = function()
                                edit_BlipColor = edit__Index6
                            end,
                            onSelected = function()
                                edit_BlipColor = KeyboardInput("Donner une couleur à votre blip (0 - 85)", nil, 2)
                                if edit_BlipColor == nil or edit_BlipColor == "" or not tonumber(edit_BlipColor) then
                                    edit_BlipColor = ""
                                    ESX.ShowNotification("Vous devez rentrer une couleur valide")
                                else   
                                    edit__Index6 = tonumber(edit_BlipColor)  
                                    edit_BlipColor = edit__Index6  
                                    if edit_BlipPreview == true then        
                                        RemoveBlip(edit__blip) 
                                        edit__PreviewBlip(edit_BlipName, edit_Blip) 
                                    end 
                                    ESX.ShowNotification("Vous venez de sauvegarder la couleur du blip qui est de ~b~"..edit_BlipColor)               
                                end
                            end
                        })                       
                    end
                end)
                RageUI.IsVisible(edit_subMenu6,function()
                    if edit_MarkerPreview then
                        DrawMarker(edit_MarkerType, GetEntityCoords(PlayerPedId()).x, GetEntityCoords(PlayerPedId()).y, GetEntityCoords(PlayerPedId()).z-1, 0.0, 0.0, 0.0, edit_MarkerrotX, edit_MarkerrotY, edit_MarkerrotZ, edit_MarkerscaleX, edit_MarkerscaleY, edit_MarkerscaleZ, edit_MarkerR, edit_MarkerV, edit_MarkerB, edit_MarkerO, false, false, p19, false) 
                    end
                    RageUI.Checkbox("Ajouter un marker", nil, edit_Marker, {}, {
                        onChecked = function()
                            edit_Marker = true
                            ESX.ShowNotification("Vous avez ~g~ajouté~s~ le marker à l'ascenseur ~b~"..edit_label)                        
                        end,
                        onUnChecked = function()
                            edit_Marker = false
                            ESX.ShowNotification("Vous avez ~r~retiré~s~ le marker à l'ascenseur ~b~"..edit_label)                
                        end
                    })
                    if edit_Marker then
                        RageUI.Line()
                        RageUI.Checkbox("Prévisualisé le marker", nil, edit_MarkerPreview, {}, {
                            onChecked = function()
                                edit_MarkerPreview = true
                                edit_MarkerType = edit__Items4[edit__Index7]
                                edit_MarkerrotX = edit__Items5[edit__Index8]
                                edit_MarkerrotY = edit__Items6[edit__Index9]
                                edit_MarkerrotZ = edit__Items7[edit__Index10]
                                edit_MarkerscaleX = edit__Items8[edit__Index11]
                                edit_MarkerscaleY = edit__Items9[edit__Index12]
                                edit_MarkerscaleZ = edit__Items10[edit__Index13]
                                edit_MarkerR = edit__Items11[edit__Index14]
                                edit_MarkerV = edit__Items12[edit__Index15]
                                edit_MarkerB = edit__Items13[edit__Index16]
                                edit_MarkerO = edit__Items14[edit__Index17]          
                                ESX.ShowNotification("Prévisualisation ~g~activée~s~")       
                            end,
                            onUnChecked = function()   
                                edit_MarkerPreview = false
                                ESX.ShowNotification("Prévisualisation ~r~désactivée~s~")           
                            end
                        })
                        RageUI.List("Type", edit__Items4, edit__Index7, nil, {}, true, {
                            onListChange = function(Index)
                                edit__Index7 = Index
                            end,
                            onActive = function()
                                edit_MarkerType = edit__Index7
                            end
                        })
                        RageUI.List("Rotation X", edit__Items5, edit__Index8, nil, {}, true, {
                            onListChange = function(Index)
                                edit__Index8 = Index
                            end,
                            onActive = function()
                                edit_MarkerrotX = edit__Items5[edit__Index8]
                            end,
                            onSelected = function()
                                edit_MarkerrotX = KeyboardInput("Donner une rotation x à votre marker (-180.0 - 180.0)", nil, 5)
                                if edit_MarkerrotX == nil or edit_MarkerrotX == "" or not tonumber(edit_MarkerrotX) then
                                    edit_MarkerrotX = ""
                                    ESX.ShowNotification("Vous devez rentrer une rotation valide")
                                else      
                                    for k,v in pairs(edit__Items5) do
                                        if v == tonumber(edit_MarkerrotX) then
                                            edit__Index8 = k
                                        end
                                    end 
                                    ESX.ShowNotification("Vous venez de sauvegarder la rotation x du marker qui est de ~b~"..edit_MarkerrotX)          
                                end
                            end
                        })
                        RageUI.List("Rotation Y", edit__Items6, edit__Index9, nil, {}, true, {
                            onListChange = function(Index)
                                edit__Index9 = Index
                            end,
                            onActive = function()
                                edit_MarkerrotY = edit__Items6[edit__Index9]
                            end,
                            onSelected = function()
                                edit_MarkerrotY = KeyboardInput("Donner une rotation y à votre marker (-180.0 - 180.0)", nil, 5)
                                if edit_MarkerrotY == nil or edit_MarkerrotY == "" or not tonumber(edit_MarkerrotY) then
                                    edit_MarkerrotY = ""
                                    ESX.ShowNotification("Vous devez rentrer une rotation valide")
                                else       
                                    for k,v in pairs(edit__Items6) do
                                        if v == tonumber(edit_MarkerrotY) then
                                            edit__Index9 = k
                                        end
                                    end
                                    ESX.ShowNotification("Vous venez de sauvegarder la rotation y du marker qui est de ~b~"..edit_MarkerrotY)          
                                end
                            end
                        })
                        RageUI.List("Rotation Z", edit__Items7, edit__Index10, nil, {}, true, {
                            onListChange = function(Index)
                                edit__Index10 = Index
                            end,
                            onActive = function()
                                edit_MarkerrotZ = edit__Items7[edit__Index10]
                            end,
                            onSelected = function()
                                edit_MarkerrotZ = KeyboardInput("Donner une rotation z à votre marker (-180.0 - 180.0)", nil, 5)
                                if edit_MarkerrotZ == nil or edit_MarkerrotZ == "" or not tonumber(edit_MarkerrotZ) then
                                    edit_MarkerrotZ = ""
                                    ESX.ShowNotification("Vous devez rentrer une rotation valide")
                                else       
                                    for k,v in pairs(edit__Items7) do
                                        if v == tonumber(edit_MarkerrotZ) then
                                            edit__Index10 = k
                                        end
                                    end
                                    ESX.ShowNotification("Vous venez de sauvegarder la rotation z du marker qui est de ~b~"..edit_MarkerrotZ)          
                                end
                            end
                        })
                        RageUI.List("Taille X", edit__Items8, edit__Index11, nil, {}, true, {
                            onListChange = function(Index)
                                edit__Index11 = Index
                            end,
                            onActive = function()
                                edit_MarkerscaleX = edit__Items8[edit__Index11]
                            end,
                            onSelected = function()
                                edit_MarkerscaleX = KeyboardInput("Donner une taille x à votre marker (0.0 - 2.0)", nil, 5)
                                if edit_MarkerscaleX == nil or edit_MarkerscaleX == "" or not tonumber(edit_MarkerscaleX) then
                                    edit_MarkerscaleX = ""
                                    ESX.ShowNotification("Vous devez rentrer une taille valide")
                                else       
                                    for k,v in pairs(edit__Items8) do
                                        if v == tonumber(edit_MarkerscaleX) then
                                            edit__Index11 = k
                                        end
                                    end 
                                    ESX.ShowNotification("Vous venez de sauvegarder la taille x du marker qui est de ~b~"..edit_MarkerscaleX)          
                                end
                            end
                        })
                        RageUI.List("Taille Y", edit__Items9, edit__Index12, nil, {}, true, {
                            onListChange = function(Index)
                                edit__Index12 = Index
                            end,
                            onActive = function()
                                edit_MarkerscaleY = edit__Items9[edit__Index12]
                            end,
                            onSelected = function()
                                edit_MarkerscaleY = KeyboardInput("Donner une taille y à votre marker (0.0 - 2.0)", nil, 5)
                                if edit_MarkerscaleY == nil or edit_MarkerscaleY == "" or not tonumber(edit_MarkerscaleY) then
                                    edit_MarkerscaleY = ""
                                    ESX.ShowNotification("Vous devez rentrer une taille valide")
                                else       
                                    for k,v in pairs(edit__Items9) do
                                        if v == tonumber(edit_MarkerscaleY) then
                                            edit__Index12 = k
                                        end
                                    end 
                                    ESX.ShowNotification("Vous venez de sauvegarder la taille y du marker qui est de ~b~"..edit_MarkerscaleY)          
                                end
                            end
                        })
                        RageUI.List("Taille Z", edit__Items10, edit__Index13, nil, {}, true, {
                            onListChange = function(Index)
                                edit__Index13 = Index
                            end,
                            onActive = function()
                                edit_MarkerscaleZ = edit__Items10[edit__Index13]
                            end,
                            onSelected = function()
                                edit_MarkerscaleZ = KeyboardInput("Donner une taille z à votre marker (0.0 - 2.0)", nil, 5)
                                if edit_MarkerscaleZ == nil or edit_MarkerscaleZ == "" or not tonumber(edit_MarkerscaleZ) then
                                    edit_MarkerscaleZ = ""
                                    ESX.ShowNotification("Vous devez rentrer une taille valide")
                                else        
                                    for k,v in pairs(edit__Items10) do
                                        if v == tonumber(edit_MarkerscaleZ) then
                                            edit__Index13 = k
                                        end
                                    end 
                                    ESX.ShowNotification("Vous venez de sauvegarder la taille z du marker qui est de ~b~"..edit_MarkerscaleZ)          
                                end
                            end
                        })
                        RageUI.List("R", edit__Items11, edit__Index14, nil, {}, true, {
                            onListChange = function(Index)
                                edit__Index14 = Index
                            end,
                            onActive = function()
                                edit_MarkerR = edit__Items11[edit__Index14]
                            end,
                            onSelected = function()
                                edit_MarkerR = KeyboardInput("Donner une couleur rouge à votre marker (0 - 255)", nil, 5)
                                if edit_MarkerR == nil or edit_MarkerR == "" or not tonumber(edit_MarkerR) then
                                    edit_MarkerR = ""
                                    ESX.ShowNotification("Vous devez rentrer une couleur rouge valide")
                                else   
                                    for k,v in pairs(edit__Items11) do
                                        if v == tonumber(edit_MarkerR) then
                                            edit__Index14 = k
                                        end
                                    end        
                                    ESX.ShowNotification("Vous venez de sauvegarder la couleur rouge du marker qui est de ~b~"..edit_MarkerR)          
                                end
                            end
                        })
                        RageUI.List("V", edit__Items12, edit__Index15, nil, {}, true, {
                            onListChange = function(Index)
                                edit__Index15 = Index
                            end,
                            onActive = function()
                                edit_MarkerV = edit__Items12[edit__Index15]
                            end,
                            onSelected = function()
                                edit_MarkerV = KeyboardInput("Donner une couleur verte à votre marker (0 - 255)", nil, 5)
                                if edit_MarkerV == nil or edit_MarkerV == "" or not tonumber(edit_MarkerV) then
                                    edit_MarkerV = ""
                                    ESX.ShowNotification("Vous devez rentrer une couleur verte valide")
                                else       
                                    for k,v in pairs(edit__Items12) do
                                        if v == tonumber(edit_MarkerV) then
                                            edit__Index15 = k
                                        end
                                    end     
                                    ESX.ShowNotification("Vous venez de sauvegarder la couleur vert du marker qui est de ~b~"..edit_MarkerV)          
                                end
                            end
                        })
                        RageUI.List("B", edit__Items13, edit__Index16, nil, {}, true, {
                            onListChange = function(Index)
                                edit__Index16 = Index
                            end,
                            onActive = function()
                                edit_MarkerB = edit__Items13[edit__Index16]
                            end,
                            onSelected = function()
                                edit_MarkerB = KeyboardInput("Donner une couleur bleu à votre marker (0 - 255)", nil, 5)
                                if edit_MarkerB == nil or edit_MarkerB == "" or not tonumber(edit_MarkerB) then
                                    edit_MarkerB = ""
                                    ESX.ShowNotification("Vous devez rentrer une couleur bleu valide")
                                else      
                                    for k,v in pairs(edit__Items13) do
                                        if v == tonumber(edit_MarkerB) then
                                            edit__Index16 = k
                                        end
                                    end      
                                    ESX.ShowNotification("Vous venez de sauvegarder la couleur bleu du marker qui est de ~b~"..edit_MarkerB)          
                                end
                            end
                        })
                        RageUI.List("O", edit__Items14, edit__Index17, nil, {}, true, {
                            onListChange = function(Index)
                                edit__Index17 = Index
                            end,
                            onActive = function()
                                edit_MarkerO = edit__Items14[edit__Index17]
                            end,
                            onSelected = function()
                                edit_MarkerO = KeyboardInput("Donner une opacité à votre marker (0 - 255)", nil, 5)
                                if edit_MarkerO == nil or edit_MarkerO == "" or not tonumber(edit_MarkerO) then
                                    edit_MarkerO = ""
                                    ESX.ShowNotification("Vous devez rentrer une opacité valide")
                                else
                                    for k,v in pairs(edit__Items14) do
                                        if v == tonumber(edit_MarkerO) then
                                            edit__Index17 = k
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
                    RageUI.Button("Aucun pour le moment", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            edit_data_job = {}
                            edit_ModifyJob = {value = nil, verify = false}
                            RageUI.GoBack() 
                        end
                    }) 
                    RageUI.Line()
                    for _,v in pairs(getData.Jobs) do
                        RageUI.Button(v.label, nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                if edit_ModifyJob.verify == true then
                                    table.remove(edit_data_job, edit_ModifyJob.value)
                                    table.insert(edit_data_job, edit_ModifyJob.value, {name = v.name, label = v.label})
                                    edit_ModifyJob = {value = nil, verify = false}
                                    RageUI.GoBack()
                                else  
                                    table.insert(edit_data_job, {name = v.name, label = v.label})
                                    edit_ModifyJob = {value = nil, verify = false}
                                    RageUI.GoBack() 
                                end
                            end
                        }) 
                    end
                end)
                RageUI.IsVisible(edit_subMenu8,function()
                    edit_subMenu8:UpdateInstructionalButtons(true)    
                    RageUI.Button("Aucun pour le moment", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            edit_data_user = {}
                            edit_ModifyUser = {value = nil, verify = false}
                            RageUI.GoBack()
                        end
                    }) 
                    RageUI.Line()
                    for _,v in pairs(getData.Users) do
                        RageUI.Button(v.firstname.." "..v.lastname, nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                if edit_ModifyUser.verify == true then
                                    table.remove(edit_data_user, edit_ModifyUser.value)
                                    table.insert(edit_data_user, edit_ModifyUser.value, {identifier = v.identifier, firstname = v.firstname, lastname = v.lastname})
                                    edit_ModifyUser = {value = nil, verify = false}
                                    RageUI.GoBack()
                                else
                                    table.insert(edit_data_user, {identifier = v.identifier, firstname = v.firstname, lastname = v.lastname})
                                    edit_ModifyUser = {value = nil, verify = false}
                                    RageUI.GoBack() 
                                end
                            end
                        }) 
                    end
                end)
                RageUI.IsVisible(edit_subMenu4,function()
                    edit_subMenu4:UpdateInstructionalButtons(true)    
                    RageUI.Button("Label", nil, {RightLabel = "~b~"..edit_PosLabel.." ~s~→"}, true, {
                        onSelected = function()
                            edit_PosLabel = KeyboardInput("Donner un nom à votre position", nil, 50)
                            if edit_PosLabel == nil or edit_PosLabel == "" then
                                edit_PosLabel = ""
                                ESX.ShowNotification("Vous devez rentrer un nom valide")
                            else                       
                                ESX.ShowNotification("Vous avez nommé votre position ~b~"..edit_PosLabel)
                            end
                        end
                    }) 
                    if edit_actualymodify then
                        RageUI.Button("Position de téléportation", nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                edit_PosTP = GetEntityCoords(PlayerPedId())
                                ESX.ShowNotification("Vous venez de sauvegarder la ~b~position de téléportation")
                                edit_actualymodify = false
                            end
                        })
                    else
                        RageUI.Button("Position de téléportation", "~b~"..edit_PosTP, {RightLabel = "→"}, true, {
                            onSelected = function()
                                edit_PosTP = GetEntityCoords(PlayerPedId())
                                ESX.ShowNotification("Vous venez de sauvegarder la ~b~position de téléportation")
                            end
                        }) 
                    end
                    RageUI.Button("Direction de téléportation", "~b~"..edit_PosTPHeading, {RightLabel = "→"}, true, {
                        onSelected = function()
                            edit_PosTPHeading = GetEntityHeading(PlayerPedId())
                            ESX.ShowNotification("Vous venez de sauvegarder la ~b~direction de téléportation")
                        end
                    }) 
                    RageUI.Button("Valider", nil, pAscenseurBuilder.RightLabel, true, {
                        onSelected = function()
                            if edit_ModifyPos.verify == true then
                                table.remove(edit_data_pos, edit_ModifyPos.value)
                                table.insert(edit_data_pos, edit_ModifyPos.value, {label = edit_PosLabel, coords = {x = edit_PosTP.x, y = edit_PosTP.y, z = edit_PosTP.z, w = edit_PosTPHeading}})
                                edit_ModifyPos = {value = nil, verify = false}
                                edit_PosLabel,edit_PosTP,edit_PosTPHeading = "","",""
                                RageUI.GoBack()
                            else
                                table.insert(edit_data_pos, {label = edit_PosLabel, coords = {x = edit_PosTP.x, y = edit_PosTP.y, z = edit_PosTP.z, w = edit_PosTPHeading}})
                                edit_ModifyPos = {value = nil, verify = false}
                                edit_PosLabel,edit_PosTP,edit_PosTPHeading = "","",""
                                RageUI.GoBack() 
                            end
                            edit_actualymodify = false
                        end
                    }) 
                end)
            Wait(0)
            end
        end)
    end
end

RegisterCommand("ascenseurbuilder", function()
    ESX.TriggerServerCallback('pAscenseurBuilder:getUserGroup', function(group)
        playergroup = group
        for _,v in pairs(pAscenseurBuilder.AllowedGroup) do
            if v == playergroup then
                CheckAllowedGroup = true
            end            
        end
    end)
    for _,v in pairs(pAscenseurBuilder.AllowedPermission) do
        if v == ESX.PlayerData.identifier then
            CheckAllowedPermission = true
        end            
    end
    Wait(200)
    if CheckAllowedPermission then
        OpenAscenseurBuilder()
    elseif CheckAllowedGroup then
        OpenAscenseurBuilder()
    else
        ESX.ShowNotification("Vous n'avez pas la permission pour exécuter cette commande")
    end
end)