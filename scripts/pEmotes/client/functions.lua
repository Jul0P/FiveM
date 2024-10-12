function LoadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
       Wait(1)
    end
end

function TaskAnim(ped, animDict, animName)
    LoadAnimDict(animDict)
    TaskPlayAnim(ped, animDict, animName, 1.0, -1.0, -1, 1, 1, false, false, false)
end

function PlayAnim(peds, Dict, Anim, Flag)
    RequestAnimDict(Dict)
    while not HasAnimDictLoaded(Dict) do
        Citizen.Wait(0)
    end
    TaskPlayAnim(peds, Dict, Anim, 8.0, -8.0, -1, Flag or 0, 0, false, false, false)
end

function SetPexIndexClosset(EmoteName)
    Citizen.CreateThread(function()
        DeleteEntity(peds)
        peds = ClonePed(PlayerPedId(), false, false)
        Coords = GetEntityCoords(PlayerPedId())
        SetEntityAlpha(peds, 200)
        SetEntityCollision(peds, false, false)
        SetEntityCoords(peds, Coords.x, Coords.y, Coords.z)
        AttachEntityToEntity(peds, PlayerPedId(), 0, 0.0, 0.2, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 0, 1)
        FreezeEntityPosition(peds, true)
        SetBlockingOfNonTemporaryEvents(peds, true)
        SetEntityInvincible(peds, true)

        InVehicle = IsPedInAnyVehicle(PlayerPedId(), true)
        if not DoesEntityExist(GetPlayerPed(-1)) then
            return false
        end
        if IsPedArmed(GetPlayerPed(-1), 7) then
            SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey('WEAPON_UNARMED'), true)
        end
        ChosenDict,ChosenAnimation,ename = table.unpack(EmoteName)
        AnimationDuration = -1
        if PlayerHasProp then
            DestroyAllProps()
        end
        if ChosenDict == "Expression" then
            SetFacialIdleAnimOverride(peds, ChosenAnimation, 0)
            return
        end
        if ChosenDict == "MaleScenario" or "Scenario" then 
            CheckGender()
            if ChosenDict == "MaleScenario" then 
                if InVehicle then 
                    return 
                end
                if PlayerGender == "male" then
                    ClearPedTasks(peds)
                    TaskStartScenarioInPlace(peds, ChosenAnimation, 0, true)
                    IsInAnimation = true
                end 
                return
            elseif ChosenDict == "ScenarioObject" then 
                if InVehicle then 
                    return 
                end
                BehindPlayer = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0 - 0.5, -0.5);
                ClearPedTasks(peds)
                TaskStartScenarioAtPosition(peds, ChosenAnimation, BehindPlayer['x'], BehindPlayer['y'], BehindPlayer['z'], GetEntityHeading(PlayerPedId()), 0, 1, false)
                IsInAnimation = true
                return
            elseif ChosenDict == "Scenario" then 
                if InVehicle then 
                    return 
                end
                ClearPedTasks(peds)
                TaskStartScenarioInPlace(peds, ChosenAnimation, 0, true)
                IsInAnimation = true
                return 
            end 
        end
        LoadAnimDict(ChosenDict)
        if EmoteName.AnimationOptions then
            if EmoteName.AnimationOptions.EmoteLoop then
                MovementType = 1
                if EmoteName.AnimationOptions.EmoteMoving then
                    MovementType = 51
                end
            elseif EmoteName.AnimationOptions.EmoteMoving then
                MovementType = 51
            elseif EmoteName.AnimationOptions.EmoteMoving == false then
                MovementType = 0
            elseif EmoteName.AnimationOptions.EmoteStuck then
                MovementType = 50
            end
        else
            MovementType = 0
        end
        if InVehicle == 1 then
            MovementType = 51
        end
        if EmoteName.AnimationOptions then
            if EmoteName.AnimationOptions.EmoteDuration == nil then 
                EmoteName.AnimationOptions.EmoteDuration = -1
                AttachWait = 0
            else
                AnimationDuration = EmoteName.AnimationOptions.EmoteDuration
                AttachWait = EmoteName.AnimationOptions.EmoteDuration
            end
            if EmoteName.AnimationOptions.PtfxAsset then
                PtfxAsset = EmoteName.AnimationOptions.PtfxAsset
                PtfxName = EmoteName.AnimationOptions.PtfxName
                if EmoteName.AnimationOptions.PtfxNoProp then
                    PtfxNoProp = EmoteName.AnimationOptions.PtfxNoProp
                else
                    PtfxNoProp = false
                end
                Ptfx1, Ptfx2, Ptfx3, Ptfx4, Ptfx5, Ptfx6, PtfxScale = table.unpack(EmoteName.AnimationOptions.PtfxPlacement)
                PtfxInfo = EmoteName.AnimationOptions.PtfxInfo
                PtfxWait = EmoteName.AnimationOptions.PtfxWait
                PtfxNotif = false
                PtfxPrompt = true
                PtfxThis(PtfxAsset)
            else
                PtfxPrompt = false
            end
        end
    
        TaskPlayAnim(peds, ChosenDict, ChosenAnimation, 2.0, 2.0, AnimationDuration, MovementType, 0, false, false, false)
        RemoveAnimDict(ChosenDict)
        IsInAnimation = true
        MostRecentDict = ChosenDict
        MostRecentAnimation = ChosenAnimation

        if EmoteName.AnimationOptions then
            if EmoteName.AnimationOptions.Prop then
                PropName = EmoteName.AnimationOptions.Prop
                PropBone = EmoteName.AnimationOptions.PropBone
                PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6 = table.unpack(EmoteName.AnimationOptions.PropPlacement)
                if EmoteName.AnimationOptions.SecondProp then
                    SecondPropName = EmoteName.AnimationOptions.SecondProp
                    SecondPropBone = EmoteName.AnimationOptions.SecondPropBone
                    SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6 = table.unpack(EmoteName.AnimationOptions.SecondPropPlacement)
                    SecondPropEmote = true
                else
                    SecondPropEmote = false
                end
                Wait(AttachWait)
                AddPropToPlayer2(PropName, PropBone, PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6)
                if SecondPropEmote then
                    AddPropToPlayer2(SecondPropName, SecondPropBone, SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6)
                end
            end
        end
        return true
        --DeleteEntity(peds) il faut ré appuyer sur le bouton
    end)
