--@impl interface
local control = {
    Running = true,
}

--@condition
local function IsStop(event, db, manage)
    local msgstr = tostring(event.message)
    if msgstr == db._StopCmd then 
        return manage.Running
    else 
        return false
    end
end

--@react
local function Stop(event, db, manage)
    manage.Running = false
    event.group:sendMessage(db._OnStop)
end

--@condition
local function IsStart(event, db, manage)
    local msgstr = tostring(event.message)
    if msgstr == db._StartCmd then
        return not manage.Running
    else 
        return false
    end
end

--@react
local function Start(event, db, manage)
    manage.Running = true
    event.group:sendMessage(db._OnStart)
end

--@ret
local module = {
    Manage = control,

    Condition = {
        IsStart, IsStop,
    },

    React = {
        Start, Stop
    },
}


return module