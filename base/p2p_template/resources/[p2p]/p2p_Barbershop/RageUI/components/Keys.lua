Keys = {};

function Keys.Register(Controls, ControlName, Description, Action)
    local _Keys = {
        CONTROLS = Controls
   }
    RegisterKeyMapping(string.format('w_legacy-%s', ControlName), Description, 'keyboard', Controls)
    RegisterCommand(string.format('w_legacy-%s', ControlName), function(source, args)
        if (Action ~= nil) then
            Action();
        end
    end, false)
    return setmetatable(_Keys, Keys)
end

function Keys:Exists(Controls)
    return self.CONTROLS == Controls and true or false
end