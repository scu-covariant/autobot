--@impl interface 
local info = {  -- 该模块信息
    SelfName = "模块名字",
    Database = "数据库页名",
    CtrlName = "控制表页名",
    Terminal = true, -- 发生该事件后是否不再响应其他事件 
}
--@impl interface
local ctrl {    -- 控制表
    Running = true,
}

--@enum optional
local errnum = {
    Ok = 0,
}

--@impl interface
local function filiter(msgstr)
    return true
end

--@impl interface
local function check(ring, db, uid)

end

--@impl interface
local function action(event, err, ring, db)

end

--@impl interface
local function after(db, uid)

end

--@impl interface
local function log(db, uid)

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
