PlayerData = {}

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(xPlayer)
    PlayerData = xPlayer
end)

local currentWeapon = false
local canfire = false

local ItemShooting = false
local noWeaponBox = false
local Prop = {}

RegisterNetEvent('WeaponItem:useWeapon')
AddEventHandler('WeaponItem:useWeapon', function(weapon)
    --if not IsPedInAnyVehicle(PlayerPedId()) and not noWeaponBox then
        if currentWeapon == weapon then
            RemoveWeapon(currentWeapon)
            currentWeapon = nil
        else
            currentWeapon = weapon
            GiveWeapon(currentWeapon)
            if weapon == "WEAPON_BRIEFCASE_02" then
                TriggerServerEvent("Malette", 1)
            elseif weapon == "WEAPON_BRIEFCASE" then
                TriggerServerEvent("Malette", 2)
            end
        end
    --end
end)

function loadAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

function RemoveWeapon(weapon)
    if weapon == "WEAPON_BRIEFCASE" or "WEAPON_BRIEFCASE_02" then
        TriggerServerEvent("Malette", 3)
    end
    --if not IsPedInAnyVehicle(PlayerPedId(), false) then
        local playerPed = PlayerPedId()

        ItemShooting = false
        GiveWeaponToPed(playerPed, "weapon_unarmed", 0, false, true)
        SetCurrentPedWeapon(playerPed, "weapon_unarmed", true)
    --end
end

local ListItemShooting = {
    0x497FACC3,
    0x24B17070,
    0x34A67B97,
    0x787F0BB,
    0x23C9F95C,
}

local ListWeaponsAnim = {
	'WEAPON_PISTOL',
    'WEAPON_APPISTOL',
    'WEAPON_PISTOL50',
    'WEAPON_REVOLVER',
    'WEAPON_SNSPISTOL',
    'WEAPON_HEAVYPISTOL',
    'WEAPON_VINTAGEPISTOL',
    'WEAPON_DOUBLEACTION',
    'WEAPON_COMBATPISTOL'
}

function GiveWeapon(weapon)
    --if not IsPedInAnyVehicle(PlayerPedId(), false) then
        local playerPed = PlayerPedId()
        local hash = GetHashKey(weapon)
        local label = ESX.GetWeaponLabel(weapon)

        if label ~= nil then
            ESX.ShowNotification("Vous avez équipé votre ~b~"..label.."~s~")
        end

        if PlayerData.job and PlayerData.job.name ~= "police" and PlayerData.job.name ~= "uss" then
            for k,v in pairs(ListWeaponsAnim) do
                if weapon == v then
                    canfire = true
                    --GiveWeaponToPed(playerPed, "weapon_unarmed", 0, false, true)
                    --loadAnimDict("reaction@intimidation@1h")
                    --TaskPlayAnimAdvanced(playerPed, "reaction@intimidation@1h", "intro", GetEntityCoords(playerPed, true), 0, 0, GetEntityHeading(playerPed), 8.0, 3.0, 2500, 50, 0, 0, 0)
                    --Wait(800)
                end
            end
        end

        if 0x497FACC3 == hash then
            GiveWeaponToPed(playerPed, hash, 1, false, true)

            ItemShooting = true
            while ItemShooting do
                Wait(1)
                if IsPedShooting(PlayerPedId()) then
                    TriggerServerEvent('WeaponItem:removeItem', weapon)
                    Wait(150)
                    GiveWeaponToPed(playerPed, "weapon_unarmed", 0, false, true)
                    currentWeapon = nil
                    ItemShooting = false
                end
            end
        elseif 0x24B17070 == hash then
            GiveWeaponToPed(playerPed, hash, 1, false, true)

            ItemShooting = true
            while ItemShooting do
                Wait(1)
                if IsPedShooting(PlayerPedId()) then
                    TriggerServerEvent('WeaponItem:removeItem', weapon)
                    Wait(150)
                    GiveWeaponToPed(playerPed, "weapon_unarmed", 0, false, true)
                    currentWeapon = nil
                    ItemShooting = false
                end
            end
        elseif 0x34A67B97 == hash then
            GiveWeaponToPed(playerPed, hash, 1000, false, true)

            ItemShooting = true
            while ItemShooting do
                Wait(1)
                if IsPedShooting(PlayerPedId()) then
                    TriggerServerEvent('WeaponItem:removeItem', weapon)
                    Wait(150)
                    GiveWeaponToPed(playerPed, "weapon_unarmed", 0, false, true)
                    currentWeapon = nil
                    ItemShooting = false
                end
            end
        elseif 0x787F0BB == hash then
            GiveWeaponToPed(playerPed, hash, 1, false, true)

            ItemShooting = true
            while ItemShooting do
                Wait(1)
                if IsPedShooting(PlayerPedId()) then
                    TriggerServerEvent('WeaponItem:removeItem', weapon)
                    Wait(150)
                    GiveWeaponToPed(playerPed, "weapon_unarmed", 0, false, true)
                    currentWeapon = nil
                    ItemShooting = false
                end
            end
        elseif 0x23C9F95C == hash then
            GiveWeaponToPed(playerPed, hash, 1, false, true)
            
            ItemShooting = true
            while ItemShooting do
                Wait(1)
                if IsPedShooting(PlayerPedId()) then
                    TriggerServerEvent('WeaponItem:removeItem', weapon)
                    Wait(150)
                    GiveWeaponToPed(playerPed, "weapon_unarmed", 0, false, true)
                    currentWeapon = nil
                    ItemShooting = false
                end
            end
        else
            GiveWeaponToPed(playerPed, hash, 0, false, true)
            TriggerEvent("AddAmmoInWeapon")
            if canfire then
                Wait(1500)
                canfire = false
            end
        end
    --end
