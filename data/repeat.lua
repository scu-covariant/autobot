
-- auto repeat 

--@set
local TriggerValue  = 3

local StopCmd       = "复读--"
local OnStop        = ""
local StartCmd      = "复读++"
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


