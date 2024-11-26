local coffre = false 
local mainMenu = RageUI.CreateMenu('Coffre', 'MENU')
mainMenu.Closed = function() coffre = false end

function Coffre()
    if coffre then coffre = false RageUI.Visible(mainMenu, false) return else coffre = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
        	while coffre do 
           		RageUI.IsVisible(mainMenu,function() 
               		RageUI.Button("Prendre item", nil, {RightLabel = "→"}, true , {
                   		onSelected = function()
							GetCoffre()
                   			RageUI.CloseAll()
							coffre = false
                   		end
               		})
               		RageUI.Button("Déposer item", nil, {RightLabel = "→"}, true , {
                   		onSelected = function()
							PutCoffre()
                   			RageUI.CloseAll()
							coffre = false
                   		end
               		})
           		end)
         	Wait(0)
        	end
     	end)
  	end
end

local pos = {{x = 253.10, y = 223.02, z = 106.28}}

Citizen.CreateThread(function()
    while true do
    	local wait = 900
    	for k in pairs(pos) do
        	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'banquier' then 
            	local coords = GetEntityCoords(GetPlayerPed(-1), false)
            	local dist = Vdist(coords.x, coords.y, coords.z, pos[k].x, pos[k].y, pos[k].z)
            	if dist <= 2.0 then 
					wait = 0
            		DrawMarker(6, 253.10, 223.02, 105.29, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 66, 255, false, false, p19, false)   
            		if dist <= 1.0 then 
						wait = 0
						ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir le ~g~Coffre")
                		if IsControlJustPressed(1,51) then
							Coffre()
           				end
        			end
        		end
    		end
		Citizen.Wait(wait)
		end
	end
end)

function GetCoffre()
	ESX.TriggerServerCallback('esx_banquierjob:getStockItems', function(items)
		local elements = {}
		for i=1, #items, 1 do table.insert(elements, {label = 'x' .. items[i].count .. ' ' .. items[i].label,value = items[i].name})
		end
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {css = 'banquier',title = 'coffre banquier',align = 'top-left',elements = elements}, function(data, menu)
			local itemName = data.current.value
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {css = 'banquier',title = 'quantité'}, function(data2, menu2)
				local count = tonumber(data2.value)
				if count == nil then ESX.ShowNotification('quantité invalide')
				else menu2.close() menu.close() TriggerServerEvent('esx_banquierjob:getStockItem', itemName, count) Citizen.Wait(1000) GetCoffre()
				end
			end, function(data2, menu2) menu2.close()
			end)
		end, function(data, menu) menu.close()
		end)
	end)
end

function PutCoffre()
	ESX.TriggerServerCallback('esx_banquierjob:getPlayerInventory', function(inventory)
		local elements = {}
		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]
			if item.count > 0 then table.insert(elements, {label = item.label .. ' x' .. item.count,type  = 'item_standard',value = item.name})
			end
		end
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {css = 'banquier',title = 'inventaire',align = 'top-left',elements = elements}, function(data, menu)
			local itemName = data.current.value
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {css = 'banquier',title = 'quantité'}, function(data2, menu2)
				local count = tonumber(data2.value)
				if count == nil then ESX.ShowNotification('quantité invalide')
				else menu2.close() menu.close() TriggerServerEvent('esx_banquierjob:putStockItems', itemName, count) Citizen.Wait(1000) PutCoffre()
				end
			end, function(data2, menu2) menu2.close()
			end)
		end, function(data, menu) menu.close()
		end)
	end)
end