end

RegisterNetEvent('WeaponItem:useWeaponFlashlight')
AddEventHandler('WeaponItem:useWeaponFlashlight', function()
    local pPed = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(pPed)

    if currentWeaponHash == GetHashKey("WEAPON_PISTOL") then
        if not HasPedGotWeaponComponent(pPed, GetHashKey("WEAPON_PISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH")) then
            GiveWeaponComponentToPed(pPed, GetHashKey("WEAPON_PISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH"))  

            ESX.ShowNotification("Vous avez équipé votre lampe sur votre ~g~'"..ESX.GetWeaponLabel('WEAPON_PISTOL').."'~s~")
        else
            RemoveWeaponComponentFromPed(pPed, GetHashKey("WEAPON_PISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH"))
        end
    elseif currentWeaponHash == GetHashKey("WEAPON_COMBATPISTOL") then
        if not HasPedGotWeaponComponent(pPed, GetHashKey("WEAPON_COMBATPISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH")) then
            GiveWeaponComponentToPed(pPed, GetHashKey("WEAPON_COMBATPISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH"))  

            ESX.ShowNotification("Vous avez équipé votre lampe sur votre ~g~'"..ESX.GetWeaponLabel('WEAPON_COMBATPISTOL').."'~s~")
        else
            RemoveWeaponComponentFromPed(pPed, GetHashKey("WEAPON_COMBATPISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH"))
        end
    elseif currentWeaponHash == GetHashKey("WEAPON_PISTOL50") then
        if not HasPedGotWeaponComponent(pPed, GetHashKey("WEAPON_PISTOL50"), GetHashKey("COMPONENT_AT_PI_FLSH")) then
            GiveWeaponComponentToPed(pPed, GetHashKey("WEAPON_PISTOL50"), GetHashKey("COMPONENT_AT_PI_FLSH"))  

            ESX.ShowNotification("Vous avez équipé votre lampe sur votre ~g~'"..ESX.GetWeaponLabel('WEAPON_PISTOL50').."'~s~")
        else
            RemoveWeaponComponentFromPed(pPed, GetHashKey("WEAPON_PISTOL50"), GetHashKey("COMPONENT_AT_PI_FLSH"))
        end
    elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYPISTOL") then
        if not HasPedGotWeaponComponent(pPed, GetHashKey("WEAPON_HEAVYPISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH")) then
            GiveWeaponComponentToPed(pPed, GetHashKey("WEAPON_HEAVYPISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH"))  

            ESX.ShowNotification("Vous avez équipé votre lampe sur votre ~g~'"..ESX.GetWeaponLabel('WEAPON_HEAVYPISTOL').."'~s~")
        else
            RemoveWeaponComponentFromPed(pPed, GetHashKey("WEAPON_HEAVYPISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH"))
        end
    elseif currentWeaponHash == GetHashKey("WEAPON_SMG") then
        if not HasPedGotWeaponComponent(pPed, GetHashKey("WEAPON_SMG"), GetHashKey("COMPONENT_AT_AR_FLSH")) then
            GiveWeaponComponentToPed(pPed, GetHashKey("WEAPON_SMG"), GetHashKey("COMPONENT_AT_AR_FLSH"))  

            ESX.ShowNotification("Vous avez équipé votre lampe sur votre ~g~'"..ESX.GetWeaponLabel('WEAPON_SMG').."'~s~")
        else
            RemoveWeaponComponentFromPed(pPed, GetHashKey("WEAPON_SMG"), GetHashKey("COMPONENT_AT_AR_FLSH"))
        end
    elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
        if not HasPedGotWeaponComponent(pPed, GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_AT_AR_FLSH")) then
            GiveWeaponComponentToPed(pPed, GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_AT_AR_FLSH"))  

            ESX.ShowNotification("Vous avez équipé votre lampe sur votre ~g~'"..ESX.GetWeaponLabel('WEAPON_CARBINERIFLE').."'~s~")
        else
            RemoveWeaponComponentFromPed(pPed, GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_AT_AR_FLSH"))
        end
    end
end)