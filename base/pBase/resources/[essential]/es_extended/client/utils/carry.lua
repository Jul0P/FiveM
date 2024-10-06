if Config.ActivateCarry.Activate then
    local piggyBackInProgress = false

    -- Citizen.CreateThread(function()
    --     while true do
    --         if piggyBackInProgress then
    --             local playerPed = PlayerPedId()
    --             local closestPlayer, distance = ESX.Game.GetClosestPlayer()
    --             local closestPed = GetPlayerPed(closestPlayer)
    --             if IsPedInAnyVehicle(playerPed, true) and not IsPedDeadOrDying(closestPed, 0) then
    --                 piggyBackInProgress = false
    --                 ClearPedSecondaryTask(PlayerPedId())
    --                 DetachEntity(PlayerPedId(), true, false)
    --                 DetachEntity(closestPed, true, false)
    --                 TriggerServerEvent('pBase:carryStop', GetPlayerServerId(closestPlayer))
    --             end
    --         end
    --         Citizen.Wait(1000)
    --     end
    -- end)

    if Config.ActivateCarry.CommandFR then
        RegisterCommand('porter', function(source, args)
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            if closestDistance ~= -1 and closestDistance <= 3 then 
                Carry(source, args)
            else
                ESX.ShowNotification("Aucune personne à proximité")
            end
        end, false)
    end
    if Config.ActivateCarry.CommandENG then
        RegisterCommand('carry', function(source, args)
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            if closestDistance ~= -1 and closestDistance <= 3 then 
                Carry(source, args)
            else
                ESX.ShowNotification("Aucune personne à proximité")
            end
        end, false)
    end
    function Carry(source, args)
        if not piggyBackInProgress then
            piggyBackInProgress = true
            local lib = 'anim@arena@celeb@flat@paired@no_props@'
            local anim1 = 'piggyback_c_player_a'
            local anim2 = 'piggyback_c_player_b'
            local closestPlayer, distance = ESX.Game.GetClosestPlayer()
            if closestPlayer ~= nil and distance < 3 then
                TriggerServerEvent('pBase:carry', GetPlayerServerId(closestPlayer), lib, anim1, anim2, -0.07, 0.0, 0.45, 100000, 0.0, 49, 33, 1)
            else
                piggyBackInProgress = false
            end
        else
            piggyBackInProgress = false
            ClearPedSecondaryTask(PlayerPedId())
            DetachEntity(PlayerPedId(), true, false)
            local closestPlayer, distance = ESX.Game.GetClosestPlayer()
            if closestPlayer == nil and distance < 3 then 
                return 
            end
            local closestPed = GetPlayerPed(closestPlayer)
            ClearPedSecondaryTask(closestPed)
            DetachEntity(closestPed, true, false)
            TriggerServerEvent('pBase:carryStop', GetPlayerServerId(closestPlayer))
        end
    end

    RegisterNetEvent('pBase:carryTarget')
    AddEventHandler('pBase:carryTarget', function(target, animationLib, animation2, distans, distans2, height, length,spin,controlFlag)
        local playerPed = PlayerPedId()
        local playerServer = GetPlayerFromServerId(target)
        if playerServer == -1 then return end

        local targetPed = GetPlayerPed(playerServer)
        piggyBackInProgress = true
        RequestAnimDict(animationLib)

        while not HasAnimDictLoaded(animationLib) do
            Citizen.Wait(10)
        end
        if spin == nil then spin = 180.0 end
        AttachEntityToEntity(playerPed, targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)
        if controlFlag == nil then controlFlag = 0 end
        TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
    end)

    RegisterNetEvent('pBase:carrySync')
    AddEventHandler('pBase:carrySync', function(animationLib, animation,length,controlFlag,animFlag)
        local playerPed = PlayerPedId()
        RequestAnimDict(animationLib)

        while not HasAnimDictLoaded(animationLib) do
            Citizen.Wait(10)
        end
        Wait(500)
        if controlFlag == nil then controlFlag = 0 end
        TaskPlayAnim(playerPed, animationLib, animation, 8.0, -8.0, length, controlFlag, 0, false, false, false)

        Citizen.Wait(length)
    end)

    RegisterNetEvent('pBase:carryStopTarget')
    AddEventHandler('pBase:carryStopTarget', function(target)
        local playerPed = PlayerPedId()
        local pid = GetPlayerFromServerId(target)
        if pid == -1 then
        
            return
        end
        local targetPed = GetPlayerPed(pid)
        piggyBackInProgress = false
        ClearPedSecondaryTask(PlayerPedId())
        ClearPedSecondaryTask(playerPed)
        DetachEntity(GetPlayerPed(GetPlayerFromServerId(target)), true, false)
        DetachEntity(playerPed, true, false)
    end)
end