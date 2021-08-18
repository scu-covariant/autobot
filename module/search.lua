local module = {

    --@table<field, string>
    Service = {
        FileName = "search",
        Setting = "search set",
        DataPage = "search page",
        Control = "search ctrl",
        Logic = "search logic"
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
        -- StopCmd = Self.Name .. " " .. "your cmd",
        -- StartCmd = Self.Name .. " " .. "your cmd",
        -- other custom data

        Maybe = {
            ["百度一下"] = [[http://www.oxox.ltd/bai/du.html?]],
            ["教务处搜索"] = [[%教务处链接%]],
            ["知乎搜索"] = [[%知乎链接%]],
            ["github search"] = [[%https://github.com/search?q=]],
        },
        Index = "",
    },

    --@table<field, function[]>
    Control = {
        --@function
        --@para (type: EventType, event:Event, set: Setting, page: DataPage, ctrl: Control, logic: Logic, tasks: option<Tasks>)
        --@ret bool
        Condition = {},

        --@function
        --@para (type: EventType, event:Event, set: Setting, page: DataPage, ctrl: Control, logic: Logic, tasks: option<Tasks>)
        --@ret nil
        Reaction = {},
    },

    Logic = {
        --@enum as index, depend on self.Setting.Target
        [EventType.GroupMessage] = {
            Filiter = function(event, dbpage, tasks) 
                local msgstr = tostring(event.message)
                for key, _ in pairs(dbpage.Maybe) do
                    if msgstr:find(key) == 1 then 
                        dbpage.Index = key
                        return true
                    end
                end
                return false
            end,
            Actor = function(event, dbpage, tasks) 
                local msgstr = tostring(event.message)
                local what = msgstr:gsub(dbpage.Index, "")
                local rep = dbpage.Maybe[dbpage.Index]..what:encodeURL("UTF-8")
                rep = rep:gsub("+", "")
                event.group:sendMessage(rep)
            end,
            After = function(event, dbpage, tasks) end,
            Log = function(event, dbpage, tasks) 
                return dbpage.Index.." trigged success by:"..tostring(event.sender)
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
