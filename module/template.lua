local module = {

    --@table<field, string>
    Service = {
        FileName = "",
        Setting = "",
        DataPage = "",
        Control = "",
        Logic = ""
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
        StopCmd = Self.Name .. " " .. "your cmd",
        StartCmd = Self.Name .. " " .. "your cmd",
        -- other custom data
    },

    --@table<field, function[]>
    Control = {
        --@function
        --@para (type: EventType, event: Event, set: Setting, page: DataPage, ctrl: Control, logic: Logic, tasks: option<Tasks>)
        --@ret bool
        Condition = {},

        --@function
        --@para (type: EventType, event: Event, set: Setting, page: DataPage, ctrl: Control, logic: Logic, tasks: option<Tasks>)
        --@ret nil
        Reaction = {},
    },

    Logic = {
        --@enum as index, depend on self.Setting.Target
        [EventType.GroupMessage] = {
            --@ret nil
            Filiter = function(event, dbpage, tasks) end,
            
            --@ret nil
            Actor = function(event, dbpage, tasks) end,
            
            --@ret nil
            After = function(event, dbpage, tasks) end,
            
            --@ret string
            Log = function(event, dbpage, tasks) end
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
