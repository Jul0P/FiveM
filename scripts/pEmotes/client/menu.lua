if pEmotes.ESX == "new" then
	ESX = exports["es_extended"]:getSharedObject()
elseif pEmotes.ESX == "old" then
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

local mainMenu = RageUI.CreateMenu("Menu Emotes", "MENU")
local subMenu = RageUI.CreateSubMenu(mainMenu, "Emotes", "Menu Emotes")
local subMenu2 = RageUI.CreateSubMenu(mainMenu, "Emotes Partagées", "Menu Emotes")
local subMenu3 = RageUI.CreateSubMenu(subMenu, "Emotes All", "Menu Emotes")
local subMenu5 = RageUI.CreateSubMenu(mainMenu, "Style de marche", "Menu Emotes")
local subMenu6 = RageUI.CreateSubMenu(mainMenu, "Gestion des Favoris", "Menu Emotes")
local subMenu7 = RageUI.CreateSubMenu(mainMenu, "Gestion des Keybind", "Menu Emotes")
mainMenu.Closed = function()
    emotesmenu = false
    DeleteEntity(peds)
end
subMenu.Closed = function()
    filterIndex = 1
end
subMenu2.Closed = function()
    filterIndex = 1
end
subMenu3.Closed = function()
    filterIndex = 1
end
subMenu5.Closed = function()
    filterIndex = 1
end

local ArrayIndex = 1
local ArrayIndex2 = 1
local ArrayIndex3 = 1
local ArrayIndex4 = 1
local ArrayIndex5 = 1
local ArrayIndex6 = 1
local ArrayIndex7 = 1
local ArrayIndex8 = 1

