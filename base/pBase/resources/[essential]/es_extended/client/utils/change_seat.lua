if Config.ActivateSwitchPlacesInCar then	
	Citizen.CreateThread(function()
		while true do
			local sleep = 750
			local plyPed = PlayerPedId()
			if IsPedSittingInAnyVehicle(plyPed) then
				sleep = 1
				local plyVehicle = GetVehiclePedIsIn(plyPed, false)
				local carSpeed = GetEntitySpeed(plyVehicle) * 3.6

				if IsControlJustReleased(0, 157) then -- conducteur
					SetPedIntoVehicle(plyPed, plyVehicle, -1)
					Citizen.Wait(10)
				end

				if IsControlJustReleased(0, 158) then -- avant droit
					if not (IsPedOnAnyBike(plyPed) and carSpeed > 30.0) then
						SetPedIntoVehicle(plyPed, plyVehicle, 0)
						Citizen.Wait(10)
					end
				end

				if IsControlJustReleased(0, 160) then -- arriere gauche
					SetPedIntoVehicle(plyPed, plyVehicle, 1)
					Citizen.Wait(10)
				end

				if IsControlJustReleased(0, 164) then -- arriere gauche
					SetPedIntoVehicle(plyPed, plyVehicle, 2)
					Citizen.Wait(10)
				end
			end
			Citizen.Wait(sleep)
		end
	end)
end