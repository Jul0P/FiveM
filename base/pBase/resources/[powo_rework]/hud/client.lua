Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        local ped = PlayerPedId()
        local health = GetEntityHealth(ped)
        local armor = GetPedArmour(ped)
        local stamina = GetPlayerSprintStaminaRemaining(PlayerId())
        TriggerEvent('esx_status:getStatus', 'hunger', function(status)
            food = status.val / 10000
        end)
        TriggerEvent('esx_status:getStatus', 'thirst', function(status)
            thirst = status.val / 10000
        end)
        TriggerEvent('esx_status:getStatus', 'drug', function(status)
            drugs = status.val / 10000
        end)
        TriggerEvent('esx_status:getStatus', 'drunk', function(status)
            drunk = status.val / 10000
        end)
        TriggerEvent('esx_status:getStatus', 'stress', function(status)
            stress = status.val / 10000
        end)
        SendNUIMessage({
			stats = true,
            health = health,
            armor = armor,
            thirst = thirst,
            food = food,
            drugs = drugs,
            drunk = drunk,
            stress = stress,
            stamina = stamina,
        });
    end
end)