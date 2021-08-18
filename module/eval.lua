local module = {

    --@table<field, string>
    Service = {
        FileName = "eval",
        Setting = "eval set",
        DataPage = "eval page",
        Control = "eval ctrl",
        Logic = "eval logic"
        -- TaskQueue    = "",
    },

    --@table
    Setting = {

        --@bool
        Running = true,

        --@bool
        Terminal = true,

        --@enum EventType
        Target = EventType.GroupMessage
    },

    DataPage = {
        StopCmd = Self.Name .. " " .. "stop eval",
        StartCmd = Self.Name .. " " .. "start eval",
        -- other custom data

        Trigger = Self.Name.." ./ ",
        Script = "",
        -- Environment = {},

    },

    --@table<field, function[]>
    Control = {
        --@function
        --@para (type: EventType, event:Event, set: Setting, page: DataPage, ctrl: Control, logic: Logic, tasks: option<Tasks>)
        --@ret bool
        Condition = {
            -- is stop
            [1] = function(type, event, set, page, ctrl, logic, tasks)
                if tostring(event.message):find(page.StopCmd) == 1 then 
                    return true
                end
                return false
            end,

            -- is start
            [2] = function(type, event, set, page, ctrl, logic, tasks)
                if tostring(event.message):find(page.StartCmd) == 1 then 
                    return true
                end
                return false
            end,
        },

        --@function
        --@para (type: EventType, event:Event, set: Setting, page: DataPage, ctrl: Control, logic: Logic, tasks: option<Tasks>)
        --@ret nil
        Reaction = {
            [1] = function(type, event, set, page, ctrl, logic, tasks)
                set.Running = false
            end,

            [2] = function(type, event, set, page, ctrl, logic, tasks)
                set.Running = true
            end,
        },
    },

    Logic = {
        --@enum as index, depend on self.Setting.Target
        [EventType.GroupMessage] = {
            --@ret nil
            Filiter = function(event, dbpage, tasks) 
                local msgstr = tostring(event.message)
                if msgstr:find(dbpage.Trigger) == 1 then
                    dbpage.Script = msgstr:gsub(dbpage.Trigger, ""):gsub("\\", "")
                    return true
                end
                return false
            end,
            
            --@ret nil
            Actor = function(event, dbpage, tasks) 
                if type(dbpage.Script) == "string" then                    
                    
                    local sender = function (...)
                        event.group:sendMessage(...)
                    end
                    print("script:"..dbpage.Script)

                    local env = {
                        math = _ENV.math,
                        string = _ENV.string,
                        pairs = _ENV.pairs,
                        ipairs = _ENV.ipairs,
                        type = _ENV.type,
                        tostring = _ENV.tostring,
                        tonumber = _ENV.tonumber,
                        coroutine = _ENV.coroutine,
                        table = _ENV.table,
                        print = sender,
                    }

                    load(dbpage.Script, 
                        tostring(event.sender), 
                        "t",
                        env
                    )()
                else
                    event.group:sendMessage("type:"..type(dbpage.Script).." eval failed")
                end
            end,
            
            --@ret nil
            After = function(event, dbpage, tasks) end,
            
            --@ret string
            Log = function(event, dbpage, tasks)
                print("script:"..dbpage.Script)
            end
        }
    }

    --[[
        Tasks = {
            ["123456789"] = {
                [0] = function(...) end,
                [1] = ...
                ...
            }

            ...
        }
    ]]
}

return module
