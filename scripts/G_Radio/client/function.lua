ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(5000)
	end
end)

function KeyboardInput(TextEntry, ExampleText, MaxStringLength)
	AddTextEntry('FMMC_KEY_TIP1', TextEntry)
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
	blockinput = true
	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Citizen.Wait(0) 
    end
	if UpdateOnscreenKeyboard() ~= 2 then 
        local result = GetOnscreenKeyboardResult() 
        Citizen.Wait(500) 
        blockinput = false 
        return result
    else Citizen.Wait(500) 
        blockinput = false 
        return nil
	end
end

function GetLabelTable(value)
    for k,v in pairs(G_Radio.PrivateCanal.List) do
        if v.frequency == value then
            return v.label
        end
    end
end