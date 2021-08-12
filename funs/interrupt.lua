--@impl interface
local info = {
    SelfName = "interrupt",
    Database = "irptdb",
    CtrlName = "irptctrl",
    Terminal = false,
}

--@enum optional
local errnum = {
    Ok = 0,
}

--@impl interface
local function filiter(msgstr, db)
    return true
end

--@impl interface
local function check(ring, db, uid)
    return errnum.Ok
end

--@impl interface
local function action(event, err, ring, db)
    if err == errnum.Ok then
        local msgstr = tostring(event.message)
        if msgstr == db.LastMessage then
            db.RepeatCount = db.RepeatCount + 1
            if db.RepeatCount >= db._TriggerValue - 1 then
                if db.LastMessage == db._IrptReplay then 
                    event.group:sendMessage(db._TrappedReply)
                else 
                    event.group:sendMessage(db._IrptReplay)
                end
                db.RepeatCount = 0
            end
        else
            db.LastMessage = msgstr
            db.RepeatCount = 0
        end
    end
end

--@impl interface
local function after(db, uid)
    -- nothing
end

--@impl interface
local function log(db, uid)
    -- nothing
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
