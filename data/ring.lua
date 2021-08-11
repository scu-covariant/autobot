--[[
    ring
--]]

Ring = {
    Admin = 0,
    Master = 2,
    Common  = 4,
    Black   = 8,
}

--@hash
local All = {
    ["2821006329"]  = 0,
    ["157027148"]   = 2,
}

local function GetRing(uid)
    if All[uid] == nil then 
        All[uid] = Ring.Common
    end
    return All[uid]
end

-- local function AddMaster(uid)
--     Master[uid] = true
-- end

-- local function DeleteMaster(uid)
--     Master[uid] = nil
-- end

-- local function AddBlack(uid)
--     Black[uid] = true
-- end

-- local function DeleteBlack(uid)
--     Black[uid] = nil
-- end

local module = {
    _All = All,
    GetRing = GetRing,
    -- AddMaster = AddMaster,
    -- DeleteMaster = DeleteMaster,
    -- AddBlack = AddBlack,
    -- DeleteBlack = DeleteBlack,
    -- SetAdminCall = SetAdminCall,
    -- SetMasterCall = SetMasterCall,
    -- GetMasterCall = GetMasterCall,
    -- GetAdminCall = GetAdminCall, 
}

return module