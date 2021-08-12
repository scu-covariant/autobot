--@impl interface 
local info = {
    SelfName = "keyanswer",
    Database = "kadb",
    CtrlName = "kactrl",
    Terminal = true, 
}

--@enum interface
local errnum = {
    Ok = 0,
}

--@impl interface
local function filiter(msgstr, db)
    for _, key in pairs(db.Keys) do 
        if msgstr:find(key) ~= nil then 
            return true 
        end
    end
    return false
end

--@impl interface
local function check(ring, db, uid)
    return ring <= Ring.Master
end

--@impl interface
local function action(event, err, ring, db)
    local msgstr = tostring(event.message)
    for index, key in pairs(db.Keys) do 
        if msgstr:find(key) ~= nil then 
            event.group:sendMessage(db.Answers[index])
        end
    end
end

--@impl interface
local function after(db, uid)
    -- nothing
end

--@impl interface
local function log(db, uid)
    print(uid.." trig key")
end

--@ret 
local module = {
    --@impl interface
    Info    = info,
    
    Filiter = filiter,
    Checker = check,
    Act     = action,
    After   = after,
    Log     = log
}

return module
