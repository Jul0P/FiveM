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

local mainMenu = RageUI.CreateMenu(Config.Translate('menu_title'), Config.Translate('menu_desc'))
local subMenu = RageUI.CreateSubMenu(mainMenu, "", Config.Translate('menu_title'))
local currentTattoos = {}
local opacity = 1
local index_opacity = 0.1

subMenu.EnableMouse = true

mainMenu.Closed = function()
    tattoos = false
    opacity = 1
    index_opacity = 0.1
    RenderScriptCams(0, true, 2000)
    DestroyAllCams(true)
    FreezeEntityPosition(PlayerPedId(), false)
	ResetSkin()
end

subMenu.Closed = function()
    RenderScriptCams(false, true, 1000, true, true)
    DestroyAllCams(true)
end

subMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, Config.key.tournerdroite, 0), [2] = Config.Translate('cam_right')}) 
subMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, Config.key.tournergauche, 0), [2] = Config.Translate('cam_left')})
subMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, Config.key.activerdesactivercamera, 0), [2] = Config.Translate('cam_active')})
subMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, Config.key.tourner90, 0), [2] = Config.Translate('cam_90')})
subMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, Config.key.dezoomer, 0), [2] = Config.Translate('cam_zoomout')})
subMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, Config.key.zoomer, 0), [2] = Config.Translate('cam_zoom')})

allTattoos = json.decode(LoadResourceFile(GetCurrentResourceName(), 'shared/tattoos.json'))

_tattoos = {
    {
        zone = "ZONE_HEAD",
        label = Config.Translate('zone_head'),
        cam = vector3(0.0, 0.0, 0.5)
    },
    {
        zone = "ZONE_TORSO", 
        label = Config.Translate('zone_torso'), 
        cam = vector3(0.0, 0.0, 0.2)
    },
    {
        zone = "ZONE_LEFT_ARM", 
        label = Config.Translate('zone_left_arm'), 
        cam = vector3(-0.2, 0.0, 0.2)
    },
    {
        zone = "ZONE_RIGHT_ARM", 
        label = Config.Translate('zone_right_arm'), 
        cam = vector3(0.2, 0.0, 0.2)
    },
    {
        zone = "ZONE_LEFT_LEG",
        label = Config.Translate('zone_left_leg'),
        cam = vector3(-0.2, 0.0, -0.6)
    },
    {
        zone = "ZONE_RIGHT_LEG", 
        label = Config.Translate('zone_right_leg'), 
        cam = vector3(0.2, 0.0, -0.6)
    },
}

AddEventHandler('skinchanger:modelLoaded', function()
	ESX.TriggerServerCallback('p2p_TattooShop:GetPlayerTattoos', function(tattooList)
		if tattooList then
			ClearPedDecorations(PlayerPedId())  
			for k,v in pairs(tattooList) do
				if v.count ~= nil then
					for i = 1, v.count do
						SetPedDecoration(PlayerPedId(), v.collection, v.nameHash)
					end
				else
					SetPedDecoration(PlayerPedId(), v.collection, v.nameHash)
				end
			end
			currentTattoos = tattooList
		end
	end)
end)

Citizen.CreateThread(function()
	while true do		
        Citizen.Wait(2000)
		ESX.TriggerServerCallback('p2p_TattooShop:GetPlayerTattoos', function(tattooList)
            if tattooList then
                ClearPedDecorations(PlayerPedId())
                for k,v in pairs(tattooList) do
                    if v.count ~= nil then
                        for i = 1, v.count do
                            SetPedDecoration(PlayerPedId(), v.collection, v.nameHash)
                        end
                    else
                        SetPedDecoration(PlayerPedId(), v.collection, v.nameHash)
                    end
                end
                currentTattoos = tattooList
            end
        end)
	end
end)

function DrawTattoo(collection, name)
	ClearPedDecorations(PlayerPedId())
	for k,v in pairs(currentTattoos) do
		if v.count ~= nil then
			for i = 1, v.count do
				SetPedDecoration(PlayerPedId(), v.collection, v.nameHash)
			end
		else
			SetPedDecoration(PlayerPedId(), v.collection, v.nameHash)
		end
	end
	for i = 1, opacity do
		SetPedDecoration(PlayerPedId(), collection, name)
	end
