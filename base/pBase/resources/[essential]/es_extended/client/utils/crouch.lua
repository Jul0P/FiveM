if Config.ActivateCrouch.Activate then
	crouched = false
	RegisterCommand('crouch', function()
        CreateThread(function()
            if (DoesEntityExist(PlayerPedId())) and (not IsEntityDead(PlayerPedId())) and (IsPedOnFoot(PlayerPedId())) then
                crouched = not crouched
                while crouched do
                    Citizen.Wait(0)
                    DisableControlAction(1, Config.ActivateCrouch.Key, true)
                    if crouched then
                        ESX.Streaming.RequestAnimSet('move_ped_crouched', function()
                            SetPedMovementClipset(PlayerPedId(), 'move_ped_crouched', 0.25)
                            RemoveAnimSet('move_ped_crouched')
                        end)
                    else
                        ResetPedMovementClipset(PlayerPedId(), 0)                   
                    end
                end
            end
        end)
	end)
	RegisterKeyMapping('crouch', "S'accroupir", 'keyboard', Config.ActivateCrouch.Key)
end
