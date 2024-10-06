Citizen.CreateThread(function()
    if Config.ActivateTazerEffect then
        local isTaz = false
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(4)		
                if IsPedBeingStunned(PlayerPedId()) then			
                    SetPedToRagdoll(PlayerPedId(), 5000, 5000, 0, 0, 0, 0)			
                end		
                if IsPedBeingStunned(PlayerPedId()) and not isTaz then
                    isTaz = true
                    ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 1.0)			
                elseif not IsPedBeingStunned(PlayerPedId()) and isTaz then
                    isTaz = false
                    Wait(5000)			
                    Wait(10000)		
                    SetTransitionTimecycleModifier("")
                    StopGameplayCamShaking()
                end
            end
        end)
    end
end)