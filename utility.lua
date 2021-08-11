-- 序列化tablle表--將表转化成string
function Serialize(obj)
    local lua = ""
    local t = type(obj)
    if t == "number" then
        lua = lua .. obj
    elseif t == "boolean" then
        lua = lua .. tostring(obj)
    elseif t == "string" then
        lua = lua .. string.format("%q", obj)
    elseif t == "table" then
        lua = lua .. "{\n"
    for k, v in pairs(obj) do
        lua = lua .. "[" .. serialize(k) .. "]=" .. serialize(v) .. ",\n"
    end
    local metatable = getmetatable(obj)
        if metatable ~= nil and type(metatable.__index) == "table" then
        for k, v in pairs(metatable.__index) do
            lua = lua .. "[" .. serialize(k) .. "]=" .. serialize(v) .. ",\n"
        end
    end
        lua = lua .. "}"
    elseif t == "nil" then
        return nil
    else
        return "-nil-" 
        --error("can not serialize a " .. t .. " type.")
    end
    return lua
end

-- 反序列化tablle表--將string转化成table
function Unserialize(lua)
    local t = type(lua)
    if t == "nil" or lua == "" then
        return nil
    elseif t == "number" or t == "string" or t == "boolean" then
        lua = tostring(lua)
    else
        error("can not unserialize a " .. t .. " type.")
    end
    lua = "return " .. lua
    local func = loadstring(lua)
    if func == nil then
        return nil
    end
    return func()
end

Database = {}
Funcs = {}
Ctrl = {}

function RegistDatabaePage(name, mod)
    Database[name] = mod
end

function RegistFuncMod(name, mod)
    Funcs[name] = mod
end

function RegistCtrlTable(name, mod)
    Ctrl[name] = mod
end

function LoadMods(mods)
    local count = 0
    for _, modname in pairs(mods) do 
        local funpath = "data.funs."
        local target = require(funpath..modname)
        RegistFuncMod(target.Info.SelfName, target)
        local datapath = "data.data."
        RegistDatabaePage(target.Info.Database, require(datapath..modname))
        local ctrlpath = "data.manage."
        RegistCtrlTable(target.Info.CtrlName, require(ctrlpath..modname))
        count = count + 1
        print("load "..modname.." mod successful")
    end
    print("load "..count.." mod altogether")
end

