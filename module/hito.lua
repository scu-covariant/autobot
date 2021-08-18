local module = {
    Service = {
        FileName = "hito",
        Setting = "hito set",
        DataPage = "hito db",
        Control = "hito ctrl",
        Logic = "hito logic"
    },

    Setting = {
        Running = true,
        Record = false,
        Terminal = false,
        Target = EventType.GroupMessage
    },

    DataPage = {
        -- StopCmd     = Self.Name.." ".."",
        -- StartCmd    = Self.Name.." ".."your cmd",
        Trigger = "一言"
    },

    Control = {
        Condition = {},
        Reaction = {},
    },

    Logic = {
        [EventType.GroupMessage] = {
            Filiter = function(event, dbpage, tasks)
                local msgstr = tostring(event.message)
                return msgstr == "一言"
            end,

            Actor = function(event, dbpage, tasks)
                local hito = Http.get(
                                 "https://v1.hitokoto.cn/?c=a&c=b&c=c&c=d&c=h&c=i&c=j&c=k"):match(
                                 [["hitokoto":"(.-)","type"]])
                event.group:sendMessage(Quote(event.message) .. hito)
            end,

            After = function(event, dbpage, tasks) end,
            Log = function(event, page, tasks) end
        }
    }
}

return module