end

RegisterNetEvent('pEmotes:syncRequest')
AddEventHandler('pEmotes:syncRequest', function(requester, v, name)
    local accepted = false
    local timer = GetGameTimer() + 5000
    ESX.ShowNotification("~b~Emote Partagé: ~s~"..v["Label"].."\nAppuyez sur ~g~E~s~ pour accepter")
    while timer >= GetGameTimer() do 
        Wait(0)
        if IsControlJustReleased(0, 194) then
            break
        elseif IsControlJustReleased(0, 51) then
            accepted = true
            break
        end
    end
    if accepted then
        TriggerServerEvent('pEmotes:syncAccepted', requester, v)
    end
end)

RegisterNetEvent('pEmotes:playSynced')
AddEventHandler('pEmotes:playSynced', function(serverid, v, type)
    local anim = v[type]

    local target = GetPlayerPed(GetPlayerFromServerId(serverid))
    if anim['Attach'] then
        local attach = anim['Attach']
        AttachEntityToEntity(PlayerPedId(), target, attach['Bone'], attach['xP'], attach['yP'], attach['zP'], attach['xR'], attach['yR'], attach['zR'], 0, 0, 0, 0, 2, 1)
    end
    Wait(750)
    if anim['Type'] == 'animation' then
        PlayAnim(PlayerPedId(), anim['Dict'], anim['Anim'], anim['Flags'])
    end
    if type == 'Requester' then
        anim = v['Accepter']
    else
        anim = v['Requester']
    end
    while not IsEntityPlayingAnim(target, anim['Dict'], anim['Anim'], 3) do
        Wait(0)
        SetEntityNoCollisionEntity(PlayerPedId(), target, true)
    end
    DetachEntity(PlayerPedId())
    while IsEntityPlayingAnim(target, anim['Dict'], anim['Anim'], 3) do
        Wait(0)
        SetEntityNoCollisionEntity(PlayerPedId(), target, true)
    end
    ClearPedTasks(PlayerPedId())
end)

PlayerProps = {}

function DestroyAllProps()
    for _, v in pairs(PlayerProps) do
        DeleteEntity(v)
    end
    PlayerHasProp = false
end

