if Config.ActivateTimeBar.Activate then
    local TimerBar = {}
    RegisterCommand(Config.ActivateTimeBar.CommandStart, function(source, args)
        TimerBar:TestDraw(true, args[1])
    end)
    RegisterCommand(Config.ActivateTimeBar.CommandStop, function(source, args)
        TimerBar:TestDraw(false)
    end)
    -- TimerBar:TestDraw(true, 20)  -- Activé
    -- TimerBar:TestDraw(false)  -- Désativé
    function Rounder(number, decimals) local power = 10^decimals return math.floor(number * power) / power end
    function DrawTextuel(a,b,c,d,e,f,g,h,i,j,k,l)SetTextFont(k)SetTextScale(e,e)N_0x4e096588b13ffeca(l)SetTextColour(254,254,254,255)SetTextEntry("STRING")AddTextComponentString(f)DrawText(a-0.1+c,b-0.02+d)end
    function TimerBar:TestDraw(Show, Time)
        if TimerBar.Info == true then
            TimerBar.Info = false
            Citizen.Wait(50)
        end
        if Show == false then TimerBar.Timer = 0 TimerBar.Info = false end
        TimerBar.Timer = tonumber(Time)
        Citizen.Wait(100)
        TimerBar.Info = true
        Citizen.CreateThread(function()
            while TimerBar.Info do
                if TimerBar.Timer == nil then return end
                RequestStreamedTextureDict("timerbars", false)
                if TimerBar.Timer > 10 then
                    DrawTextuel(1.025, 0.955, 0.005, 0.0028, 0.29, "Temps restant: "..Rounder(TimerBar.Timer, 1), 255, 255, 255, 255, 0, 0)
                else
                    DrawTextuel(1.025, 0.955, 0.005, 0.0028, 0.29, "Temps restant: ~r~"..Rounder(TimerBar.Timer, 1), 255, 255, 255, 255, 0, 0)
                end
                DrawSprite("timerbars", "all_black_bg", 0.920, 0.950, 0.132, 0.032, 0.0, 255, 255, 255, 200)
                Citizen.Wait(4)
            end
        end)
        Citizen.CreateThread(function()
            while TimerBar.Info do
            Citizen.Wait(100)
            if TimerBar.Timer == nil then return end
                if TimerBar.Timer <= 0.1 then
                    TimerBar.Info = false
                else
                    TimerBar.Timer = TimerBar.Timer - 0.1
                end
            end
        end)
    end
end