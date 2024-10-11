function SublimeIndex.PlayAnimCharacterCreator()
    ESX.Streaming.RequestAnimDict("timetable@reunited@ig_10", function()
        TaskPlayAnim(PlayerPedId(), "timetable@reunited@ig_10", "base_amanda", 8.0, -8.0, -1, 1, 0, false, false, false)
        RemoveAnimDict("timetable@reunited@ig_10")
        ESX.Streaming.RequestAnimDict("amb@world_human_hang_out_street@female_arms_crossed@idle_a", function()
            TaskPlayAnim(PlayerPedId(), "amb@world_human_hang_out_street@female_arms_crossed@idle_a", "idle_a", 8.0, -8.0, -1, 51, 0, false, false, false)
            RemoveAnimDict("amb@world_human_hang_out_street@female_arms_crossed@idle_a")
        end)
    end)
end

local sub_b0b5 = {
    [0] = "MP_Plane_Passenger_1",
    [1] = "MP_Plane_Passenger_2",
    [2] = "MP_Plane_Passenger_3",
    [3] = "MP_Plane_Passenger_4",
    [4] = "MP_Plane_Passenger_5",
    [5] = "MP_Plane_Passenger_6",
    [6] = "MP_Plane_Passenger_7"
}

function sub_b747(ped, a_1)
    if a_1 == 0 then
        SetPedHeadBlendData(ped, 0, 0, 0, 5, 5, 5, 1.0, 1.0, 1.0, true)
        SetPedHeadOverlay(ped, 1, 10, (10 / 10) + 0.0) 
        SetPedHeadOverlay(ped, 2, 0, (10 / 10) + 0.0)
        SetPedHeadOverlayColor(ped, 1, 1, 0, 0)
        SetPedHeadOverlayColor(ped, 2, 1, 0, 0)
        SetPedComponentVariation(ped, 2, 10, 0, 2)
        SetPedComponentVariation(ped, 8, 15, 0, 2) 
        SetPedComponentVariation(ped, 11, 17, 0, 2) 
        SetPedComponentVariation(ped, 3, 5, 0, 2) 
        SetPedComponentVariation(ped, 4, 16, 3, 2) 
        SetPedComponentVariation(ped, 6, 105, 0, 2) 
        ClearPedProp(ped, 0)
        ClearPedProp(ped, 1)
        ClearPedProp(ped, 2)
        ClearPedProp(ped, 3)
        ClearPedProp(ped, 4)
        ClearPedProp(ped, 5)
        ClearPedProp(ped, 6)
        ClearPedProp(ped, 7)
        ClearPedProp(ped, 8)
    elseif a_1 == 1 then
        SetPedHeadBlendData(ped, 0, 0, 0, 5, 5, 5, 1.0, 1.0, 1.0, true)
        SetPedHeadOverlay(ped, 1, 3, (10 / 10) + 0.0) 
        SetPedHeadOverlay(ped, 2, 0, (10 / 10) + 0.0)
        SetPedHeadOverlayColor(ped, 1, 1, 0, 0)
        SetPedHeadOverlayColor(ped, 2, 1, 0, 0)
        SetPedComponentVariation(ped, 2, 9, 0, 2)
        SetPedComponentVariation(ped, 8, 31, 0, 2) 
        SetPedComponentVariation(ped, 11, 31, 0, 2) 
        SetPedComponentVariation(ped, 3, 12, 0, 2) 
        SetPedComponentVariation(ped, 4, 24, 0, 2)
        SetPedComponentVariation(ped, 6, 10, 0, 2) 
        ClearPedProp(ped, 0)
        ClearPedProp(ped, 1)
        ClearPedProp(ped, 2)
        ClearPedProp(ped, 3)
        ClearPedProp(ped, 4)
        ClearPedProp(ped, 5)
        ClearPedProp(ped, 6)
        ClearPedProp(ped, 7)
        ClearPedProp(ped, 8)
    elseif a_1 == 2 then
        SetPedHeadBlendData(ped, 0, 0, 0, 5, 5, 5, 1.0, 1.0, 1.0, true)
        SetPedHeadOverlay(ped, 1, 7, (10 / 10) + 0.0) 
        SetPedHeadOverlay(ped, 2, 0, (10 / 10) + 0.0)
        SetPedHeadOverlayColor(ped, 1, 1, 0, 0)
        SetPedHeadOverlayColor(ped, 2, 1, 0, 0)
        SetPedComponentVariation(ped, 2, 10, 0, 2) 
        SetPedComponentVariation(ped, 8, 15, 0, 2)
        SetPedComponentVariation(ped, 11, 50, 0, 2)
        SetPedComponentVariation(ped, 3, 15, 0, 2) 
        SetPedComponentVariation(ped, 4, 4, 0, 2) 
        SetPedComponentVariation(ped, 6, 2, 6, 2)
        ClearPedProp(ped, 0)
        ClearPedProp(ped, 1)
        ClearPedProp(ped, 2)
        ClearPedProp(ped, 3)
        ClearPedProp(ped, 4)
        ClearPedProp(ped, 5)
        ClearPedProp(ped, 6)
        ClearPedProp(ped, 7)
        ClearPedProp(ped, 8)
    elseif a_1 == 3 then
        SetPedHeadBlendData(ped, 0, 0, 0, 5, 5, 5, 1.0, 1.0, 1.0, true)
        SetPedHeadOverlay(ped, 2, 0, (10 / 10) + 0.0)
        SetPedHeadOverlay(ped, 1, 5, (10 / 10) + 0.0) 
        SetPedHeadOverlayColor(ped, 1, 1, 0, 0)
        SetPedHeadOverlayColor(ped, 2, 1, 0, 0)
        SetPedComponentVariation(ped, 2, 13, 0, 2) 
        SetPedComponentVariation(ped, 8, 15, 0, 2) 
        SetPedComponentVariation(ped, 11, 89, 0, 2)
        SetPedComponentVariation(ped, 3, 15, 0, 2) 
        SetPedComponentVariation(ped, 4, 4, 4, 2) 
        SetPedComponentVariation(ped, 6, 2, 6, 2) 
        ClearPedProp(ped, 0)
        ClearPedProp(ped, 1)
        ClearPedProp(ped, 2)
        ClearPedProp(ped, 3)
        ClearPedProp(ped, 4)
        ClearPedProp(ped, 5)
        ClearPedProp(ped, 6)
        ClearPedProp(ped, 7)
        ClearPedProp(ped, 8)
    elseif a_1 == 4 then
        SetPedHeadBlendData(ped, 0, 0, 0, 5, 5, 5, 1.0, 1.0, 1.0, true)
        SetPedHeadOverlay(ped, 2, 0, (10 / 10) + 0.0)
        SetPedHeadOverlay(ped, 1, 1, (10 / 10) + 0.0)
        SetPedHeadOverlayColor(ped, 1, 1, 0, 0)
        SetPedHeadOverlayColor(ped, 2, 1, 0, 0)
        SetPedComponentVariation(ped, 2, 18, 0, 2)
        SetPedComponentVariation(ped, 8, 24, 0, 2)
        SetPedComponentVariation(ped, 11, 6, 0, 2)
        SetPedComponentVariation(ped, 3, 15, 0, 2) 
        SetPedComponentVariation(ped, 4, 4, 4, 2) 
        SetPedComponentVariation(ped, 6, 2, 6, 2)
        ClearPedProp(ped, 0)
        ClearPedProp(ped, 1)
        ClearPedProp(ped, 2)
        ClearPedProp(ped, 3)
        ClearPedProp(ped, 4)
        ClearPedProp(ped, 5)
        ClearPedProp(ped, 6)
        ClearPedProp(ped, 7)
        ClearPedProp(ped, 8)
    elseif a_1 == 5 then
        SetPedHeadBlendData(ped, 0, 0, 0, 5, 5, 5, 1.0, 1.0, 1.0, true)
        SetPedHeadOverlay(ped, 2, 0, (10 / 10) + 0.0)
        SetPedHeadOverlay(ped, 1, 1, (10 / 10) + 0.0) 
        SetPedHeadOverlayColor(ped, 1, 1, 0, 0)
        SetPedHeadOverlayColor(ped, 2, 1, 0, 0)
        SetPedComponentVariation(ped, 2, 18, 0, 2) 
        SetPedComponentVariation(ped, 8, 15, 0, 2) 
        SetPedComponentVariation(ped, 11, 328, 0, 2) 
        SetPedComponentVariation(ped, 3, 15, 0, 2)
        SetPedComponentVariation(ped, 4, 26, 0, 2) 
        SetPedComponentVariation(ped, 6, 2, 6, 2)
        ClearPedProp(ped, 0)
        ClearPedProp(ped, 1)
        ClearPedProp(ped, 2)
        ClearPedProp(ped, 3)
        ClearPedProp(ped, 4)
        ClearPedProp(ped, 5)
        ClearPedProp(ped, 6)
        ClearPedProp(ped, 7)
        ClearPedProp(ped, 8)
    elseif a_1 == 6 then
        SetPedHeadBlendData(ped, 0, 0, 0, 2, 2, 2, 1.0, 1.0, 1.0, true)
        SetPedHeadOverlay(ped, 2, 0, (10 / 10) + 0.0)
        SetPedHeadOverlay(ped, 1, 1, (10 / 10) + 0.0) 
        SetPedHeadOverlayColor(ped, 1, 1, 0, 0)
        SetPedHeadOverlayColor(ped, 2, 1, 0, 0)
        SetPedComponentVariation(ped, 2, 14, 0, 2)
        SetPedComponentVariation(ped, 8, 15, 0, 2) 
        SetPedComponentVariation(ped, 11, 350, 0, 2)
        SetPedComponentVariation(ped, 3, 15, 0, 2) 
        SetPedComponentVariation(ped, 4, 42, 0, 2) 
        SetPedComponentVariation(ped, 6, 31, 0, 2) 
        ClearPedProp(ped, 0)
        ClearPedProp(ped, 1)
        ClearPedProp(ped, 2)
        ClearPedProp(ped, 3)
        ClearPedProp(ped, 4)
        ClearPedProp(ped, 5)
        ClearPedProp(ped, 6)
        ClearPedProp(ped, 7)
        ClearPedProp(ped, 8)
    end