function AddPropToPlayer(prop1, bone, off1, off2, off3, rot1, rot2, rot3)
    local Player = PlayerPedId()
    local x, y, z = table.unpack(GetEntityCoords(Player))
    if not HasModelLoaded(prop1) then
        LoadPropDict(prop1)
    end
    prop = CreateObject(GetHashKey(prop1), x, y, z + 0.2, true, true, true)
    AttachEntityToEntity(prop, Player, GetPedBoneIndex(Player, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)
    table.insert(PlayerProps, prop)
    PlayerHasProp = true
    SetModelAsNoLongerNeeded(prop1)
end

function AddPropToPlayer2(prop1, bone, off1, off2, off3, rot1, rot2, rot3)
    local x, y, z = table.unpack(GetEntityCoords(peds))
    if not HasModelLoaded(prop1) then
        LoadPropDict(prop1)
    end
    prop = CreateObject(GetHashKey(prop1), x, y, z + 0.2, true, true, true)
    AttachEntityToEntity(prop, peds, GetPedBoneIndex(peds, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)
    table.insert(PlayerProps, prop)
    PlayerHasProp = true
    SetModelAsNoLongerNeeded(prop1)
end

PlayerHasProp = false

function CheckGender()
    local hashSkinMale = GetHashKey("mp_m_freemode_01")
    local hashSkinFemale = GetHashKey("mp_f_freemode_01")
    if GetEntityModel(PlayerPedId()) == hashSkinMale then
        PlayerGender = "male"
    elseif GetEntityModel(PlayerPedId()) == hashSkinFemale then
         PlayerGender = "female"
    end
end

function OnEmotePlay(EmoteName)
    InVehicle = IsPedInAnyVehicle(PlayerPedId(), true)
    -- if not Config.AllowedInCars and InVehicle == 1 then
    --     return
    -- end
    if not DoesEntityExist(GetPlayerPed(-1)) then
        return false
    end
    if IsPedArmed(GetPlayerPed(-1), 7) then
        SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey('WEAPON_UNARMED'), true)
    end
    ChosenDict,ChosenAnimation,ename = table.unpack(EmoteName)
    AnimationDuration = -1
    if PlayerHasProp then
        DestroyAllProps()
    end
    if ChosenDict == "Expression" then
        SetFacialIdleAnimOverride(PlayerPedId(), ChosenAnimation, 0)
        return
    end
    if ChosenDict == "MaleScenario" or "Scenario" then 
        CheckGender()
        if ChosenDict == "MaleScenario" then 
            if InVehicle then 
                return 
            end
            if PlayerGender == "male" then
                ClearPedTasks(GetPlayerPed(-1))
                TaskStartScenarioInPlace(GetPlayerPed(-1), ChosenAnimation, 0, true)
                IsInAnimation = true
            end 
            return
        elseif ChosenDict == "ScenarioObject" then 
            if InVehicle then 
                return 
            end
            BehindPlayer = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0 - 0.5, -0.5);
            ClearPedTasks(GetPlayerPed(-1))
            TaskStartScenarioAtPosition(GetPlayerPed(-1), ChosenAnimation, BehindPlayer['x'], BehindPlayer['y'], BehindPlayer['z'], GetEntityHeading(PlayerPedId()), 0, 1, false)
            IsInAnimation = true
            return
        elseif ChosenDict == "Scenario" then 
            if InVehicle then 
                return 
            end
            ClearPedTasks(GetPlayerPed(-1))
            TaskStartScenarioInPlace(GetPlayerPed(-1), ChosenAnimation, 0, true)
            IsInAnimation = true
            return 
        end 
    end
    LoadAnimDict(ChosenDict)
    if EmoteName.AnimationOptions then
        if EmoteName.AnimationOptions.EmoteLoop then
            MovementType = 1
            if EmoteName.AnimationOptions.EmoteMoving then
                MovementType = 51
            end
        elseif EmoteName.AnimationOptions.EmoteMoving then
            MovementType = 51
        elseif EmoteName.AnimationOptions.EmoteMoving == false then
            MovementType = 0
        elseif EmoteName.AnimationOptions.EmoteStuck then
            MovementType = 50
        end
    else
        MovementType = 0
    end
    if InVehicle == 1 then
        MovementType = 51
    end
    if EmoteName.AnimationOptions then
        if EmoteName.AnimationOptions.EmoteDuration == nil then 
            EmoteName.AnimationOptions.EmoteDuration = -1
            AttachWait = 0
        else
            AnimationDuration = EmoteName.AnimationOptions.EmoteDuration
            AttachWait = EmoteName.AnimationOptions.EmoteDuration
        end
        if EmoteName.AnimationOptions.PtfxAsset then
            PtfxAsset = EmoteName.AnimationOptions.PtfxAsset
            PtfxName = EmoteName.AnimationOptions.PtfxName
            if EmoteName.AnimationOptions.PtfxNoProp then
                PtfxNoProp = EmoteName.AnimationOptions.PtfxNoProp
            else
                PtfxNoProp = false
            end
            Ptfx1, Ptfx2, Ptfx3, Ptfx4, Ptfx5, Ptfx6, PtfxScale = table.unpack(EmoteName.AnimationOptions.PtfxPlacement)
            PtfxInfo = EmoteName.AnimationOptions.PtfxInfo
            PtfxWait = EmoteName.AnimationOptions.PtfxWait
            PtfxNotif = false
            PtfxPrompt = true
            PtfxThis(PtfxAsset)
        else
            PtfxPrompt = false
        end
    end
  
    TaskPlayAnim(GetPlayerPed(-1), ChosenDict, ChosenAnimation, 2.0, 2.0, AnimationDuration, MovementType, 0, false, false, false)
    RemoveAnimDict(ChosenDict)
    IsInAnimation = true
    MostRecentDict = ChosenDict
    MostRecentAnimation = ChosenAnimation
  
    if EmoteName.AnimationOptions then
        if EmoteName.AnimationOptions.Prop then
            PropName = EmoteName.AnimationOptions.Prop
            PropBone = EmoteName.AnimationOptions.PropBone
            PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6 = table.unpack(EmoteName.AnimationOptions.PropPlacement)
            if EmoteName.AnimationOptions.SecondProp then
                SecondPropName = EmoteName.AnimationOptions.SecondProp
                SecondPropBone = EmoteName.AnimationOptions.SecondPropBone
                SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6 = table.unpack(EmoteName.AnimationOptions.SecondPropPlacement)
                SecondPropEmote = true
            else
                SecondPropEmote = false
            end
            Wait(AttachWait)
            AddPropToPlayer(PropName, PropBone, PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6)
            if SecondPropEmote then
                AddPropToPlayer(SecondPropName, SecondPropBone, SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6)
            end
        end
    end
    return true
