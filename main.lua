require("data.mod")
local ring = require("data.data.ring")

Event.subscribe("GroupMessageEvent", function(event) 
	local msgstr = tostring(event.message)
	local uid = tostring(event.sender)
	for mod, actor in pairs(Funcs) do 
		local dbpage = Database[actor.Info.Database]
		local ctrl = Ctrl[actor.Info.CtrlName].Manage
		
		if ctrl.Running then 
			print("判断事件："..actor.Info.SelfName)
			if  actor.Filiter(msgstr) then 
				print(actor.Info.SelfName.." 条件满足")
				actor.Act(event, actor.Checker(0, dbpage, uid), 0, dbpage)
				actor.After(dbpage, uid)
				actor.Log(dbpage, uid)
				if mod ~= "interrupt" and mod ~= "autorepeat" then
					if actor.Info.Terminal then 
						print(actor.Info.SelfName.." 触发后中断属性为 true, 跳过后续判断")
						return 
					end
				end 
			else
				print(actor.Info.SelfName.." 条件不满足")
			end
		end
		--判断权限, 执行管理员的命令
		-- if ring.GetRing(uid) <= 2 then 
		
		if uid:find("2821006329") ~= nil then
			print("权限足够， 管理员命令判断|"..uid.."|")
			for index, cond in ipairs(Ctrl[actor.Info.CtrlName].Condition) do 
				if cond(event, dbpage, ctrl) then 
					Ctrl[actor.Info.CtrlName].React[index](event, dbpage, ctrl)
					print(actor.Info.CtrlName.." 's function: "..index.." triggered")
				end
			end
		end

	end

end)