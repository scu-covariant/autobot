--@impl interface 
local info = {  -- 该模块信息
    SelfName = "paper",
    Database = "paperdb",
    CtrlName = "paperctrl",
    Terminal = true, -- 发生该事件后是否不再响应其他事件 
}

--@enum optional
local errnum = {
    Ok = 0,
}

--@impl interface
local function filiter(msgstr)
    return msg:find("来点壁纸") ~= nil
end

--@impl interface
local function check(ring, db, uid)
    return true
end

--@impl interface
local function action(event, err, ring, db)
    local bz = ("https://api.ixiaowai.cn/gqapi/gqapi.php")
    event.group:sendMsg(Msg():appendImage(bz, group))
end

--@impl interface
local function after(db, uid)
    --nothing
end

--@impl interface
local function log(db, uid)
    --nothing
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
