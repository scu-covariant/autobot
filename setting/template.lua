-- @type dataclass
-- @field Group: string
-- @field Service: table<string, dataclass>
local GroupSet = {
    -- @required
    Group = "123456",

    -- @required
    Self = {Name = "", Nick = "", From = "", BaseFolder = "", Modules = ""},

    -- @required
    -- @type string[]
    Modules = {},

    -- @required
    Service = {

        -- @optional
        -- @type dataclass
        -- @field DataPage:  string
        -- @field Setting:   string
        -- @field Control:   string
        -- @field Logic:     string
        -- file name of a specfic service
        ["service one"] = {

            -- @required
            Setting = "set one",

            -- @optional
            DataPage = "page one",

            -- @required
            Control = "ctrl one",

            -- @required
            Logic = "logic one",

            -- @optional
            TaskQueue = "tasks one"
        }

        -- other services
        -- ["sercive two"] = {...}
    },

    -- @required
    DataBase = {

        -- @depend on service
        -- @type dataclass
        -- @field custom data ...
        ["page one"] = {
            -- some data
        }

        -- other pages
        -- ["other page"] = {...},
    },

    -- @required
    Setting = {

        -- @required
        -- @type dataclass
        -- @field Running:   bool
        -- @field Terminal:  bool
        -- @field Target:    EventType[]
        ["set one"] = {

            -- @required
            -- whether service is running
            Running = true,

            -- @required
            -- whether break when triggerd
            Terminal = true,

            -- @required
            -- event type you need to deal with, multi event type is are allowed
            Target = EventType.GroupMessage

            -- @required
            -- whether have self thread
            -- OwnThread = false,

        }

        -- other settings
        -- ["other set"] = {}
    },

    -- @required
    Control = {

        -- @required
        -- @field Checker:   function
        ["ctrl one"] = {

            -- @optional
            -- @type function(etype, event, dbpage, ctrl, logics, tasks)[]
            Condition = {},

            -- @optional
            -- @type function(etype, event, dbpage, ctrl)[]
            Reaction = {}

        }
    },

    -- @required
    Logic = {

        -- @required
        ["logic one"] = {

            -- @depend on Target
            -- @type dataclass
            -- @field filiter:   function
            -- @field action:    function
            -- @field after:     function
            -- @field log:       function
        }

        -- other logic
    },

    -- @optional
    TaskQueue = {
        -- @depend on setting
        -- @type dataclass
        ["tasks one"] = {}
    }
}
