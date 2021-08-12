
-- key-answer

local Keys = {
    "ayan",
}

local Answers = {
    "你在叫我吗？",
}

local function OnAddKeySay(key, ans)
    local rep = "下次听到"..key.."时， 我会说"..ans 
    return rep
end

local module = {
    Keys = Keys,
    Answers = Answers,
    OnAddKeySay = OnAddKeySay,
} 

return module