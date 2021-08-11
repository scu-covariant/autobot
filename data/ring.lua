--[[
    ring control tables

    table          contents         type     main key/elements      properties
    -Admin      -> super user       table       uid(string)         Call(string)
    -Master     -> power user       table       uid(string)         Call(string) 
    -Common     -> common user      hash        uid(string)             /
    -Black      -> black list       hash        uid(string)             /

    function            ret    
    IsAdmin(uid)    ->  bool
    IsMaster(uid)   ->  bool
    IsCommon(uid)   ->  bool
    IsBlack(uid)    ->  bool
    AddMaster(uid)  ->  /
    DeleteMaster(uid)               ->  /
    SetMasterCall(uid, newcall)     ->  /
    SetAdminCall(newcall)           ->  /
    GetMasterCall(uid)      -> string
    GetAdminCall()          -> string

--]]

local Admin = {
    ["2821006329"] = {  Call = "老板"   }
}

local Master = {
    --[[
        ["123456789"] = {  Call = "_"   },
    --]]
}

--@hashtable, main key = uid(string), value = 1(number)
local Common = {
    --[[
        ["123456789"] = 1,
    --]]
}

--@hashtable, main key = uid(string), value = 1(number)
local Black = {
    --[[
        ["123456789"] = 1,
    --]]
}

local function isAdmin(uid)
    return Admin[uid] ~= nil
end

local function isMaster(uid)
    return Master[uid] ~= nil
end

local function isBlack(uid)
    return Black[uid] ~= nil
end

local function isCommon(uid)
    return Common[uid] ~= nil
end

local function addMaster(uid)
    Master[uid] = {}
end

local function deleteMaster(uid)
    Master[uid] = nil
end

local function setMasterCall(uid, call)
    Master[uid].Call = call
end

local function setAdminCall(call)
    Admin["2821006329"].Call = call
end

local function getAdminCall()
    return Admin["2821006329"].Call
end

local function getMasterCall(uid)
    return Master[uid].Call
end

local Ring = {
    _admin = Admin,
    _master = Master,
    _common = Common,
    _balck  = Black,
    IsAdmin = isAdmin,
    IsBlack = isBlack,
    IsCommon = isCommon,
    IsMaster = isMaster,
    AddMaster = addMaster,
    DeleteMaster = deleteMaster,
    SetAdminCall = setAdminCall,
    SetMasterCall = setMasterCall,
    GetMasterCall = getMasterCall,
    GetAdminCall = getAdminCall, 
}

return Ring 