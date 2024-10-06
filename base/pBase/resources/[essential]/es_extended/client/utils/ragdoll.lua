if Config.ActivateRagdoll.Activate then
    local isInRagdoll = false

    RegisterCommand('ragdoll', function()
        isInRagdoll = not isInRagdoll
        GoRagdoll()
    end, false)

    RegisterKeyMapping('ragdoll', 'Ragdoll (Tomber)', 'keyboard', Config.ActivateRagdoll.Key)

    function GoRagdoll()
        CreateThread(function()
            while isInRagdoll do
                SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
                Citizen.Wait(100)
            end
        end)
    end
end