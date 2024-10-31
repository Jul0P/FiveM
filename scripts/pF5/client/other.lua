-- Porter
local piggyBackInProgress = false

-- Citizen.CreateThread(function()
-- 	while true do
-- 		if piggyBackInProgress then
-- 			local playerPed = PlayerPedId()
-- 			local closestPlayer, distance = ESX.Game.GetClosestPlayer()
-- 			local closestPed = GetPlayerPed(closestPlayer)
-- 			if IsPedInAnyVehicle(playerPed, true) and not IsPedDeadOrDying(closestPed, 0) then
-- 				--piggyBackInProgress = false
-- 				--ClearPedSecondaryTask(PlayerPedId())
-- 				--DetachEntity(PlayerPedId(), true, false)
-- 				--DetachEntity(closestPed, true, false)
-- 				--TriggerServerEvent('pF5:carryStop', GetPlayerServerId(closestPlayer))
-- 			end
-- 		end
-- 		Citizen.Wait(1000)
-- 	end
-- end)

if pF5.Active.CommandPorter then
	RegisterCommand('porter', function(source, args)
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if closestDistance ~= -1 and closestDistance <= 3 then 
			Carry(source, args)
		else
			ESX.ShowNotification("Aucune personne à proximité")
		end
	end, false)
end

if pF5.Active.CommandCarry then
	RegisterCommand('carry', function(source, args)
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if closestDistance ~= -1 and closestDistance <= 3 then 
			Carry(source, args)
		else
			ESX.ShowNotification("Aucune personne à proximité")
		end
	end, false)
end

function Carry(source, args)
	if not piggyBackInProgress then
		piggyBackInProgress = true
		local lib = 'anim@arena@celeb@flat@paired@no_props@'
		local anim1 = 'piggyback_c_player_a'
		local anim2 = 'piggyback_c_player_b'
		local closestPlayer, distance = ESX.Game.GetClosestPlayer()
		if closestPlayer ~= nil and distance < 3 then
			TriggerServerEvent('pF5:carry', GetPlayerServerId(closestPlayer), lib, anim1, anim2, -0.07, 0.0, 0.45, 100000, 0.0, 49, 33, 1)
		else
			piggyBackInProgress = false
		end
	else
		piggyBackInProgress = false
		ClearPedSecondaryTask(PlayerPedId())
		DetachEntity(PlayerPedId(), true, false)
		local closestPlayer, distance = ESX.Game.GetClosestPlayer()
		if closestPlayer == nil and distance < 3 then 
			print("Nobody in radius 3") 
			return 
		end
		local closestPed = GetPlayerPed(closestPlayer)
		ClearPedSecondaryTask(closestPed)
		DetachEntity(closestPed, true, false)
		TriggerServerEvent('pF5:carryStop', GetPlayerServerId(closestPlayer))
	end
end

RegisterNetEvent('pF5:carryTarget')
AddEventHandler('pF5:carryTarget', function(target, animationLib, animation2, distans, distans2, height, length,spin,controlFlag)
	local playerPed = PlayerPedId()
	local playerServer = GetPlayerFromServerId(target)
	if playerServer == -1 then return end

	local targetPed = GetPlayerPed(playerServer)
	piggyBackInProgress = true
	RequestAnimDict(animationLib)

	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end
	if spin == nil then spin = 180.0 end
	AttachEntityToEntity(playerPed, targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)
	if controlFlag == nil then controlFlag = 0 end
	TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
end)

RegisterNetEvent('pF5:carrySync')
AddEventHandler('pF5:carrySync', function(animationLib, animation,length,controlFlag,animFlag)
	local playerPed = PlayerPedId()
	RequestAnimDict(animationLib)

	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end
	Wait(500)
	if controlFlag == nil then controlFlag = 0 end
	TaskPlayAnim(playerPed, animationLib, animation, 8.0, -8.0, length, controlFlag, 0, false, false, false)

	Citizen.Wait(length)
end)

RegisterNetEvent('pF5:carryStopTarget')
AddEventHandler('pF5:carryStopTarget', function(target)
	local playerPed = PlayerPedId()
	local pid = GetPlayerFromServerId(target)
	if pid == -1 then
	
		return
	end
	local targetPed = GetPlayerPed(pid)
	piggyBackInProgress = false
	ClearPedSecondaryTask(PlayerPedId())
	ClearPedSecondaryTask(playerPed)
	DetachEntity(GetPlayerPed(GetPlayerFromServerId(target)), true, false)
	DetachEntity(playerPed, true, false)
end)