end

function pairsByKeys(t, z)
    local a = {}
    for n,v in pairs(t) do
        if z == v[4] then
            table.insert(a, v[3])
        end
    end
    table.sort(a)
    local i = 0      -- iterator variable
    local iter = function ()   -- iterator function
        i = i + 1
        if a[i] == nil then
            return nil
        else
            return a[i], t[a[i]]
        end
    end
    return iter
end

function pairsByKeys2(t, f)
    local a = {}
    for n,v in pairs(t) do
        table.insert(a, n)
    end
    table.sort(a, f)
    local i = 0      -- iterator variable
    local iter = function ()   -- iterator function
        i = i + 1
        if a[i] == nil then
            return nil
        else
            return a[i], t[a[i]]
        end
    end
    return iter
end

function LoadAnim(dict)
    if not DoesAnimDictExist(dict) then
        return false
    end
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(10)
    end
    return true
end

function LoadPropDict(model)
    while not HasModelLoaded(GetHashKey(model)) do
        RequestModel(GetHashKey(model))
        Wait(10)
    end
end

function PtfxThis(asset)
    while not HasNamedPtfxAssetLoaded(asset) do
        RequestNamedPtfxAsset(asset)
        Wait(10)
    end
    UseParticleFxAssetNextCall(asset)
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

function sharedemote(v)
    Citizen.CreateThread(function()
        pedsclone2 = ClonePed(PlayerPedId(), false, false)
        target = ClonePed(PlayerPedId(), false, false)
        SetBlockingOfNonTemporaryEvents(pedsclone2, true)
        SetBlockingOfNonTemporaryEvents(target, true)
        SetEntityAlpha(pedsclone2, 190, 0)
        SetEntityAlpha(target, 190, 0)
        CreateThread(function()
            local anim = v['Accepter']
            if v['Car'] then
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
            anim = v['Requester']                          
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
            local anim = v['Requester']
            if anim['Attach'] then
                local attach = anim['Attach']
                AttachEntityToEntity(pedsclone2, target, attach['Bone'], attach['xP'], attach['yP'], attach['zP'], attach['xR'], attach['yR'], attach['zR'], 0, 0, 0, 0, 2, 1)
            end    
            Wait(750)      
            if anim['Type'] == 'animation' then
                PlayAnim(pedsclone2, anim['Dict'], anim['Anim'], anim['Flags'])
            end    
            anim = v['Accepter']       
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
    end)
end

RegisterNetEvent('pEmotes:Command')
AddEventHandler('pEmotes:Command', function(args)
    target_animation = args
    for k, v in pairs(AnimationList) do
        if k == target_animation then
            if IsInAnimation then
                EmoteCancel()
            end
            Citizen.CreateThread(function()
                OnEmotePlay(v)
            end)
        end
    end
end)