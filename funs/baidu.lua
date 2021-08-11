--@impl interface
local info = {
    SelfName = "baidu",
    Database = "baidudb",
    CtrlName = "baiductrl",
    Terminal = true,
}

--@enum
local errnum = {
    Ok = 0,
    CcountRunOut = 1,
}

--@impl interface
local function filiter(msgstr)
    return 1 == string.find(msgstr, "百度一下") 
end

--@impl interface
local function check(ring, db, uid)
    return errnum.Ok
end

--@impl interface
local function action(event, err, ring, db)
    local sender = event.group
    if err == errnum.Ok then 
        BAIDU = "http://www.oxox.ltd/bai/du.html?"
        local msgstr = string.gsub(tostring(event.message), "百度一下", "")
	    local rep = BAIDU..msgstr:encodeURL("UTF-8")
        rep = string.gsub(rep, "+", "")
        sender:sendMessage(rep)
    end
end

--@impl interface
local function after(db, uid)
end

--@impl interface
local function log(db, uid)
end

--@ret
local module = {
    Info = info,

    Filiter = filiter,
    Checker = check,
    Act = action,
    After = after,
    Log = log,
}

return module