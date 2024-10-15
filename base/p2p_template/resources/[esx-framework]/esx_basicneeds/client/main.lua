local IsDead = false
local IsAnimated = false

local IsAlreadyDrunk = false
local DrunkLevel     = -1

function Drunk(level, start)
  
  CreateThread(function()

    local playerPed = PlayerPedId()

    if start then
      DoScreenFadeOut(800)
      Wait(1000)
    end

    if level == 0 then

      RequestAnimSet("move_m@drunk@slightlydrunk")
      
      while not HasAnimSetLoaded("move_m@drunk@slightlydrunk") do
        Wait(0)
      end

      SetPedMovementClipset(playerPed, "move_m@drunk@slightlydrunk", true)

    elseif level == 1 then

      RequestAnimSet("move_m@drunk@moderatedrunk")
      
      while not HasAnimSetLoaded("move_m@drunk@moderatedrunk") do
        Wait(0)
      end

      SetPedMovementClipset(playerPed, "move_m@drunk@moderatedrunk", true)

    elseif level == 2 then

      RequestAnimSet("move_m@drunk@verydrunk")
      
      while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
        Wait(0)
      end

      SetPedMovementClipset(playerPed, "move_m@drunk@verydrunk", true)

    end

    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    SetPedIsDrunk(playerPed, true)

    if start then
      DoScreenFadeIn(800)
    end

  end)

end

function Reality()

  CreateThread(function()

    local playerPed = PlayerPedId()

    DoScreenFadeOut(800)
    Wait(1000)

    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(playerPed, 0)
    SetPedIsDrunk(playerPed, false)
    SetPedMotionBlur(playerPed, false)

    DoScreenFadeIn(800)

  end)

end

AddEventHandler('esx_basicneeds:resetStatus', function()
	TriggerEvent('esx_status:set', 'hunger', 500000)
	TriggerEvent('esx_status:set', 'thirst', 500000)
	TriggerEvent('esx_status:set', 'drunk', 0)
end)

RegisterNetEvent('esx_basicneeds:healPlayer')
AddEventHandler('esx_basicneeds:healPlayer', function()
	-- restore hunger & thirst
	TriggerEvent('esx_status:set', 'hunger', 1000000)
	TriggerEvent('esx_status:set', 'thirst', 1000000)
	TriggerEvent('esx_status:set', 'drunk', 0)

	-- restore hp
	local playerPed = PlayerPedId()
	SetEntityHealth(playerPed, 200)
end)

AddEventHandler('esx:onPlayerDeath', function()
	IsDead = true
end)

AddEventHandler('esx:onPlayerSpawn', function(spawn)
	if IsDead then
		TriggerEvent('esx_basicneeds:resetStatus')
	end

	IsDead = false	
end)

AddEventHandler('esx_status:loaded', function(status)
	TriggerEvent('esx_status:registerStatus', 'hunger', 1000000, '#CFAD0F', function(status)
		return Config.Visible
	end, function(status)
		status.remove(100)
	end)

	TriggerEvent('esx_status:registerStatus', 'thirst', 1000000, '#0C98F1', function(status)
		return Config.Visible
	end, function(status)
		status.remove(75)
	end)

	TriggerEvent('esx_status:registerStatus', 'drunk', 0, '#8F15A5', function(status)
		if status.val > 0 then
			return true
		else
			return false
		end
	end, function(status)
		status.remove(1500)
	end)
	CreateThread(function()
		while true do
			Wait(1000)
			TriggerEvent('esx_status:getStatus', 'drunk', function(status)
				if status.val > 0 then	
					local start = true
					if IsAlreadyDrunk then
						start = false
					end
					local level = 0
					if status.val <= 250000 then
						level = 0
					elseif status.val <= 500000 then
						level = 1
					else
						level = 2
					end
					if level ~= DrunkLevel then
						Drunk(level, start)
					end
					IsAlreadyDrunk = true
					DrunkLevel = level
				end
				if status.val == 0 then
					if IsAlreadyDrunk then
						Reality()
					end
					IsAlreadyDrunk = false
					DrunkLevel     = -1
				end
			end)
		end
	end)
end)

