require("data.selfdef")

Config = {}

function RegistModule(guid, file)
    local mod = require(file)
    Config[guid].Service[mod.Service.FileName] = {
        Setting = mod.Service.Setting,
        DataPage = mod.Service.DataPage,
        Control = mod.Service.Control,
        Logic = mod.Service.Logic,
        TaskQueue = mod.Service.TaskQueue or nil
    }
    print("regist service index success, info:")
    for key, value in pairs(Config[guid].Service[mod.Service.FileName]) do
        print("|"..key..":"..value)
    end

    local service = mod.Service

    Config[guid].DataBase[service.DataPage] = mod.DataPage
    print("regist datapage:"..service.DataPage.." success")
    Config[guid].Control[service.Control] = mod.Control
    print("regist control:"..service.Control.." success")
    Config[guid].Logic[service.Logic] = mod.Logic
    print("regist logic:"..service.Logic.." success")
    Config[guid].Setting[service.Setting] = mod.Setting
    print("regist setting"..service.Setting.." success")
    if mod.Tasks then
        Config[guid].TaskQueue[mod.Service.TaskQueue] = mod.Tasks
        print("regist taskqueue:"..service.TaskQueue.." success")
    end
    print("Regist module:" .. file .. " of group:" .. guid .. " success")
end

function RegistConfig(set)
    Config[set.Group] = set
    Self = set.Self
    local path = set.Self.Modules
    for _, module in pairs(set.Module) do
        print("registing module:" .. module)
        RegistModule(set.Group, path .. module)
    end
    print("Regist config of group: " .. set.Group .. " success")
end

-- @init
require("data.config")

-- -- 序列化tablle表--將表转化成string
-- function Serialize(obj)
--     local lua = ""
--     local t = type(obj)
--     if t == "number" then
--         lua = lua .. obj
--     elseif t == "boolean" then
--         lua = lua .. tostring(obj)
--     elseif t == "string" then
--         lua = lua .. string.format("%q", obj)
--     elseif t == "table" then
--         lua = lua .. "{\n"
--         for k, v in pairs(obj) do
--             lua = lua .. "[" .. serialize(k) .. "]=" .. serialize(v) .. ",\n"
--         end
--         local metatable = getmetatable(obj)
--         if metatable ~= nil and type(metatable.__index) == "table" then
--             for k, v in pairs(metatable.__index) do
--                 lua = lua .. "[" .. serialize(k) .. "]=" .. serialize(v) .. ",\n"
--             end
--         end
--         lua = lua .. "}"
--     elseif t == "nil" then
--         return nil
--     else
--         return "-nil-" 
--         --error("can not serialize a " .. t .. " type.")
--     end
--     return lua
-- end

-- -- 反序列化tablle表--將string转化成table
-- function Unserialize(lua)
--     local t = type(lua)
--     if t == "nil" or lua == "" then
--         return nil
--     elseif t == "number" or t == "string" or t == "boolean" then
--         lua = tostring(lua)
--     else
--         error("can not unserialize a " .. t .. " type.")
--     end
--     lua = "return " .. lua
--     local func = loadstring(lua)
--     if func == nil then
--         return nil
--     end
--     return func()
-- end
