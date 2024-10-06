if Config.ActivateToggleMoteur.Activate then
    local toggleEngine = false
    RegisterCommand('toggleEngine', function()
        if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then
            toggleEngine = not toggleEngine
            GoEngine()
        end
    end, false)

    RegisterKeyMapping('toggleEngine', 'Moteur (Allumer/Éteindre)', 'keyboard', Config.ActivateToggleMoteur.Key)

    function GoEngine()
        CreateThread(function()
            while toggleEngine do
                if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then
                    SetVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId(), false), false, true, true)
                    Citizen.Wait(100)
                else
                    SetVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId(), false), true, true, true)
                    toggleEngine = false
                end
            end
        end)
    end
end