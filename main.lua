require("data.mod")


Event.subscribe("GroupMessageEvent", function(event)
	if tostring(event.group.id):find("9400") == 1 then 
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
							print(actor.Info.SelfName.." 中断属性为 true, 跳过后续判断")
							return 
						end
					end 
				else
					print(actor.Info.SelfName.." 条件不满足")
				end
			end

			--判断下权限
			if ctrl == nil then print("nil") end 
			for index, cond in ipairs(Ctrl[actor.Info.CtrlName].Condition) do 
				if cond(event, dbpage, ctrl) then 
					Ctrl[actor.Info.CtrlName].React[index](event, dbpage, ctrl)
					print(actor.Info.CtrlName.." 's function: "..index.." triggered")
				end
			end
		end
	end
end)