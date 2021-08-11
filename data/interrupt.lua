
-- interrupt repeat 

--@set
local TriggerValue  = 3
local IrptReplay    = "打破复读"
local TrappedReply  = "想套路我？"

local StopCmd       = "嘘"
local OnStop        = "我以后不会多嘴了"
local StartCmd      = "..."
local onStart       = "..."

--@item
local LastMessage = ""
local RepeatCount = 0

--@ret
local module = {
    --@set
    _TriggerValue   = TriggerValue,
    _IrptReplay     = IrptReplay,
    _TrappedReply   = TrappedReply,
    _StopCmd        = StopCmd,
    _OnStop         = OnStop,
    _OnStart        = onStart,
    _StartCmd       = StartCmd, 

    --@item
    LastMessage = LastMessage,
    RepeatCount = RepeatCount
}

return module 


