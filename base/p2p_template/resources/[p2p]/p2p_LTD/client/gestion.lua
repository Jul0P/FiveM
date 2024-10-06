if Config.getSharedObject == "last" then
	ESX = exports["es_extended"]:getSharedObject()
elseif Config.getSharedObject == "old" then
	ESX = nil
	Citizen.CreateThread(function()
		while ESX == nil do
			TriggerEvent('esx:getSharedObject', function(obj) 
                ESX = obj 
            end)
			Citizen.Wait(0)
		end
	end)
end

local mainMenu = RageUI.CreateMenu(Config.Translate('gestion_title'), Config.Translate('gestion_desc'))

mainMenu.Closed = function()
    gestion = false
end

function Gestion()
    if not gestion then gestion = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
		    while gestion do
                RageUI.IsVisible(mainMenu,function()
                    
                end)
            Wait(0)
            end
        end)
    end
end

Citizen.CreateThread(function()
    while true do
        local wait = 900
        for k,v in pairs(Config.LTD) do
            local coords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist(coords.x, coords.y, coords.z, v.gestion.x, v.gestion.y, v.gestion.z)
            if dist <= 2.0 then
                wait = 0
                DrawMarker(Config.job.marker.type, v.gestion.x, v.gestion.y, v.gestion.z, 0.0, 0.0, 0.0, Config.job.marker.rotation.x, Config.job.marker.rotation.y, Config.job.marker.rotation.z, Config.job.marker.scale.x, Config.job.marker.scale.y, Config.job.marker.scale.z, Config.job.marker.color.r, Config.job.marker.color.g, Config.job.marker.color.b, Config.job.marker.color.a, Config.job.marker.jump, false, p19, Config.job.marker.rotate)
                ESX.ShowHelpNotification(Config.Translate('gestion_marker_title', Config.job.label, v.label))
                if IsControlJustPressed(1,51) then
                    mainMenu:SetSubtitle(Config.job.label.." - "..v.label)
                    Gestion()
                end
            elseif dist > 2.0 and dist < 2.1 and gestion == true then
                RageUI.CloseAll()
                gestion = false
            end
        end
    Citizen.Wait(wait)
    end
end)