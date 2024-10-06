if Config.ActivateNoclip.Activate then
    noclipcfg = {
        speeds = {
            { label = "Very Slow", speed = 0},
            { label = "Slow", speed = 0.5},
            { label = "Normal", speed = 2},
            { label = "Fast", speed = 4},
            { label = "Very Fast", speed = 6},
            { label = "Extremely Fast", speed = 10},
            { label = "Extremely Fast v2.0", speed = 20},
            { label = "Max Speed", speed = 25}
        },
    }
        
    noclipActive = false 
    
    index = 3 
    
    function getPosition()
        local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
        return x,y,z
    end
      
    function getCamDirection()
        local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(GetPlayerPed(-1))
        local pitch = GetGameplayCamRelativePitch()
        local x = -math.sin(heading*math.pi/180.0)
        local y = math.cos(heading*math.pi/180.0)
        local z = math.sin(pitch*math.pi/180.0)
        local len = math.sqrt(x*x+y*y+z*z)
        if len ~= 0 then
          x = x/len
          y = y/len
          z = z/len
        end
        return x,y,z
    end

    function NoClip()
        noclipActive = not noclipActive
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            noclipEntity = GetVehiclePedIsIn(PlayerPedId(), false)
            veh = GetVehiclePedIsIn(PlayerPedId(), false)
            ped = PlayerPedId()
        else
            noclipEntity = PlayerPedId()
            ped = PlayerPedId()
            veh = nil 
        end
        SetEntityCollision(noclipEntity, not noclipActive, not noclipActive)
        FreezeEntityPosition(noclipEntity, noclipActive)
        SetEntityInvincible(noclipEntity, noclipActive)
        SetVehicleRadioEnabled(noclipEntity, not noclipActive)
        if noclipActive then
            Citizen.CreateThread(function()
                buttons = setupScaleform("instructional_buttons")
                currentSpeed = noclipcfg.speeds[index].speed
                while noclipActive do
                    Citizen.Wait(1) 
                    if noclipActive then                       
                        SetEntityAlpha(veh, 140, false)
                        SetEntityAlpha(ped, 140, false)
                        SetEntityVisible(ped, false)
                        DrawScaleformMovieFullscreen(buttons)
                        if IsControlJustPressed(1, 21) then
                            if index ~= 8 then
                                index = index+1
                                currentSpeed = noclipcfg.speeds[index].speed
                            else
                                currentSpeed = noclipcfg.speeds[3].speed
                                index = 1
                            end
                            setupScaleform("instructional_buttons")
                        end              
                        DisableControls()
                        local x,y,z = getPosition()
                        local dx,dy,dz = getCamDirection()
                        SetEntityVelocity(ped, 0.0001, 0.0001, 0.0001)
                        if IsDisabledControlPressed(0, 32) then
                            x = x+currentSpeed*dx
                            y = y+currentSpeed*dy
                            z = z+currentSpeed*dz
                        end
                        if IsDisabledControlPressed(0,269) then -- MOVE DOWN
                            x = x-currentSpeed*dx
                            y = y-currentSpeed*dy
                            z = z-currentSpeed*dz
                        end

                        if IsDisabledControlPressed(0, 34) then
                            SetEntityHeading(noclipEntity, GetEntityHeading(noclipEntity)+3)
                        end
                        
                        if IsDisabledControlPressed(0, 35) then
                            SetEntityHeading(noclipEntity, GetEntityHeading(noclipEntity)-3)
                        end

                        SetEntityCoordsNoOffset(noclipEntity, x, y, z, noclipActive, noclipActive, noclipActive)
                        SetEntityLocallyVisible(ped)
                    else
                        SetEntityAlpha(veh, 255, false)
                        SetEntityAlpha(ped, 255, false)
                        SetEntityVisible(ped, true)
                    end
                end
            end)
        end
    end
    
    function ButtonMessage(text)
        BeginTextCommandScaleformString("STRING")
        AddTextComponentScaleform(text)
        EndTextCommandScaleformString()
    end
    
    function Button(ControlButton)
        N_0xe83a3e3557a56640(ControlButton)
    end
    
    function setupScaleform(scaleform)
    
        local scaleform = RequestScaleformMovie(scaleform)
    
        while not HasScaleformMovieLoaded(scaleform) do
            Citizen.Wait(1)
        end
    
        PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
        PopScaleformMovieFunctionVoid()
        
        PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
        PushScaleformMovieFunctionParameterInt(200)
        PopScaleformMovieFunctionVoid()
    
        PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
        PushScaleformMovieFunctionParameterInt(4)
        Button(GetControlInstructionalButton(2, 289, true))
        ButtonMessage("Désactiver Noclip")
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
        PushScaleformMovieFunctionParameterInt(3)
        -- Button(GetControlInstructionalButton(1, 33, true))
        Button(GetControlInstructionalButton(1, 32, true))
        ButtonMessage("Dirigez-vous (En Avant)")
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
        PushScaleformMovieFunctionParameterInt(2)
        -- Button(GetControlInstructionalButton(1, 33, true))
        Button(GetControlInstructionalButton(1, 33, true))
        ButtonMessage("Dirigez-vous (En Arrière)")
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
        PushScaleformMovieFunctionParameterInt(1)
        Button(GetControlInstructionalButton(1, 35, true))
        Button(GetControlInstructionalButton(1, 34, true))
        ButtonMessage("Orienter Gauche/Droite")
        PopScaleformMovieFunctionVoid()
    
        PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
        PushScaleformMovieFunctionParameterInt(0)
        Button(GetControlInstructionalButton(2, 21, true))
        ButtonMessage("Changer la  Vitesse ("..noclipcfg.speeds[index].label..")")
        PopScaleformMovieFunctionVoid()
    
        PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
        PopScaleformMovieFunctionVoid()
    
        PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
        PushScaleformMovieFunctionParameterInt(0)
        PushScaleformMovieFunctionParameterInt(0)
        PushScaleformMovieFunctionParameterInt(0)
        PushScaleformMovieFunctionParameterInt(80)
        PopScaleformMovieFunctionVoid()
    
        return scaleform
    end
    
    function DisableControls()
        DisableControlAction(0, 30, true)
        DisableControlAction(0, 31, true)
        DisableControlAction(0, 32, true)
        DisableControlAction(0, 33, true)
        DisableControlAction(0, 34, true)
        DisableControlAction(0, 35, true)
        DisableControlAction(0, 266, true)
        DisableControlAction(0, 267, true)
        DisableControlAction(0, 268, true)
        DisableControlAction(0, 269, true)
        DisableControlAction(0, 44, true)
        DisableControlAction(0, 20, true)
        DisableControlAction(0, 74, true)
    end

    RegisterCommand('noclip', function()
	    if ESX.PlayerData.group == 'admin' then
            NoClip()
        end
    end, false)
  
    RegisterKeyMapping('noclip', 'NoClip (Vehicle)', 'keyboard', Config.ActivateNoclip.Key)
end