if Config.DisableNorthRadarBlip then
    SetBlipAlpha(GetNorthRadarBlip(), 0)
end
if Config.ActivateZoomMap.Activate then
    ZoomList = {1000,1100,1200,1300,1400}
    ZoomIndex = 1
    RegisterCommand('zoomminimap', function()
        if ZoomIndex < 5 then
            ZoomIndex = ZoomIndex + 1
            SetRadarZoom(ZoomList[ZoomIndex])
        end
    end)
    RegisterCommand('dezoomminimap', function()
        if ZoomIndex > 1 then
            ZoomIndex = ZoomIndex - 1
            SetRadarZoom(ZoomList[ZoomIndex])
        end
    end)
    RegisterKeyMapping('zoomminimap', "Zoomer Minimap", 'keyboard', Config.ActivateZoomMap.KeyUp)
    RegisterKeyMapping('dezoomminimap', "DéZoomer Minimap", 'keyboard', Config.ActivateZoomMap.KeyDown)
end