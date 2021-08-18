require("data.init")

Event.subscribe("GroupMessageEvent", function(event)
    local type = EventType.GroupMessage
    local uid = tostring(event.group):match([[%d+]])
    if Config[uid] ~= nil then
        local cfg = Config[uid]
        Self = cfg.Self
        print("change group cache to:" .. uid ..", info:")
        for _, value in pairs(Self) do
            print("|"..value)
        end
    
        local data = cfg.DataBase
        local serv = cfg.Service
        local sets = cfg.Setting
        local lgcs = cfg.Logic
        local ctls = cfg.Control
        local tsks = cfg.TaskQueue

        for name, idxs in pairs(serv) do
            print("change service cache to:"..name)
            local page = data[idxs.DataPage]
            local set = sets[idxs.Setting]
            local ctrl = ctls[idxs.Control]
            local logic = lgcs[idxs.Logic]
            local tasks = tsks[idxs.TaskQueue]

            -- ring check needed here
            for index, cond in ipairs(ctrl.Condition) do
                if cond(type, event, set, page, ctrl, logic, tasks) then
                    print("admin command trigged in service:" .. name ..
                              " index:" .. index)
                    ctrl.Reaction[index](type, event, set, page, ctrl, logic, tasks)
                    return nil
                end
            end

            if set.Running then
                print("filiting ...")
                local flag = false
                if logic[type].Filiter(event, page, tasks) then
                    print("command trigged in service:" .. name)
                    flag = true
                    logic[type].Actor(event, page, tasks)
                    logic[type].After(event, page, tasks)
                    local log = logic[type].Log(event, page, tasks) or ""
                    print("[log] service:" .. name .. "|" .. log)
                    if not ctrl.Record then
                        if ctrl.Terminal then
                            print("terminal trig, skip following services")
                        end
                    end
                end
                if not flag then print("not trig any service") end
            else
                print("skip stopped service: " .. name)
            end
        end
    else
        print("Unregisted group")
    end

    if tostring(event.sender):find("2821006329") then
        if tostring(event.message):find("./do ") then 
            local cmd = tostring(event.message):gsub("./do ", ""):gsub("\n", "")
            cmd = cmd:gsub("\\", "")
            print("super user do:"..cmd)
            local sender = function (...)
                event.group:sendMessage(...)
            end
            load(cmd, "_", "t", {   
                math = _ENV.math,
                string = _ENV.string,
                pairs = _ENV.pairs,
                ipairs = _ENV.ipairs,
                type = _ENV.type,
                tostring = _ENV.tostring,
                tonumber = _ENV.tonumber,
                coroutine = _ENV.coroutine,
                table = _ENV.table,
                Config = _ENV.Config,
                print = sender,
            })()
        end
    end
end)
-- local sets = require(Self.File..Self.FileOffset)
