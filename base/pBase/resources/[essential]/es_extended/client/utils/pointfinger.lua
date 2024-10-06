if Config.ActivatePointFinger.Activate then
    pointing = false
    local function startPointing(plyPed)
        ESX.Streaming.RequestAnimDict("anim@mp_point", function()
            SetPedConfigFlag(plyPed, 36, 1)
            TaskMoveNetworkByName(plyPed, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
            RemoveAnimDict("anim@mp_point")
        end)
    end
    
    local function stopPointing(plyPed)
        RequestTaskMoveNetworkStateTransition(plyPed, "Stop")
    
        if not IsPedInjured(plyPed) then
            ClearPedSecondaryTask(plyPed)
        end
    
        SetPedConfigFlag(plyPed, 36, 0)
        ClearPedSecondaryTask(plyPed)
    end
    
    function CrouchAndPointing()
        CAP = not CAP
        Citizen.CreateThread(function()
            while CAP do
                Citizen.Wait(10)
                if handsup or pointing or crouched then
                    if not IsPedOnFoot(PlayerPedId()) then
                        ResetPedMovementClipset(PlayerPedId(), 0)
                        stopPointing()
                        handsup, pointing, crouched = false, false, false
                    elseif pointing then
                        local camPitch = GetGameplayCamRelativePitch()
    
                        if camPitch < -70.0 then
                            camPitch = -70.0
                        elseif camPitch > 42.0 then
                            camPitch = 42.0
                        end
    
                        camPitch = (camPitch + 70.0) / 112.0
    
                        local camHeading = GetGameplayCamRelativeHeading()
                        local cosCamHeading = Cos(camHeading)
                        local sinCamHeading = Sin(camHeading)
    
                        if camHeading < -180.0 then
                            camHeading = -180.0
                        elseif camHeading > 180.0 then
                            camHeading = 180.0
                        end
    
                        camHeading = (camHeading + 180.0) / 360.0 
                        local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
                        local rayHandle, blocked = GetShapeTestResult(StartShapeTestCapsule(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, PlayerPedId(), 7))
    
                        SetTaskMoveNetworkSignalFloat(PlayerPedId(), "Pitch", camPitch)
                        SetTaskMoveNetworkSignalFloat(PlayerPedId(), "Heading", (camHeading * -1.0) + 1.0)
                        SetTaskMoveNetworkSignalFloat(PlayerPedId(), "isBlocked", blocked)
                        SetTaskMoveNetworkSignalFloat(PlayerPedId(), "isFirstPerson", N_0xee778f8c7e1142e2(N_0x19cafa3c87f7c2ff()) == 4)
                    end
                end 
            end
        end)
    end

    RegisterCommand('point', function()
        if (DoesEntityExist(PlayerPedId())) and (not IsEntityDead(PlayerPedId())) and (IsPedOnFoot(PlayerPedId())) then
            if handsup then 
                handsup = false
            end

            pointing = not pointing

            if pointing then
                startPointing(PlayerPedId())
                CrouchAndPointing()
            else
                stopPointing(PlayerPedId())
                CrouchAndPointing()
            end
        end
    end)

    RegisterKeyMapping('point', "Pointer du doigt", 'keyboard', Config.ActivatePointFinger.Key)
end