AddEventHandler('esx_status:onTick', function(data)
	local playerPed  = PlayerPedId()
	local prevHealth = GetEntityHealth(playerPed)
	local health     = prevHealth
	
	for k, v in pairs(data) do
		if v.name == 'hunger' and v.percent == 0 then
			if prevHealth <= 150 then
				health = health - 5
			else
				health = health - 1
			end
		elseif v.name == 'thirst' and v.percent == 0 then
			if prevHealth <= 150 then
				health = health - 5
			else
				health = health - 1
			end
		end
	end
	
	if health ~= prevHealth then SetEntityHealth(playerPed, health) end
end)

AddEventHandler('esx_basicneeds:isEating', function(cb)
	cb(IsAnimated)
end)

RegisterNetEvent('esx_basicneeds:onUse')
AddEventHandler('esx_basicneeds:onUse', function(type, prop_name)
	if not IsAnimated then
		local anim = {dict = 'mp_player_inteat@burger', name = 'mp_player_int_eat_burger_fp', settings = {8.0, -8, -1, 49, 0, 0, 0, 0}}
		IsAnimated = true
		if type == 'food' then
			prop_name = prop_name or 'prop_cs_burger_01'
			anim = {dict = 'mp_player_inteat@burger', name = 'mp_player_int_eat_burger_fp', settings = {8.0, -8, -1, 49, 0, 0, 0, 0}}
		elseif type == 'drink' then
			prop_name = prop_name or 'prop_ld_flow_bottle'
			anim = {dict = 'mp_player_intdrink', name = 'loop_bottle', settings = {1.0, -1.0, 2000, 0, 1, true, true, true}}
		elseif type == 'drunk' then
			prop_name = prop_name or 'prop_ld_flow_bottle'
			anim = {dict = 'mp_player_intdrink', name = 'loop_bottle', settings = {1.0, -1.0, 2000, 0, 1, true, true, true}}
		end

		CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(joaat(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 18905)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)

			ESX.Streaming.RequestAnimDict(anim.dict, function()
				TaskPlayAnim(playerPed, anim.dict, anim.name, anim.settings[1], anim.settings[2], anim.settings[3], anim.settings[4], anim.settings[5], anim.settings[6], anim.settings[7], anim.settings[8])
				RemoveAnimDict(anim.dict)

				Wait(3000)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
			end)
		end)
	end
end)

-- Backwards compatibility
RegisterNetEvent('esx_basicneeds:onEat')
AddEventHandler('esx_basicneeds:onEat', function(prop_name)
    local Invoke = GetInvokingResource()

    print(('[^3WARNING^7] ^5%s^7 used ^5esx_basicneeds:onEat^7, this method is deprecated and should not be used! Refer to ^5https://documentation.esx-framework.org/addons/esx_basicneeds/events/oneat^7 for more info!'):format(Invoke))

    if not prop_name then
        prop_name = 'prop_cs_burger_01'
    end
    TriggerEvent('esx_basicneeds:onUse', 'food', prop_name)
end)

RegisterNetEvent('esx_basicneeds:onDrink')
AddEventHandler('esx_basicneeds:onDrink', function(prop_name)
    local Invoke = GetInvokingResource()

    print(('[^3WARNING^7] ^5%s^7 used ^5esx_basicneeds:onDrink^7, this method is deprecated and should not be used! Refer to ^5https://documentation.esx-framework.org/addons/esx_basicneeds/events/ondrink^7 for more info!'):format(Invoke))


    if not prop_name then
        prop_name = 'prop_ld_flow_bottle'
    end
    TriggerEvent('esx_basicneeds:onUse', 'drink', prop_name)
end)

RegisterNetEvent('esx_basicneeds:onDrunk')
AddEventHandler('esx_basicneeds:onDrunk', function(prop_name)
    local Invoke = GetInvokingResource()

    print(('[^3WARNING^7] ^5%s^7 used ^5esx_basicneeds:onDrunk^7, this method is deprecated and should not be used! Refer to ^5https://documentation.esx-framework.org/addons/esx_basicneeds/events/ondrink^7 for more info!'):format(Invoke))


    if not prop_name then
        prop_name = 'prop_ld_flow_bottle'
    end
	local playerPed = PlayerPedId()
	TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_DRINKING", 0, 1)
	Wait(1000)
	ClearPedTasksImmediately(playerPed)
    TriggerEvent('esx_basicneeds:onUse', 'drunk', prop_name)
end)