end 

RegisterCommand("intro", function()
    TriggerEvent('introCinematic:start')
end)

RegisterCommand("introcut", function()
    
end)

RegisterNetEvent('introCinematic:start')
AddEventHandler('introCinematic:start', function()
	PrepareMusicEvent("FM_INTRO_START")
	TriggerMusicEvent("FM_INTRO_START") 
    local plyrId = PlayerPedId() 
	if IsMale(plyrId) then
		RequestCutsceneWithPlaybackList("MP_INTRO_CONCAT", 31, 8)
	else	
		RequestCutsceneWithPlaybackList("MP_INTRO_CONCAT", 103, 8)
	end
    while not HasCutsceneLoaded() do Wait(10) end
	if IsMale(plyrId) then
		RegisterEntityForCutscene(0, 'MP_Male_Character', 3, GetEntityModel(PlayerPedId()), 0)
		RegisterEntityForCutscene(PlayerPedId(), 'MP_Male_Character', 0, 0, 0)
		SetCutsceneEntityStreamingFlags('MP_Male_Character', 0, 1) 
		local female = RegisterEntityForCutscene(0,"MP_Female_Character",3,0,64) 
		NetworkSetEntityInvisibleToNetwork(female, true)
	else
		RegisterEntityForCutscene(0, 'MP_Female_Character', 3, GetEntityModel(PlayerPedId()), 0)
		RegisterEntityForCutscene(PlayerPedId(), 'MP_Female_Character', 0, 0, 0)
		SetCutsceneEntityStreamingFlags('MP_Female_Character', 0, 1) 
		local male = RegisterEntityForCutscene(0,"MP_Male_Character",3,0,64) 
		NetworkSetEntityInvisibleToNetwork(male, true)
	end
	local ped = {}
	for v_3=0, 6, 1 do
		if v_3 == 1 or v_3 == 2 or v_3 == 4 or v_3 == 6 then
			ped[v_3] = CreatePed(26, `mp_f_freemode_01`, -1117.77783203125, -1557.6248779296875, 3.3819, 0.0, 0, 0)
		else
			ped[v_3] = CreatePed(26, `mp_m_freemode_01`, -1117.77783203125, -1557.6248779296875, 3.3819, 0.0, 0, 0)
		end
        if not IsEntityDead(ped[v_3]) then
			sub_b747(ped[v_3], v_3)
            FinalizeHeadBlend(ped[v_3])
            RegisterEntityForCutscene(ped[v_3], sub_b0b5[v_3], 0, 0, 64)
        end
    end
	NewLoadSceneStartSphere(-1212.79, -1673.52, 7, 1000, 0)
    SublimeIndex.DestroyCams()
    StartCutscene(4)
    Wait(33000)
    StopCutsceneImmediately()
    DoScreenFadeOut(250)
    ESX.Game.Teleport(PlayerPedId(), {x = Config.SpawnAfterCreator.x, y = Config.SpawnAfterCreator.y, z = Config.SpawnAfterCreator.z, heading = Config.SpawnAfterCreator.h}, function() 
        FreezeEntityPosition(PlayerPedId(), true)      
    end)
    Wait(50)
    DoScreenFadeIn(250)
    ESX.Game.Teleport(PlayerPedId(), {x = Config.SpawnAfterCreator.x, y = Config.SpawnAfterCreator.y, z = Config.SpawnAfterCreator.z, heading = Config.SpawnAfterCreator.h}, function()       
        FreezeEntityPosition(PlayerPedId(), false)
        SetPlayerBuckets(false)
        if Config.DisplayRadar then
            DisplayRadar(true)
        end
        TriggerEvent('skinchanger:getSkin', function(finalSkin)
            TriggerServerEvent('esx_skin:save', finalSkin)
        end)
        Citizen.Wait(1500)
        ClearPedTasks(PlayerPedId())
        ESX.ShowNotification("~y~Création du personnage terminé\n~s~Bon jeu sur "..Config.ServerName.." !")
        TriggerEvent('instance:leave')
    end)
	for v_3=0, 6, 1 do
		DeleteEntity(ped[v_3])
	end
	PrepareMusicEvent("AC_STOP")
	TriggerMusicEvent("AC_STOP")
end) 

function IsMale(ped)
	if IsPedModel(ped, 'mp_m_freemode_01') then
		return true
	else
		return false
	end
end