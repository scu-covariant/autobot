--@impl interface
local control = {
    Running = true,
}

--@key
local function IsStop(event, db, ctrl)
    local msgstr = tostring(event.message)
    -- if msgstr == "xxx" then 
    --     return ctrl.Running
    -- else 
    --     return false
    -- end
end

--@react
local function Stop(event, db, ctrl)
    ctrl.Running = false
end

--@key
local function IsStart(event, db, ctrl)
    local msgstr = tostring(event.message)
    -- if msgstr == "kk" then
    --     return not ctrl.Running
    -- else 
    --     return false
    -- end
end

--@react
local function Start(event, db, ctrl)
    ctrl.Running = true
end

--@ret
local module = {}
module[IsStop]  = Stop
module[IsStart] = Start

return module