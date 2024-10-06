if Config.ActivateClignotant.Activate then
    local rightSignal = false
    local leftSignal = false
    RegisterCommand('clignotantdroit', function()
        if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then
            rightSignal = not rightSignal 
            SetVehicleIndicatorLights(GetVehiclePedIsIn(PlayerPedId(), false), 0, rightSignal)
        end
    end, false)
    RegisterCommand('clignotantgauche', function()
        if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then
            leftSignal  = not leftSignal 
            SetVehicleIndicatorLights(GetVehiclePedIsIn(PlayerPedId(), false), 1, leftSignal)
        end
    end, false)
  
    RegisterKeyMapping('clignotantdroit', 'Clignotant (Droit)', 'keyboard', Config.ActivateClignotant.RightKey)
    RegisterKeyMapping('clignotantgauche', 'Clignotant (Gauche)', 'keyboard', Config.ActivateClignotant.LeftKey)
end