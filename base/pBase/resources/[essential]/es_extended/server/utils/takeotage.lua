if Config.ActivateTakeOtage.Activate then
    RegisterNetEvent('pBase:anim:sync')
    AddEventHandler('pBase:anim:sync', function(target, animationLib,animationLib2, animation, animation2, distans, distans2, height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget,attachFlag)
        TriggerClientEvent('pBase:anim:syncTarget', targetSrc, source, animationLib2, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget,attachFlag)
        TriggerClientEvent('pBase:anim:syncMe', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
    end)
    
    RegisterNetEvent('pBase:anim:stop')
    AddEventHandler('pBase:anim:stop', function(targetSrc)
        TriggerClientEvent('pBase:anim:cl_stop', targetSrc)
    end)
end