if Config.ActivateCarry.Activate then
    RegisterNetEvent('pBase:carry')
    AddEventHandler('pBase:carry', function(targetSrc, animationLib, animation, animation2, distans, distans2, height, length, spin, controlFlagSrc, controlFlagTarget, animFlagTarget)
        TriggerClientEvent('pBase:carryTarget', targetSrc, source, animationLib, animation2, distans, distans2, height, length, spin, controlFlagTarget, animFlagTarget)
        TriggerClientEvent('pBase:carrySync', source, animationLib, animation, length, controlFlagSrc, animFlagTarget)
    end)

    RegisterNetEvent('pBase:carryStop')
    AddEventHandler('pBase:carryStop', function(targetSrc)
        if targetSrc ~= nil and targetSrc > 0 then
            TriggerClientEvent('pBase:carryStopTarget', targetSrc, source)
        end
    end)
end