if Config.ActivateHandsup.Activate then
    handsup = false

    RegisterCommand('handsup', function()
        CreateThread(function()
            if not IsPedInAnyVehicle(PlayerPedId(), false) then
                if not handsup then
                    RequestAnimDict("missminuteman_1ig_2")
                    while not HasAnimDictLoaded("missminuteman_1ig_2") do
                        Wait(100)
                    end
                    TaskPlayAnim(PlayerPedId(), "missminuteman_1ig_2", "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false, false)
                    RemoveAnimDict("missminuteman_1ig_2")
                    handsup = true 
                else
                    handsup = false
                    ClearPedTasks(PlayerPedId())
                end
            end
        end)
    end)
    
    RegisterKeyMapping('handsup', "Lever les bras", 'keyboard', Config.ActivateHandsup.Key)
end
