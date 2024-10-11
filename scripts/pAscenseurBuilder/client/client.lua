function Ascenseur(k, v, y, z)
    local ascenseur = false 
    local mainMenu = RageUI.CreateMenu(v.label, z.label)
    mainMenu.Closed = function()
        ascenseur = false
    end
    if not ascenseur then ascenseur = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
		    while ascenseur do 
                RageUI.IsVisible(mainMenu,function() 
                    for a,b in pairs(v.teleport_data) do
                        RageUI.Button(b.label, nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                DoScreenFadeOut(1500)
                                Wait(1000)
                                DoScreenFadeIn(1500)
                                SetEntityCoords(GetPlayerPed(-1), b.coords.x, b.coords.y, b.coords.z, 0.0, 0.0, 0.0, true)
                                SetEntityHeading(GetPlayerPed(-1), b.coords.w)  
                            end
                        })
                    end
                end)  
            Wait(0)
            end
        end)
    end
end

Citizen.CreateThread(function()
    while true do
        local wait = 900
        local coords = GetEntityCoords(GetPlayerPed(-1), false)
        for k,v in pairs(getData.Ascenseur) do        
            for y,z in pairs(v.teleport_data) do
                if z.coords ~= nil and z.coords ~= "" then                   
                    if json.encode(v.job_data) == "[]" and json.encode(v.user_data) == "[]" then
                        local dist = Vdist(coords.x, coords.y, coords.z, z.coords.x, z.coords.y, z.coords.z)
                        if dist <= 20.0 then 
                            wait = 0
                            DrawMarker(v.markers_data.types, z.coords.x, z.coords.y, z.coords.z-1, 0.0, 0.0, 0.0, v.markers_data.rotX, v.markers_data.rotY, v.markers_data.rotZ, v.markers_data.scaleX, v.markers_data.scaleY, v.markers_data.scaleZ, v.markers_data.colorR, v.markers_data.colorV, v.markers_data.colorB, v.markers_data.colorO, false, false, p19, false) 
                            if dist <= 1.0 then 
                                wait = 0 
                                ESX.ShowHelpNotification("~INPUT_TALK~ pour appeler l'~b~Ascenseur ~s~- [~b~"..z.label.."~s~]")
                                if IsControlJustPressed(1,51) then 
                                    Ascenseur(k, v, y, z)
                                end
                            end
                        end
                    else
                        if json.encode(v.job_data) == "[]" then
                            for _,n in pairs(v.user_data) do
                                if ESX.PlayerData.identifier and ESX.PlayerData.identifier == n.identifier then                                
                                    local dist = Vdist(coords.x, coords.y, coords.z, z.coords.x, z.coords.y, z.coords.z)
                                    if dist <= 20.0 then 
                                        wait = 0
                                        DrawMarker(v.markers_data.types, z.coords.x, z.coords.y, z.coords.z-1, 0.0, 0.0, 0.0, v.markers_data.rotX, v.markers_data.rotY, v.markers_data.rotZ, v.markers_data.scaleX, v.markers_data.scaleY, v.markers_data.scaleZ, v.markers_data.colorR, v.markers_data.colorV, v.markers_data.colorB, v.markers_data.colorO, false, false, p19, false) 
                                        if dist <= 1.0 then 
                                            wait = 0 
                                            ESX.ShowHelpNotification("~INPUT_TALK~ pour appeler l'~b~Ascenseur ~s~- [~b~"..z.label.."~s~]")
                                            if IsControlJustPressed(1,51) then 
                                                Ascenseur(k, v, y, z)
                                            end
                                        end
                                    end
                                end
                            end                               
                        else
                            if json.encode(v.user_data) == "[]" then
                                for _,u in pairs(v.job_data) do
                                    if ESX.PlayerData.job and ESX.PlayerData.job2 and ESX.PlayerData.job.name == u.name or ESX.PlayerData.job2.name == u.name then                                
                                        local dist = Vdist(coords.x, coords.y, coords.z, z.coords.x, z.coords.y, z.coords.z)
                                        if dist <= 20.0 then 
                                            wait = 0
                                            DrawMarker(v.markers_data.types, z.coords.x, z.coords.y, z.coords.z-1, 0.0, 0.0, 0.0, v.markers_data.rotX, v.markers_data.rotY, v.markers_data.rotZ, v.markers_data.scaleX, v.markers_data.scaleY, v.markers_data.scaleZ, v.markers_data.colorR, v.markers_data.colorV, v.markers_data.colorB, v.markers_data.colorO, false, false, p19, false) 
                                            if dist <= 1.0 then 
                                                wait = 0 
                                                ESX.ShowHelpNotification("~INPUT_TALK~ pour appeler l'~b~Ascenseur ~s~- [~b~"..z.label.."~s~]")
                                                if IsControlJustPressed(1,51) then 
                                                    Ascenseur(k, v, y, z)
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                for _,u in pairs(v.job_data) do
                                    for _,n in pairs(v.user_data) do
                                        if ESX.PlayerData.job and ESX.PlayerData.job2 and ESX.PlayerData.job.name == u.name or ESX.PlayerData.job2.name == u.name or ESX.PlayerData.identifier and ESX.PlayerData.identifier == n.identifier then                                
                                            local dist = Vdist(coords.x, coords.y, coords.z, z.coords.x, z.coords.y, z.coords.z)
                                            if dist <= 20.0 then 
                                                wait = 0
                                                DrawMarker(v.markers_data.types, z.coords.x, z.coords.y, z.coords.z-1, 0.0, 0.0, 0.0, v.markers_data.rotX, v.markers_data.rotY, v.markers_data.rotZ, v.markers_data.scaleX, v.markers_data.scaleY, v.markers_data.scaleZ, v.markers_data.colorR, v.markers_data.colorV, v.markers_data.colorB, v.markers_data.colorO, false, false, p19, false) 
                                                if dist <= 1.0 then 
                                                    wait = 0 
                                                    ESX.ShowHelpNotification("~INPUT_TALK~ pour appeler l'~b~Ascenseur ~s~- [~b~"..z.label.."~s~]")
                                                    if IsControlJustPressed(1,51) then 
                                                        Ascenseur(k, v, y, z)
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end      
            end 
        end
    Citizen.Wait(wait)
    end
end)