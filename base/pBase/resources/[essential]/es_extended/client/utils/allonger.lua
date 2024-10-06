if Config.ActivateAllonger.Activate then
    function SeTrainerAuSol()
        if GetSelectedPedWeapon(PlayerPedId()) ~= GetHashKey("weapon_musket") then
            CreateThread(function()
                if IsPedInAnyVehicle(PlayerPedId(), false) then 
                    return 
                end
                local PlayerPed = PlayerPedId()
                coucher = not coucher
                if not coucher then
                    Wait(0)
                    FreezeEntityPosition(PlayerPed, false)
                    local dict, anim = "get_up@directional@transition@prone_to_knees@crawl", "front"
                    TaskPlayAnim(PlayerPed, dict, anim, 8.0, -4.0, -1, 9, 0.0)
                else
                    if IsPedRunning(PlayerPed)or IsPedSprinting(PlayerPed) or IsPedStrafing(PlayerPed)then
                        local dict, anim = "move_jump", "dive_start_run"
                        RequestAndWaitDict(dict)
                        TaskPlayAnim(PlayerPed, dict, anim, 8.0, -4.0, -1, 9, 0.0)
                        Citizen.Wait(1200)
                    end
                    CreateThread(function()
                        while coucher do 
                                Wait(0)
                                FreezeEntityPosition(PlayerPedId(), false)
                                if IsPedSwimming(PlayerPedId()) or IsPedFalling(PlayerPedId()) then 
                                    coucher = false
                                    FreezeEntityPosition(PlayerPedId(), false)
                                    local dict, anim = "get_up@directional@transition@prone_to_knees@crawl", "front"
                                    TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, -4.0, -1, 9, 0.0)
                                    break 
                                end
                                if IsControlPressed(1,32) and not IsEntityPlayingAnim(PlayerPed,"move_crawl", "onfront_fwd",3) then
                                    local dict, anim = "move_crawl", "onfront_fwd"
                                    RequestAndWaitDict(dict)
                                    TaskPlayAnim(PlayerPed, dict, anim, 8.0, -4.0, -1, 9, 0.0)
                                elseif IsControlPressed(1, 33) and not IsEntityPlayingAnim(PlayerPed, "move_crawl", "onfront_bwd", 3) then
                                    local dict, anim = "move_crawl", "onfront_bwd"
                                    RequestAndWaitDict(dict)
                                    TaskPlayAnim(PlayerPed, dict, anim, 8.0, -4.0, -1, 9, 0.0)
                                end
                                if IsControlPressed(1, 34) then
                                    SetEntityHeading(PlayerPed, GetEntityHeading(PlayerPed)+1.0)
                                elseif IsControlPressed(1, 35)then
                                    SetEntityHeading(PlayerPed, GetEntityHeading(PlayerPed)-1.0)
                                end
                                if IsControlReleased(1, 32) and IsControlReleased(1, 33) then
                                    local dict, anim = "move_crawl", "onfront_fwd"
                                    RequestAndWaitDict(dict)
                                    TaskPlayAnim(PlayerPed, dict, anim, 8.0, -4.0, -1, 9, 0.0)
                                    FreezeEntityPosition(PlayerPed, true)
                                end
                            end 
                        end)
                    end 
                end)
            end
        end

        function RequestAndWaitDict(dictName)
            if dictName and DoesAnimDictExist(dictName) and not HasAnimDictLoaded(dictName) then
                RequestAnimDict(dictName)
                while not HasAnimDictLoaded(dictName) do 
                    Wait(100) 
                end
            end
        end

    RegisterCommand("allonger", function()
        if not IsPedInAnyVehicle(PlayerPedId(), false) then
            if not IsPedSwimming(PlayerPedId()) then
                if not IsEntityInWater(PlayerPedId()) then
                    if not IsPedFalling(PlayerPedId()) then 
                        SeTrainerAuSol()
                    end
                end
            end
        end
    end)

    RegisterKeyMapping("allonger", "S'allonger au Sol", "keyboard", Config.ActivateAllonger.Key)
end