ArrayEmotes = {}
ArrayEmotesKeyding = {}
ArrayList5 = {"Aucun", "Emote", "Emote Partagées", "Style de marche"}
ArrayAllEmote = {"Dance", "Props", "Geste", "Activité", "Position", "Sport", "Santé", "Expression", "Autre"}
AllEmoteActive = ""
filterList = {"Aucun","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"}
filterIndex = 1
local function starts(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end

Citizen.CreateThread(function()
    while not ESX.PlayerLoaded do 
        Citizen.Wait(100) 
    end
    ESX.TriggerServerCallback("pEmotes:getAnimations", function(data)
        ArrayEmotesKeyding = data
    end)
end)

function MenuEmote()
    if not emotesmenu then emotesmenu = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
		    while emotesmenu do 
                RageUI.IsVisible(mainMenu,function()               
                    RageUI.Button("Emote", nil, {RightLabel = "→"}, true, {}, subMenu)
                    RageUI.Button("Emote Partagées", nil, {RightLabel = "→"}, true, {}, subMenu2)
                    RageUI.Button("Style de marche", nil, {RightLabel = "→"}, true, {}, subMenu5)
                    RageUI.Button("Gestion des Favoris", nil, {RightLabel = "→"}, true, {
                        onSelected = function()    
                            Citizen.CreateThread(function()
                                ESX.TriggerServerCallback("pEmotes:getAnimations", function(data)
                                    ArrayEmotes = data
                                    EmoteLoaded = true
                                end)
                            end)
                            EmoteLoaded = false
                        end
                    }, subMenu6)
                    RageUI.Button("Gestion des Keybind", nil, {RightLabel = "→"}, true, {
                        onSelected = function()                        
                            Citizen.CreateThread(function()
                                ESX.TriggerServerCallback("pEmotes:getAnimations", function(data)
                                    ArrayEmotesKeyding = data
                                    EmoteLoaded = true
                                end)
                            end)
                            EmoteLoaded = false
                        end
                    }, subMenu7)
                end)
                RageUI.IsVisible(subMenu,function()
                    for k,v in pairs(ArrayAllEmote) do
                        RageUI.Button(v, nil, {RightLabel = "→"}, true, {
                            onActive = function()
                                AllEmoteActive = v
                            end
                        }, subMenu3)
                    end
                end)
                RageUI.IsVisible(subMenu2,function()
                    RageUI.List("Filtre", filterList, filterIndex, nil, {}, true, {
                        onListChange = function(Index)
                            filterIndex = Index               
                        end,
                        onSelected = function()
                            local filterNumber = KeyboardInput("Choisissez la lettre que vous souhaitez filtrer", "", 0)
                            if filterNumber then
                                for k,v in pairs(filterList) do
                                    if string.upper(filterNumber) == v then
                                        filterIndex = k
                                    end
                                end
                            end
                        end
                    })
                    for k,v in pairs(Animation_Config_Synced) do 
                        if starts(v['Label']:lower(), filterList[filterIndex]:lower()) or filterList[filterIndex] == "Aucun" then
                            RageUI.List(v['Label'], {"Visualiser", "Jouer", "Favoris", "Keybind"}, ArrayIndex2, nil, {}, true, {
                                onListChange = function(Index)
                                    ArrayIndex2 = Index
                                end,
                                onSelected = function()          
                                    if ArrayIndex2 == 1 then 
                                        EmoteCancel()
                                        sharedemote(v)
                                    elseif ArrayIndex2 == 2 then 
                                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                        if closestPlayer ~= -1 and closestDistance < 2.0 then
                                            TriggerServerEvent('pEmotes:requestSynced', GetPlayerServerId(closestPlayer), v)
                                        end
                                    elseif ArrayIndex2 == 3 then
                                        TriggerServerEvent("pEmotes:saveemote", v, "Emote Partagées", v['Label'], v['Label'], true)
                                    elseif ArrayIndex2 == 4 then
                                        local keybindNumber = KeyboardInput("Choisissez le NUMPAD vous souhaitez mettre votre emote (0 - 6)", "", 1)
                                        if tonumber(keybindNumber) and tonumber(keybindNumber) >= 0 and tonumber(keybindNumber) <= 6 then 
                                            TriggerServerEvent("pEmotes:saveemotekeybind", v, "Emote Partagées", v['Label'], v['Label'], "NUMPAD"..keybindNumber) 
                                            Wait(500)
                                            ESX.TriggerServerCallback("pEmotes:getAnimations", function(data)
                                                ArrayEmotesKeyding = data
                                            end)
                                        else
                                            ESX.ShowNotification("Le nombre entré est invalide")
                                        end
                                    end
                                end
                            })
                        end
                    end
                end)
                RageUI.IsVisible(subMenu3,function()
                    RageUI.List("Filtre", filterList, filterIndex, nil, {}, true, {
                        onListChange = function(Index)
                            filterIndex = Index
                        end,
                        onSelected = function()
                            local filterNumber = KeyboardInput("Choisissez la lettre que vous souhaitez filtrer", "", 0)
                            if filterNumber then
                                for k,v in pairs(filterList) do
                                    if string.upper(filterNumber) == v then
                                        filterIndex = k
                                    end
                                end
                            end
                        end
                    })
                    if AllEmoteActive == "Expression" then
                        RageUI.Button("Par Défaut", nil, {RightLabel = "→"}, true, {
                            onSelected = function()    
                                ClearFacialIdleAnimOverride(PlayerPedId())
                            end
                        })
                        RageUI.Separator("↓ Liste des expressions ↓")
                    end
                    for y,z in pairsByKeys(AnimationList, AllEmoteActive) do
                        if starts(y:lower(), filterList[filterIndex]:lower()) or filterList[filterIndex] == "Aucun" then
                            RageUI.List(y, {"Visualiser", "Jouer", "Favoris", "Keybind"}, ArrayIndex, nil, {}, true, {
                                onListChange = function(Index)
                                    ArrayIndex = Index
                                end,
                                onSelected = function()
                                    for k,v in pairs(AnimationList) do
                                        if y == v[3] then
                                            if ArrayIndex == 1 then
                                                EmoteCancel()
                                                SetPexIndexClosset(v)
                                            elseif ArrayIndex == 2 then
                                                EmoteCancel()
                                                OnEmotePlay(v)                               
                                            elseif ArrayIndex == 3 then
                                                TriggerServerEvent("pEmotes:saveemote", v, "Emote", v[3], v[3], true)
                                            elseif ArrayIndex == 4 then
                                                local keybindNumber = KeyboardInput("Choisissez le NUMPAD vous souhaitez mettre votre emote (0 - 6)", "", 1)
                                                if tonumber(keybindNumber) and tonumber(keybindNumber) >= 0 and tonumber(keybindNumber) <= 6 then
                                                    TriggerServerEvent("pEmotes:saveemotekeybind", v, "Emote", v[3], v[3], "NUMPAD"..keybindNumber)
                                                    Wait(500)
                                                    ESX.TriggerServerCallback("pEmotes:getAnimations", function(data)
                                                        ArrayEmotesKeyding = data
                                                    end)
                                                else
                                                    ESX.ShowNotification("Le nombre entré est invalide")
                                                end
                                            end   
                                        end                             
                                    end
                                end 
                            })
                        end
                    end
                end)         
                RageUI.IsVisible(subMenu5,function()
                    RageUI.List("Filtre", filterList, filterIndex, nil, {}, true, {
                        onListChange = function(Index)
                            filterIndex = Index
                        end,
                        onSelected = function()
                            local filterNumber = KeyboardInput("Choisissez la lettre que vous souhaitez filtrer", "", 0)
                            if filterNumber then
                                for k,v in pairs(filterList) do
                                    if string.upper(filterNumber) == v then
                                        filterIndex = k
                                    end
                                end
                            end
                        end
                    })
                    RageUI.Button("Par Défaut", nil, {RightLabel = "→"}, true, {
                        onSelected = function()   
                            if GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") then
                                RequestAnimSet("move_m@multiplayer")
                                while not HasAnimSetLoaded("move_m@multiplayer") do
                                    Citizen.Wait(0)
                                end
                                SetPedMovementClipset(PlayerPedId(), "move_m@multiplayer", 0.2)
                            elseif GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then
                                RequestAnimSet("move_f@multiplayer")
                                while not HasAnimSetLoaded("move_f@multiplayer") do
                                    Citizen.Wait(0)
                                end
                                SetPedMovementClipset(PlayerPedId(), "move_f@multiplayer", 0.2)
                            end
                        end
                    })
                    RageUI.Separator("↓ Liste des marches ↓")
                    for k,v in pairsByKeys2(MarcheList) do
                        if starts(k:lower(), filterList[filterIndex]:lower()) or filterList[filterIndex] == "Aucun" then     
                            RageUI.List(k, {"Jouer", "Favoris", "Keybind"}, ArrayIndex7, nil, {}, true, {
                                onListChange = function(Index)
                                    ArrayIndex7 = Index
                                end,
                                onSelected = function()
                                    if ArrayIndex7 == 1 then
                                        RequestAnimSet(v[1])
                                        while not HasAnimSetLoaded(v[1]) do
                                            Citizen.Wait(0)
                                        end
                                        SetPedMovementClipset(PlayerPedId(), v[1], 0.2)
                                    elseif ArrayIndex7 == 2 then
                                        TriggerServerEvent("pEmotes:saveemote", {label = k, name = v[1]}, "Style de marche", k, k, true)  
                                    elseif ArrayIndex7 == 3 then
                                        local keybindNumber = KeyboardInput("Choisissez le NUMPAD vous souhaitez mettre votre emote (0 - 6)", "", 1)
                                        if tonumber(keybindNumber) and tonumber(keybindNumber) >= 0 and tonumber(keybindNumber) <= 6 then 
                                            TriggerServerEvent("pEmotes:saveemotekeybind", {label = k, name = v[1]}, "Style de marche", k, k, "NUMPAD"..keybindNumber)
                                            Wait(500)
                                            ESX.TriggerServerCallback("pEmotes:getAnimations", function(data)
                                                ArrayEmotesKeyding = data
                                            end) 
                                        else
                                            ESX.ShowNotification("Le nombre entré est invalide")
                                        end
                                    end
                                end 
                            })
                        end
                    end
                end)
                RageUI.IsVisible(subMenu6,function()  
                    if not EmoteLoaded then                                            
                        RageUI.Separator("Chargement des emotes favoris...")
                    end
                    if EmoteLoaded then 
                        if #ArrayEmotes == 0 then                            
                            RageUI.Separator("Aucune emote favoris")
                        else 
                            RageUI.List("Filtre", ArrayList5, ArrayIndex5, nil, {}, true, {
                                onListChange = function(Index)
                                    ArrayIndex5 = Index
                                end                      
                            })
                            RageUI.Line()
                            for k,v in pairs(ArrayEmotes) do
                                if v.favorite == "1" then
                                    if v.type == ArrayList5[ArrayIndex5] or ArrayList5[ArrayIndex5] == "Aucun" then
                                        RageUI.List(v.name, {"Visualiser", "Jouer", "Renommer", "Supprimer", "Keybind"}, ArrayIndex4, nil, {}, true, {
                                            onListChange = function(Index)
                                                ArrayIndex4 = Index
                                            end,
                                            onSelected = function()
                                                if ArrayIndex4 == 1 then 
                                                    if v.type == "Emote" then
                                                        EmoteCancel()
                                                        for y,z in pairs(AnimationList) do
                                                            if z[3] == v.originalname then
                                                                SetPexIndexClosset(z)
                                                            end
                                                        end
                                                    elseif v.type == "Emote Partagées" then
                                                        EmoteCancel()
                                                        pedsclone2 = ClonePed(PlayerPedId(), false, false)
                                                        target = ClonePed(PlayerPedId(), false, false)
                                                        SetBlockingOfNonTemporaryEvents(pedsclone2, true)
                                                        SetBlockingOfNonTemporaryEvents(target, true)
                                                        SetEntityAlpha(pedsclone2, 190, 0)
                                                        SetEntityAlpha(target, 190, 0)
                                                        CreateThread(function()
                                                            local anim = v.data['Accepter']
                                                            if v.data['Car'] then
                                                                TaskWarpPedIntoVehicle(target, GetVehiclePedIsUsing(PlayerPedId()), 0)
                                                            end       
                                                            if anim['Attach'] then
                                                                local attach = anim['Attach']
                                                                AttachEntityToEntity(target, pedsclone2, attach['Bone'], attach['xP'], attach['yP'], attach['zP'], attach['xR'], attach['yR'], attach['zR'], 0, 0, 0, 0, 2, 1)
                                                            end    
                                                            Wait(750)     
                                                            if anim['Type'] == 'animation' then
                                                                RequestAnimDict(anim['Dict'])
                                                                while not HasAnimDictLoaded(anim['Dict']) do
                                                                    Wait(0)
                                                                end
                                                                TaskPlayAnim(target, anim['Dict'], anim['Anim'], 8.0, -8.0, -1, anim['Flags'] or 0, 0, false, false, false)
                                                            end  
                                                            anim = v.data['Requester']                          
                                                            while not IsEntityPlayingAnim(pedsclone2, anim['Dict'], anim['Anim'], 3) do
                                                                Wait(0)
                                                                SetEntityNoCollisionEntity(PlayerPedId(), pedsclone2, true)
                                                                SetEntityNoCollisionEntity(PlayerPedId(), target, true)
                                                                SetEntityNoCollisionEntity(target, pedsclone2, true)
                                                            end
                                                            DetachEntity(target)
                                                            while IsEntityPlayingAnim(pedsclone2, anim['Dict'], anim['Anim'], 3) do
                                                                Wait(0)
                                                                SetEntityNoCollisionEntity(PlayerPedId(), pedsclone2, true)
                                                                SetEntityNoCollisionEntity(PlayerPedId(), target, true)
                                                                SetEntityNoCollisionEntity(target, pedsclone2, true)
                                                            end      
                                                            ClearPedTasks(target)
                                                            DeleteEntity(target)     
                                                        end)
                                                        CreateThread(function()
                                                            local anim = v.data['Requester']
                                                            if anim['Attach'] then
                                                                local attach = anim['Attach']
                                                                AttachEntityToEntity(pedsclone2, target, attach['Bone'], attach['xP'], attach['yP'], attach['zP'], attach['xR'], attach['yR'], attach['zR'], 0, 0, 0, 0, 2, 1)
                                                            end    
                                                            Wait(750)      
                                                            if anim['Type'] == 'animation' then
                                                                PlayAnim(pedsclone2, anim['Dict'], anim['Anim'], anim['Flags'])
                                                            end    
                                                            anim = v.data['Accepter']       
                                                            while not IsEntityPlayingAnim(target, anim['Dict'], anim['Anim'], 3) do
                                                                Wait(0)
                                                                SetEntityNoCollisionEntity(pedsclone2, target, true)
                                                            end
                                                            DetachEntity(pedsclone2)
                                                            while IsEntityPlayingAnim(target, anim['Dict'], anim['Anim'], 3) do
                                                                Wait(0)
                                                                SetEntityNoCollisionEntity(pedsclone2, target, true)
                                                            end       
                                                            ClearPedTasks(pedsclone2)
                                                            DeleteEntity(pedsclone2)
                                                        end)
                                                    end
                                                elseif ArrayIndex4 == 2 then  
                                                    if v.type == "Emote" then 
                                                        EmoteCancel()
                                                        for y,z in pairs(AnimationList) do
                                                            if z[3] == v.originalname then
                                                                OnEmotePlay(z) 
                                                            end
                                                        end
                                                    elseif v.type == "Emote Partagées" then
                                                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                                        if closestPlayer ~= -1 and closestDistance < 2.0 then
                                                            TriggerServerEvent('pEmotes:requestSynced', GetPlayerServerId(closestPlayer), v.data)
                                                        end
                                                    elseif v.type == "Style de marche" then
                                                        RequestAnimSet(v.data.name)
                                                        while not HasAnimSetLoaded(v.data.name) do
                                                            Citizen.Wait(0)
                                                        end
                                                        SetPedMovementClipset(PlayerPedId(), v.data.name, 0.2)
                                                    end
                                                elseif ArrayIndex4 == 3 then
                                                    local rename = KeyboardInput("Renomé votre animation", false, 40, "small_text")
                                                    if rename then 
                                                        TriggerServerEvent("pEmotes:renameAnimation", v.id, rename)
                                                        Wait(100)
                                                        ESX.TriggerServerCallback("pEmotes:getAnimations", function(data)
                                                            ArrayEmotes = data
                                                        end)
                                                    end
                                                elseif ArrayIndex4 == 4 then
                                                    TriggerServerEvent("pEmotes:removeAnimation", v, "favorite")
                                                    Wait(100)
                                                    ESX.TriggerServerCallback("pEmotes:getAnimations", function(data)
                                                        ArrayEmotes = data
                                                    end)
                                                elseif ArrayIndex4 == 5 then
                                                    local keybindNumber = KeyboardInput("Choisissez le NUMPAD vous souhaitez mettre votre emote (0 - 6)", "", 0)
                                                    if tonumber(keybindNumber) and tonumber(keybindNumber) >= 0 and tonumber(keybindNumber) <= 6 then
                                                        TriggerServerEvent("pEmotes:saveemotekeybind", v.data, v.type, v.name, v.originalname, "NUMPAD"..keybindNumber)
                                                    else
                                                        ESX.ShowNotification("Le nombre entré est invalide")
                                                    end
                                                end                                           
                                            end 
                                        })
                                    end
                                end
                            end
                        end                  
                    end
                end)
                RageUI.IsVisible(subMenu7,function()  
                    if not EmoteLoaded then                     
                        RageUI.Separator("Chargement des emotes keybind...")
                    end
                    if EmoteLoaded then 
                        if #ArrayEmotesKeyding == 0 then 
                            RageUI.Separator("Aucune emote keybind")
                        else 
                            for k,v in pairs(ArrayEmotesKeyding) do
                                if v.keybind ~= nil then
                                    RageUI.List(v.name.." [~b~"..v.keybind.."~s~]", {"Visualiser", "Jouer", "Renommer", "Supprimer", "Favoris"}, ArrayIndex8, nil, {}, true, {
                                        onListChange = function(Index)
                                            ArrayIndex8 = Index
                                        end,
                                        onSelected = function()
                                            if ArrayIndex8 == 1 then 
                                                if v.type == "Emote" then
                                                    EmoteCancel()
                                                    for y,z in pairs(AnimationList) do
                                                        if z[3] == v.originalname then
                                                            SetPexIndexClosset(z)
                                                        end
                                                    end
                                                elseif v.type == "Emote Partagées" then
                                                    EmoteCancel()
                                                    pedsclone2 = ClonePed(PlayerPedId(), false, false)
                                                    target = ClonePed(PlayerPedId(), false, false)
                                                    SetBlockingOfNonTemporaryEvents(pedsclone2, true)
                                                    SetBlockingOfNonTemporaryEvents(target, true)
                                                    SetEntityAlpha(pedsclone2, 190, 0)
                                                    SetEntityAlpha(target, 190, 0)
                                                    CreateThread(function()
                                                        local anim = v.data['Accepter']
                                                        if v.data['Car'] then
                                                            TaskWarpPedIntoVehicle(target, GetVehiclePedIsUsing(PlayerPedId()), 0)
                                                        end       
                                                        if anim['Attach'] then
                                                            local attach = anim['Attach']
                                                            AttachEntityToEntity(target, pedsclone2, attach['Bone'], attach['xP'], attach['yP'], attach['zP'], attach['xR'], attach['yR'], attach['zR'], 0, 0, 0, 0, 2, 1)
                                                        end    
                                                        Wait(750)     
                                                        if anim['Type'] == 'animation' then
                                                            RequestAnimDict(anim['Dict'])
                                                            while not HasAnimDictLoaded(anim['Dict']) do
                                                                Wait(0)
                                                            end
                                                            TaskPlayAnim(target, anim['Dict'], anim['Anim'], 8.0, -8.0, -1, anim['Flags'] or 0, 0, false, false, false)
                                                        end  
                                                        anim = v.data['Requester']                          
                                                        while not IsEntityPlayingAnim(pedsclone2, anim['Dict'], anim['Anim'], 3) do
                                                            Wait(0)
                                                            SetEntityNoCollisionEntity(PlayerPedId(), pedsclone2, true)
                                                            SetEntityNoCollisionEntity(PlayerPedId(), target, true)
                                                            SetEntityNoCollisionEntity(target, pedsclone2, true)
                                                        end
                                                        DetachEntity(target)
                                                        while IsEntityPlayingAnim(pedsclone2, anim['Dict'], anim['Anim'], 3) do
                                                            Wait(0)
                                                            SetEntityNoCollisionEntity(PlayerPedId(), pedsclone2, true)
                                                            SetEntityNoCollisionEntity(PlayerPedId(), target, true)
                                                            SetEntityNoCollisionEntity(target, pedsclone2, true)
                                                        end      
                                                        ClearPedTasks(target)
                                                        DeleteEntity(target)     
                                                    end)
                                                    CreateThread(function()
                                                        local anim = v.data['Requester']
                                                        if anim['Attach'] then
                                                            local attach = anim['Attach']
                                                            AttachEntityToEntity(pedsclone2, target, attach['Bone'], attach['xP'], attach['yP'], attach['zP'], attach['xR'], attach['yR'], attach['zR'], 0, 0, 0, 0, 2, 1)
                                                        end    
                                                        Wait(750)      
                                                        if anim['Type'] == 'animation' then
                                                            PlayAnim(pedsclone2, anim['Dict'], anim['Anim'], anim['Flags'])
                                                        end    
                                                        anim = v.data['Accepter']       
                                                        while not IsEntityPlayingAnim(target, anim['Dict'], anim['Anim'], 3) do
                                                            Wait(0)
                                                            SetEntityNoCollisionEntity(pedsclone2, target, true)
                                                        end
                                                        DetachEntity(pedsclone2)
                                                        while IsEntityPlayingAnim(target, anim['Dict'], anim['Anim'], 3) do
                                                            Wait(0)
                                                            SetEntityNoCollisionEntity(pedsclone2, target, true)
                                                        end       
                                                        ClearPedTasks(pedsclone2)
                                                        DeleteEntity(pedsclone2)
                                                    end)
                                                end
                                            elseif ArrayIndex8 == 2 then  
                                                if v.type == "Emote" then 
                                                    EmoteCancel()
                                                    for y,z in pairs(AnimationList) do
                                                        if z[3] == v.originalname then           
                                                            OnEmotePlay(z) 
                                                        end
                                                    end
                                                elseif v.type == "Emote Partagées" then
                                                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                                    if closestPlayer ~= -1 and closestDistance < 2.0 then
                                                        TriggerServerEvent('pEmotes:requestSynced', GetPlayerServerId(closestPlayer), v.data)
                                                    end
                                                elseif v.type == "Style de marche" then
                                                    RequestAnimSet(v.data.name)
                                                    while not HasAnimSetLoaded(v.data.name) do
                                                        Citizen.Wait(0)
                                                    end
                                                    SetPedMovementClipset(PlayerPedId(), v.data.name, 0.2)
                                                end
                                            elseif ArrayIndex8 == 3 then
                                                local rename = KeyboardInput("Renomé votre animation", false, 40, "small_text")
                                                if rename then 
                                                    TriggerServerEvent("pEmotes:renameAnimation", v.id, rename)
                                                    Wait(100)
                                                    ESX.TriggerServerCallback("pEmotes:getAnimations", function(data)
                                                        ArrayEmotesKeyding = data
                                                    end)
                                                end
                                            elseif ArrayIndex8 == 4 then
                                                TriggerServerEvent("pEmotes:removeAnimation", v, "keybind")
                                                Wait(100)
                                                ESX.TriggerServerCallback("pEmotes:getAnimations", function(data)
                                                    ArrayEmotesKeyding = data
                                                end)
                                            elseif ArrayIndex8 == 5 then
                                                TriggerServerEvent("pEmotes:saveemote", v.data, v.type, v.name, v.originalname, true)  
                                            end                                           
                                        end 
                                    })
                                end
                            end
                        end                  
                    end
                end)
            Wait(0)
            end
        end)
    end