end

function GetNaked()
    if GetEntityModel(PlayerPedId()) == `mp_m_freemode_01` then
        TriggerEvent('skinchanger:loadSkin', Config.clothes.male)
    else
        TriggerEvent('skinchanger:loadSkin', Config.clothes.female)
    end
end

function ResetSkin()
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)
	ClearPedDecorations(PlayerPedId())
	for k,v in pairs(currentTattoos) do
		if v.count ~= nil then
			for i = 1, v.count do
				SetPedDecoration(PlayerPedId(), v.collection, v.nameHash)
			end
		else
			SetPedDecoration(PlayerPedId(), v.collection, v.nameHash)
		end
	end
end

function BuyTattoo(collection, name, label, price)
	ESX.TriggerServerCallback('p2p_TattooShop:PurchaseTattoo', function(success)
		if success then
			table.insert(currentTattoos, {collection = collection, nameHash = name, count = opacity})
		end
	end, currentTattoos, price, {collection = collection, nameHash = name, count = opacity}, GetLabelText(label))
end

function RemoveTattoo(name, label)
	for k,v in pairs(currentTattoos) do
		if v.nameHash == name then
			table.remove(currentTattoos, k)
		end
	end
	TriggerServerEvent("p2p_TattooShop:RemoveTattoo", currentTattoos)
	ESX.ShowNotification(Config.Translate('remove_tattoo', GetLabelText(label)))
end

function Tattoos()
    if not tattoos then tattoos = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
		    while tattoos do
                RageUI.IsVisible(mainMenu,function()
                    mainMenu:UpdateInstructionalButtons(true)
                    for k,v in pairs(_tattoos) do
                        RageUI.Button(v.label, nil, {RightLabel = "→"}, true, {
                            onActive = function()
                                array = v
                            end,
                            onSelected = function()
                                CreateCam()
                                subMenu:SetTitle(v.label)
                            end
                        }, subMenu)
                    end
                end)
                RageUI.IsVisible(subMenu,function()
                    subMenu:UpdateInstructionalButtons(true)
                    LoadCam()
                    PointCamAtCoord(cam, GetOffsetFromEntityInWorldCoords(PlayerPedId(), array.cam))
                    for _,tattoo in pairs(allTattoos) do
                        if tattoo.Zone == array.zone then
                            if GetEntityModel(PlayerPedId()) == `mp_m_freemode_01` then
                                if tattoo.HashNameMale ~= "" then
                                    local found = false
                                    for k,v in pairs(currentTattoos) do
                                        if v.nameHash == tattoo.HashNameMale then
                                            found = true                                        
                                            break
                                        end
                                    end
                                    if found then
                                        RageUI.Button(GetLabelText(tattoo.Name), nil, {RightBadge = RageUI.BadgeStyle.Tattoo}, true, {
                                            onSelected = function()
                                                RemoveTattoo(tattoo.HashNameMale, tattoo.Name)
                                            end
                                        })
                                    else
                                        local price = math.ceil(tattoo.Price / 20) == 0 and 100 or math.ceil(tattoo.Price / 20)
                                        RageUI.Button(GetLabelText(tattoo.Name), nil, {RightLabel = "~g~"..price.."$ ~s~→"}, true, {
                                            onActive = function()
                                                DrawTattoo(tattoo.Collection, tattoo.HashNameMale)
                                            end,
                                            onSelected = function()
                                                BuyTattoo(tattoo.Collection, tattoo.HashNameMale, tattoo.Name, price)
                                            end
                                        })
                                    end
                                end
                            else
                                if tattoo.HashNameFemale ~= "" then
                                    local found = false
                                    for k,v in pairs(currentTattoos) do
                                        if v.nameHash == tattoo.HashNameFemale then
                                            found = true
                                            break
                                        end
                                    end
                                    if found then
                                        RageUI.Button(GetLabelText(tattoo.Name), nil, {RightBadge = RageUI.BadgeStyle.Tattoo}, true, {
                                            onSelected = function()
                                                RemoveTattoo(tattoo.HashNameFemale, tattoo.Name)
                                            end
                                        })
                                    else
                                        local price = math.ceil(tattoo.Price / 20) == 0 and 100 or math.ceil(tattoo.Price / 20)
                                        RageUI.Button(GetLabelText(tattoo.Name), nil, {RightLabel = "~g~"..price.."$ ~s~→"}, true, {
                                            onActive = function()
                                                DrawTattoo(tattoo.Collection, tattoo.HashNameFemale)
                                            end,
                                            onSelected = function()
                                                BuyTattoo(tattoo.Collection, tattoo.HashNameFemale, tattoo.Name, price)
                                            end
                                        })
                                    end
                                end
                            end
                        end
                    end
                    RageUI.PercentagePanel(index_opacity, 'Opacité ('..math.floor(opacity * 10)..'%)', '0%', '100%', {
                        onProgressChange = function(index)  
                            index_opacity = index
                            opacity = index * 10
                        end
                    })
                end)
            Wait(0)
            end
        end)
    end
