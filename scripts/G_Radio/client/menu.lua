ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(5000)
	end
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
    ESX.PlayerData.job = job
end)

RegisterNetEvent("esx:setJob2")
AddEventHandler("esx:setJob2", function(job2)
    ESX.PlayerData.job2 = job2
end)

local frequence = ""
local xIndex = 1
local radio_volume = 0

function Radio()
	local __label = {}
	local __frequency = {}
	for i = 1, #G_Radio.PrivateCanal.List, 1 do
		table.insert(__label, G_Radio.PrivateCanal.List[i].label)
		table.insert(__frequency, G_Radio.PrivateCanal.List[i].frequency)
    end
	local mainMenu = RageUI.CreateMenu("Radio", "Menu")
    local radio_menu = false
    mainMenu.Closed = function() radio_menu = false end
	if not radio_menu then radio_menu = true RageUI.Visible(mainMenu, true)
		CreateThread(function()
		    while radio_menu do 
		        RageUI.IsVisible(mainMenu, function() 
					mainMenu.EnableMouse = false
					RageUI.Checkbox("Allumer / Éteindre la radio", nil, radio_active, {}, {
                        onChecked = function()
                            radio_active = true
							if G_Radio.VoiceSystem == "pma-voice" then
								exports["pma-voice"]:setVoiceProperty("radioEnabled", true)
							elseif G_Radio.VoiceSystem == "mumble-voip" then
								exports["mumble-voip"]:SetMumbleProperty("radioEnabled", true)
							end
							ESX.ShowNotification("Vous venez d'~g~allumer ~s~votre radio")                                
                        end,
                        onUnChecked = function()
                            radio_active = false  
							if G_Radio.VoiceSystem == "pma-voice" then
								exports["pma-voice"]:setVoiceProperty("radioEnabled", false)
							elseif G_Radio.VoiceSystem == "mumble-voip" then
								exports["mumble-voip"]:SetMumbleProperty("radioEnabled", false)
							end     
							ESX.ShowNotification("Vous venez d'~r~éteindre ~s~votre radio")                                  
                        end
                    })
					if radio_active then
						RageUI.Line()	
						if radio_connect then
							RageUI.Separator("Status : ~g~Connecté")
						else
							RageUI.Separator("Status : ~r~Déconnecté")
						end
						RageUI.Separator("Volume : ~b~"..math.round(radio_volume*100).."%")
						RageUI.Line()
						RageUI.Button("Choix de la fréquence", nil, {RightLabel = "[~b~"..frequence.."~s~] →"}, true, {
							onActive = function()
								mainMenu.EnableMouse = true
								if G_Radio.PrivateCanal.Info and G_Radio.PrivateCanal.Active then
									RageUI.Info("Liste des fréquences privées", __label, __frequency)
								end
							end,
							onSelected = function()
								_frequence = KeyboardInput("Choix de votre fréquence (1 - 999)", nil, 3)
								if G_Radio.PrivateCanal.Active then	
									for k,v in pairs(G_Radio.PrivateCanal.List)	do
										if v.frequency == tonumber(_frequence) then
											if v.type == "job1" then
												if v.name ~= ESX.PlayerData.job.name then
													ESX.ShowNotification("Vous ne pouvez pas rentrer sur cette fréquence car elle est réversé au / à la ~b~"..v.label)
													return
												end
											elseif v.type == "job2" then
												if v.name ~= ESX.PlayerData.job2.name then
													ESX.ShowNotification("Vous ne pouvez pas rentrer sur cette fréquence car elle est réversé au / à la ~b~"..v.label)
													return
												end
											end
										end
									end
								end
								frequence = _frequence
								if radio_connect then
									if G_Radio.VoiceSystem == "pma-voice" then
										exports["pma-voice"]:setRadioChannel(tonumber(frequence))
									elseif G_Radio.VoiceSystem == "mumble-voip" then
										exports["mumble-voip"]:SetRadioChannel(tonumber(frequence))
									end
								end
							end
						})			
						RageUI.List("Fréquence", {"Connecté", "Déconnecté"}, xIndex, nil, {}, true, {
							onActive = function()
								mainMenu.EnableMouse = true
							end,
							onListChange = function(Index)
								xIndex = Index
							end,
							onSelected = function()
								if xIndex == 1 then
									radio_connect = true
									if G_Radio.VoiceSystem == "pma-voice" then
										if frequence == "" then
											ESX.ShowNotification("Vous devez d'abord choisir une fréquence")
											return
										end
										exports["pma-voice"]:setRadioChannel(tonumber(frequence))
									elseif G_Radio.VoiceSystem == "mumble-voip" then
										exports["mumble-voip"]:SetRadioChannel(tonumber(frequence))
									end
									ESX.ShowNotification("Vous venez de vous ~g~connecter ~s~à la fréquence ~b~"..frequence) 
								elseif xIndex == 2 then
									radio_connect = false
									if G_Radio.VoiceSystem == "pma-voice" then
										exports["pma-voice"]:setRadioChannel(0)
									elseif G_Radio.VoiceSystem == "mumble-voip" then
										exports["mumble-voip"]:SetRadioChannel(0)
									end
									ESX.ShowNotification("Vous venez de vous ~r~déconnecter ~s~de la fréquence ~b~"..frequence) 
								end
							end
						})
						RageUI.Checkbox("Activer / Désactiver les bruitages", nil, radio_bruitage, {}, {
							onChecked = function()
								radio_bruitage = true 
								if G_Radio.VoiceSystem == "pma-voice" then
									exports["pma-voice"]:setVoiceProperty("micClicks", true)
								elseif G_Radio.VoiceSystem == "mumble-voip" then
									exports["mumble-voip"]:SetMumbleProperty("micClicks", true)
								end 
								ESX.ShowNotification("Vous venez d'~g~activer ~s~les bruitages")                                
							end,
							onUnChecked = function()
								radio_bruitage = false
								if G_Radio.VoiceSystem == "pma-voice" then
									exports["pma-voice"]:setVoiceProperty("micClicks", false)
								elseif G_Radio.VoiceSystem == "mumble-voip" then
									exports["mumble-voip"]:SetMumbleProperty("micClicks", false)
								end       
								ESX.ShowNotification("Vous venez de ~r~désactiver ~s~les bruitages")                                  
							end 
						})
						RageUI.PercentagePanel(radio_volume, 'Volume', '0%', '100%', {
							onProgressChange = function(Index)	
								radio_volume = Index
								if G_Radio.VoiceSystem == "pma-voice" then
									exports["pma-voice"]:setRadioVolume(radio_volume)
								end 
							end
						}, 6)
						RageUI.PercentagePanel(radio_volume, 'Volume', '0%', '100%', {
							onProgressChange = function(Index)	
								radio_volume = Index
								if G_Radio.VoiceSystem == "pma-voice" then
									exports["pma-voice"]:setRadioVolume(radio_volume)
								end
							end
						}, 7)
					end
		        end)                   
		    Wait(0)
		    end
	    end)
    end
end

Keys.Register(G_Radio.OpenKey, "openradiomenu", "Ouvrir le menu radio", function()
	ESX.TriggerServerCallback("</G_Radio>:_Verify_", function(cb)
		if cb ~= true then
			return
		else
			if G_Radio.Item.Active then
				ESX.TriggerServerCallback('</G_Radio>:_getItemAmount_', function(cb)
					if cb >= 1 then
						Radio()
					else
						ESX.ShowNotification("Vous devez vous munir d'une radio")
					end
				end, G_Radio.Item.Name)
			else
				Radio()
			end
		end
	end)
end)