end

Keys.Register(pEmotes.Key, 'menuemotes', 'Ouvrir le menu emotes', function()
	MenuEmote()
end)

Keys.Register(pEmotes.KeyCancelEmote, 'cancelemote', 'Arrêter l\'animation', function()
    EmoteCancel()
end)

function EmoteCancel()
    if ChosenDict == "MaleScenario" and IsInAnimation then
        ClearPedTasksImmediately(PlayerPedId())
        IsInAnimation = false
    elseif ChosenDict == "Scenario" and IsInAnimation then
        ClearPedTasksImmediately(PlayerPedId())
        IsInAnimation = false
    end

    PtfxNotif = false
    PtfxPrompt = false
  
    if IsInAnimation then
      ClearPedTasks(GetPlayerPed(-1))
      ClearPedSecondaryTask(GetPlayerPed(-1))
      DestroyAllProps()
      IsInAnimation = false
    end
    DeleteEntity(peds)
    DeleteEntity(pedsclone2)
    DeleteEntity(target)
end

Keys.Register("NUMPAD1", 'keybind1', 'Emote n°1', function()
    for k,v in pairs(ArrayEmotesKeyding) do
        if v.keybind == "NUMPAD1" then
            KeyPlayEmote(v)
        end
    end
end)

Keys.Register("NUMPAD2", 'keybind2', 'Emote n°2', function()
    for k,v in pairs(ArrayEmotesKeyding) do
        if v.keybind == "NUMPAD2" then
            KeyPlayEmote(v)
        end
    end
end)