end

Citizen.CreateThread(function()
    while true do
        local wait = 900
        for k,v in pairs(Config.coords) do
            local coords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(coords.x, coords.y, coords.z, v.x, v.y, v.z)
            if dist <= 2.0 then 
                wait = 0
                DrawMarker(Config.marker.type, v.x, v.y, v.z, 0.0, 0.0, 0.0, Config.marker.rotation.x, Config.marker.rotation.y, Config.marker.rotation.z, Config.marker.scale.x, Config.marker.scale.y, Config.marker.scale.z, Config.marker.color.r, Config.marker.color.g, Config.marker.color.b, Config.marker.color.a, Config.marker.jump, false, p19, Config.marker.rotate)
                if dist <= 2.0 then 
                    wait = 0 
                    ESX.ShowHelpNotification(Config.Translate('marker_title'))
                    if IsControlJustPressed(1,51) then
                        FreezeEntityPosition(PlayerPedId(), true)
                        GetNaked()                                    
                        Tattoos()
                    end
                end
            end
        end
    Citizen.Wait(wait)
    end
end)

Citizen.CreateThread(function()
    for k,v in pairs(Config.coords) do
        local blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(blip, Config.blip.sprite)
        SetBlipScale (blip, Config.blip.scale)
        SetBlipColour(blip, Config.blip.colour)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(Config.Translate('blip_label'))
        EndTextCommandSetBlipName(blip)
    end
end)

function CreateCam()
	local coords = GetEntityCoords(GetPlayerPed(-1))
    cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', coords.x-1.75, coords.y, coords.z+1, 0.0, 0.0, 0.0, 30.0, true, true)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z+0.6)
    RenderScriptCams(1, 1, 1500, 1, 1)
    local hcam = GetEntityHeading(cam)
    SetEntityHeading(GetPlayerPed(-1), hcam+90)
end

function LoadCam()
    EnableControlAction(0, Config.key.activeraesactivercamera, true)  
    EnableControlAction(0, Config.key.tourner90, true)                  
    if IsControlJustPressed(0, Config.key.tourner90) then
        local back2 = GetEntityHeading(GetPlayerPed(-1))
        SetEntityHeading(GetPlayerPed(-1), back2+90)      
    end
    if IsControlJustPressed(0, Config.key.activerdesactivercamera) then
        pressed = not pressed
        if pressed then
            RenderScriptCams(false, true, 1000, true, true)
            DestroyAllCams(true)
        else
            CreateCam()
        end
    end
    if IsDisabledControlPressed(0, Config.key.tournerdroite) then
        SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())-1.5)
    elseif IsDisabledControlPressed(0, Config.key.tournergauche) then
        SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())+1.5)
    elseif IsDisabledControlPressed(0, Config.key.dezoomer) then
        SetCamFov(cam, GetCamFov(cam)+0.2)
    elseif IsDisabledControlPressed(0, Config.key.zoomer) then
        SetCamFov(cam, GetCamFov(cam)-0.2)
    end
end