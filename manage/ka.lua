--@impl interface
local control = {
    Running = true,
}

local msgstr

local function IsAddKey(event, db, manage)
    msgstr = tostring(event.message)
    if msgstr:find("阿言 当听见") ~= nil and msgstr:find("时说") ~= nil then
        return true
    else 
        return false
    end
end
    
local function AddKey(event, db, manage)
    msgstr = msgstr:gsub("阿言 当听见", ""):gsub("时说", "|")
    local i = string.find(msgstr, "|")
    local front = msgstr:sub(1, i - 1):gsub(" ", "")
    local back = msgstr:sub(i + 1, msgstr:len()):gsub(" ", "")
    if front:len() <= 1 and back:len() <= 1 then 
        print("invalid key :".. front..", answer: "..back)
        event.group:sendMessage("我还小， 听不懂你在说什么")
    else 
        print("add key, key: ".. front..", answer: "..back)
        table.insert(db.Keys, front)
        table.insert(db.Answers, back)
        event.group:sendMessage(db.OnAddKeySay(front, back))
    end
end    

local function IsForget(event, db, manage)
    msgstr = tostring(event.message)
    if msgstr:find("阿言 忘记") ~= nil then 
        return true
    else 
        return false 
    end
end


local function ForgetKey(event, db, manage)
    local msg = tostring(event.message)
    local i = string.find(msg, "~")
    msg = msg:sub(i + 1, msg:len() + 1):gsub("~", "")
    print("target key to forget: "..msg)
    if msg:len() < 1 then 
        print("invalid forget key"..msg)
    else 
        for index, key in pairs(db.Keys) do 
            if key:find(msg) ~= nil and math.abs(key:len() - msg:len()) < 2 then
                print("条件满足， 忘记")
                db.Keys[index] = nil
                db.Answers[index] = nil
                event.group:sendMessage("我已经忘了"..msg)
                return 
            else 
                print("条件不满足, 不能忘记关键字"..msg)
            end
        end  
    end
end

local module = {
    Manage = control,

    Condition = {
        IsAddKey, IsForget,
    }, -- function array

    React = {
        AddKey, ForgetKey,
    },  -- function array
}

return module