local hostageAllowedWeapons = {
	`WEAPON_PISTOL`,
	`WEAPON_COMBATPISTOL`,
	`WEAPON_PISTOL50`,
	`WEAPON_SNSPISTOL`,
	`WEAPON_HEAVYPISTOL`,
	`WEAPON_VINTAGEPISTOL`,
	`WEAPON_APPISTOL`,

	`WEAPON_PISTOL_MK2`,
	`WEAPON_SNSPISTOL_MK2`,
	`WEAPON_REVOLVER_MK2`,
	`WEAPON_CERAMICPISTOL`,
	`WEAPON_NAVYREVOLVER`,
	`WEAPON_GADGETPISTOL`,
}

local holdingHostageInProgress = false

if pF5.Active.CommandOtage then
	RegisterCommand("otage",function()
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if closestDistance ~= -1 and closestDistance <= 3 then 
			takeHostage()
		else
			ESX.ShowNotification("Aucune personne à proximité")
		end
	end)
end

function takeHostage()
	ClearPedSecondaryTask(PlayerPedId())
	DetachEntity(PlayerPedId(), true, false)

	canTakeHostage = false
	for i=1, #hostageAllowedWeapons do
		if HasPedGotWeapon(PlayerPedId(), hostageAllowedWeapons[i], false) then
			if GetAmmoInPedWeapon(PlayerPedId(), hostageAllowedWeapons[i]) > 0 then
				canTakeHostage = true
				foundWeapon = hostageAllowedWeapons[i]
				break
			end
		end
	end

	if not canTakeHostage then
		ESX.ShowNotification("Vous avez besoin d'un pistolet pour prendre en otage")
		return
	end

	if holdingHostageInProgress then
		return
	end

	local lib = 'anim@gangops@hostage@'
	local anim1 = 'perp_idle'
	local lib2 = 'anim@gangops@hostage@'
	local anim2 = 'victim_idle'
	local distans = 0.11 --Higher = closer to camera
	local distans2 = -0.24 --higher = left
	local height = 0.0
	local spin = 0.0
	local length = 100000
	local controlFlagMe = 49
	local controlFlagTarget = 49
	local animFlagTarget = 50
	local attachFlag = true
	local closestPlayer = ESX.Game.GetClosestPlayer()
	local target = GetPlayerServerId(closestPlayer)
	if closestPlayer ~= nil then
		SetCurrentPedWeapon(PlayerPedId(), foundWeapon, true)
		holdingHostageInProgress = true
		holdingHostage = true
		TriggerServerEvent('pF5:anim:sync', closestPlayer, lib, lib2, anim1, anim2, distans, distans2, height, target, length, spin, controlFlagMe, controlFlagTarget, animFlagTarget, attachFlag)
	else
		ESX.ShowNotification("Aucun joueur à proximité")
	end
end

RegisterNetEvent('pF5:anim:syncTarget')
AddEventHandler('pF5:anim:syncTarget', function(target, animationLib, animation2, distans, distans2, height, length,spin,controlFlag,animFlagTarget,attach)
	local playerPed = PlayerPedId()
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))

	if GetPlayerFromServerId(target) == -1 then
	
		return
	end

	if holdingHostageInProgress then
		holdingHostageInProgress = false
	else
		holdingHostageInProgress = true
	end
	beingHeldHostage = true
	RequestAnimDict(animationLib)

	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end
	if spin == nil then spin = 180.0 end
	if attach then
		AttachEntityToEntity(PlayerPedId(), targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)
	end

	if controlFlag == nil then controlFlag = 0 end

	if animation2 == "victim_fail" then
		SetEntityHealth(PlayerPedId(),0)
		DetachEntity(PlayerPedId(), true, false)
		TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
		beingHeldHostage = false
		holdingHostageInProgress = false
	elseif animation2 == "shoved_back" then
		holdingHostageInProgress = false
		DetachEntity(PlayerPedId(), true, false)
		TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
		beingHeldHostage = false
	else
		TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
	end
end)

RegisterNetEvent('pF5:anim:syncMe')
AddEventHandler('pF5:anim:syncMe', function(animationLib, animation,length,controlFlag,animFlag)
	local playerPed = PlayerPedId()
	ClearPedSecondaryTask(playerPed)
	RequestAnimDict(animationLib)
	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end
	if controlFlag == nil then controlFlag = 0 end
	TaskPlayAnim(playerPed, animationLib, animation, 8.0, -8.0, length, controlFlag, 0, false, false, false)
	if animation == "perp_fail" then
		SetPedShootsAtCoord(playerPed, 0.0, 0.0, 0.0, 0)
		holdingHostageInProgress = false
	end
	if animation == "shove_var_a" then
		Wait(900)
		ClearPedSecondaryTask(playerPed)
		holdingHostageInProgress = false
	end
end)

RegisterNetEvent('pF5:anim:cl_stop')
AddEventHandler('pF5:anim:cl_stop', function()
	holdingHostageInProgress = false
	beingHeldHostage = false
	holdingHostage = false
	ClearPedSecondaryTask(PlayerPedId())
	DetachEntity(PlayerPedId(), true, false)
end)

