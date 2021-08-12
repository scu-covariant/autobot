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
    ["157027148"]   = 0, --jhz
    ["1543633728"]  = 0,
    ["1059899674"]  = 0,
    ["1499765600"]  = 0,
    ["1728902978"]  = 0,    --pd

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