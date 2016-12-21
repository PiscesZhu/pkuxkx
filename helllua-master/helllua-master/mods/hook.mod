hooks={}
hooks.step="step"
--每进入一个新房间的hook
hooks.searchfrofail="searchfrofail"
--search失败的hook
hooks.isbusy="isbusy"
--是否busy的hook
hooks.infoend="infoend"
--信息结束的hook
hooks.stepfail="stepfail"
--步近失败的hook
hooks.flyfail="flyfail"
--fly失败的hook
hooks.logok="logok"
--登陆成功后的hook
hooks.hurt="hurt"
--轻伤
hooks.faint="faint"
--重伤
hooks.faint1="faint1"
--昏迷
hooks.fight="onfight"
--战斗时触发.如果需要战斗必须使用此hook,不然将reconnect
hooks.steptimeout="steptimeout"
--发送上一个指令4秒后触发。一般用于search之类的step超时
hooks.blocked="blocked"
--step 被拦住的hook
hooks.maxstep="maxstep"
--多步行走
hooks.accept="accept"
--挑战
hooks.dragon="dragon"
--龙出没

hooks.killme="killme"
---被npc下kill的hook,函数第一个参数是下kill的npc的名字
_hooklist={}
_hookarglist={}
hashook=function(str)
	if _hooklist[str] ==nil then
		return false
	else
		return true
	end
end

hook=function(str,callback,...)
	_hooklist[str]=callback
	if callback==nil then
		_hookarglist[str]=nil
	else
		_hookarglist[str]={...}
	end
end

unhookall=function()
	_hooklist={}
	_hookarglist={}
end

callhook=function(str,removehook)
	thook=_hooklist[str]
	thookarg=_hookarglist[str]
	if removehook==true then
		hook(str,nil)
	end
	if thookarg~=nil then
		call(thook,unpack(thookarg))
	else
		call(thook)
	end
end

call=function(func,...)
	if (func~=nil) then
		func(...)
	end
end