Citizen.CreateThread(function()
	while true do
		if holdingHostage then
			if IsEntityDead(PlayerPedId()) then
				holdingHostage = false
				holdingHostageInProgress = false
				local closestPlayer, distance = ESX.Game.GetClosestPlayer()
				target = GetPlayerServerId(closestPlayer)
				TriggerServerEvent("pF5:anim:stop",target)
				Wait(100)
				releaseHostage()
			end

			DisableControlAction(0, 24, true) -- disable attack
			DisableControlAction(0, 25, true) -- disable aim
			DisableControlAction(0, 47, true) -- disable weapon
			DisableControlAction(0, 58, true) -- disable weapon
			DisablePlayerFiring(PlayerPedId(), true)

			local playerCoords = GetEntityCoords(PlayerPedId())
			ESX.ShowHelpNotification('~INPUT_DETONATE~ pour relacher\n~INPUT_VEH_HEADLIGHT~ pour tuer l\'otage', true)

			if IsDisabledControlJustPressed(0,47) then --release
				holdingHostage = false
				holdingHostageInProgress = false
				local closestPlayer, distance = ESX.Game.GetClosestPlayer()
				target = GetPlayerServerId(closestPlayer)
				TriggerServerEvent("pF5:anim:stop",target)
				Wait(100)
				releaseHostage()
			elseif IsDisabledControlJustPressed(0,74) then --kill
				holdingHostage = false
				holdingHostageInProgress = false
				local closestPlayer, distance = ESX.Game.GetClosestPlayer()
				target = GetPlayerServerId(closestPlayer)
				TriggerServerEvent("pF5:anim:stop",target)
				killHostage()
			end
		elseif beingHeldHostage then
			DisableControlAction(0, 21, true) -- disable sprint
			DisableControlAction(0, 24, true) -- disable attack
			DisableControlAction(0, 25, true) -- disable aim
			DisableControlAction(0, 47, true) -- disable weapon
			DisableControlAction(0, 58, true) -- disable weapon
			DisableControlAction(0, 263, true) -- disable melee
			DisableControlAction(0, 264, true) -- disable melee
			DisableControlAction(0, 257, true) -- disable melee
			DisableControlAction(0, 140, true) -- disable melee
			DisableControlAction(0, 141, true) -- disable melee
			DisableControlAction(0, 142, true) -- disable melee
			DisableControlAction(0, 143, true) -- disable melee
			DisableControlAction(0, 75, true) -- disable exit vehicle
			DisableControlAction(27, 75, true) -- disable exit vehicle
			DisableControlAction(0, 22, true) -- disable jump
			DisableControlAction(0, 32, true) -- disable move up
			DisableControlAction(0, 268, true)
			DisableControlAction(0, 33, true) -- disable move down
			DisableControlAction(0, 269, true)
			DisableControlAction(0, 34, true) -- disable move left
			DisableControlAction(0, 270, true)
			DisableControlAction(0, 35, true) -- disable move right
			DisableControlAction(0, 271, true)
		else
			Citizen.Wait(1000)
		end
		Citizen.Wait(0)
	end
end)

function releaseHostage()
	local player = PlayerPedId()
	local lib = 'reaction@shove'
	local anim1 = 'shove_var_a'
	local lib2 = 'reaction@shove'
	local anim2 = 'shoved_back'
	local distans = 0.11 --Higher = closer to camera
	local distans2 = -0.24 --higher = left
	local height = 0.0
	local spin = 0.0
	local length = 100000
	local controlFlagMe = 120
	local controlFlagTarget = 0
	local animFlagTarget = 1
	local attachFlag = false
	local closestPlayer, distance = ESX.Game.GetClosestPlayer()
	local target = GetPlayerServerId(closestPlayer)
	if closestPlayer ~= nil then
		TriggerServerEvent('pF5:anim:sync', closestPlayer, lib,lib2, anim1, anim2, distans, distans2, height,target,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget,attachFlag)
	else

	end
end

function killHostage()
	local player = PlayerPedId()
	local lib = 'anim@gangops@hostage@'
	local anim1 = 'perp_fail'
	local lib2 = 'anim@gangops@hostage@'
	local anim2 = 'victim_fail'
	local distans = 0.11 --Higher = closer to camera
	local distans2 = -0.24 --higher = left
	local height = 0.0
	local spin = 0.0
	local length = 0.2
	local controlFlagMe = 168
	local controlFlagTarget = 0
	local animFlagTarget = 1
	local attachFlag = false
	local closestPlayer, distance = ESX.Game.GetClosestPlayer()
	target = GetPlayerServerId(closestPlayer)
	if closestPlayer ~= nil then
	
		TriggerServerEvent('pF5:anim:sync', closestPlayer, lib,lib2, anim1, anim2, distans, distans2, height,target,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget,attachFlag)
	else
		
	end
end