Keys.Register("NUMPAD3", 'keybind3', 'Emote n°3', function()
    for k,v in pairs(ArrayEmotesKeyding) do
        if v.keybind == "NUMPAD3" then
            KeyPlayEmote(v)
        end
    end
end)

Keys.Register("NUMPAD4", 'keybind4', 'Emote n°4', function()
    for k,v in pairs(ArrayEmotesKeyding) do
        if v.keybind == "NUMPAD4" then
            KeyPlayEmote(v)
        end
    end
end)

Keys.Register("NUMPAD5", 'keybind5', 'Emote n°5', function()
    for k,v in pairs(ArrayEmotesKeyding) do
        if v.keybind == "NUMPAD5" then
            KeyPlayEmote(v)
        end
    end
end)

Keys.Register("NUMPAD6", 'keybind6', 'Emote n°6', function()
    for k,v in pairs(ArrayEmotesKeyding) do
        if v.keybind == "NUMPAD6" then
            KeyPlayEmote(v)
        end
    end
end)

function KeyPlayEmote(v)
    if v.type == "Emote" then 
        EmoteCancel()
        for y,z in pairs(AnimationList) do
            if z[3] == v.originalname then
                OnEmotePlay(z) 
            end
        end
    elseif v.type == "Emote Partagées" then
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        if closestPlayer ~= -1 and closestDistance < 2.0 then
            TriggerServerEvent('pEmotes:requestSynced', GetPlayerServerId(closestPlayer), v.data)
        end
    elseif v.type == "Style de marche" then
        RequestAnimSet(v.data.name)
        while not HasAnimSetLoaded(v.data.name) do
            Citizen.Wait(0)
        end
        SetPedMovementClipset(PlayerPedId(), v.data.name, 0.2)
    end
end